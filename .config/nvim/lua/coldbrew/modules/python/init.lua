local py = cb_mod("python.globals")
local Env = cb_mod("python.env")

local CBPython = {
  venv_register = {},
  nvim_venv = nil,
  current_venv = nil,
  settings_file = vim.fs.joinpath(vim.fn.stdpath("config"), "dotfiles", "python", "pyproject.toml"),
}

local function check_nvim_venv()
  if not vim.uv.fs_stat(py.local_venv_path) then
    vim.fn.system({
      vim.g.python_bin,
      "-m",
      "venv",
      py.local_venv_path,
    })
  end
end

local function update_path()
  local new_path = {}
  if CBPython.current_venv ~= nil then
    table.insert(new_path, CBPython.current_venv.bin_path)
  end
  table.insert(new_path, CBPython.nvim_venv.bin_path)

  for _, entry in ipairs(vim.split(vim.env.PATH, vim.g.path_sep)) do
    if not vim.tbl_contains(new_path, entry) then
      table.insert(new_path, entry)
    end
  end
  vim.env.PATH = table.concat(new_path, vim.g.path_sep)
end

function CBPython.setup(config)
  if config == nil then
    config = {}
  end
  check_nvim_venv()
  CBPython.nvim_venv = Env.new("nvim[hidden]", nil, {
    venv_path = py.local_venv_path,
    main = true,
    persisted = true,
  })
  vim.schedule(function()
    local active_venv_path = py.get_active_venv()
    if active_venv_path ~= nil then
      CBPython.current_venv = Env.new(nil, nil, {
        venv_path = active_venv_path,
        main = false,
        persisted = false,
      })
    end

    CBPython.nvim_venv:ensure_binaries(config.binaries, true)
    if CBPython.current_venv ~= nil then
      CBPython.current_venv:ensure_binaries(config.binaries)
    end
    update_path()
  end)
end

function CBPython.post_lazy() end

return CBPython
