local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Example: def snippet
  s('func', {
    t('def '),
    i(1, 'function_name'),
    t('('),
    i(2, 'args'),
    t('):'),
    t('\t'),
    i(0),
  }),

  -- Add more Python snippets here
}, {
  -- Autotriggered snippets
}