local py = cb_mod("python.globals")

local Env = {}
local default_config = {
  venv_path = nil,
  main = false,
  persisted = false,
  name = nil,
}

-- Constructor
function Env.new(name, python_path, options)
  options = cb.tbl_merge(options or {}, default_config)

  if python_path == nil and options.venv_path == nil then
    error("either 'python_path' or 'venv_path' should be set")
    return nil
  end
  if python_path == nil then
    python_path = py.get_python_path(options.venv_path)
  else
    options.venv_path = vim.fs.dirname(vim.fs.dirname(python_path))
  end
  if name == nil then
    name = vim.fn.fnamemodify(options.venv_path, ":t")
  end

  if not vim.uv.fs_stat(python_path) then
    error("error occured when loading venv path[" .. python_path .. "]: " .. err, vim.log.levels.ERROR)
    return nil
  end

  local bin_path = vim.uv.fs_realpath(vim.fs.dirname(python_path))

  local self = setmetatable({
    name = name,
    venv_path = options.venv_path,
    bin_path = bin_path,
    python_path = python_path,
    is_main = options.main,
    is_persisted = options.persisted,
  }, { __index = Env })

  return self
end

function Env:printable_name()
  return self.name .. (self.is_persisted and "" or "!")
end

function Env:bin(bin_name)
  return vim.fs.joinpath(self.bin_path, bin_name)
end

function Env:install_package(package_name)
  local job_id = cb.run_job({ self:bin("pip"), "install", package_name }, "[pip install" .. package_name .. "]")

  vim.fn.jobwait({ job_id })
end

function Env:ensure_binaries(binaries, force)
  function confirm(package_name)
    local choice = vim.fn.confirm(
      "",
      "'" .. package_name .. "' missing from current virtual env. Should it be installed? {&Yes\n&No}",
      2
    )
    if choice == 1 then
      return true
    elseif choice == 2 then
      return false
    end
  end

  for _, package in ipairs(binaries) do
    if vim.fn.executable(self:bin(package.binary)) == 1 or (package.global and not self.is_main) then
      goto continue
    end
    if force or confirm(package.name) then
      local cmd = { self:bin("pip"), "install", package.name }
      cb.run_job(cmd, "install missing coldbrew python packages [" .. self.name .. "]| " .. package.name)
    end
    ::continue::
  end
end

return Env
