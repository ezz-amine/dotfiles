local lualine_require = require("lualine_require")
local M = lualine_require.require("lualine.component"):extend()
local CBPython = cb_mod("python")

local function has_current_project()
  return cb_mod("projects.manager").current_project ~= nil
end

function M:init(options)
  options = options or {}
  -- options.color = { fg = "#7aa2f7" }
  options.icon = ""
  options.color = {}
  M.super.init(self, options)
  self.icon_color = { fg = "#c53b53" }
end

function M:update_status()
  --
  if CBPython.current_venv ~= nil then
    self.icon_color = { fg = "#41a6b5" }
    return CBPython.current_venv:printable_name()
  end

  return "󰟢"
end

-- function M:apply_icon()
--   local icon_highlight = self:create_hl(self.icon_color)
--   icon = self:format_hl(icon_highlight) .. self.options.icon .. self:get_default_hl()
--   self.status = icon .. " " .. self.status
-- end
 
return M
