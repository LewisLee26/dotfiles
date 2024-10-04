return {
  {
    'GCBallesteros/jupytext.nvim',
    config = function()
      require('jupytext').setup {
        custom_language_formatting = {
          python = {
            extension = 'md',
            style = 'markdown',
            force_ft = 'markdown',
          },
        },
      }
    end,
    lazy = false,
  },

  {

    'quarto-dev/quarto-nvim',
    ft = { 'quarto', 'markdown' },
    dependencies = {
      'nvim-cmp',
      'nvim-lspconfig',
      'otter.nvim',
    },
    config = function()
      local quarto = require 'quarto'
      quarto.setup {
        lspFeatures = {
          languages = { 'python' },
          chunks = 'all', -- 'curly' or 'all'
          diagnostics = {
            enabled = true,
            triggers = { 'BufWritePost' },
          },
          completion = {
            enabled = true,
          },
        },
        keymap = {
          hover = 'H',
          definition = 'gd',
          rename = '<leader>rn',
          references = 'gr',
          format = '<leader>gf',
        },
        codeRunner = {
          enabled = true,
          ft_runners = {
            bash = 'slime',
          },
          default_method = 'molten',
        },
      }

      -- local runner = require 'quarto.runner'
      --
      -- -- Set up key mappings for quarto.runner
      -- vim.keymap.set('n', '<leader>rc', runner.run_cell, { desc = 'run cell', silent = true })
      -- vim.keymap.set('n', '<leader>ra', runner.run_above, { desc = 'run cell and above', silent = true })
      -- vim.keymap.set('n', '<leader>rA', runner.run_all, { desc = 'run all cells', silent = true })
      -- -- vim.keymap.set("n", "<leader>rl", runner.run_line, { desc = "run line", silent = true })
      -- vim.keymap.set('v', '<leader>r', runner.run_range, { desc = 'run visual range', silent = true })
      -- vim.keymap.set('n', '<leader>RA', function()
      --   runner.run_all(true)
      -- end, { desc = 'run all cells of all languages', silent = true })

      vim.keymap.set('n', '<localleader>qp', quarto.quartoPreview, { desc = 'Preview the Quarto document', silent = true, noremap = true })
      -- to create a cell in insert mode, I have the ` snippet
      vim.keymap.set('n', '<localleader>cc', 'i`<c-j>', { desc = 'Create a new code cell', silent = true })
      vim.keymap.set('n', '<localleader>cs', 'i```\r\r```{}<left>', { desc = 'Split code cell', silent = true, noremap = true })
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
    ft = { 'markdown', 'quarto', 'norg' },
    opts = {},
  },
}
