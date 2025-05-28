local ColdBrew = {
  modules = {
    projects = {},
    python = {
      binaries = {
        ["basedpyright-langserver"] = "basedpyright",
        codespell = "codespell",
        djhtml = "djhtml",
        djlint = "djlint",
        black = "black",
        pylint = "pylint",
        isort = "isort",
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

function ColdBrew.setup()
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
