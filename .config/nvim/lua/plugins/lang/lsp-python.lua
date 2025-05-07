-- Set Python venv path (adjust to your venv location)

local vars = require("coldbrew.vars")
local python_tools = require("coldbrew.tools").python
local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.g.python3_host_prog = vars.python_bin


return {
    {
      "neovim/nvim-lspconfig",
      ft = "python",
      dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
      },
      config = function()
        -- Pyright LSP setup
        require("mason-lspconfig").setup({
          -- ensure_installed = { "pyright", "pylint", "black" },
        })
        require("lspconfig").pyright.setup({
          cmd = { python_tools.venv_tool("pyright-langserver"), "--stdio" },
          before_init = function(_, config)
            config.settings.python.pythonPath = python_tools.get_python_path()
          end,
          capabilities = capabilities,
          settings = {
            python = {
              disableOrganizeImports = true,
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                  reportUnusedImport = "warning",
                  reportMissingImports = "error",
                },
              },
            },
          },
          on_attach = function(client, bufnr)
            -- Auto-fix imports
            vim.keymap.set('n', '<leader>fi', function()
              vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } } })
            end, { buffer = bufnr, desc = '[F]ix [I]mports' })
          end
        })

        -- Format-on-Save with venv tools
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*.py",
          callback = python_tools.python_formatters
        })
      end,
    },
  }