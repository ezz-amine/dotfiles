local fzf_build = "make" -- "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"

if vim.g.is_windows then
  fzf_build =
  "cmake -S. -Bbuild -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"   -- LLVM/clang compilation
end

return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",                           -- Stable version
    dependencies = {
      "nvim-lua/plenary.nvim",                  -- Required
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-frecency.nvim", -- For smart sorting
      "kkharji/sqlite.lua",                     -- Required for frecency
      "rcarriga/nvim-notify",                   -- notification as popups/toasts
    },
    config = function()
      local telescope = require("telescope")
      local config = cb_config("telescope")

      telescope.setup(config.body)

      -- Load extensions - immediately
      config.load_extensions(telescope)
    end,
  },
  -- Optional performance booster (compile on install)
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = fzf_build,
    lazy = true,
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },
}
