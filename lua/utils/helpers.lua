local helpers = {}

helpers.harpoon_file = function()
  local mark = require 'harpoon.mark'
  local action_state = require 'telescope.actions.state'
  local state = action_state.get_selected_entry()
  local buf = vim.bo.ft
  print '🔱'
  if buf == 'TelescopePrompt' then
    mark.add_file(state.value)
  else
    mark.add_file()
  end
end

helpers.create_temp_buffer = function(bufr_fn, filetype)
  vim.cmd 'vnew'
  vim.cmd 'set buftype=nofile'
  vim.cmd 'set bufhidden=delete'
  if filetype ~= nil then
    vim.cmd('set filetype=' .. filetype)
  end
  if bufr_fn ~= nil then
    bufr_fn()
  end
end

helpers.curl_to_temp_buffer = function(curl, filetype)
  local temp_buffer_callback = function() vim.cmd('read !' .. curl) end
  helpers.create_temp_buffer(temp_buffer_callback, filetype)
end

helpers.print_table = function(_table) print(table.concat(_table, ', ')) end

helpers.get_word_under_cursor = function() return vim.fn.expand '<cword>' end

return helpers
