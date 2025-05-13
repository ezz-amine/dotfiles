return {
  -- {
  --   "neovim/python-client",
  --   build = ":UpdateRemotePlugins",
  --   config = function()
  --     local python_tools = require("coldbrew.tools").python
  --     vim.g.python3_host_prog = python_tools.get_python_path()
  --   end,
  --   ft = "python",
  -- },
  -- -- Optional: Mason for automatic LSP installation
  -- {
  --   "williamboman/mason.nvim",
  --   opts = {
  --     ensure_installed = { "pylsp" }
  --   }
  -- },

  -- -- Optional: Debugging support
  -- {
  --   "mfussenegger/nvim-dap-python",
  --   dependencies = { "mfussenegger/nvim-dap" },
  --   ft = "python",
  --   config = function()
  --     require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
  --   end
  -- },
  {
    'nvimtools/none-ls.nvim',
    ft = "python",
    config = function()
      local null_ls = require('null-ls')
      local python_tools = require("coldbrew.tools").python

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.black.with({
            extra_args = { "--config", python_tools.main_pyproject_path(), "$FILENAME" }
          }),
          null_ls.builtins.diagnostics.pylint.with({
            extra_args = { "--rcfile", python_tools.main_pyproject_path() }
          }),
          null_ls.builtins.formatting.isort.with({
            extra_args = { "--settings-file", python_tools.main_pyproject_path() }
          }),
          -- null_ls.builtins.formatting.autoflake.with({
          --   args = { "--config", python_tools.main_pyproject_path() }
          -- }),
        },
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            -- pattern = "*.py",
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end,
      })
    end,

  },
}
