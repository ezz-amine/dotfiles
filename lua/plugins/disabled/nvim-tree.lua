return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle file explorer" },
      { "<leader>E", ":NvimTreeFindFile<CR>", desc = "Reveal current file in explorer" },
    },
    config = function()
      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true
        },
        view = {
          width = 30,
          side = "left",
        },
        filters = {
          dotfiles = true,
          git_ignored = true,
          custom = { "^.git$" },  -- Hide .git directory
        },
        git = {
          enable = true,
          ignore = true,  -- Respect .gitignore
          timeout = 400,
        },
        renderer = {
          group_empty = true,
          icons = {
            git_placement = "after",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        actions = {
          open_file = {
            quit_on_open = true,
            window_picker = {
              enable = false,
            },
          },
        },
      })
    end,
  }