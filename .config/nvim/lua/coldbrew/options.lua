-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- coldbrew - Home Brew
local config = {}
local instance_config_path = vim.fs.joinpath(vim.fn.stdpath("data"), ".coldbrew.lua")
if vim.fn.filereadable(instance_config_path) == 1 then
  config = dofile(instance_config_path)
end
vim.g.python_bin = config["python_bin"] or "python"
vim.g.python3_host_prog = vim.g.python_bin
vim.g.preserve_cwd = config["preserve_cwd"] or true
vim.g.github_token = config["gh_token"] or nil
vim.g.gemini_token = config["gemini_token"] or nil
vim.g.save_all_at_exit = false    -- running ColdBrew.save_all preLeave
vim.g.save_session_at_exit = true -- save current project/session preLeave

-- os/env specifis
vim.g.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 10000
vim.g.path_sep = vim.g.is_windows and ";" or ":"
vim.g.run_in_tmux = vim.env.TMUX ~= nil

-- Basic Neovim settings
vim.g.have_nerd_font = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false

-- Quality of life settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. ".undodir"

vim.schedule(function()
  vim.opt.clipboard = config["clipboard"] or "unnamed"
end)
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- bufferline: options
vim.g.bufferline_auto_hide = true
vim.opt.showtabline = 0

-- git : options
vim.g.git_blame_enable = true

-- Only enable Tree-sitter for large files
vim.g.treesitter_highlight_config = {
  large_file = {
    enable = false,
    line_limit = 10000,
  },
}

vim.opt.sessionoptions = "buffers,curdir,folds,tabpages"

vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  signs = true,
  virtual_text = false,
})
