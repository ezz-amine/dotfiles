local M = {}
local vars = require("coldbrew.vars")
local tools = require("coldbrew.tools")

M.pcall_extensions = {}
M.normal_extensions = { "file_browser", "frecency", "notify", "textcase", "ui-select" }

-- Define and call the extension loading function
M.load_extensions = function()
  local l_telescope = require("telescope")

  for _, ext in ipairs(M.pcall_extensions) do
    pcall(l_telescope.load_extension, ext)
  end

  for _, ext in ipairs(M.normal_extensions) do
    l_telescope.load_extension(ext)
  end
end

-- telescope
-- M.find_excludes = tools.table_merge(vars.excludes, { ".protobuf" })
M.find_cmd = {
  "rg",
  "--files",
  "--color=never",
  "--no-heading",
  "--with-filename",
  "--line-number",
  "--column",
  "--smart-case",
  "--hidden",
  "--glob=!.git/",         -- Ignore .git
  "--glob=!node_modules/", -- Ignore node_modules
  "-L",
}
M.grep_cmd = {
  "rg",
  "--color=never",
  "--no-heading",
  "--with-filename",
  "--line-number",
  "--column",
  "--smart-case",
  "--hidden",              -- Search hidden files
  "--glob=!.git/",         -- Ignore .git
  "--glob=!node_modules/", -- Ignore node_modules
  "-L",
}


return M
