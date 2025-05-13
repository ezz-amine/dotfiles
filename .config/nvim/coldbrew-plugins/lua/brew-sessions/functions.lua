local M = {}

function M.get_arg(args, index, default)
  return args and args[index] or default
end

function M.notify(msg, level)
  vim.notify(msg, level, { title = 'ColdBrew - Session Brew' })
end

function M.is_subfolder(parent, child)
  local Path = require("plenary.path")

  local parent_path = Path:new(parent):absolute()
  local child_path = Path:new(child):absolute()
  return child_path:sub(1, #parent_path) == parent_path
end

return M
