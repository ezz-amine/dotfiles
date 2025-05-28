return {
  'goolord/alpha-nvim',
  config = function()
    local coldbrew_theme = cb_config("alpha")

    require('alpha').setup(coldbrew_theme.config)
  end
}
