local M = {}

-- Path to commands.md
local function get_file_path()
  return vim.fn.stdpath('config') .. '/commands.md'
end

-- Parse commands.md into structured entries
local function parse_commands_file()
  local file_path = get_file_path()
  local file = io.open(file_path, 'r')
  if not file then
    return nil, 'Could not open file: ' .. file_path
  end

  local items = {}
  local current_section = ''
  local current_subsection = ''
  local lnum = 0

  for line in file:lines() do
    lnum = lnum + 1
    local trimmed = line:match('^%s*(.-)%s*$')
    local s_h2 = trimmed:match('^##%s+(.+)')
    local s_h3 = trimmed:match('^###%s+(.+)')

    if s_h2 then
      current_section = s_h2
      current_subsection = ''
    elseif s_h3 then
      current_subsection = s_h3
    else
      local content = trimmed:match('^%-%s+(.+)')
      if content then
        local cmd_part, desc_part = content:match('^(.-)%s+%-%s+(.+)$')
        local cat = current_section
        if current_subsection ~= '' then
          cat = cat .. ' > ' .. current_subsection
        end

        if cmd_part and desc_part then
          local clean_cmd = cmd_part:gsub('`', '')
          table.insert(items, {
            cmd = clean_cmd,
            raw_cmd = cmd_part,
            desc = desc_part,
            category = cat,
            lnum = lnum,
            filename = file_path,
          })
        else
          table.insert(items, {
            cmd = '💡 Tip',
            raw_cmd = '',
            desc = content,
            category = cat,
            lnum = lnum,
            filename = file_path,
          })
        end
      end
    end
  end

  file:close()
  return items, file_path
end

-- Open commands.md in a floating modal window
function M.popup(target_lnum)
  local file_path = get_file_path()
  if vim.fn.filereadable(file_path) ~= 1 then
    vim.notify('commands.md not found at ' .. file_path, vim.log.levels.ERROR)
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  local lines = vim.fn.readfile(file_path)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  vim.bo[buf].filetype = 'markdown'
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].modifiable = false
  vim.bo[buf].readonly = true

  local width = math.min(100, math.floor(vim.o.columns * 0.85))
  local height = math.min(36, math.floor(vim.o.lines * 0.85))
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = ' 󰋖 Neovim Commands Reference (q/Esc: close, /: search, s: fuzzy search) ',
    title_pos = 'center',
  })

  vim.wo[win].number = true
  vim.wo[win].cursorline = true
  vim.wo[win].wrap = true

  if target_lnum and target_lnum > 0 and target_lnum <= #lines then
    vim.api.nvim_win_set_cursor(win, { target_lnum, 0 })
    vim.cmd('normal! zz')
  end

  local function close()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end

  vim.keymap.set('n', 'q', close, { buffer = buf, nowait = true, desc = 'Close cheat sheet' })
  vim.keymap.set('n', '<Esc>', close, { buffer = buf, nowait = true, desc = 'Close cheat sheet' })
  vim.keymap.set('n', 's', function()
    close()
    M.search()
  end, { buffer = buf, nowait = true, desc = 'Switch to fuzzy search' })
end

