local WindowsManager = {}

local _width_90 = math.floor(vim.o.columns * 0.9)
local _height_90 = math.floor(vim.o.lines * 0.9)

local default_options = {
  window = {
    relative = "editor",
    width = 0.9,
    height = 0.9,
    border = "rounded",
  },
  keymap = {
    { "n", "q", ":q<CR>" },
  },
  filetype = nil,
}

function WindowsManager.open_file(file_path, options)
  if file_path == nil then
    error("'file_path' must be a string")
    return nil, nil
  end

  options = vim.tbl_deep_extend("keep", options or {}, default_options)
  if not cb.is_number(options.window.width) or options.window.width < 0.4 or options.window.width > 0.9 then
    options.window.width = default_options.window.width
  end
  if not cb.is_number(options.window.height) or options.window.height < 0.4 or options.window.height > 0.9 then
    options.window.height = default_options.window.height
  end

  options.window.width = math.floor(vim.o.columns * options.window.width)
  options.window.height = math.floor(vim.o.lines * options.window.height) - 1
  options.window.col = (vim.o.columns - options.window.width) / 2
  options.window.row = (vim.o.lines - options.window.height - 1) / 2

  local buf_id = vim.fn.bufnr(file_path, true) -- true to create if not exists
  if buf_id == -1 then
    buf_id = vim.fn.bufload(file_path)
    if buf_id == -1 then
      error(string.format("Error: Could not load file '%s' into a buffer.", file_path))
    end
  end

  local win_id = vim.api.nvim_open_win(buf_id, true, options.window)
  if options.filetype ~= nil then
    vim.api.nvim_set_option_value("filetype", options.filetype, { buf = buf_id })
  end
  for _, keybind in ipairs(options.keymap) do
    if #keybind == 3 then
      vim.api.nvim_buf_set_keymap(buf_id, keybind[1], keybind[2], keybind[3], { noremap = true, silent = true })
    else
      error(
        "malformed keybind, must be { mode(s), key_combin, cmd_or_function }: [e.g.: { \"n\", \"q\", \":wq\" }]"
        .. vim.inspect(keybind)
      )
    end
  end

  return win_id, buf_id
end

return WindowsManager
