local gemini_token = "AIzaSyDvTM-BP8dSxxIruAtVWZxiJcpk9qV10JU"

return {
  "frankroeder/parrot.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "ibhagwan/fzf-lua",
  },
  opts = {},
  config = cb_config("parrot")
}
