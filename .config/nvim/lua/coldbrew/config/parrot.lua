return {
  -- Providers must be explicitly added to make them available.
  providers = {
    gemini = {
      name = "gemini",
      endpoint = function(self)
        return "https://generativelanguage.googleapis.com/v1beta/models/"
            .. self._model
            .. ":streamGenerateContent?alt=sse"
      end,
      model_endpoint = function(self)
        return { "https://generativelanguage.googleapis.com/v1beta/models?key=" .. self.api_key }
      end,
      api_key = vim.g.gemini_token,
      params = {
        chat = { temperature = 1.1, topP = 1, topK = 10, maxOutputTokens = 8192 },
        command = { temperature = 0.8, topP = 1, topK = 10, maxOutputTokens = 8192 },
      },
      topic = {
        model = "gemini-2.5-flash-preview-05-20",
        params = { maxOutputTokens = 64 },
      },
      headers = function(self)
        return {
          ["Content-Type"] = "application/json",
          ["x-goog-api-key"] = self.api_key,
        }
      end,
      models = {
        "gemini-2.5-flash-preview-05-20",
        "gemini-2.5-pro-preview-05-06",
        "gemini-1.5-pro-latest",
        "gemini-1.5-flash-latest",
        "gemini-2.5-pro-exp-03-25",
        "gemini-2.0-flash-lite",
        "gemini-2.0-flash-thinking-exp",
        "gemma-3-27b-it",
      },
      preprocess_payload = function(payload)
        local contents = {}
        local system_instruction = nil
        for _, message in ipairs(payload.messages) do
          if message.role == "system" then
            system_instruction = { parts = { { text = message.content } } }
          else
            local role = message.role == "assistant" and "model" or "user"
            table.insert(contents, { role = role, parts = { { text = message.content:gsub("^%s*(.-)%s*$", "%1") } } })
          end
        end
        local gemini_payload = {
          contents = contents,
          generationConfig = {
            temperature = payload.temperature,
            topP = payload.topP or payload.top_p,
            maxOutputTokens = payload.max_tokens or payload.maxOutputTokens,
          },
        }
        if system_instruction then
          gemini_payload.systemInstruction = system_instruction
        end
        return gemini_payload
      end,
      process_stdout = function(response)
        if not response or response == "" then
          return nil
        end
        local success, decoded = pcall(vim.json.decode, response)
        if
            success
            and decoded.candidates
            and decoded.candidates[1]
            and decoded.candidates[1].content
            and decoded.candidates[1].content.parts
            and decoded.candidates[1].content.parts[1]
        then
          return decoded.candidates[1].content.parts[1].text
        end
        return nil
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
