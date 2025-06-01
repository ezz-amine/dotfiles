local f = cb_mod("projects.functions")
local Project = cb_mod("projects.project")

local ProjectsManager = {
  options = {},
  config = {},
  projects = {},
  current_project = nil,
}

function ProjectsManager.setup(config)
  ProjectsManager.options = config

  ProjectsManager.load_projects()
  ProjectsManager.register_commands()
  ProjectsManager.register_auto_commands()
end

function ProjectsManager.base_path()
  return vim.fn.resolve(ProjectsManager.options.sessions_path)
end

function ProjectsManager.config_path()
  local path = vim.fs.joinpath(ProjectsManager.base_path(), ".projects")
  return vim.fs.abspath(vim.fn.resolve(path))
end

function ProjectsManager.project_path(project_name)
  local project_path = vim.fs.joinpath(ProjectsManager.base_path(), project_name)
  project_path = vim.fs.abspath(vim.fn.resolve(project_path))
  return project_path
end

local function _create_config_file()
  local file, err = io.open(ProjectsManager.config_path(), "w")
  if err ~= nil then
    error("Failed to create file: " .. tostring(err), vim.log.levels.ERROR)
  elseif file ~= nil then
    file:write(cb.serialize_config({}))
    file:close()
  end
end

local function check_config_dir()
  local dir_path, err = vim.loop.fs_realpath(ProjectsManager.base_path())
  if err ~= nil then
    local success, err = vim.fn.mkdir(ProjectsManager.base_path(), "p")
    if err ~= nil then
      error("Failed to create directory: " .. tostring(err), vim.log.levels.ERROR)
    end

    _create_config_file()
    return false
  end

  return true
end

local function check_config_file()
  local file_path, err = vim.loop.fs_realpath(ProjectsManager.config_path())

  if err ~= nil then
    _create_config_file()
    return false
  end

  return true
end

function ProjectsManager.get_config()
  if not check_config_dir() then
    return nil
  end

  local local_config = {}
  if check_config_file() then
    local_config = dofile(ProjectsManager.config_path())
  end
  ProjectsManager.config = {
    projects = vim.tbl_get(local_config, "projects") or {},
  }

  return ProjectsManager.config
end

function ProjectsManager.load_projects()
  local config = ProjectsManager.get_config()
  ProjectsManager.projects = {}
  if config ~= nil and vim.tbl_contains(vim.tbl_keys(config), "projects") then
    for project_name, project_data in pairs(config.projects) do
      table.insert(ProjectsManager.projects, Project.new(project_name, project_data))
    end
  end

  return true
end

function ProjectsManager.set_config()
  local data = cb.tbl_copy(ProjectsManager.config)

  for _, p in ipairs(ProjectsManager.projects) do
    data.projects[p.name] = {
      path = p.path,
      active_session = p.active_session or "default",
      sessions = p.sessions or {},
    }
  end

  serialized_table = cb.serialize_config(data)

  local file, err = io.open(ProjectsManager.config_path(), "w")
  if file ~= nil then
    file:write(serialized_table)
    file:close()
    local reformating_cmd = {
      "stylua",
      "--column-width",
      120,
      "--indent-type",
      "Spaces",
      "--indent-width",
      2,
      "--quote-style",
      "ForceDouble",
      "call-parentheses",
      "Always",
      "line-endings",
      "Unix",
      ProjectsManager.config_path() .. "2",
    }
    vim.fn.system(table.concat(reformating_cmd, " "))
  elseif err ~= nil then
    error("Failed to store config: " .. tostring(err), vim.log.levels.ERROR)
  else
    error("Failed to store config: UNKNOW ERROR", vim.log.levels.ERROR)
  end
end

function ProjectsManager.register_commands()
  local Commands = cb_mod("projects.commands")
  Commands.register(ProjectsManager)
end

function ProjectsManager.register_auto_commands()
  local Commands = cb_mod("projects.autocmds")
  Commands.register(ProjectsManager)
end

function ProjectsManager.register_project(project)
  table.insert(ProjectsManager.projects, project)
  ProjectsManager.set_config()
end

function ProjectsManager.get_current_project()
  return ProjectsManager.current_project
end

function ProjectsManager.save_current_project(args)
  if ProjectsManager.current_project == nil then
    f.notify("no project loaded", vim.log.levels.WARN)
  else
    ProjectsManager.current_project:save_session(args)
  end
end

function ProjectsManager.find_project_by_cwd()
  local raw_current = vim.fn.getcwd()
  local current, err = vim.loop.fs_realpath(raw_current)
  for _, project in ipairs(ProjectsManager.projects) do
    local project_path, err = vim.loop.fs_realpath(project.path)
    if err ~= nil then
      error(err)
      return nil
    end
    if current:sub(1, #project_path) == project_path or raw_current:sub(1, #project_path) == project_path then
      return project
    end
  end

  return nil
end

function ProjectsManager.create(args)
  args = vim.split(args, "%s+")
  local project_name, raw_project_dir = f.get_arg(args, 1), f.get_arg(args, 2, vim.fn.getcwd())
  local project_dir, err = vim.loop.fs_realpath(raw_project_dir)

  if err ~= nil then
    f.notify(raw_project_dir .. "is not a valid path", vim.log.levels.ERROR)
    return false
  end

  local project_rc_path = ProjectsManager.project_path(project_name)
  local _, err = vim.loop.fs_realpath(project_rc_path)

  if err == nil then
    f.notify("project " .. project_name .. " already exists, nothing happend", vim.log.levels.WARN)
    return false
  end

  local success, err = vim.fn.mkdir(project_rc_path, "p")

  if success == nil or err ~= nil then
    f.notify("Failed to create directory: " .. tostring(err), vim.log.levels.ERROR)
    return false
  end

  local project = Project.new(project_name, { path = project_dir })

  ProjectsManager.register_project(project)
  ProjectsManager.current_project = project
  project:save_session()
  return true
end

return ProjectsManager
