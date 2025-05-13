local Path = require("plenary.path")
local f = require("brew-sessions.functions")
local Project = require("brew-sessions.project")


local ProjectsManager = {
  options = {},
  projects = {},
  current_project = nil
}

function ProjectsManager.setup(config)
  ProjectsManager.options = config

  ProjectsManager.load_projects()
  ProjectsManager.register_commands()
  ProjectsManager.register_auto_commands()
end

function ProjectsManager.base_path()
  return ProjectsManager.options.sessions_path
end

function ProjectsManager.register_path()
  return ProjectsManager.base_path() .. '.projects'
end

function ProjectsManager.project_path(project_name)
  return ProjectsManager.base_path() .. project_name
end

function ProjectsManager.load_projects()
  local ok, contents = pcall(
    function()
      return Path:new(ProjectsManager.register_path()):read()
    end
  )

  ProjectsManager.projects = {}
  if not ok or contents == nil then
    Path:new(ProjectsManager.register_path()):touch()
    return true
  end

  local data = vim.json.decode(contents)
  for project_name, project_data in pairs(data.projects) do
    table.insert(ProjectsManager.projects, Project.new(project_name, project_data))
  end

  return true
end

function ProjectsManager.unload_projects()
  local data = {
    projects = {}
  }

  for _, p in ipairs(ProjectsManager.projects) do
    data["projects"][p.name] = {
      path = p.path,
      active_session = p.active_session,
      sessions = p.sessions
    }
  end

  Path:new(ProjectsManager.register_path()):write(
    vim.json.encode(data), 'w'
  )
end

function ProjectsManager.register_commands()
  local Commands = require("brew-sessions.commands")
  Commands.register(ProjectsManager)
end

function ProjectsManager.register_auto_commands()
  local Commands = require("brew-sessions.autocmds")
  Commands.register(ProjectsManager)
end

function ProjectsManager.register_project(project)
  table.insert(ProjectsManager.projects, project)
  ProjectsManager.unload_projects()
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
  local current = Path:new(vim.fn.getcwd())
  for _, project in ipairs(ProjectsManager.projects) do
    if project.path == current:absolute() then
      return project
    elseif f.is_subfolder(project.path, current:absolute()) then
      return project
    end
  end

  return nil
end

function ProjectsManager.create(args)
  -- split args
  args = vim.split(args, "%s+")
  local project_name, project_dir = f.get_arg(args, 1), f.get_arg(args, 2, vim.fn.getcwd())
  project_dir = Path:new(project_dir)

  -- if the project_dir exists is keep the absolute path, if not it popup an error
  if not project_dir:exists() then
    f.notify(project_dir .. 'don\'t exists', vim.log.levels.ERROR)
    return false
  else
    project_dir = project_dir:absolute()
  end

  -- if the project exists (a folder already exists)
  if Path:new(ProjectsManager.project_path(project_name)):exists() then
    f.notify('project exists', vim.log.levels.WARN)
    return false
  end

  local ok, err = vim.fn.mkdir(ProjectsManager.project_path(project_name), "p")
  if ok == 0 then
    f.notify("failed to create directory: " .. err, vim.log.levels.ERROR)
  end

  local project = Project.new(project_name, { path = project_dir })

  ProjectsManager.register_project(project)
  ProjectsManager.current_project = project
  project:save_session()
  return true
end

return ProjectsManager
