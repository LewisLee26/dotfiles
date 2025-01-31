return {
  {
    'robitx/gp.nvim',
    config = function()
      local conf = {
        providers = {
          openai = {
            disable = false,
            endpoint = 'https://api.openai.com/v1/chat/completions',
            openai_api_key = os.getenv 'OPENAI_API_KEY',
          },
          anthropic = {
            disable = true,
            endpoint = 'https://api.anthropic.com/v1/messages',
            secret = os.getenv 'ANTHROPIC_API_KEY',
          },
        },
      }
      require('gp').setup(conf)

      -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
      local function keymapOptions(desc)
        return {
          noremap = true,
          silent = true,
          nowait = true,
          desc = 'GPT prompt ' .. desc,
        }
      end

      -- Chat commands
      vim.keymap.set({ 'n', 'i' }, '<C-g>c', '<cmd>GpChatNew<cr>', keymapOptions 'New Chat')
      vim.keymap.set({ 'n', 'i' }, '<C-g>t', '<cmd>GpChatToggle<cr>', keymapOptions 'Toggle Chat')
      vim.keymap.set({ 'n', 'i' }, '<C-g>f', '<cmd>GpChatFinder<cr>', keymapOptions 'Chat Finder')

      vim.keymap.set('v', '<C-g>c', ":<C-u>'<,'>GpChatNew<cr>", keymapOptions 'Visual Chat New')
      vim.keymap.set('v', '<C-g>p', ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions 'Visual Chat Paste')
      vim.keymap.set('v', '<C-g>t', ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions 'Visual Toggle Chat')

      vim.keymap.set({ 'n', 'i' }, '<C-g><C-x>', '<cmd>GpChatNew split<cr>', keymapOptions 'New Chat split')
      vim.keymap.set({ 'n', 'i' }, '<C-g><C-v>', '<cmd>GpChatNew vsplit<cr>', keymapOptions 'New Chat vsplit')
      vim.keymap.set({ 'n', 'i' }, '<C-g><C-t>', '<cmd>GpChatNew tabnew<cr>', keymapOptions 'New Chat tabnew')

      vim.keymap.set('v', '<C-g><C-x>', ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions 'Visual Chat New split')
      vim.keymap.set('v', '<C-g><C-v>', ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions 'Visual Chat New vsplit')
      vim.keymap.set('v', '<C-g><C-t>', ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions 'Visual Chat New tabnew')
    end,
  },
}
