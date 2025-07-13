- [x] fix issue with timeout none-ls/null-ls
- [ ] BrewSession
  - [ ] mutli-session
  - [ ] hooks
  - [ ] pre-config/post-load
  - [ ] python integration
  - [ ] pinned files (by session) - maybe use harpoon
  - [ ] stop lsp when saving all, format files post , restart lsp
- [ ] terminal (as popup), with pre-cmd
- [x] fix live_grep
- plugins:
  - [ ] https://github.com/lewis6991/gitsigns.nvim
  - [x] https://github.com/folke/which-key.nvim-lua
        https://github.com/nvim-lua/kickstart.nvim/blob/6ba2408cdf5eb7a0e4b62c7d6fab63b64dd720f6/init.lua#L301
  - [ ] telescope -> <leader>s
        https://github.com/nvim-lua/kickstart.nvim/blob/6ba2408cdf5eb7a0e4b62c7d6fab63b64dd720f6/init.lua#L427 - [ ] file browser -> show depth
  - [x] folke/lazydev.nvim
        https://github.com/nvim-lua/kickstart.nvim/blob/6ba2408cdf5eb7a0e4b62c7d6fab63b64dd720f6/init.lua#L466
  - [ ] config lsp mapping (gd, r, )
    - https://github.com/nvim-lua/kickstart.nvim/blob/6ba2408cdf5eb7a0e4b62c7d6fab63b64dd720f6/init.lua#L495
    - https://github.com/nvim-lua/kickstart.nvim/blob/6ba2408cdf5eb7a0e4b62c7d6fab63b64dd720f6/init.lua#L621
  - [ ] use `vim.list_extend` and `vim.` function to loop/manipulate tables
        deps:

vim.api.nvim_create_user_command('PyDoc', function(opts)
local module = opts.args
vim.cmd('new') -- Open a new buffer
vim.fn.execute('read !pydoc ' .. module)
vim.cmd('set ft=man') -- Apply man-page styling
vim.cmd('normal gg') -- Jump to top
end, { nargs = 1 })
