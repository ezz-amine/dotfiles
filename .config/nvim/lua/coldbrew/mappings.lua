local set = vim.keymap.set
local s_leader = "<M-w>"
local c_up = "<M-Up>"     -- move line down
local c_down = "<M-Down>" -- move line down

-- GLOBALS
-- -- QoL
set("n", "<leader>sft", function()
  vim.api.nvim_feedkeys(":set filetype=", "n", false)
end, { desc = "[S]et [F]ile [T]ype (python, html, go, ...)" })
set("n", "<leader>sff", function()
  vim.api.nvim_feedkeys(":set fileformat=", "n", false)
end, { desc = "[S]et [F]ile [F]ormat (Unix, Windows)" })
set("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>") -- remove search highlight

set("n", s_leader .. "tt", function()
  vim.opt.showtabline = vim.opt.showtabline == 2 and 0 or 2
end, { desc = "[B]uffer [T]oggle tabline" })                                -- toggle tab bar

set("i", "<C-v>", "<C-o>p", { noremap = true, desc = "insert mode paste" }) -- paste in insert mode

set({ "n", "v" }, "<M-j>", function()
  vim.api.nvim_feedkeys("10j", vim.fn.mode(), false)
end, { desc = "move down by 10 lines" })
set({ "n", "v" }, "<M-k>", function()
  vim.api.nvim_feedkeys("10k", vim.fn.mode(), false)
end, { desc = "move up by 10 lines" })

-- -- -- UNDO/REDO
set({ "n", "x" }, "<C-z>", "u", { noremap = true, desc = "Undo" })
set({ "n", "x" }, "<C-y>", "<C-r>", { noremap = true, desc = "Redo" })
set("i", "<C-z>", "<C-o>u", { noremap = true, desc = "insert mode undo" })     -- undo insert mode
set("i", "<C-y>", "<C-o><C-r>", { noremap = true, desc = "insert mode redo" }) -- redo insert mode
-- -- -- UNDO/REDO

-- -- -- MOVE LINE/SELECTION
set("n", c_up, "<Cmd>move .-2<CR>==", { desc = "Move line up" })
set("n", c_down, "<Cmd>move .+1<CR>==", { desc = "Move line down" })
set("i", c_up, "<Esc><Cmd>move .-2<CR>==gi", { desc = "Move line up" })
set("i", c_down, "<Esc><Cmd>move .+1<CR>==gi", { desc = "Move line down" })
set("v", c_up, ":move '<-2<CR>gv=gv", { desc = "Move selection up" })
set("v", c_down, ":move '>+1<CR>gv=gv", { desc = "Move selection down" })
-- -- -- MOVE LINE/SELECTION

-- -- -- TEXT-CASE
set({ "n", "x" }, s_leader .. "s", "<cmd>TextCaseOpenTelescope<CR>", { desc = "[S]tring manipulation" })
-- -- -- TEXT-CASE

set("v", "<Tab>", ">gv", { noremap = true, silent = true })                     -- indent selection
set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })                   -- "de"-indent selection

set("n", "<leader>x", ":bdelete<CR>", { silent = true, desc = "Close buffer" }) -- delete buffer - exit and free memory

set("n", "<leader>of", ":e .<CR>", { silent = true, desc = "[O]pen [F]ile" })   -- open file
-- GLOBALS

-- TELESCOPE
-- //SOME CUSTOM TELESCOPE LISTINGS ARE IN THERE RESPECTIVE EXTENSIONS//
local builtin = require("telescope.builtin")
-- -- file search
set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
set({ "n", "v" }, "<Tab><Tab>", builtin.find_files, { desc = "[F]ind [F]iles" })
-- -- file browser
set("n", "<leader>fb", ":Telescope file_browser<CR>", { desc = "[F]ile [B]rowser" })

-- -- fuzzy find file contents
set({ "n", "v" }, "<C-M-g>", builtin.live_grep, { desc = "[F]ind [R]ecent files" })

-- -- show open buffers
set("n", "<leader>bb", builtin.buffers, { desc = "Opened [B]uffers" })

