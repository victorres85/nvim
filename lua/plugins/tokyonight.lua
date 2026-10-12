return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- Custom fixed-hex port of Claude Code's dark-daltonized theme
      -- (colors/claude-daltonized.lua). tokyonight stays installed; swap the
      -- name back to 'tokyonight-storm' to return to it.
      vim.cmd.colorscheme 'claude-daltonized'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
