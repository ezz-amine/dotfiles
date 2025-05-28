local config = cb_config("treesitter")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects", -- Better text objects
      "windwp/nvim-ts-autotag",                      -- Auto-close HTML tags LINUX ONLY
    },
    config = function()
      require("nvim-treesitter.configs").setup(config.main_config)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = config.context_opts
  },
  -- Optional: Auto-close tags for HTML/JSX (works with Python f-strings) LINUX ONLY
  {
    "windwp/nvim-ts-autotag",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("nvim-ts-autotag").setup(config.autotag_config)
    end,
  }
}
