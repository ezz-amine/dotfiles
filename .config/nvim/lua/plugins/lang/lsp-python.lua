-- Set Python venv path (adjust to your venv location)

local python_tools = require("coldbrew.tools").python
local capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
  {
    "neovim/nvim-lspconfig",
    ft = "python",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require('lspconfig').pylsp.setup({
        cmd = {python_tools.venv_tool('pylsp')},
        capabilities = capabilities,
        settings = {
          pylsp = {
            pythonPath = python_tools.get_python_path(),
            plugins = {
              flake8 = {nabled = false,},
              autopep8 = { enabled = false },
              mccabe = {enabled = false},
              pycodestyle = { enabled = false},
              pyflakes = {enabled = false},
              pylint = { enabled = true, executable = python_tools.venv_tool('pylint'), args = {"--rcfile=" .. python_tools.main_pyproject_path() }}, --
              black = { enabled = true, executable = python_tools.venv_tool('black'), line_length = 120},
              autoflake = { enabled = true, executable = python_tools.venv_tool('autoflake') },
              isort = { enabled = true, executable = python_tools.venv_tool('isort') },
              pylsp_mypy = {
                enabled = false,
              --   mypy_command = {python_tools.venv_tool('mypy')},
              --   strict= true,
              --   live_mode = true,
              --   overrides={
              --     "--ignore-missing-imports"
              --   },
              --   args = {}
              --   --"--ignore-missing-imports", "--disallow-untyped-calls", "--disallow-untyped-defs", "--disallow-incomplete-defs"
              }
            }
          }
        }
      })
    end,
  },
}
