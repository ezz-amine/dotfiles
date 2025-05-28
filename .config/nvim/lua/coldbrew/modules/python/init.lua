local Env = require("coldbrew.modules.python.env")
local CBPython = {}

local data = {
  venv_register = {},
  nvim_venv = nil,
  current_venv = nil,
}

function CBPython.setup(config)
  if config == nil then
    config = {}
  end
  data.nvim_venv = Env.new(vim.g.nvim_python_path)
  vim.schedule(function()
    vim.api.nvim_echo({ { "install missing coldbrew python packages" } }, false, {})
    data.nvim_venv:ensure_binaries(config.binaries)
  end)
  -- run_with_spinner({ py_tool_path(data.nvim_venv.bin_path, "pip"), "install", "Django" }, "installing Django")
end

function CBPython.post_lazy() end

return CBPython
