-- Register the extension

local CBProjects = cb_mod "projects"

return require("telescope").register_extension {
  exports = {
    cb_projects = CBProjects.ts_projects_list,
  },
}
