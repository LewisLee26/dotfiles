return {
  {
    'stevearc/dressing.nvim',
    enabled = false,
  },
  {
    'VonHeikemen/fine-cmdline.nvim',
    enabled = false,
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
    },
    config = function()
      vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<CR>', '<cmd>FineCmdline<CR>', { noremap = true })
    end,
  },
}
