local lsp = {
  "lsp_status",
  ignore_lsp = {
    "null-ls",
    "none-ls",
  },
}
local filename = {
  -- function()
  --   return vim.fn.expand "%:."
  -- end,
  "filename",
  fmt = function(n)
    return vim.fs.normalize(n)
  end,
  file_status = true,     -- Displays file status (readonly status, modified status)
  newfile_status = false, -- Display new file status (new file means no write after created)
  path = 1,               -- 0: Just the filename
  -- 1: Relative path
  -- 2: Absolute path
  -- 3: Absolute path, with tilde as the home directory
  -- 4: Filename and parent dir, with tilde as the home directory

  shorting_target = 40, -- Shortens path to leave 40 spaces in the window
  -- for other components. (terrible name, any suggestions?)
  symbols = {
    modified = "", -- Text to show when the file is modified.
    readonly = "󰌾", -- Text to show when the file is non-modifiable or readonly.
    unnamed = "UNKNOWNIUM", -- Text to show for unnamed buffers.
    newfile = "NEWUM", -- Text to show for newly created file before first write
  },
}

local mode_map = {
  ["NORMAL"] = "N",
  ["O-PENDING"] = "N?",
  ["INSERT"] = "I",
  ["VISUAL"] = "V",
  ["V-BLOCK"] = "VB",
  ["V-LINE"] = "VL",
  ["V-REPLACE"] = "VR",
  ["REPLACE"] = "R",
  ["COMMAND"] = "!",
  ["SHELL"] = "SH",
  ["TERMINAL"] = "T",
  ["EX"] = "X",
  ["S-BLOCK"] = "SB",
  ["S-LINE"] = "SL",
  ["SELECT"] = "S",
  ["CONFIRM"] = "Y?",
  ["MORE"] = "M",
}

return {
  options = {
    icons_enabled = true,
    theme = "tokyonight-storm", -- Force Tokyo Night Moon theme
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "neo-tree", "alpha" },
    always_divide_middle = true,
    always_show_tabline = false,
    globalstatus = true,
  },
  winbar = {
    lualine_a = {},
    lualine_b = { filename },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { lsp },
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = { filename },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { lsp },
  },
  sections = {
    lualine_a = { {
      "mode",
      fmt = function(s)
        return mode_map[s] or s
      end,
    } },
    lualine_b = {
      "branch",
      { "diff", symbols = { added = " ", modified = " ", removed = " " } },
      "diagnostics",
    },
    lualine_c = {
      {
        "filetype",
        on_click = function()
          vim.cmd("Telescope filetypes")
        end,
      },
    },
    lualine_x = {
      {
        "cb_project",
      },
      {
        "fileformat",
        symbols = {
          unix = "", -- e712
          dos = "", -- e70f
          mac = "", -- e711
        },
      },
      {
        "encoding",
        fmt = function(str)
          return str == "utf-8" and "UTF8" or str:upper()
        end,
      },
      require("coldbrew.tools").python.lualine_venv(),
    },
    lualine_y = { "progress", "location" },
    lualine_z = {
      {
        "datetime",
        style = "%d/%m/%Y %H:%M",
        icon = "",
      },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = { "progress", "location" },
    lualine_z = {
      {
        "datetime",
        style = "%d/%m/%Y %H:%M",
        icon = "",
      },
    },
  },
}
