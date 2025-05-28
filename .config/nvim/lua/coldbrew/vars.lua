local M = {}

-- exclude fro filter, tree ...
M.excludes = { -- Default ignores
  ".git",
  "__pycache__/",
  "*.py[cod]",
  "*.so",
  ".Python",
  "env",
  ".env",
  "env/",
  ".env/",
  "venv/",
  ".venv/",
  "build/",
  "develop-eggs/",
  "dist/",
  "eggs/",
  "lib/",
  "lib64/",
  "parts/",
  "sdist/",
  "var/",
  "*.egg-info/",
  ".installed.cfg",
  "*.egg",
  "pip-log.txt",
  "pip-delete-this-directory.txt",
  "htmlcov/",
  ".tox/",
  ".coverage",
  ".cache",
  "nosetests.xml",
  "coverage.xml",
  "*.mo",
  "*.pot",
  "*.log",
  "*.log.*",
  "docs/_build/",
  "/.idea",
  "/.code",
  "*.bk",
  ".DS_Store",
  "node_modules",
  ".pytest_cache",
  ".clink",
}

-- PYTHON
M.venv_path = nil -- vim.g.python_env_path

if vim.g.is_windows then
  M.venv_bin_path = nil --M.venv_path .. "Scripts\\" -- Windows
else
  M.venv_bin_path = nil --M.venv_path .. "bin/"      -- Linux
end

M.python_bin = nil -- M.venv_bin_path .. "python"

return M