-- -- git tools
set({ "n", "x" }, "<leader>gcb", "<cmd>Telescope git_branches<CR>", { desc = "[G]it [C]heckout [B]ranches" })
-- TELESCOPE

-- NEO-TREE
set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true, desc = "File [E]xplorer" })
set("n", s_leader .. "e", ":Neotree focus<CR>", { silent = true, desc = "Focus on [E]xplorer" })
set("n", s_leader .. "b", ":Neotree buffers toggle<CR>", { silent = true, desc = "[B]uffer Explorer" })
-- NEO-TREE

-- LAZYGIT
set({ "n", "x" }, "<leader>lg", "<cmd>LazyGit<CR>", { desc = "[L]azy[G]it" })                                 -- open lazygit
set({ "n", "x" }, s_leader .. "g", "<cmd>LazyGitCurrentFile<CR>", { desc = "Lazy[G]it" })                     -- lazygit on current buffer
set({ "n", "x" }, s_leader .. "b", "<cmd>LazyGitFilterCurrentFile<CR>", { desc = "LazyGitFilter ([B]lame)" }) -- git blame
-- LAZYGIT

-- GIT DIFF ON FILE
set({ "n", "x" }, "<leader>gsd", "<cmd>DiffviewFileHistory<CR>", { desc = "[G]it [S]how [D]iff" })
-- GIT DIFF ON FILE

-- SPECTRE
-- -- global search
set({ "n", "v", "i" }, "<C-M-f>", function()
  require("spectre").toggle()
end, { desc = "Advanced [F]ind & Replace" })
-- SPECTRE

-- HARPOON2
local harpoon = require("harpoon")
set("n", "<leader>ah", function()
  harpoon:list():add()
end)
set("n", "<leader>hl", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)
-- HARPOON2

-- WHICH-KEY
set({ "n", "v" }, "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })
set({ "n", "v" }, s_leader .. "?", function()
  require("which-key").show({ global = true })
end, { desc = "Buffer Local Keymaps (which-key)" })
-- WHICH-KEY

-- CHEATSHEET.NVIM
-- set({ "n", "x" }, s_leader .. "?", "<cmd>Cheatsheet<cr>", { desc = "Search keymaps" })
-- CHEATSHEET.NVIM

-- MULTICURSOR
-- -- Add or skip adding a new cursor by matching word/selection
local multicursor = require("multicursor-nvim")
set({ "n", "x" }, "<leader>n", function()
  multicursor.matchAddCursor(1)
end)
set({ "n", "x" }, "<leader>s", function()
  multicursor.matchSkipCursor(1)
end)
set({ "n", "x" }, "<leader>N", function()
  multicursor.matchAddCursor(-1)
end)
set({ "n", "x" }, "<leader>S", function()
  multicursor.matchSkipCursor(-1)
end)
-- Add and remove cursors with control + left click.
local mc = require("multicursor-nvim")
set({ "n", "v" }, "<c-leftmouse>", multicursor.handleMouse)
set({ "n", "v" }, "<c-leftdrag>", multicursor.handleMouseDrag)
set({ "n", "v" }, "<c-leftrelease>", multicursor.handleMouseRelease)
-- Disable and enable cursors.
set({ "n", "x", "v" }, "<c-q>", multicursor.toggleCursor)
-- MULTICURSOR

-- TIME-MACHINE.NVIM
-- -- localhistory
set({ "n", "x" }, s_leader .. "h", "<cmd>TimeMachineToggle<CR>", { desc = "Local [H]istory" })
-- TIME-MACHINE.NVIM

-- COLDBREW - SUPER-DUPER-CUSTOM
set("n", "<leader>td", "<cmd>CBGreb @todo<cr>", { desc = "[T]O[D]O comment list" })
set("n", "<leader>op", ":Telescope cb_projects<cr>", { desc = "[O]pen [P]roject, show coldbrew projects/sessions" })
-- set({ 'n', 'v' }, '<C-s>', ":CBSaveAll<cr>", { silent = true, desc = 'Save all buffers' })
-- set('i', '<C-s>', function() vim.cmd(':CBSaveAll') end, { silent = true, desc = 'Save all buffers' })
