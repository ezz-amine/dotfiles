local create = vim.api.nvim_create_user_command
local coldbrew_prefix="CB"

create('CBGreb',
  function(opts)
    require('telescope.builtin').live_grep({ default_text = opts.args })
  end,
  { nargs = 1 }
)