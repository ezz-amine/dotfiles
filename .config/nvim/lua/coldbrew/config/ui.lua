local M = {}

M.small_pop_select = {
  -- Smaller layout
  layout_config = {
    width = 0.5,             -- 50% of the editor width
    height = 0.3,            -- 30% of the editor height
    prompt_position = "top", -- Optional: place prompt at the top
  },
  -- Other dropdown theme overrides
  border = true,
  previewer = false, -- Disable previewer for a minimal look
}


return M
