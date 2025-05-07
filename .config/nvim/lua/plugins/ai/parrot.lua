local gemini_token = "AIzaSyDvTM-BP8dSxxIruAtVWZxiJcpk9qV10JU"

return {
  "frankroeder/parrot.nvim",
  dependencies = { 
    "ibhagwan/fzf-lua",
    build = "make",
    "nvim-lua/plenary.nvim" 
  },
  opts = {},
  config = function()
    require("parrot").setup({
      -- Providers must be explicitly added to make them available.
      providers = {
        gemini  = {
          api_key = gemini_token,
        },
      },
      online_model_selection = false,
      toggle_target = "vsplit",
      user_input_ui = "native",
      -- Enables the query spinner animation 
      enable_spinner = true,
      -- Type of spinner animation to display while loading
      -- Available options: "dots", "line", "star", "bouncing_bar", "bouncing_ball"
      spinner_type = "star",
      -- Show hints for context added through completion with @file, @buffer or @directory
      show_context_hints = true,
      -- Controls visibility of the thinking window
      show_thinking_window = true,
    })
  end,
}