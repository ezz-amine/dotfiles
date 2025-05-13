local vars = require("coldbrew.vars")

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  lazy = false, -- neo-tree will lazily load itself
  opts = {
    -- fill any relevant options here
    close_if_last_window = true,
    default_component_configs = {
      file_size = { enabled = false },
      type = { enabled = false },
      last_modified = { enabled = false },
      created = { enabled = false },
    },
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_by_pattern = vars.excludes,
        hide_by_name = vars.excludes,
        never_show = vars.excludes,
      },
    },
    window = {
      position = "left",
      width = 25,
      mappings = {}
    }
  },
}
