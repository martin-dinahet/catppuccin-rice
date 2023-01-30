local nvim_lsp = require("lspconfig")
local opts = { noremap=true, silent=true }
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local lsp_flags = {debounce_text_changes = 150}

require("lspconfig")["denols"].setup {
   on_attach = on_attach,
   flags = lsp_flags,
   capabilities = capabilities,
 }
