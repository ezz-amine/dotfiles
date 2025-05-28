-- credit : https://github.com/nvim-lua/kickstart.nvim
local function client_supports_method(client, method, bufnr)
  if vim.fn.has "nvim-1.11" == 1 then
    return client:supports_method(method, bufnr)
  else
    return client.supports_method(method, { bufnr = bufnr })
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("coldbrew-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc, silent = true })
    end

    map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
    map("fx", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
    map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
    map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
    map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")
    map("gee", vim.diagnostic.open_float, "[G]oto [E]rror [E]xplainer", "n")
    map("<leader><leader>", vim.diagnostic.open_float, "[E]rror [E]xplainer", "n")

    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("coldbrew-lsp-detach", { clear = true }),
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, "[T]oggle Inlay [H]ints")
    end
  end,
})
