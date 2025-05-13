local create = vim.api.nvim_create_user_command
local M = {}

function M.register(ProjectsManager)
  create('CBNewProject', function(opts)
    ProjectsManager.create(opts.args)
  end, { nargs = "+" })

  create(
    'CBSaveSession',
    function(opts)
      ProjectsManager.save_current_project(opts.args)
    end,
    { nargs = "?" }
  )

  create(
    'CBListProjects',
    function(opts)
      vim.cmd(":Telescope brew_sessions")
    end,
    { nargs = 0 }
  )
end

return M
