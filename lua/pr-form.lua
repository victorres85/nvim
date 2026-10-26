-- Floating form for creating a GitHub pull request with the `gh` CLI.
--
--   :PRCreate  (or <leader>gp)
--
-- Inside the form:
--   <C-s>  submit (pushes the branch, then runs `gh pr create`)
--   <C-t>  toggle Draft yes/no
--   <C-a>  pick reviewers from the repo collaborators (Telescope, <Tab> to multi-select)
--   q      cancel (normal mode)
--
-- Reviewers / Labels are comma or space separated. Teams work as `org/team`.

local M = {}

local SEP = '──────── Body (write below this line) ────────'
local FIELDS = { 'Title', 'Base', 'Draft', 'Reviewers', 'Labels' }

local function git(args, cwd)
  local cmd = vim.list_extend({ 'git' }, args)
  if cwd then
    cmd = vim.list_extend({ 'git', '-C', cwd }, args)
  end
  local out = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then
    return nil
  end
  return out
end

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = 'PR' })
end

local function split_list(s)
  return vim.split(s or '', '[,%s]+', { trimempty = true })
end

local function field_line(key, value)
  return string.format('%-11s%s', key .. ':', value or '')
end

local function default_base(root)
  local out = git({ 'rev-parse', '--abbrev-ref', 'origin/HEAD' }, root)
  if out and out[1] and out[1] ~= 'origin/HEAD' then
    return (out[1]:gsub('^origin/', ''))
  end
  return 'main'
end

local function pr_template(root)
  for _, p in ipairs {
    '.github/pull_request_template.md',
    '.github/PULL_REQUEST_TEMPLATE.md',
    'pull_request_template.md',
    'docs/pull_request_template.md',
  } do
    local f = root .. '/' .. p
    if vim.fn.filereadable(f) == 1 then
      return vim.fn.readfile(f)
    end
  end
end

local function parse(buf)
  local f = { body = {} }
  local in_body = false
  for _, l in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
    if in_body then
      table.insert(f.body, l)
    elseif l == SEP then
      in_body = true
    else
      local k, v = l:match '^(%a+):%s*(.-)%s*$'
      if k then
        f[k:lower()] = v
      end
    end
  end
  f.body = vim.trim(table.concat(f.body, '\n'))
  return f
end

local function set_field(buf, key, value)
  for i, l in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
    if l == SEP then
      return
    end
    if l:match('^' .. key .. ':') then
      vim.api.nvim_buf_set_lines(buf, i - 1, i, false, { field_line(key, value) })
      return
    end
  end
end

