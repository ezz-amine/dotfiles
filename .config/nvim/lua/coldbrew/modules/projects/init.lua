local ProjectsManager = cb_mod "projects.manager"

local CBProjects = {}

local defaults = {
  sessions_path = vim.fn.stdpath "data" .. "/cb-sessions/",
}

function CBProjects.setup(config)
  if config == nil then
    config = {}
  end

  ProjectsManager.setup(vim.tbl_deep_extend("force", defaults, config))
end

function CBProjects.post_lazy() end

function CBProjects.select_project(project)
  -- Get all modified buffers
  local unsaved_buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, "modified") and vim.api.nvim_buf_get_option(buf, "buflisted") then
      local name = vim.api.nvim_buf_get_name(buf)
      table.insert(unsaved_buffers, {
        buf = buf,
        name = name ~= "" and name or "[No Name]",
      })
    end
  end

  -- If no unsaved changes, just run the callback
  if #unsaved_buffers == 0 then
    project:load_session()
    return
  end

  -- Show confirmation dialog
  vim.ui.select({ "Save", "Discard", "Cancel" }, { prompt = "You have unsaved changes. What to do?" }, function(choice)
    if choice == "Save" then
      -- Save all buffers
      vim.cmd ":CBSaveAll"
      project:load_session()
    elseif choice == "Discard" then
      vim.cmd ":bufdo e!"
      vim.cmd ":CBSaveSession"
      project:load_session()
    end
  end)
end

function CBProjects.ts_projects_list(opts)
  opts = opts or {}

  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  local small_select = cb_config("ui").small_pop_select

  pickers
      .new(opts, {
        prompt_title = "Brew Sessions - Project List",
        -- Smaller layout
        layout_config = small_select.layout_config,
        border = small_select.border,
        previewer = small_select.previewer,
        -- Smaller layout

        finder = finders.new_table {
          results = ProjectsManager.projects,
          entry_maker = function(entry)
            return {
              value = entry,                           -- The entire item table
              display = entry.name .. " (" .. entry.path .. ")",
              ordinal = entry.name .. " " .. entry.path, -- For search
            }
          end,
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local project = action_state.get_selected_entry().value

            CBProjects.select_project(project)
          end)
          return true
        end,
      })
      :find()
end

return CBProjects
