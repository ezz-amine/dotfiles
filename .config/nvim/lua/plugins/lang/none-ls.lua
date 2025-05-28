return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
      "gbprod/none-ls-shellcheck.nvim",
    },
    config = function()
      require("null-ls").setup(cb_config "none-ls")
    end,
  },
}
