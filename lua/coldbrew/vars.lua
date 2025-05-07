local M = {}

-- global
M.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

-- exclude fro filter, tree ... 
M.excludes = {  -- Default ignores
  ".git",    "__pycache__/",    "*.py[cod]",
  "*.so",    ".Python",    "env",
  ".env",    "env/",    ".env/",
  "venv/",    ".venv/",    "build/",
  "develop-eggs/",    "dist/",    "eggs/",
  "lib/",    "lib64/",    "parts/",
  "sdist/",    "var/",    "*.egg-info/",
  ".installed.cfg",    "*.egg",    "pip-log.txt",
  "pip-delete-this-directory.txt",    "htmlcov/",    ".tox/",
  ".coverage",    ".cache",    "nosetests.xml",
  "coverage.xml",    "*.mo",    "*.pot",
  "*.log",    "*.log.*",    "docs/_build/",
  "/.idea",    "/.code",    "*.bk",
  ".DS_Store", "node_modules", ".pytest_cache",
  ".clink"
}

-- PYTHON
if M.is_windows then
  M.venv_path = "D:\\projects\\.env\\nvim\\" -- Windows
else
  M.venv_path = "~/.env/nvim" -- Linux
end

if M.is_windows then
  M.venv_bin_path = M.venv_path .. "Scripts\\" -- Windows
else
  M.venv_bin_path =  M.venv_path .. "bin/" -- Linux
end

M.python_bin = M.venv_bin_path .. "python"

return M