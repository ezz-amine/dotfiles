return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Cross-platform venv detection
    local python_tools = require("coldbrew.tools")

    local function unique_filename()
      local filename = vim.fn.expand("%:t")  -- Just the filename
      if filename == "" then return "" end    -- Return empty for unnamed buffers

      -- Check for duplicate filenames in open buffers
      local duplicates = false
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
          local other = vim.api.nvim_buf_get_name(buf)
          if vim.fn.fnamemodify(other, ":t") == filename and other ~= vim.api.nvim_buf_get_name(0) then
            duplicates = true
            break
          end
        end
      end

      return duplicates and vim.fn.expand("%:.") or filename
    end

    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "tokyonight-moon",  -- Force Tokyo Night Moon theme
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "NvimTree", "alpha" },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          { "diff", symbols = { added = " ", modified = " ", removed = " " } },
          "diagnostics",
        },
        lualine_c = {
          {
            function()  -- Wrapped in function to handle errors
              local ok, result = pcall(unique_filename)
              return ok and result or ""
            end,
          },
          python_tools.get_venv_name
        },
        lualine_x = {
          {
            "encoding",
            fmt = function(str)
              return str == "utf-8" and "UTF8" or str:upper()
            end
          },
          {
            -- function()
            --   local wins = vim.api.nvim_list_wins()
            --   local layout = {}
            --   for _, win in ipairs(wins) do
            --     local config = vim.api.nvim_win_get_config(win)
            --     if not config.external then
            --       table.insert(layout, config.width .. ":" .. config.height)
            --     end
            --   end
            --   return table.concat(layout, " ")
            -- end,
            -- icon = " ",
          },
          "filetype",
        },
        lualine_y = { "progress", "location", },
        lualine_z = {
          {
            function()
              return os.date("%H:%M", os.time())
            end,
            icon = ""
          }
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
