local set = vim.keymap.set
local s_leader = "<M-w>"

-- coldbrew : customizations
--  - todo comment list
set("n", "<leader>td", "<cmd>CBGreb @todo<cr>", {desc = "[T]O[D]O comment list"})
--  - togglee tab bar
set('n', '<leader>bt', function() vim.opt.showtabline = vim.opt.showtabline:get() == 2 and 0 or 2 end, {desc = '[B]uffer [T]oggle tabline'})
--  - View all diagnostics
set('n', '<leader><leader>', vim.diagnostic.open_float, { desc = '[E]rror [E]xplainer' })
--  - set file type
set('n', '<leader>sft', function()
    vim.api.nvim_feedkeys(':set filetype=', 'n', false)
end, { desc = '[S]et [F]ile [T]ype (python, html, go, ...)' })
set('n', '<leader>sff', function()
    vim.api.nvim_feedkeys(':set fileformat=', 'n', false)
end, { desc = '[S]et [F]ile [F]ormat (Unix, Windows)' })
--  - because i'm lazy
local function _save_all(insert)
    vim.cmd('wa')
    vim.cmd(':SessionSave')
    vim.notify('All buffers saved', vim.log.levels.INFO, { title = 'ColdBrew' })
    if insert then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Right>', true, false, true), 'n', false)
    end
end

vim.keymap.set('i', '<C-v>', '<C-r>+', { noremap = true, desc = 'Paste from system clipboard' })

vim.keymap.set({'n', 'v'}, '<C-s>', function()
    _save_all(false)
  end, { desc = 'Save all buffers' })
vim.keymap.set('i', '<C-s>', function()
_save_all(true)
end, { desc = 'Save all buffers' })

vim.keymap.set('i', '<C-z>', '<C-o>u', { noremap = true, desc = 'Undo in insert mode' })
vim.keymap.set('i', '<C-y>', '<C-o><C-r>', { noremap = true, desc = 'Redo in insert mode' })
vim.keymap.set({'n', 'x'}, '<C-z>', 'u', { noremap = true, desc = 'Undo' })
vim.keymap.set({'n', 'x'}, '<C-y>', '<C-r>', { noremap = true, desc = 'Redo' })

--  - Move current line up/down with Ctrl+Up/Down
local c_up = "<M-Up>"
local c_down = "<M-Down>"
vim.keymap.set("n", c_up, "<Cmd>move .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("n", c_down, "<Cmd>move .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("i", c_up, "<Esc><Cmd>move .-2<CR>==gi", { desc = "Move line up" })
vim.keymap.set("i", c_down, "<Esc><Cmd>move .+1<CR>==gi", { desc = "Move line down" })
vim.keymap.set("v", c_up, ":move '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", c_down, ":move '>+1<CR>gv=gv", { desc = "Move selection down" })

vim.keymap.set({"n", "v"}, "<leader>gd", ":Telescope lsp_definitions<cr>", { desc = "Move line up" })

-- View neo-tree sidenav
set('n', '<leader>e', ":Neotree toggle<CR>", { silent = true, desc = 'File [E]xplorer' }) -- NvimTreeToggle
set('n', '<C-w>e', ":Neotree focus<CR>", { silent = true, desc = 'File [E]xplorer' }) -- NvimTreeToggle
set('n', '<leader>be', ":Neotree buffers toggle<CR>", { silent = true, desc = '[B]uffer [E]xplorer' })
set('n', '<leader>of', ":tab new<CR>:Neotree position=current<CR>", { silent = true, desc = '[O]pen [F]ile' })

-- Bufferline (tab toolbar) - Keymaps
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true, desc = "Next tab" })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Previous tab" })
vim.keymap.set("n", "<leader>x", ":bdelete<CR>", { silent = true, desc = "Close buffer" })

-- code completion
local luasnip = require("luasnip")
set('i', '<C-Space>', function() luasnip.jump(1) end, { noremap = true, silent = true })
set('s', '<C-Space>', function() luasnip.jump(1) end, { noremap = true, silent = true })
-- set('i', '<C-m>', function() luasnip.jump(-1) end, { noremap = true, silent = true })
-- set('s', '<C-m>', function() luasnip.jump(-1) end, { noremap = true, silent = true })

