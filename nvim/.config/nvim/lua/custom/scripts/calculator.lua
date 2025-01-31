local popup = require 'plenary.popup'

-- Table to store the popup buffer and window
local PopupManager = {
  popup_buf = nil,
  popup_win = nil,
}

-- Function to create a popup with the given text
function PopupManager:show_popup(text)
  if self.popup_win and vim.api.nvim_win_is_valid(self.popup_win) then
    print 'Popup is already open! Close it first with :PopupDelete'
    return
  end

  -- Create a new buffer for the popup
  self.popup_buf = vim.api.nvim_create_buf(false, true) -- No file, no listed

  -- Set the text in the buffer
  vim.api.nvim_buf_set_lines(self.popup_buf, 0, -1, false, { text })

  -- Create the popup window
  self.popup_win = popup.create(self.popup_buf, {
    title = 'Popup',
    highlight = 'Normal',
    border = {
      '┌',
      '─',
      '┐',
      '│',
      '┘',
      '─',
      '└',
      '│',
    },
    line = math.floor((vim.o.lines - 3) / 2),
    col = math.floor((vim.o.columns - 40) / 2),
    minwidth = 40,
    minheight = 3,
  })

  -- Make the popup buffer modifiable
  vim.api.nvim_buf_set_option(self.popup_buf, 'modifiable', false)
end

-- Function to delete the popup
function PopupManager:delete_popup()
  if self.popup_win and vim.api.nvim_win_is_valid(self.popup_win) then
    vim.api.nvim_win_close(self.popup_win, true)
    self.popup_win = nil
    self.popup_buf = nil
  else
    print 'No popup to close!'
  end
end

-- Define the :Popupnew command
vim.api.nvim_create_user_command('Popupnew', function(opts)
  PopupManager:show_popup(opts.args)
end, {
  nargs = 1, -- Require exactly one argument
  complete = nil, -- No completion
})

-- Define the :PopupDelete command
vim.api.nvim_create_user_command('PopupDelete', function()
  PopupManager:delete_popup()
end, {})
