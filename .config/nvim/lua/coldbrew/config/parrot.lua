return {
  -- Providers must be explicitly added to make them available.
  providers = {
    gemini = {
      api_key = vim.g.gemini_token,
      endpoint = function(self)
        return "https://generativelanguage.googleapis.com/v1beta/models/"
            .. self._model
            .. ":streamGenerateContent?alt=sse"
      end,
    },
    -- github = {
    --   api_key = vim.g.github_token,
    --   models = {
    --     "mistral-ai/Ministral-3B",
    --   },
    --   params = {
    --     temperature = 1.0,
    --     max_tokens = 1000,
    --     top_p = 1.0,
    --   },
    -- },
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
}
