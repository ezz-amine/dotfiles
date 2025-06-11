local py = {
  bin_dir = vim.g.is_windows and "Scripts" or "bin",
  local_venv_path = vim.fs.joinpath(vim.fn.stdpath("data"), "cb-venv"),
}

function py.get_python_path(venv_path)
  return vim.fs.normalize(vim.fs.joinpath(venv_path, py.bin_dir, "python"))
end

function py.get_active_venv()
  if vim.env.VIRTUAL_ENV == nil then
    return nil
  end

  return vim.env.VIRTUAL_ENV
end

return py
