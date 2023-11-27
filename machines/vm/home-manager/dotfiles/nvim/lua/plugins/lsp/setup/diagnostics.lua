local M = {}

local opts = {
	underline = true,
	-- underline = {
	-- 	severity = { min = vim.diagnostic.severity.WARN },
	-- },
	update_in_insert = false,
	virtual_text = {
		only_current_line = false,
		spacing = 4,
		prefix = "■",
		-- prefix = function(diagnostic)
		-- 	local icons = require("icons").diagnostics
		-- 	for d, icon in pairs(icons) do
		-- 		if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
		-- 			return icon
		-- 		end
		-- 	end
		-- end,
		source = "if_many",
	},
	severity_sort = true,
	signs = true,
	float = {
		focusable = false,
		-- style = "minimal",
		border = "rounded",
		scope = "line",
		source = "always",
		header = "",
		prefix = "",
	},
}

function M.setup()
	for name, icon in pairs(require("icons").diagnostics) do
		name = "DiagnosticSign" .. name
		vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
	end
	vim.diagnostic.config(opts)
end

return M
