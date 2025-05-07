local python = {}
local vars = require("coldbrew.vars")

-- run python or python tools (pytest, poetry, pip, ...) using venv bin path
function python.venv_tool(bin_name)
  return vars.venv_bin_path .. bin_name
end


-- Helper to find project root with pyproject.toml
function python.find_project_root(fname)
  local util = require("lspconfig").util

  return util.root_pattern("pyproject.toml")(fname) or
         util.find_git_ancestor(fname) or
         vim.fn.getcwd() or
         util.path.dirname(fname)
end

-- -- Normalize paths across OS
-- function python.normalize_path(path)
--   return tostring(Path:new(path))
-- end

function python.python_formatters()
  local Path = require("plenary.path")
  local root = python.find_project_root()
  local use_pyproject = false
  local pyproject = Path:new(root):joinpath('pyproject.toml')
  if pyproject:exists() then
    pyproject = Path:absolute()
    use_pyproject = true
  end
  -- Formatter commands with OS-specific handling
  local formatters = {
    {
      cmd = { python.venv_tool('isort'), '--quite', '--filename', '$FILENAME' },
      args = use_pyproject and { '--settings-path', pyproject } or { '--profile', 'black' }
    },
    {
      cmd = { python.venv_tool('autoflake'), '--quite', vars.is_windows and '$FILENAME' or '-'},  -- Windows needs filename
      args = use_pyproject and { '--config', pyproject } or {
        '--remove-all-unused-imports',
        '--ignore-init-module-imports'
      }
    },
    {
      cmd = { python.venv_tool('black'), '--quite' },
      args = use_pyproject and { '--config', pyproject } or {},
      stdin_support = not vars.is_windows  -- Black on Windows needs files
    }
  }

  local bufnr = vim.api.nvim_get_current_buf()
  -- local filename = python.normalize_path(vim.api.nvim_buf_get_name(bufnr))
  local filename = vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr))

  for _, fmt in ipairs(formatters) do
    local full_cmd = vim.list_extend({}, fmt.cmd)
    for _, arg in ipairs(fmt.args) do
      table.insert(full_cmd, arg == '$FILENAME' and filename or arg)
    end

    if fmt.stdin_support then
      -- UNIX-style STDIN formatting
      local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), '\n')
      local formatted = silent_system(full_cmd .. ' > /dev/null 2>&1', content)
      if vim.v.shell_error == 0 then
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(formatted, '\n'))
      end
    else
      -- Windows-safe file-based formatting
      vim.cmd('w')  -- Save first
      os.execute(table.concat(full_cmd, ' '))
      vim.cmd('e!')  -- Reload
    end
  end
end

-- Shared venv detection logic
local function detect_venv()
  local venv = os.getenv('VIRTUAL_ENV') or os.getenv('CONDA_PREFIX')
  if not venv then return nil end

  -- Normalize paths (Windows support)
  if package.config:sub(1,1) == '\\' then
    venv = venv:gsub('\\', '/')
  end

  return venv
end

-- For LSP configuration
function python.get_python_path()
  local venv = detect_venv()
  if venv then
    local python_path = venv .. (vars.is_windows and '/Scripts/python.exe' or '/bin/python')
    if vim.fn.executable(python_path) == 1 then
      return python_path
    end
  end

  return vars.is_windows and 'py' or 'python'
end

-- For statusline display
function python.get_venv_name()
  local venv = detect_venv()
  return venv and " " .. vim.fn.fnamemodify(venv, ":t") or ""
end

return python