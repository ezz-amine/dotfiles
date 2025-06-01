local lualine_require = require("lualine_require")
local M = lualine_require.require("lualine.component"):extend()

local function has_current_project()
  return cb_mod("projects.manager").current_project ~= nil
end

function M:init(options)
  options = options or {}
  options.icon = { "󱥾", color = { fg = "#ffc777" } }
  options.color = { fg = "#7aa2f7" }

  M.super.init(self, options)
end

function M:update_status()
  return cb_mod("projects.manager").get_current_project_name()
end

return M
