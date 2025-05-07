vim.opt.rtp:append(vim.fn.stdpath("config") .. "/lua")

-- Load core settings first
require("coldbrew.options")
vim.cmd('filetype plugin indent on')

-- Set up Lazy.nvim plugin manager
require("plugins.lazy")

require("coldbrew.mappings")
require("coldbrew.autocmds")
require("coldbrew.commands")