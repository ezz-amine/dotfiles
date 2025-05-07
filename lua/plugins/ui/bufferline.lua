return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "tabs", -- or "buffers"
          separator_style = "slant", -- or "thick", "thin"
          show_close_icon = false,
          show_buffer_close_icons = false,
          diagnostics = "nvim_lsp",
          close_command = "bdelete! %d",
          right_mouse_command = nil,
          left_mouse_command = "buffer %d",
          middle_mouse_command = "bdelete! %d",
          always_show_bufferline = false,
          offsets = {
            {
              filetype = "NeoTree",
              text = "Tree",
              highlight = "Directory",
              text_align = "left",
            },
          },
        },
      })
    end,
  }
