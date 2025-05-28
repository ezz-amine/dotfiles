local M = {}

function M.get_arg(args, index, default)
  return args and args[index] or default
end

function M.notify(msg, level)
  vim.notify(msg, level, { title = "ColdBrew - Projects" })
end

return M
