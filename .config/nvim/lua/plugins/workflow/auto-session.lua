return {
  'rmagatti/auto-session',
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    enabled = true, -- Enables/disables auto creating, saving and restoring
    root_dir = vim.fn.stdpath("data") .. "/sessions/", -- Root dir where sessions will be stored
    auto_save = true, -- Enables/disables auto saving session on exit
    auto_restore = true, -- Enables/disables auto restoring session on start
    auto_create = true, -- Enables/disables auto creating new session files. Can take a function that should return true/false if a new session file should be created or not
    suppressed_dirs = vim.g.sessions_ignored_dirs, -- Suppress session restore/create in certain directories
    auto_restore_last_session = false, -- On startup, loads the last saved session if session for cwd does not exist
    git_use_branch_name = true, -- Include git branch name in session name
    git_auto_restore_on_branch_change = true, -- Should we auto-restore the session when the git branch changes. Requires git_use_branch_name
    bypass_save_filetypes = {"neo-tree"}, -- List of filetypes to bypass auto save when the only buffer open is one of the file types listed, useful to ignore dashboards
  }
}
