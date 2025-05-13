local PluginManager = require("brew-sessions.manager")

local BrewSessions = {}

local defaults = {
  sessions_path = vim.fn.stdpath("data") .. "/brew-sessions/"
}


function BrewSessions.setup(config)
  if config == nil then
    config = {}
  end

  PluginManager.setup(vim.tbl_deep_extend("force", defaults, config))
end

function BrewSessions.select_project(project)
  -- Get all modified buffers
  local unsaved_buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, 'modified') and vim.api.nvim_buf_get_option(buf, 'buflisted') then
      local name = vim.api.nvim_buf_get_name(buf)
      table.insert(unsaved_buffers, {
        buf = buf,
        name = name ~= "" and name or "[No Name]"
      })
    end
  end

  -- If no unsaved changes, just run the callback
  if #unsaved_buffers == 0 then
    project:load_session()
    return
  end

  -- Show confirmation dialog
  vim.ui.select(
    { "Save", "Discard", "Cancel" },
    { prompt = "You have unsaved changes. What to do?" },
    function(choice)
      if choice == "Cancel" then
        return false
      elseif choice == "Save" then
        -- Save all buffers
        vim.cmd(":CBSaveAll")
      elseif choice == "Discard" then
        vim.cmd(":bufdo e!")
        vim.cmd(":CBSaveSession")
      end

      project:load_session()
    end
  )
end

function BrewSessions.brew_sessions(opts)
  opts = opts or {}

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new(opts, {
    prompt_title = "Brew Sessions - Project List",
    finder = finders.new_table {
      results = PluginManager.projects,
      entry_maker = function(entry)
        return {
          value = entry,                             -- The entire item table
          display = entry.name .. " (" .. entry.path .. ")",
          ordinal = entry.name .. " " .. entry.path, -- For search
        }
      end
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local project = action_state.get_selected_entry().value

        BrewSessions.select_project(project)
      end)
      return true
    end,
  }):find()
end

return BrewSessions
