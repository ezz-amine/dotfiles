return {
  "rcarriga/nvim-notify", -- notification as popups/toasts
  config = function()
    require("notify").setup(cb_config("notify"))
  end,
}
