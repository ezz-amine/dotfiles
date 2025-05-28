-- register global helpers
function cb_require(package)
  return require("coldbrew." .. package)
end

function cb_config(package)
  return cb_require("config." .. package)
end

function cb_mod(package)
  return cb_require("modules." .. package)
end

function cb_lsp(lang)
  return cb_config("lsp." .. lang)
end

cb = {}
-- language tools and helpers

function cb.any(t, predicate)
  for _, v in pairs(t) do
    if predicate(v) then
      return true
    end
  end
  return false
end

function cb.all(t, predicate)
  for _, v in pairs(t) do
    if not predicate(v) then
      return false
    end
  end
  return true
end

function cb.is_nil(value)
  return type(value) == "nil"
end

function cb.is_number(value)
  return type(value) == "number"
end

function cb.is_string(value)
  return type(value) == "string"
end

function cb.is_bool(value)
  return type(value) == "bool"
end

function cb.is_table(value)
  return type(value) == "table"
end

function cb.is_function(value)
  return type(value) == "function"
end

function cb.is_list(value)
  return cb.is_table(value) and cb.all(vim.tbl_keys(value), cb.is_number)
end

function cb.is_dict(value)
  return cb.is_table(value) and not cb.is_list(value)
end

--is_dict
--is_list

-- shalow copy of a table
function cb.tbl_copy(tbl)
  return vim.tbl_extend("force", {}, tbl)
end

-- merge 2 table
function cb.tbl_merge(tbl_1, tbl_2)
  local result = cb.tbl_copy(tbl_1)
  for _, value in ipairs(tbl_2) do
    table.insert(result, value)
  end

  return result
end

local function serialize_value(value)
  if type(value) == "table" then
    local value_as_arr = {}

    table.insert(value_as_arr, "{")

    if cb.is_list(value) then
      for _, listvalue in ipairs(value) do
        table.insert(value_as_arr, serialize_value(listvalue) .. ",")
      end
    else
      for dictkey, dictvalue in pairs(value) do
        table.insert(value_as_arr, "[" .. serialize_value(dictkey) .. "] = " .. serialize_value(dictvalue) .. ",")
      end
    end
    table.insert(value_as_arr, "}")
    return table.concat(value_as_arr, "\n")
  elseif cb.is_number(value) then
    return tostring(value)
  elseif cb.is_string(value) then
    return string.format("%q", value)
  elseif cb.is_boolean(value) then
    return (value and "true" or "false")
  else
    error("serialize_config: \"[unsupported type " .. type(value) .. "]\"", vim.log.levels.WARN)
    return nil
  end
end

function cb.serialize_config(value)
  if not cb.is_table(value) then
    error("value must be table " .. type(value) .. "given")
    return ""
  end

  return "return " .. serialize_value(value)
end

-- helpers for paths
function cb.os_path(path)
  if vim.g.is_windows then
    path, _ = path:gsub("/", "\\")
  else
    path, _ = path:gsub("\\", "/")
  end

  return path
end

-- system helpers

function cb.run_job(cmd, message)
  message = message or "Working..."
  local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local idx = 1
  local timer = vim.loop.new_timer()

  -- Start spinner
  timer:start(100, 200, function()
    vim.schedule(function()
      idx = idx % #frames + 1
      vim.api.nvim_echo({ { message .. " " .. frames[idx] } }, false, {})
    end)
  end)

  -- Run command
  return vim.fn.jobstart(cmd, {
    on_stderr = function(id, output, _)
      print(vim.inspect({ "job log", cmd, output }))
    end,
    on_exit = function(id, exitcode, event)
      vim.schedule(function()
        if exitcode == 0 then
          vim.api.nvim_echo({ { "done!" } }, false, {})
        else
          vim.api.nvim_echo({ { "err!" } }, false, {})
        end
        timer:stop()
        timer:close()
      end)
    end,
  })
end