-- tab move lines
set("v",    "<Tab>",         ">gv", { noremap = true, silent = true })
set("v",    "<S-Tab>",       "<gv", { noremap = true, silent = true })

-- comment/uncomment
vim.keymap.set({"n", "v"}, "<leader>/", ":Commentary<CR>", { desc = "Toggle comment" })
-- vim.keymap.set("i", "<C-/>", ":Commentary<CR>", { desc = "Toggle comment" })

-- Add or skip cursor above/below the main cursor.
local multicursor = require("multicursor-nvim")
set({"n", "x"}, "<leader><up>", function() multicursor.lineSkipCursor(-1) end)
set({"n", "x"}, "<leader><down>", function() multicursor.lineSkipCursor(1) end)

-- Add or skip adding a new cursor by matching word/selection
set({"n", "x"}, "<leader>n", function() multicursor.matchAddCursor(1) end)
set({"n", "x"}, "<leader>s", function() multicursor.matchSkipCursor(1) end)
set({"n", "x"}, "<leader>N", function() multicursor.matchAddCursor(-1) end)
set({"n", "x"}, "<leader>S", function() multicursor.matchSkipCursor(-1) end)

-- Add and remove cursors with control + left click.
set({ "n", "v" }, "<c-leftmouse>", multicursor.handleMouse)
set({ "n", "v" }, "<c-leftdrag>", multicursor.handleMouseDrag)
set({ "n", "v" }, "<c-leftrelease>", multicursor.handleMouseRelease)

-- Disable and enable cursors.
set({"n", "x", "v" }, "<c-q>", multicursor.toggleCursor)

-- telescope keymaps
local builtin = require("telescope.builtin")
set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
set("n", "<Tab><Tab>", builtin.find_files, { desc = "[F]ind [F]iles" })
set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })
-- set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
set("n", "<leader>dd", builtin.lsp_document_symbols, { desc = "[D]ocument [D]efinitions" })
set("n", "<leader>os", ":Telescope session-lens<CR>", { desc = "[F]ile [E]xplorer" })
-- set("n", "<C-E>", "<cmd>Telescope frecency<cr>", {desc = "[F]ind [R]ecent files"})


-- cheatsheet.nvim
set({"n", "x"}, "<leader>?", "<cmd>Cheatsheet<cr>", { desc = "Search keymaps" })

-- spectre - global search
local function spectre_toggle()
    require("spectre").toggle()
end

set({"n", "v", "i"}, "<C-M-f>", spectre_toggle, {
    desc = "[F]ind [R]ecent files"
})
set({"n", "v", "i"}, "<leader>gs", spectre_toggle, {
    desc = "[F]ind [R]ecent files"
})

-- git tools
set({ "n", "x" }, "<leader>lg", "<cmd>LazyGit<CR>", {desc = "[L]azy[G]it"})
set({ "n", "x" }, s_leader .. "g", "<cmd>LazyGitCurrentFile<CR>", {desc = "Lazy[G]it"})
set({ "n", "x" }, s_leader .. "b", "<cmd>LazyGitFilterCurrentFile<CR>", {desc = "LazyGitFilter ([B]lame)"})
set({ "n", "x" }, "<leader>gsd", "<cmd>DiffviewFileHistory<CR>", {desc = "[G]it [S]how [D]iff"})
set({ "n", "x" }, "<leader>gcb", "<cmd>Telescope git_branches<CR>", {desc = "[G]it [C]heckout [B]ranches"})


-- test-case
set({ "n", "x" }, s_leader .. "s", "<cmd>TextCaseOpenTelescope<CR>", {desc = "[S]tring manipulation"})

-- timemachine: localhistory
set({ "n", "x" }, s_leader .. "h", "<cmd>TimeMachineToggle<CR>", {desc = "Local [H]istory"})

-- harpoon2
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>ah", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-h>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

