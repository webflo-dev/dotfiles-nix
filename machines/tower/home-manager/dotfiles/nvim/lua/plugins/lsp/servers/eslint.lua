local M = {

  settings = {
    autoFixOnSave = true,
    format = {
      enable = true,
    },
    codeActionOnSave = {
      enable = true,
      mode = "all",
      showDocumentation = true,
    },
    validate = "on",
    workingDirectory = {
      mode = "location",
    },
  },

  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}

return M
