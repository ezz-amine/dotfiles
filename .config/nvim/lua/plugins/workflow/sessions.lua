return {
  'natecraddock/sessions.nvim',
  config = {
    events = { "WinEnter" },
    session_filepath = vim.fn.stdpath("data") .. "/sessions",
    absolute = true,
  }
}

