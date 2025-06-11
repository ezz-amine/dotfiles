local ColdBrew = {
  modules = {
    projects = {},
    python = {
      binaries = {
        {
          name = "codespell",
          binary = "codespell",
          global = true,
        },
        {
          name = "djhtml",
          binary = "djhtml",
          global = true,
        },
        {
          name = "djlint",
          binary = "djlint",
          global = true,
        },
        {
          name = "basedpyright",
          binary = "basedpyright-langserver",
          global = false,
        },
        {
          name = "black",
          binary = "black",
          global = false,
        },
        {
          name = "pylint",
          binary = "pylint",
          global = false,
        },
        {
          name = "isort",
          binary = "isort",
          global = false,
        },
      },
    },
  },
  post_save_cmds = {
    "CBSaveSession",
  },
  telescope_exts = {
    "cb_projects",
  },
}

function ColdBrew.random_joke(prefix)
  return require("coldbrew.joke")(prefix)
end

function ColdBrew.setup()
  vim.cmd.echo(vim.fn.string(ColdBrew.random_joke("Just wait...")))
  require("coldbrew.options")
  vim.cmd("filetype plugin indent on")
  require("coldbrew.globals")

  ColdBrew.load_modules()

  -- Set up Lazy.nvim plugin manager
  require("plugins.lazy")

  ColdBrew.post_lazy()

  cb_require("mappings")
  cb_require("autocmds")
  cb_require("commands")
end

function ColdBrew.notify(msg, level)
  vim.notify(msg, level, { title = "ColdBrew - Core" })
end

function ColdBrew.load_modules()
  for plugin_name, plugin_options in pairs(ColdBrew.modules) do
    local plugin = cb_mod(plugin_name)
    plugin.setup(plugin_options)
  end
end

function ColdBrew.post_lazy()
  -- for _, ext in ipairs(ColdBrew.telescope_exts) do
  --   require("telescope").load_extension(ext)
  -- end
end

function ColdBrew.save_all()
  vim.cmd("wa!")
  for _, cmd in ipairs(ColdBrew.post_save_cmds) do
    if vim.fn.exists(cmd) then
      vim.cmd(cmd)
    end
  end
  ColdBrew.notify("All buffers saved", vim.log.levels.INFO)
end

return ColdBrew
