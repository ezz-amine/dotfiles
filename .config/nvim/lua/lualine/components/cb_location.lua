local lualine_require = require("lualine_require")
local M = lualine_require.require("lualine.component"):extend()

local function progress(cur, total)
  if cur == 1 then
    return " 󰞖 "
  elseif cur == total then
    return " 󰞙 "
  else
    return string.format("%2d%%%%", math.floor(cur / total * 100))
  end
end

function M:init(options)
  options = options or {}
  M.super.init(self, options)
end

function M:update_status()
  local line = vim.fn.line(".")
  local col = vim.fn.charcol(".")
  local location = string.format("%2d:%-2d", line, col)
  local total = vim.fn.line("$")

  return location .. "[" .. progress(line, total) .. "]"
end

return M
