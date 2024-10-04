return {
  {
    'benlubas/molten-nvim',
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    -- dependencies = { '3rd/image.nvim' },
    build = ':UpdateRemotePlugins',
    init = function()
      -- these are examples, not defaults. Please see the readme
      -- vim.g.molten_image_provider = 'image.nvim'
      vim.g.molten_image_provider = 'wezterm'
      vim.g.molten_output_win_max_height = 20
    end,
    config = function()
      vim.keymap.set('n', '<leader>mi', ':MoltenInit<CR>', { silent = true, desc = 'Initialize the plugin' })
      vim.keymap.set('n', '<leader>e', ':MoltenEvaluateOperator<CR>', { silent = true, desc = 'run operator selection' })
      vim.keymap.set('n', '<leader>rl', ':MoltenEvaluateLine<CR>', { silent = true, desc = 'evaluate line' })
      vim.keymap.set('n', '<leader>rr', ':MoltenReevaluateCell<CR>', { silent = true, desc = 're-evaluate cell' })
      vim.keymap.set('v', '<leader>r', ':<C-u>MoltenEvaluateVisual<CR>gv', { silent = true, desc = 'evaluate visual selection' })
      vim.keymap.set('n', '<leader>rd', ':MoltenDelete<CR>', { silent = true, desc = 'molten delete cell' })
      vim.keymap.set('n', '<leader>oh', ':MoltenHideOutput<CR>', { silent = true, desc = 'hide output' })
      vim.keymap.set('n', '<leader>os', ':noautocmd MoltenEnterOutput<CR>', { silent = true, desc = 'show/enter output' })
    end,
  },

  {
    'GCBallesteros/jupytext.nvim',
    config = true,
    style = 'hydrogen',
    custom_language_formatting = {
      python = {
        extension = 'md',
        style = 'markdown',
        force_ft = 'markdown',
      },
    },
  },

  {

    'quarto-dev/quarto-nvim',
    ft = { 'quarto', 'markdown' },
    config = function()
      local runner = require 'quarto.runner'

      -- Set up key mappings for quarto.runner
      vim.keymap.set('n', '<leader>rc', runner.run_cell, { desc = 'run cell', silent = true })
      vim.keymap.set('n', '<leader>ra', runner.run_above, { desc = 'run cell and above', silent = true })
      vim.keymap.set('n', '<leader>rA', runner.run_all, { desc = 'run all cells', silent = true })
      -- vim.keymap.set("n", "<leader>rl", runner.run_line, { desc = "run line", silent = true })
      vim.keymap.set('v', '<leader>r', runner.run_range, { desc = 'run visual range', silent = true })
      vim.keymap.set('n', '<leader>RA', function()
        runner.run_all(true)
      end, { desc = 'run all cells of all languages', silent = true })
    end,
    lazy = false,
  },

  {
    'jpalardy/vim-slime',
    init = function()
      -- these two should be set before the plugin loads
      vim.g.slime_target = 'neovim'
      vim.g.slime_no_mappings = true
    end,
    config = function()
      vim.g.slime_input_pid = false
      vim.g.slime_suggest_default = true
      vim.g.slime_menu_config = false
      vim.g.slime_neovim_ignore_unlisted = false
      -- options not set here are g:slime_neovim_menu_order, g:slime_neovim_menu_delimiter, and g:slime_get_jobid
      -- see the documentation above to learn about those options

      -- called MotionSend but works with textobjects as well
      vim.keymap.set('n', 'gz', '<Plug>SlimeMotionSend', { remap = true, silent = false })
      vim.keymap.set('n', 'gzz', '<Plug>SlimeLineSend', { remap = true, silent = false })
      vim.keymap.set('x', 'gz', '<Plug>SlimeRegionSend', { remap = true, silent = false })
      vim.keymap.set('n', 'gzc', '<Plug>SlimeConfig', { remap = true, silent = false })
    end,
  },

  {
    'jmbuhr/otter.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },
}