local function open_win(buf)
  local width = math.min(100, math.floor(vim.o.columns * 0.8))
  local height = math.min(30, math.floor(vim.o.lines * 0.7))
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = 'minimal',
    border = 'rounded',
    title = ' Create Pull Request ',
    title_pos = 'center',
    footer = ' <C-s> submit · <C-t> toggle draft · <C-a> reviewers · q cancel ',
    footer_pos = 'center',
  })
  vim.wo[win].wrap = true
  vim.wo[win].linebreak = true
  vim.fn.matchadd('Keyword', [[^\(]] .. table.concat(FIELDS, [[\|]]) .. [[\):]], 10, -1, { window = win })
  vim.fn.matchadd('Comment', '^' .. SEP .. '$', 10, -1, { window = win })
  vim.api.nvim_win_set_cursor(win, { 1, #vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] })
  return win
end

local function close(buf)
  for _, w in ipairs(vim.fn.win_findbuf(buf)) do
    pcall(vim.api.nvim_win_close, w, true)
  end
end

local function pick_reviewers(buf, root)
  notify 'Fetching collaborators…'
  vim.system({ 'gh', 'api', 'user', '--jq', '.login' }, { text = true, cwd = root }, function(me)
    local self_login = vim.trim(me.stdout or '')
    vim.system(
      { 'gh', 'api', '--paginate', 'repos/{owner}/{repo}/collaborators', '--jq', '.[].login' },
      { text = true, cwd = root },
      function(r)
        vim.schedule(function()
          if r.code ~= 0 then
            return notify('Could not fetch collaborators:\n' .. (r.stderr or ''), vim.log.levels.ERROR)
          end
          local users = vim.tbl_filter(function(u)
            return u ~= self_login
          end, vim.split(vim.trim(r.stdout), '\n', { trimempty = true }))

          local function apply(names)
            local current = split_list(parse(buf).reviewers)
            for _, n in ipairs(names) do
              if not vim.tbl_contains(current, n) then
                table.insert(current, n)
              end
            end
            set_field(buf, 'Reviewers', table.concat(current, ', '))
          end

          local ok, pickers = pcall(require, 'telescope.pickers')
          if not ok then
            return vim.ui.select(users, { prompt = 'Reviewer' }, function(choice)
              if choice then
                apply { choice }
              end
            end)
          end

          local finders = require 'telescope.finders'
          local conf = require('telescope.config').values
          local actions = require 'telescope.actions'
          local state = require 'telescope.actions.state'
          pickers
            .new({}, {
              prompt_title = 'Reviewers (<Tab> select, <CR> confirm)',
              finder = finders.new_table { results = users },
              sorter = conf.generic_sorter {},
              attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                  local picker = state.get_current_picker(prompt_bufnr)
                  local sel = picker:get_multi_selection()
                  if #sel == 0 then
                    sel = { state.get_selected_entry() }
                  end
                  actions.close(prompt_bufnr)
                  apply(vim.tbl_map(function(e)
                    return e.value
                  end, sel))
                end)
                return true
              end,
            })
            :find()
        end)
      end
    )
  end)
end

local function submit(buf, root)
  local f = parse(buf)
  if not f.title or f.title == '' then
    return notify('Title is required', vim.log.levels.WARN)
  end

  local args = { 'gh', 'pr', 'create', '--title', f.title, '--body', f.body, '--base', f.base or 'main' }
  if (f.draft or ''):match '^[yYtT]' then
    table.insert(args, '--draft')
  end
  for _, r in ipairs(split_list(f.reviewers)) do
    vim.list_extend(args, { '--reviewer', r })
  end
  for _, l in ipairs(split_list(f.labels)) do
    vim.list_extend(args, { '--label', l })
  end

  close(buf)
  notify 'Pushing branch…'

  local function fail(msg)
    vim.schedule(function()
      notify(msg, vim.log.levels.ERROR)
      open_win(buf) -- reopen so nothing typed is lost
    end)
  end

  vim.system({ 'git', 'push', '-u', 'origin', 'HEAD' }, { text = true, cwd = root }, function(p)
    if p.code ~= 0 then
      return fail('git push failed:\n' .. (p.stderr or ''))
    end
    vim.schedule(function()
      notify 'Creating pull request…'
    end)
    vim.system(args, { text = true, cwd = root }, function(r)
      if r.code ~= 0 then
        return fail('gh pr create failed:\n' .. (r.stderr or ''))
      end
      vim.schedule(function()
        local url = vim.trim(r.stdout):match 'https://%S+' or vim.trim(r.stdout)
        vim.fn.setreg('+', url)
        notify('PR created (URL copied): ' .. url)
        pcall(vim.api.nvim_buf_delete, buf, { force = true })
      end)
    end)
  end)
end

function M.open()
  if vim.fn.executable 'gh' == 0 then
    return notify('`gh` CLI not found', vim.log.levels.ERROR)
  end
  local root = (git { 'rev-parse', '--show-toplevel' } or {})[1]
  if not root then
    return notify('Not inside a git repository', vim.log.levels.ERROR)
  end

  local branch = (git({ 'branch', '--show-current' }, root) or {})[1] or ''
  local base = default_base(root)
  if branch == base then
    return notify('You are on ' .. base .. ' — create a feature branch first', vim.log.levels.WARN)
  end

  local commits = git({ 'log', '--format=%s', 'origin/' .. base .. '..HEAD' }, root) or {}
  local title
  if #commits == 1 then
    title = commits[1]
  else
    local prefix, rest = branch:match '^(%w+)/(.+)$'
    title = prefix and (prefix .. ': ' .. rest:gsub('[-_]', ' ')) or (branch:gsub('[-_]', ' '))
  end

  local body = pr_template(root)
  if not body then
    body = vim.tbl_map(function(c)
      return '- ' .. c
    end, commits)
  end

  local lines = {
    field_line('Title', title),
    field_line('Base', base),
    field_line('Draft', 'yes'),
    field_line('Reviewers', ''),
    field_line('Labels', ''),
    SEP,
    '',
  }
  vim.list_extend(lines, body)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = 'hide'
  vim.bo[buf].filetype = 'markdown'
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local map = function(modes, lhs, fn, desc)
    vim.keymap.set(modes, lhs, fn, { buffer = buf, desc = desc, nowait = true })
  end
  map({ 'n', 'i' }, '<C-s>', function()
    vim.cmd.stopinsert()
    submit(buf, root)
  end, 'Submit PR')
  map({ 'n', 'i' }, '<C-t>', function()
    local d = (parse(buf).draft or ''):match '^[yYtT]'
    set_field(buf, 'Draft', d and 'no' or 'yes')
  end, 'Toggle draft')
  map({ 'n', 'i' }, '<C-a>', function()
    vim.cmd.stopinsert()
    pick_reviewers(buf, root)
  end, 'Pick reviewers')
  map('n', 'q', function()
    close(buf)
    pcall(vim.api.nvim_buf_delete, buf, { force = true })
  end, 'Cancel')

  open_win(buf)
end

function M.setup()
  vim.api.nvim_create_user_command('PRCreate', M.open, { desc = 'Create a GitHub PR (floating form)' })
  vim.keymap.set('n', '<leader>gp', M.open, { desc = '[G]it create [P]R' })
end

return M
