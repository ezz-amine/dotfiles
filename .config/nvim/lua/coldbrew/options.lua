local config = {}
local instance_config_path = vim.fn.stdpath("data") .. "/.coldbrew.lua"
if vim.fn.filereadable(instance_config_path) == 1 then
  config = dofile(instance_config_path)
end
-- coldbrew - Home Brew
vim.g.python_env_path = config["python_env_path"] or "~/.env/nvim" -- Linux
vim.g.gemini_token = config["gemini_token"] or nil
vim.g.save_all_at_exit = false                                     -- running ColdBrew.save_all preLeave
vim.g.save_session_at_exit = true                                  -- save current project/session preLeave


-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic Neovim settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true

-- bufferline: options
vim.g.bufferline_auto_hide = true
vim.opt.showtabline = 0

-- git : options
vim.g.git_blame_enable = true

-- Quality of life settings
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. ".undodir"

-- Only enable Tree-sitter for large files
vim.g.treesitter_highlight_config = {
  large_file = {
    enable = false,
    line_limit = 10000,
  }
}

vim.opt.sessionoptions = "buffers,curdir,folds,tabpages"
