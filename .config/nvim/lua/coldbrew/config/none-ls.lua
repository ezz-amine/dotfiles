local null_ls = require("null-ls")
local CBPython = cb_mod("python")

local sources = {
  -- GLOBALS
  null_ls.builtins.diagnostics.codespell,
  -- require("none-ls-shellcheck.diagnostics"),  -- ?? to verify  spellcheck
  -- require("none-ls-shellcheck.code_actions"), -- ?? to verify  spellcheck
  null_ls.builtins.code_actions.refactoring,
  null_ls.builtins.formatting.prettier.with({
    extra_filetypes = { "toml" },
  }),                                         -- multi-file-type formater
  null_ls.builtins.diagnostics.dotenv_linter, -- .env files
  -- PYTHON
  null_ls.builtins.formatting.djhtml,
  null_ls.builtins.diagnostics.djlint,
  null_ls.builtins.formatting.black.with({
    extra_args = { "--config", CBPython.settings_file }, --, "$FILENAME" }
  }),
  null_ls.builtins.diagnostics.pylint.with({
    extra_args = { "--rcfile", CBPython.settings_file },
  }),
  null_ls.builtins.formatting.isort.with({
    extra_args = { "--settings-file", CBPython.settings_file },
  }),
  -- GOLANG
  null_ls.builtins.formatting.gofumpt,
  null_ls.builtins.formatting.goimports,
  -- LUA
  null_ls.builtins.formatting.stylua,
  -- CSS/SASS/SCSS
  null_ls.builtins.diagnostics.stylelint,
  -- MARKDOWN
  null_ls.builtins.diagnostics.markdownlint,
  -- YAML
  null_ls.builtins.diagnostics.yamllint,
  -- SQL
  null_ls.builtins.diagnostics.sqlfluff.with({
    extra_args = { "--dialect", "postgres" },
  }),
}
return {
  sources = sources,
}
