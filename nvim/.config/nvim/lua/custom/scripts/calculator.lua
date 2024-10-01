-- Table to store variables
local variables = {}

-- History of calculations
local history = {}

-- Default precision
local precision = 2

-- Function to evaluate the expression
local function evaluate_expression(input)
  -- Check for empty input
  if not input or input == '' then
    vim.notify('No input provided.', vim.log.levels.WARN)
    return
  end

  -- Handle variable assignment (e.g., x = 5)
  if input:match '^%s*%a+%s*=%s*[%d%.]+' then
    local var_name, value = input:match '^(%a+)%s*=%s*([%d%.]+)'
    if var_name and value then
      variables[var_name] = tonumber(value)
      vim.notify(var_name .. ' set to ' .. value, vim.log.levels.INFO)
      return
    else
      vim.notify('Invalid variable assignment.', vim.log.levels.ERROR)
      return
    end
  end

  -- Replace variable names in the input with their values
  for var_name, value in pairs(variables) do
    input = input:gsub(var_name, tostring(value))
  end

  -- Allow math functions like log, sin, cos, etc., and constants like pi and e
  local expression = input
    :gsub('log', 'math.log')
    :gsub('sqrt', 'math.sqrt')
    :gsub('sin', 'math.sin')
    :gsub('cos', 'math.cos')
    :gsub('tan', 'math.tan')
    :gsub('exp', 'math.exp')
    :gsub('tanh', 'math.tanh')
    :gsub('pi', tostring(math.pi)) -- Replace 'pi' with math.pi
    :gsub('e', tostring(math.exp(1))) -- Replace 'e' with Euler's number

  -- Safely evaluate the expression using pcall
  local success, result = pcall(load('return ' .. expression))
  if success and result then
    -- Add the calculation to history
    table.insert(history, input .. ' = ' .. tostring(result))

    -- Format the result to the specified precision
    return string.format('%.' .. precision .. 'f', result)
  else
    -- Handle errors and notify the user
    local error_message = result and result:match ': (.+)$' or 'Unknown error'
    vim.notify('Error: ' .. error_message, vim.log.levels.ERROR)
    return nil
  end
end

-- Key mapping for insert mode calculator
vim.keymap.set('i', '<C-c>', function()
  vim.ui.input({ prompt = 'Calculator (precision: ' .. precision .. '): ' }, function(input)
    local result = evaluate_expression(input)
    if result then
      vim.api.nvim_feedkeys(result, 'i', true)
    end
  end)
end)

-- Command for calculator in command-line mode (normal mode)
vim.api.nvim_create_user_command('Calc', function(opts)
  local result = evaluate_expression(opts.args)
  if result then
    vim.notify('Result: ' .. result, vim.log.levels.INFO)
  end
end, { nargs = 1 })

-- Command to view calculation history
vim.api.nvim_create_user_command('CalcHistory', function()
  if #history == 0 then
    vim.notify('No history available.', vim.log.levels.WARN)
  else
    vim.notify(table.concat(history, '\n'), vim.log.levels.INFO)
  end
end, {})

-- Command to clear calculation history
vim.api.nvim_create_user_command('ClearCalcHistory', function()
  history = {}
  vim.notify('Calculation history cleared.', vim.log.levels.INFO)
end, {})

-- Command to set precision
vim.api.nvim_create_user_command('SetCalcPrecision', function(opts)
  local new_precision = tonumber(opts.args)
  if new_precision and new_precision >= 0 then
    precision = new_precision
    vim.notify('Precision set to ' .. precision, vim.log.levels.INFO)
  else
    vim.notify('Invalid precision value.', vim.log.levels.ERROR)
  end
end, { nargs = 1 })
