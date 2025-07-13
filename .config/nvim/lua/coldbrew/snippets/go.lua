local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- // if err != nil {
-- // 	panic(err)
-- // }
return {
  -- Example: def snippet
  s("iferr", {
    t("if err "),
    i(1, "!="),
    t(" nil {"),
    i(2, ""),
    t("}"),
  }),

  -- Add more Python snippets here
}, {
  -- Autotriggered snippets
}

