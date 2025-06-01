local python = {}
local vars = cb_require("vars")

-- Helper to find project root with pyproject.toml
function python.find_project_root(fname)
  local util = require("lspconfig").util

  return util.root_pattern("pyproject.toml")(fname)
      or util.find_git_ancestor(fname)
      or vim.fn.getcwd()
      or util.path.dirname(fname)
end

-- Shared venv detection logic
local function detect_venv()
  local venv = os.getenv("VIRTUAL_ENV")
  if venv then
    return vim.fs.normalize(venv)
  end

  return nil
end

-- For LSP configuration
function python.get_python_venv()
  return detect_venv()
end

function python.get_python_path()
  local venv = detect_venv()
  if venv then
    local python_path = venv .. (vim.g.is_windows and "/Scripts/python.exe" or "/bin/python")
    if vim.fn.executable(python_path) == 1 then
      return python_path
    end
  end

  return vim.g.is_windows and "py" or "python"
end

-- run python or python tools (pytest, poetry, pip, ...) using venv bin path
function python.venv_tool(bin_name)
  local venv = detect_venv()
  if venv then
    local bin_path = venv .. (vim.g.is_windows and "/Scripts/" .. bin_name .. ".exe" or "/bin/" .. bin_name)
    if vim.fn.executable(bin_name) == 1 then
      return bin_path
    end
  end

  return vars.venv_bin_path .. bin_name
end

-- -- For statusline display
function python.lualine_venv()
  local venv = detect_venv()
  local text = "-"
  local icon_color = "#c53b53"
  if venv then
    text = vim.fn.fnamemodify(venv, ":t")
    icon_color = "#ffc777"
  end

  return {
    function()
      return text
    end,
    icon = { "", color = { fg = icon_color } },
    cond = function()
      return vim.bo.filetype == "python"
    end,
  }
end

function python.main_pyproject_path()
  local Path = require("plenary.path")
  local _path = Path:new(vim.fn.stdpath("config") .. "/dotfiles/python/pyproject.toml")

  if not _path:exists() then
    vim.notify("main python pyproject not found at '" .. _path:absolute() .. "'")
    return nil
  else
    return _path:absolute()
  end
end

return python
