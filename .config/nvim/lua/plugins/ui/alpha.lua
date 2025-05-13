return {
  'goolord/alpha-nvim',
  config = function()
    local coldbrew_theme = require("coldbrew.alpha.theme")

    require('alpha').setup(coldbrew_theme.config)
  end
}
