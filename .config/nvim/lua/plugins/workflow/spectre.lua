local vars = require("coldbrew.vars")

return {
    "nvim-pack/nvim-spectre",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("spectre").setup({
        -- Cross-platform default settings
        default = {
          find = {
            cmd = "rg",
            options = { "ignore-case" }
          },
          replace = {
            cmd = "sed"
          }
        },
        -- Windows-specific settings
        is_block_ui_break = (function()
          return true and vars.is_windows or false
        end)(),
      })
    end
  }