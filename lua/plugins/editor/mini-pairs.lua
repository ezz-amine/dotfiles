return {
    {
      "echasnovski/mini.pairs",
      event = "VeryLazy",
      config = function()
        require('mini.pairs').setup({
          -- Custom mappings (can be empty to use defaults)
          mappings = {
            ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
            ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
            ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

            -- Smart quotes (only add if not already typed)
            ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
            ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^%a\\].', register = { cr = false } },
            ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^%a\\].', register = { cr = false } },
          },

          -- Disable for certain filetypes
          disable_filetype = { 'TelescopePrompt', 'alpha', 'NvimTree' },
        })
      end
    }
  }