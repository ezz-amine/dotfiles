local servers = {
  "lua_ls",
  "marksman",
  "taplo",
  "yamlls",
  "jsonls",
  "dockerls",
  "docker_compose_language_service",
  "gopls",
  "bashls",
  "fish_lsp",
  "eslint",
  "cssls",
  "html",
}
local packages = {
  "stylua",
  "prettier",
  "dotenv-linter",
  "stylelint",
  "markdownlint",
  "yamllint",
  "sqlfluff",
  "goimports",
  "gofumpt",
}

return {
  ensure_installed = packages,
  lspconfig = {
    automatic_installation = true,
    ensure_installed = servers,
    automatic_enable = {},
  },
}
