return {
  {
    "kylechui/nvim-surround",
    version = "*",      -- Use the latest version
    event = "VeryLazy", -- Lazy-load the plugin
    config = function()
      local surround = require("nvim-surround")
      surround.setup(cb_config("surround"))
    end,
  }
}
