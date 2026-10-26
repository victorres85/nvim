-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Netrw
-- vim.keymap.set('n', '<leader>pv', '<cmd>Ex<cr>', {})

-- NvimTree
 vim.keymap.set('n', '<leader>pv', '<cmd>NvimTreeToggle<cr>', {})

-- V all
vim.keymap.set('n', '<leader>va', 'gg0vG$', {})

-- Delete all buffers
vim.keymap.set('n', '<leader>bd', '<cmd>%bd|e#<cr>', {})

-- Scoll down and up
vim.keymap.set('n', '<C-d>', '<C-d>zz', {})
vim.keymap.set('n', '<C-u>', '<C-u>zz', {})

-- Break line after cursor
vim.keymap.set('n', '<CR>', 'a<CR><Esc>', { desc = 'Break line after cursor' })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', function()
  local line_diags = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
  if #line_diags > 0 then
    vim.diagnostic.open_float()
  else
    local all_diags = vim.diagnostic.get(0)
    if #all_diags > 0 then
      vim.notify(string.format('No diagnostics on this line (%d in buffer - press ]d to jump)', #all_diags), vim.log.levels.INFO)
    else
      vim.notify('No diagnostics in buffer', vim.log.levels.INFO)
    end
  end
end, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- Comment out or remove these lines to avoid conflicts with vim-tmux-navigator
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Switch back to last buffer more intuitively
vim.keymap.set('n', '<leader><Tab>', '<C-^>')

-- Terminal and split keymaps
vim.keymap.set('n', '<leader>tt', '<cmd>term<cr>', { desc = 'Open [T]erminal' })
vim.keymap.set('n', '<leader>ts', '<cmd>sp | term<cr>', { desc = 'Open [T]erminal in [S]plit' })
vim.keymap.set('n', '<leader>tv', '<cmd>vsp | term<cr>', { desc = 'Open [T]erminal in [V]ertical split' })

-- Quick Python file creation with directory structure
vim.keymap.set('n', '<leader>np', function()
  local path = vim.fn.input('Enter Python file path: ')
  if path ~= '' then
    vim.cmd('call mkdir(fnamemodify("' .. path .. '", ":h"), "p")')
    vim.cmd('e ' .. path)
  end
end, { desc = '[N]ew [P]ython file' })

-- Dynamic directory search
vim.keymap.set('n', '<leader>sds', function()
  local path = vim.fn.input('Enter search directory (relative path): ')
  if path ~= '' then
    require('telescope.builtin').live_grep({
      search_dirs = {path}
    })
  end
end, { desc = '[S]earch in [D]irectory' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
