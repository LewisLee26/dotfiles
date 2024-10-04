return {
  -- {
  --   'xiyaowong/transparent.nvim',
  --   lazy = false,
  --   extra_groups = {
  --     'Normal',
  --     'NonText',
  --   },
  -- },

  {
    'levouh/tint.nvim',
    tint = -45, -- Darken colors, use a positive value to brighten
    saturation = 0.6, -- Saturation to preserve
    tint_background_colors = false, -- Tint background portions of highlight groups
  },

  -- {
  --   'sunjon/shade.nvim',
  -- },

  -- {
  --   'miversen33/sunglasses.nvim',
  --   config = true,
  --   opts = {
  --     filter_type = 'SHADE',
  --     filter_percent = 0.8,
  --   },
  -- },

  {
    'projekt0n/github-nvim-theme',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1001, -- make sure to load this before all the other start plugins
    config = function()
      -- Load the colorscheme here
      vim.cmd.colorscheme 'github_dark_high_contrast'

      -- You can configure highlights by doing something like
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
