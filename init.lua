vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Commands Cheat Sheet ]]
require('cheatsheet').setup()

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

vim.keymap.set('n', '<leader>rr', function()
  vim.cmd('source ~/.config/nvim/init.lua')
  vim.notify('Configuration reloaded!', vim.log.levels.INFO)
end, { desc = '[R]eload [R]econfiguration' })
