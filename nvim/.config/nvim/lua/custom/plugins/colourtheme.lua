return {
  {
    'savq/melange-nvim',
    lazy = false,
    priority = 1001, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd.colorscheme 'melange'
      vim.api.nvim_set_hl(0, 'Normal', { bg = '#0D0B0B' })
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1001, -- make sure to load this before all the other start plugins
    -- config = function()
    --   -- Load the colorscheme here
    --   vim.cmd.colorscheme 'github_dark_high_contrast'
    --
    --   -- You can configure highlights by doing something like
    --   vim.cmd.hi 'Comment gui=none'
    -- end,
  },

  {
    'rebelot/kanagawa.nvim',
  },
  {
    'ellisonleao/gruvbox.nvim',
  },
  {
    'xero/miasma.nvim',
  },
  {
    'ribru17/bamboo.nvim',
  },
}
