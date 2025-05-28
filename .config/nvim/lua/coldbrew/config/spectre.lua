return { -- Cross-platform default settings
  default = {
    find = {
      cmd = "rg",
      options = {
        "no-heading",
        "with-filename",
        "line-number",
        "column",
        "smart-case",
        "hidden",               -- Search hidden files
        "glob=!.git/*",         -- Ignore .git
        "glob=!node_modules/*", -- Ignore node_modules
        "follow",
      },
    },
    replace = {
      cmd = "sed",
    },
  },
  -- Windows-specific settings
  is_block_ui_break = (function()
    return true and vim.g.is_windows or false
  end)(),
}
