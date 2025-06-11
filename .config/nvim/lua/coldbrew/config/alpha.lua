local theme = require("alpha.themes.startify")
local layout = theme.config.layout

local header = {
  type = "text",
  val = {
    [[*******************************************************************************]],
    [[*                                                                             *]],
    [[*      ██████╗ ██████╗ ██╗     ██████╗ ██████╗ ██████╗ ███████╗██╗    ██╗     *]],
    [[*     ██╔════╝██╔═══██╗██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██║    ██║     *]],
    [[*     ██║     ██║   ██║██║     ██║  ██║██████╔╝██████╔╝█████╗  ██║ █╗ ██║     *]],
    [[*     ██║     ██║   ██║██║     ██║  ██║██╔══██╗██╔══██╗██╔══╝  ██║███╗██║     *]],
    [[*     ╚██████╗╚██████╔╝███████╗██████╔╝██████╔╝██║  ██║███████╗╚███╔███╔╝     *]],
    [[*      ╚═════╝ ╚═════╝ ╚══════╝╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝ ╚══╝╚══╝      *]],
    [[*                                                                             *]],
    [[*******************************************************************************]],
  },
  opts = {
    hl = "Type",
    shrink_margin = false,
    -- wrap = "overflow";
  },
}
local sep = {
  type = "text",
  val = {
    [[*******************************************************************************]],
  },
  opts = {
    hl = "Type",
    shrink_margin = false,
    -- wrap = "overflow";
  },
}
local top_buttons = {
  type = "group",
  val = {
    theme.button("o", "Open File", function()
      require("telescope.builtin").find_files({
        hidden = true,
        no_ignore = false,        -- also show files ignored by .gitignore
        no_ignore_parent = false, -- don't respect parent .gitignore
        file_ignore_patterns = { ".git[/\\].*", "node_modules[/\\].*", "__pycache__[/\\].*" },
      })
    end),
    theme.button("p", "Open Project", "<cmd>CBListProjects<CR>"),
  },
}

theme.file_icons.provider = "devicons"
theme.config.layout = {
  { type = "padding", val = 5 }, -- padding:5{ type = "padding", val = 2 },
  header,
  { type = "padding", val = 2 }, -- padding:2
  sep,
  top_buttons,
  sep,
  layout[5], -- mru_cwd
  -- last_projects, -- must be last 5 project not all, and it need to be read here
  layout[7], -- padding:1
  sep,
  layout[8], -- buttons bottom
  sep,
}
theme.config.opts["margin"] = 20

return theme
