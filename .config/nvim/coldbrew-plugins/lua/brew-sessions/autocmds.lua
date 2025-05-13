local autocmd = vim.api.nvim_create_autocmd
local Path = require("plenary.path")
local f = require("brew-sessions.functions")
local M = {}



local function post_session()
  local checked = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) then
      local bufname = vim.api.nvim_buf_get_name(buf)
      if not checked[bufname] then
        table.insert(checked, bufname)
        bufname = Path:new(bufname)
        if not bufname:exists() then
          vim.api.nvim_buf_delete(buf, { force = true })
          f.notify('\'' .. bufname:absolute() .. '\' can\'t be found', vim.log.levels.WARN)
        end
      end
    end
  end

  vim.defer_fn(function()
    pcall(function()
      vim.cmd('edit')
    end)
  end, 300)
end



function M.register(ProjectsManager)
  autocmd('SessionLoadPost', { callback = post_session })

  autocmd("VimEnter", {
    callback = function()
      local project = ProjectsManager.find_project_by_cwd()
      if project == nil then
        f.notify("no project found for '" .. vim.fn.getcwd() .. "'", vim.log.levels.WARN)
      else
        project:load_session()
      end
    end
  })

  if vim.g.save_session_at_exit then
    autocmd("VimLeavePre", {
      callback = function()
        ProjectsManager.save_current_project()
      end
    })
  end
end

return M
