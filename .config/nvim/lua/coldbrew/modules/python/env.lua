local Env = {}

local function neotree_opened()
  local neotree_last_source = require("neo-tree.command")._last.source
  local neotree_open = false
  if neotree_last_source ~= nil then
    neotree_open = require("neo-tree.sources.manager").get_state(neotree_last_source) ~= nil
  end

  return neotree_open
end

-- Constructor
function Env.new(python_path)
  local python_path, err = vim.loop.fs_realpath(python_path)
  if err ~= nil then
    error("error occured when loading main nvim python venv: " .. err, vim.log.levels.ERROR)
    return nil
  end

  local bin_path = vim.loop.fs_realpath(vim.fs.dirname(vim.g.nvim_python_path))
  local self = setmetatable({
    python_path = python_path,
    bin_path = bin_path,
  }, { __index = Env })

  return self
end

function Env:bin(bin_name)
  return vim.fs.joinpath(self.bin_path, bin_name)
end

function Env:install_package(package_name)
  local job_id = cb.run_job({ self:bin("pip"), "install", package_name }, "[pip install" .. package_name .. "]")

  vim.fn.jobwait({ job_id })
end

function Env:ensure_binaries(binaries)
  local packages = {}
  for bin_name, package_name in pairs(binaries) do
    if package_name == nil then
      package_name = bin_name
    end

    if vim.fn.executable(self:bin(bin_name)) == 0 then
      table.insert(packages, package_name)
    end
  end

  if #packages > 0 then
    local cmd = cb.tbl_merge({ self:bin("pip"), "install" }, packages)
    print(vim.inspect(cmd))
    local job_id = cb.run_job(cmd, "install missing coldbrew python packages")
  end
end

return Env
