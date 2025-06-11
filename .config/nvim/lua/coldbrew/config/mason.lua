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
}
local packages = {
  "stylua",
  "prettier",
  "dotenv-linter",
  "stylelint",
  "markdownlint",
  "yamllint",
  "sqlfluff",
}

return {
  ensure_installed = packages,
  lspconfig = {
    automatic_installation = true,
    ensure_installed = servers,
    automatic_enable = servers,
  },
}
