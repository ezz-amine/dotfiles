local servers = {
  "lua_ls",
  "marksman",
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
