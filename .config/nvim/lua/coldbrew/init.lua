local ColdBrew = {
    plugins = {},
    post_save_cmds = {
        "CBSaveSession"
    },
    telescope_exts = {
        "brew_sessions"
    }
}

function ColdBrew.setup()
    require("coldbrew.options")
    vim.cmd('filetype plugin indent on')

    -- Set up Lazy.nvim plugin manager
    require("plugins.lazy")

    ColdBrew.plugins["brew-sessions"] = {}
    ColdBrew.load_plugins()

    require("coldbrew.mappings")
    require("coldbrew.autocmds")
    require("coldbrew.commands")
end

function ColdBrew.notify(msg, level)
    vim.notify(msg, level, { title = "ColdBrew - Home Brew" })
end

function ColdBrew.load_plugins()
    vim.opt.rtp:append(vim.fn.stdpath("config") .. "/coldbrew-plugins")

    for plugin_name, plugin_options in pairs(ColdBrew.plugins) do
        local plugin = require(plugin_name)
        plugin.setup(plugin_options)
    end

    for _, ext in ipairs(ColdBrew.telescope_exts) do
        require("telescope").load_extension(ext)
    end
end

function ColdBrew.save_all()
    vim.cmd('wa!')
    for _, cmd in ipairs(ColdBrew.post_save_cmds) do
        if vim.fn.exists(cmd) then
            vim.cmd(cmd)
        end
    end
    ColdBrew.notify('All buffers saved', vim.log.levels.INFO)
end

return ColdBrew
