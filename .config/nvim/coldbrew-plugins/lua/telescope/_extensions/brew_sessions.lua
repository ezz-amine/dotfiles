-- Register the extension

local BrewSessions = require("brew-sessions")

return require("telescope").register_extension {
  exports = {
    brew_sessions = BrewSessions.brew_sessions,
  },
}
