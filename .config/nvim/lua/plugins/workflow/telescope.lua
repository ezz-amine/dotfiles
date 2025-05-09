local vars = require("coldbrew.vars")
local fzf_build = "make" -- "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"

if vars.is_windows then
  fzf_build = "cmake -S. -Bbuild -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"  -- LLVM/clang compilation
end

return {
    {
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",  -- Stable version
      dependencies = {
        "nvim-lua/plenary.nvim",  -- Required
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-frecency.nvim",  -- For smart sorting
        "kkharji/sqlite.lua",                      -- Required for frecency
        "rcarriga/nvim-notify", -- notification as popups/toasts
      },
      config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local config = require("config.telescope")

        telescope.setup({
          defaults = {
            file_ignore_patterns = vars.find_excludes,
            vimgrep_arguments = config.find_cmd,
            mappings = {
              i = {
                ["<C-t>"] = actions.select_tab,       -- Open in new tab
                ["<M-t>"] = actions.select_horizontal, -- Open in split
                ["<C-M-t>"] = actions.select_vertical,   -- Open in vsplit
              },
              n = {
                ["<C-t>"] = actions.select_tab,
                ["<M-t>"] = actions.select_horizontal,
                ["<C-M-t>>"] = actions.select_vertical,
              }
            },
            layout_strategy = "horizontal",  -- or 'vertical'
            layout_config = {
              prompt_position = "top",
            },
            sorting_strategy = "ascending",
          },
          pickers = {
            find_files = {
              vimgrep_arguments = config.find_cmd,
            },
            live_grep = {
              vimgrep_arguments = config.grep_cmd
            }
          },
          extensions = {
            fzf = {  -- Enable if using fzf-native
              fuzzy = true,
              override_generic_sorter = true,
              override_file_sorter = true,
              case_mode = "smart_case",
              fzf_bin = vim.fn.exepath('fzf')
            },
            frecency = {
              show_scores = true,  -- Show how often you use files
              ignore_patterns = {"*.git/*", "node_modules/*"}  -- Ignore noise
            }
          },
        })

        -- Load extensions - immediately
        config.load_extensions()
      end,
    },
    -- Optional performance booster (compile on install)
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = fzf_build,
      lazy = true,
      config = function()
        require('telescope').load_extension('fzf')
      end
    },
  }