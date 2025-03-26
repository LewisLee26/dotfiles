--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Remap C-z to increment numbers (C-a is used by wezterm)
vim.api.nvim_set_keymap('n', '<C-z>', '<C-a>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-z>', '<C-o><C-a>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-z>', '<C-a>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('c', '<C-z>', '<C-a>', { noremap = true, silent = true })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Paste without replacing buffer
vim.keymap.set('x', '<leader>p', [["_dP]])

-- End of previous work
vim.keymap.set({ 'n', 'v', 'x' }, '<C-e>', 'ge')
