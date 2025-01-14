-- Function to sync the Obsidian vault with Git
function _G.sync_obsidian_vault()
  local confirm = vim.fn.confirm('Sync vaults with Git?', '&Yes\n&No', 2)
  if confirm ~= 1 then
    print 'Sync canceled.'
    return
  end
  local obsidian_path = '~/vaults'
  local git_sync_command = [[
    cd ]] .. obsidian_path .. [[ &&
    git add . &&
    git commit -m "Shortcut sync all vaults" &&
    git push
  ]]
  -- Execute the command and capture the output and error
  local output = vim.fn.system(git_sync_command)
  local success = vim.v.shell_error == 0

  if success then
    print 'Obsidian vault synced with Git!'
  else
    print 'Error syncing Obsidian vault with Git:'
    print(output)
  end
end

-- Map <C-s> to the sync function
vim.api.nvim_set_keymap('n', '<C-s>', ':lua sync_obsidian_vault()<CR>', { noremap = true, silent = true })
