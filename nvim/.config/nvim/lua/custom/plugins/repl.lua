return {
  -- {
  --   'benlubas/molten-nvim',
  --   enabled = false,
  --   version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
  --   -- dependencies = { '3rd/image.nvim' },
  --   build = ':UpdateRemotePlugins',
  --   ft = { 'quarto', 'markdown' },
  --   init = function()
  --     vim.g.molten_image_provider = 'image.nvim'
  --     vim.g.molten_output_win_max_height = 20
  --     vim.keymap.set('n', '<localleader>mi', ':MoltenInit<CR>', { desc = 'Initialize Molten', silent = true })
  --     vim.api.nvim_create_autocmd('User', {
  --       pattern = 'MoltenInitPost',
  --       callback = function()
  --         -- quarto code runner mappings
  --         local r = require 'quarto.runner'
  --         vim.keymap.set('n', '<localleader>rc', r.run_cell, { desc = 'run cell', silent = true })
  --         vim.keymap.set('n', '<localleader>ra', r.run_above, { desc = 'run cell and above', silent = true })
  --         vim.keymap.set('n', '<localleader>rb', r.run_below, { desc = 'run cell and below', silent = true })
  --         vim.keymap.set('n', '<localleader>rl', r.run_line, { desc = 'run line', silent = true })
  --         vim.keymap.set('n', '<localleader>rA', r.run_all, { desc = 'run all cells', silent = true })
  --         vim.keymap.set('n', '<localleader>RA', function()
  --           r.run_all(true)
  --         end, { desc = 'run all cells of all languages', silent = true })
  --
  --         -- setup some molten specific keybindings
  --         vim.keymap.set('n', '<localleader>e', ':MoltenEvaluateOperator<CR>', { desc = 'evaluate operator', silent = true })
  --         vim.keymap.set('n', '<localleader>rr', ':MoltenReevaluateCell<CR>', { desc = 're-eval cell', silent = true })
  --         vim.keymap.set('v', '<localleader>r', ':<C-u>MoltenEvaluateVisual<CR>gv', { desc = 'execute visual selection', silent = true })
  --         vim.keymap.set('n', '<localleader>os', ':noautocmd MoltenEnterOutput<CR>', { desc = 'open output window', silent = true })
  --         vim.keymap.set('n', '<localleader>oh', ':MoltenHideOutput<CR>', { desc = 'close output window', silent = true })
  --         vim.keymap.set('n', '<localleader>md', ':MoltenDelete<CR>', { desc = 'delete Molten cell', silent = true })
  --         local open = false
  --         vim.keymap.set('n', '<localleader>ot', function()
  --           open = not open
  --           vim.fn.MoltenUpdateOption('auto_open_output', open)
  --         end)
  --
  --         -- if we're in a python file, change the configuration a little
  --         if vim.bo.filetype == 'python' then
  --           vim.fn.MoltenUpdateOption('molten_virt_lines_off_by_1', false)
  --           vim.fn.MoltenUpdateOption('molten_virt_text_output', false)
  --         end
  --       end,
  --     })
  --   end,
  -- },
  {
    'benlubas/molten-nvim',
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    dependencies = { '3rd/image.nvim' },
    build = ':UpdateRemotePlugins',
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = 'image.nvim'
      vim.g.molten_use_border_highlights = true

      -- don't change the mappings (unless it's related to your bug)
      vim.keymap.set('n', '<localleader>mi', ':MoltenInit<CR>')
      vim.keymap.set('n', '<localleader>e', ':MoltenEvaluateOperator<CR>')
      vim.keymap.set('n', '<localleader>rr', ':MoltenReevaluateCell<CR>')
      vim.keymap.set('v', '<localleader>r', ':<C-u>MoltenEvaluateVisual<CR>gv')
      vim.keymap.set('n', '<localleader>os', ':noautocmd MoltenEnterOutput<CR>')
      vim.keymap.set('n', '<localleader>oh', ':MoltenHideOutput<CR>')
      vim.keymap.set('n', '<localleader>md', ':MoltenDelete<CR>')
    end,
  },
  {
    -- see the image.nvim readme for more information about configuring this plugin
    '3rd/image.nvim',
    enabled = true,
    opts = {
      backend = 'kitty', -- whatever backend you would like to use
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
    },
  },
}
