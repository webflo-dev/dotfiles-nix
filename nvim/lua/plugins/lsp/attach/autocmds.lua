local M = {}

local diagnostics_float_config = {
	focusable = false,
	close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
	border = "rounded",
	source = "always",
	prefix = " ",
	scope = "cursor",
}

local function diagnostics_float_handler()
	-- Immediately return if the screen width can show virtual text
	-- Mostly done for window splits and termux
	if vim.fn.winwidth(0) > 100 then
		return
	end

	local cword = vim.fn.expand("<cword>")
	if cword ~= vim.w.lsp_diagnostics_cword then
		vim.w.lsp_diagnostics_cword = cword

		local _, winnr = vim.diagnostic.open_float(diagnostics_float_config)
		if winnr ~= nil then
			vim.api.nvim_win_set_option(winnr, "winblend", 20)
		end
	end
end

function M.attach(client, buffer, autocmd_group)
	vim.api.nvim_create_autocmd("CursorHold", {
		group = autocmd_group,
		buffer = buffer,
		callback = diagnostics_float_handler,
		desc = "Shows diagnostic in floating window on smaller windows",
	})

	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = autocmd_group,
			buffer = buffer,
			callback = vim.lsp.buf.document_highlight,
			desc = "Highlights symbol under cursor",
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			group = autocmd_group,
			buffer = buffer,
			callback = vim.lsp.buf.clear_references,
			desc = "Clears symbol highlighting under cursor",
		})
	end
end

return M
