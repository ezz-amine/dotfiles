local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Auto create directories when saving
autocmd("BufWritePre", {
  callback = function(ctx)
    local dir = vim.fn.fnamemodify(ctx.file, ":p:h")
    vim.fn.mkdir(dir, "p")
  end,
})

-- if vim.g.save_all_at_exit then
--   autocmd("VimLeavePre", {callback = ColdBrew.save_all})
-- end
