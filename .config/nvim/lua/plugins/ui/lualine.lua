return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Cross-platform venv detection

    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "tokyonight-storm", -- Force Tokyo Night Moon theme
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
          require("coldbrew.tools").python.lualine_venv(),
          {
            function()
              return vim.fn.expand('%:.')
            end,
            color = { fg = '#b4f9f8' },
          },
        },
        lualine_x = {
          -- {
          --   function()
          --     local ok, PluginManager = require("brew-sessions.manager")
          --     vim.notify(ok)
          --     -- if PluginManager.current_project ~= nil then
          --     --   return {
          --     --     function()
          --     --       return PluginManager.current_project.name
          --     --     end,
          --     --     icon = "󱥾"
          --     --   }
          --     -- end
          --     return "󰷌 -"
          --   end,
          -- },
          {
            "encoding",
            fmt = function(str)
              return str == "utf-8" and "UTF8" or str:upper()
            end
          },
          "filetype"
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
