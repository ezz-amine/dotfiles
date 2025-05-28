local vars = cb_require("vars")

return {
  -- fill any relevant options here
  close_if_last_window = true,
  default_component_configs = {
    file_size = { enabled = false },
    type = { enabled = false },
    last_modified = { enabled = false },
    created = { enabled = false },
  },
  filesystem = {
    hijack_netrw_behavior = "disabled",
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
}
