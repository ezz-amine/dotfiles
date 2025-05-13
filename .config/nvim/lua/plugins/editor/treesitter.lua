return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects", -- Better text objects
      "windwp/nvim-ts-autotag",                      -- Auto-close HTML tags LINUX ONLY
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
          "css",
          "yaml",
          "toml",
          "json",
          "javascript",
          "typescript"
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
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = true,             -- Enable this plugin (Can be enabled/disabled later via commands)
      multiwindow = false,       -- Enable multiwindow support.
      max_lines = 0,             -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0,     -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 100, -- Maximum number of lines to show for a single context
      trim_scope = 'outer',      -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'cursor',           -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20,     -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    }
  }
}
