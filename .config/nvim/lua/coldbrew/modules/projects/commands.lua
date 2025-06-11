local create = vim.api.nvim_create_user_command
local M = {}

function M.register(ProjectsManager)
  create("CBNewProject", function(opts)
    ProjectsManager.create(opts.args)
  end, { nargs = "+" })

  create("CBSaveSession", function(opts)
    ProjectsManager.save_current_project(opts.args)
  end, { nargs = "?" })

  create("CBListProjects", function(opts)
    vim.cmd(":Telescope cb_projects")
  end, { nargs = 0 })

  create("CBEditProjects", function()
    local ProjectsManager = cb_mod("projects.manager")
    local wm = cb_require("windows")
    wm.open_file(ProjectsManager.config_path(), {
      window = {
        width = 1,  --0.95,
        height = 1, -- 0.95,
      },
      filetype = "lua",
    })
  end, { nargs = 0 })
end

return M
