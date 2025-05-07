return {
    {
      "kylechui/nvim-surround",
      version = "*", -- Use the latest version
      event = "VeryLazy", -- Lazy-load the plugin
      config = function()
        local surround = require("nvim-surround")
        surround.setup({
          surrounds = {
            ["("] = {
              add = { "(", ")" },
              find = "%b()",
              delete = "^%(().-()%)$",
            },
            ["["] = {
              add = { "[", "]" },
              find = "%b[]",
              delete = "^%[().-()%]$",
            },
            ["{"] = {
              add = { "{", "}" },
              find = "%b{}",
              delete = "^%{().-()%}$",
            },
            ["F"] = {
              add = function()
                return { 'f"', '"' }  -- Can add logic here if needed
              end,
              find = 'f%([%"%\'%[]).-%1',  -- Matches f", f', f[
              delete = '^(f[%"%\'%[])().-()%1$',
              change = {
                target = '^().-()$',  -- For changing existing surrounds
              }
            },
         },
        })
      end,
    }
  }
