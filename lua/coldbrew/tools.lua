local tools = {}
local g_tools = require("coldbrew.__tools.__global")

tools.table_merge = g_tools.table_merge

tools.python = require("coldbrew.__tools.__python")

return tools