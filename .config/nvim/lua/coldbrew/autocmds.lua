-- Auto commands

-- global
require "coldbrew.__autocmds.__global"

-- lang
require "coldbrew.__autocmds.__python"

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})

-- In your init.lua
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("cb_nofile", { clear = true }),
  callback = function()
    -- Only open if Neovim was started without arguments (no specific file)
    if vim.fn.argc() == 0 then
      -- And if the current buffer is the default empty buffer
      -- This prevents it from opening if you're already in a loaded session etc.
      if vim.api.nvim_buf_get_name(0) == "" and vim.api.nvim_buf_get_option(0, "buftype") == "" then
        -- Replace 'YourDashboardCommand' with the actual command
        -- e.g., 'Dashboard', 'NvimTreeToggle', 'Startify', 'NeoTree'
        vim.cmd("Alpha")
      end
    end
  end,
})
