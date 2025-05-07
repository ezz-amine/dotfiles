return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects", -- Better text objects
      "windwp/nvim-ts-autotag", -- Auto-close HTML tags LINUX ONLY
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Install parsers synchronously
        sync_install = false,
        -- Automatically install parsers for these filetypes
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        -- Enable indentation (better than default vim indent)
        indent = { enable = true },
        -- Text objects support
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
        -- Language-specific configurations
        ensure_installed = {
          "python",
          "lua",
          "bash",
          "markdown",
          "vim",
          "vimdoc",
          "html",
          "css"
        },
      })
    end,
  },
  -- Optional: Auto-close tags for HTML/JSX (works with Python f-strings) LINUX ONLY
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup({
        filetypes = { "html", "xml", "python" }, -- Works with Python f-strings
      })
    end,
  },
}
