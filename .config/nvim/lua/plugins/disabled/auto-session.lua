return {
  'rmagatti/auto-session',
  lazy = false,
  opts = {
    enabled = true,                                    -- Enables/disables auto creating, saving and restoring
    root_dir = vim.fn.stdpath("data") .. "/sessions/", -- Root dir where sessions will be stored
    auto_save = false,                                 -- Enables/disables auto saving session on exit
    auto_restore = false,                              -- Enables/disables auto restoring session on start
    auto_create = false,                               -- Enables/disables auto creating new session files. Can take a function that should return true/false if a new session file should be created or not
    suppressed_dirs = vim.g.sessions_ignored_dirs,     -- Suppress session restore/create in certain directories
    auto_restore_last_session = false,                 -- On startup, loads the last saved session if session for cwd does not exist
    git_use_branch_name = true,                        -- Include git branch name in session name
    git_auto_restore_on_branch_change = true,          -- Should we auto-restore the session when the git branch changes. Requires git_use_branch_name
    bypass_save_filetypes = { "neo-tree" },            -- List of filetypes to bypass auto save when the only buffer open is one of the file types listed, useful to ignore dashboards
    show_auto_restore_notif = false,                   -- Whether to show a notification when auto-restoring
    lsp_stop_on_restore = false,                       -- Should language servers be stopped when restoring a session. Can also be a function that will be called if set. Not called on autorestore from startup
    args_allow_single_directory = false,               -- boolean Follow normal sesion save/load logic if launched with a single directory as the only argument
    args_allow_files_auto_save = false,                -- boolean|function Allow saving a session even when launched with a file argument (or multiple files/dirs). It does not load any existing session first. While you can just set this to true, you probably want to set it to a function that decides when to save a session when launched with file args. See documentation for more detail
  }
}
