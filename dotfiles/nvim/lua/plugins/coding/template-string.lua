return {
  {
    "axelvc/template-string.nvim",
    opts = {
      filetypes = { 'html', 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
      jsx_brackets = true,
      remove_template_string = true,
      restore_quotes = {
        normal = [["]],
        jsx = [[']],
      },
    }
  }
}
