local actions = require "telescope.actions"
local vars = cb_require "vars"
local small_pop_select = cb_config("ui").small_pop_select

local grep_cmd = {
  "rg",
  "--no-heading",
  "--with-filename",
  "--line-number",
  "--column",
  "--smart-case",
  "--hidden",        -- Search hidden files
  "--glob",
  "!.git/*",         -- Ignore .git
  "--glob",
  "!node_modules/*", -- Ignore node_modules
  "--follow",
}
local find_cmd = cb.tbl_merge(grep_cmd, { "--files" })
local extensions = { "file_browser", "frecency", "notify", "textcase", "ui-select" }

return {
  load_extensions = function(l_telescope)
    for _, ext in ipairs(extensions) do
      l_telescope.load_extension(ext)
    end
  end,
  body = {
    defaults = {
      file_ignore_patterns = vars.find_excludes,
      vimgrep_arguments = find_cmd,
      mappings = {
        i = {
          ["<C-t>"] = actions.select_tab,        -- Open in new tab
          ["<M-h>"] = actions.select_horizontal, -- Open in split
          ["<M-v>"] = actions.select_vertical,   -- Open in vsplit
        },
        n = {
          ["<C-t>"] = actions.select_tab,
          ["<M-h>"] = actions.select_horizontal,
          ["<M-v>"] = actions.select_vertical,
        },
      },
      layout_strategy = "horizontal", -- or 'vertical'
      layout_config = {
        prompt_position = "top",
      },
      sorting_strategy = "ascending",
    },
    pickers = {
      find_files = {
        find_command = find_cmd,
      },
      live_grep = {
        vimgrep_arguments = grep_cmd,
      },
    },
    extensions = {
      fzf = { -- Enable if using fzf-native
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
        fzf_bin = vim.fn.exepath "fzf",
      },
      file_browser = {
        hidden = { file_browser = true, folder_browser = true },
        respect_gitignore = 1,
        no_ignore = false,
        follow_symlinks = true,
        hijack_netrw = true,
      },
      frecency = {
        show_scores = true,                                -- Show how often you use files
        ignore_patterns = { "*.git/*", "node_modules/*" }, -- Ignore noise
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown(small_pop_select),
      },
      brew_sessions = {
        require("telescope.themes").get_dropdown(small_pop_select),
      },
    },
  },
}
