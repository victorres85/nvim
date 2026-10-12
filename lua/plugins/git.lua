return {
  { -- Diffs, merge conflicts and file history
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory', 'DiffviewToggleFiles' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = '[G]it [D]iff view' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = '[G]it file [H]istory' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = '[G]it branch [H]istory' },
      { '<leader>gq', '<cmd>DiffviewClose<cr>', desc = '[G]it diffview [Q]uit' },
    },
    opts = {},
  },

  { -- Magit-style interface for staging and committing
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = '[G]it Neogit' },
      { '<leader>gc', '<cmd>Neogit commit<cr>', desc = '[G]it [C]ommit' },
    },
    opts = { integrations = { diffview = true, telescope = true } },
  },
}
