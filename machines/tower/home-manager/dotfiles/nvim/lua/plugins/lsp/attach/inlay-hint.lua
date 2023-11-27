local M = {}

function M.attach(client, bufnr, _)
	local inlay_hint = vim.lsp.buf.inlay_hints or vim.lsp.inlay_hints
	if inlay_hint and client.supports_method("textDocument/inlayHint") then
		inlay_hint(bufnr, false)
	end
end

return M
