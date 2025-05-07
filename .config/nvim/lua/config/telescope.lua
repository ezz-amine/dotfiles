local M = {}
local vars = require("coldbrew.vars")
local tools = require("coldbrew.tools")

M.pcall_extensions = {}
M.normal_extensions = {"file_browser","frecency","notify","workspaces","textcase","todo-comments"}

-- Define and call the extension loading function
M.load_extensions = function ()
  local l_telescope = require("telescope")

  for _, ext in ipairs(M.pcall_extensions) do
      pcall(l_telescope.load_extension, ext)
  end

  for _, ext in ipairs(M.normal_extensions) do
      l_telescope.load_extension(ext)
  end
end

-- telescope
M.find_excludes = tools.table_merge(vars.excludes, { ".protobuf" })
M.find_cmd = {
  "rg",
  "--follow",
  "--files",
  "--color=never",
  "--no-heading",
  "--with-filename",
  "--line-number",
  "--column",
  "--smart-case",
  "--hidden",
}
M.grep_cmd = {
  "rg",
  "--color=never",
  "--follow",
  "--no-heading",
  "--with-filename",
  "--line-number",
  "--column",
  "--smart-case",
  "--hidden",                   -- Search hidden files
  "--glob=!.git/",              -- Ignore .git
}


return M
