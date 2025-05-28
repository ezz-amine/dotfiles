local create = vim.api.nvim_create_user_command
create('W', "w!", { nargs = 0 })
create('FB', ":Telescope file_browser", { nargs = 0 })

create('CBGreb',
  function(opts)
    require('telescope.builtin').live_grep({ default_text = opts.args })
  end,
  { nargs = 1 }
)

create('CBSaveAll',
  ColdBrew.save_all,
  { nargs = 0 }
)

create('CBCloseAll',
  function()
    vim.cmd("%bd")
    vim.cmd("Alpha")
  end,
  { nargs = 0 }
)

-- save all and quit
-- create('qs',
--   function()
--     vim.cmd("CBSaveAll")
--     vim.cmd("qa!")
--   end,
--   { nargs = 0 }
-- )
