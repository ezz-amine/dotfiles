local autocmd = vim.api.nvim_create_autocmd
local f = cb_mod("projects.functions")
local M = {}

local function post_session()
  local checked = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) then
      local bufname = vim.api.nvim_buf_get_name(buf)
      if not checked[bufname] then
        table.insert(checked, bufname)
        if not vim.fn.filereadable(bufname) then
          vim.api.nvim_buf_delete(buf, { force = true })
          f.notify("'" .. vim.fs.abspath(bufpath) .. "' can't be found", vim.log.levels.WARN)
        end
      end
    end
  end

  vim.defer_fn(function()
    pcall(function()
      vim.cmd("edit")
    end)
  end, 300)
end

function load_session(ProjectsManager)
  local project = ProjectsManager.find_project_by_cwd()
  if project == nil then
    f.notify("no project found for '" .. vim.fn.getcwd() .. "'", vim.log.levels.WARN)
  elseif not project:is_current() then
    project:load_session()
  end
end

function M.register(ProjectsManager)
  autocmd("SessionLoadPost", { callback = post_session })

  autocmd("VimEnter", {
    callback = function()
      if vim.fn.argc() == 0 then
        -- vim.schedule(function()
        load_session(ProjectsManager)
        -- end)
      else
        local arg0 = vim.fn.argv(0)
        if type(arg0) == "string" and vim.fn.isdirectory(arg0) == 1 then
          vim.cmd("cd " .. vim.fn.argv(0))
        end
      end
    end,
  })

  autocmd("DirChanged", {
    callback = function()
      load_session(ProjectsManager)
    end,
  })

  if vim.g.save_session_at_exit then
    autocmd("VimLeavePre", {
      callback = function()
        ProjectsManager.save_current_project()
      end,
    })
  end
end

return M