-- Open fuzzy search picker via Telescope
function M.search(opts)
  opts = opts or {}

  local ok_tel, _ = pcall(require, 'telescope')
  if not ok_tel then
    local ok_lazy, lazy = pcall(require, 'lazy')
    if ok_lazy then
      lazy.load({ plugins = { 'telescope.nvim' } })
    end
  end

  local ok_pickers, pickers = pcall(require, 'telescope.pickers')
  if not ok_pickers then
    vim.notify('Telescope is not available. Opening floating window instead.', vim.log.levels.WARN)
    M.popup()
    return
  end

  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local entry_display = require('telescope.pickers.entry_display')
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')

  local items, file_path = parse_commands_file()
  if not items or #items == 0 then
    vim.notify('No commands found in ' .. (file_path or 'commands.md'), vim.log.levels.WARN)
    return
  end

  local displayer = entry_display.create {
    separator = ' │ ',
    items = {
      { width = 24 },
      { width = 42 },
      { remaining = true },
    },
  }

  local function entry_maker(entry)
    return {
      value = entry,
      display = function(e)
        local is_tip = e.value.cmd == '💡 Tip'
        local cmd_hl = is_tip and 'Comment' or 'Function'
        return displayer {
          { e.value.cmd, cmd_hl },
          { e.value.desc },
          { e.value.category, 'Comment' },
        }
      end,
      ordinal = string.format('%s %s %s', entry.cmd, entry.desc, entry.category),
      filename = entry.filename,
      path = entry.filename,
      lnum = entry.lnum,
      col = 1,
    }
  end

  pickers.new(opts, {
    prompt_title = ' 󰋖 Search Commands (Enter: copy | C-p: popup doc | C-e: exec) ',
    finder = finders.new_table {
      results = items,
      entry_maker = entry_maker,
    },
    sorter = conf.generic_sorter(opts),
    previewer = conf.qflist_previewer(opts),
    attach_mappings = function(prompt_bufnr, map)
      -- Default Enter: Copy command to clipboard and notify
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then
          local item = selection.value
          if item.cmd and item.cmd ~= '' and item.cmd ~= '💡 Tip' then
            vim.fn.setreg('+', item.cmd)
            vim.fn.setreg('"', item.cmd)
            vim.notify(
              string.format('📋 Copied "%s" to clipboard! (%s)', item.cmd, item.desc),
              vim.log.levels.INFO
            )
          else
            vim.notify(string.format('%s: %s', item.category, item.desc), vim.log.levels.INFO)
          end
        end
      end)

      -- <C-p>: Open commands.md in floating popup at the exact line
      map({ 'i', 'n' }, '<C-p>', function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then
          M.popup(selection.lnum)
        else
          M.popup()
        end
      end)

      -- <C-o>: Open commands.md in editor buffer to edit/read full file
      map({ 'i', 'n' }, '<C-o>', function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then
          vim.cmd(string.format('edit +%d %s', selection.lnum, selection.filename))
        end
      end)

      -- <C-e>: Populate Ex command into command line (if starts with ':')
      map({ 'i', 'n' }, '<C-e>', function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection and selection.value.cmd ~= '' then
          local cmd = selection.value.cmd
          if cmd:sub(1, 1) == ':' then
            cmd = cmd:sub(2)
          end
          vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes(':' .. cmd, true, false, true),
            'n',
            false
          )
        end
      end)

      -- <C-y>: Copy command to clipboard
      map({ 'i', 'n' }, '<C-y>', function()
        local selection = action_state.get_selected_entry()
        if selection and selection.value.cmd ~= '' and selection.value.cmd ~= '💡 Tip' then
          vim.fn.setreg('+', selection.value.cmd)
          vim.fn.setreg('"', selection.value.cmd)
          actions.close(prompt_bufnr)
          vim.notify('📋 Copied to clipboard: ' .. selection.value.cmd, vim.log.levels.INFO)
        end
      end)

      return true
    end,
  }):find()
end

-- Setup user commands and keymaps
function M.setup()
  -- User commands
  vim.api.nvim_create_user_command('Commands', function()
    M.search()
  end, { desc = 'Search commands reference by keyword in Telescope popup' })

  vim.api.nvim_create_user_command('CheatSheet', function()
    M.search()
  end, { desc = 'Search commands reference by keyword in Telescope popup' })

  vim.api.nvim_create_user_command('CommandsDoc', function()
    M.popup()
  end, { desc = 'Open commands.md cheat sheet in a floating popup window' })

  vim.api.nvim_create_user_command('CommandsPopup', function()
    M.popup()
  end, { desc = 'Open commands.md cheat sheet in a floating popup window' })

  -- Keymaps
  vim.keymap.set('n', '<leader>sc', M.search, { desc = '[S]earch [C]ommands Reference' })
  vim.keymap.set('n', '<leader>sC', M.popup, { desc = '[S]how [C]ommands Doc (Popup)' })
  vim.keymap.set('n', '<leader>?', M.search, { desc = 'Search Commands Cheat Sheet' })
end

return M
