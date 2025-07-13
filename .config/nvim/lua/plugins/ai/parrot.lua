local gemini_token = "AIzaSyDvTM-BP8dSxxIruAtVWZxiJcpk9qV10JU"

return vim.g.gemini_token
    and {
      "frankroeder/parrot.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "ibhagwan/fzf-lua",
      },
      -- opts = {},
      config = cb_config("parrot"),
      -- function()
      -- if vim.g.gemini_token ~= nil then
      --   print(vim.inspect(cb_config("parrot")))
      --   -- require("parrot").setup(cb_config("parrot"))
      -- end
      -- end,
    }
    or {}
