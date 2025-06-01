local f = cb_mod("projects.functions")
local Project = {}

local function neotree_opened()
  local neotree_last_source = require("neo-tree.command")._last.source
  local neotree_open = false
  if neotree_last_source ~= nil then
    neotree_open = require("neo-tree.sources.manager").get_state(neotree_last_source) ~= nil
  end

  return neotree_open
end

-- Constructor
function Project.new(name, options)
  local active_session
  local sessions
  local path

  if options["path"] then
    path = options["path"]
  else
    f.notify("project must have a path", vim.log.levels.ERROR)
  end

  if options["active_session"] then
    active_session = options["active_session"]
  else
    active_session = "default"
  end

  if options["sessions"] then
    sessions = options["sessions"]
  else
    sessions = { "default" }
  end

  local self = setmetatable({
    name = name,
    path = path,
    active_session = active_session,
    sessions = sessions,
  }, { __index = Project })

  return self
end

function Project:config_path()
  return cb_mod("projects.manager").project_path(self.name)
end

function Project:save_session( --[[optional]] session_name)
  local is_neotree_opened = neotree_opened()
  if session_name == nil or session_name == "" then
    session_name = self.active_session
  end

  vim.cmd(":Neotree close") -- close neotree if open (no need to check), to not cause issues when reloading the sessions
  vim.cmd(":mksession! " .. self:config_path() .. "/" .. session_name .. ".vim")

  if is_neotree_opened then
    vim.cmd(":Neotree show") -- re-open neotree if it was opened before the sessions saving process
  end

  f.notify("project '" .. self.name .. "' saved")
end

function Project:load_session( --[[optional]] session_name)
  local is_neotree_opened = neotree_opened()
  local manager = cb_mod("projects.manager")

  if session_name == nil or session_name == "" then
    session_name = self.active_session
  end

  if manager.current_project ~= self then
    manager.current_project = self

    local cwd = vim.fn.getcwd()

    vim.cmd(":Neotree close")
    vim.cmd(":CBCloseAll")
    vim.cmd(":source " .. self:config_path() .. "/" .. session_name .. ".vim")

    if is_neotree_opened then
      vim.cmd(":Neotree show") -- re-open neotree if it was opened before the sessions saving process
    end
    if vim.g.preserve_cwd then
      vim.cmd(":cd " .. cwd)
    end

    vim.cmd("bufdo filetype detect")

    f.notify("project '" .. self.name .. "' loaded")
  else
    f.notify("project '" .. self.name .. "' is already loaded")
  end
end

return Project
