local M = {}

local functionOrCommand = require("util").functionOrCommand

local function diagnostic_goto(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

function M.attach(_, buffer, _)
	local function map(mode, key, cmd, desc)
		vim.keymap.set(mode, key, functionOrCommand(cmd), { buffer = buffer, desc = desc })
	end

	if vim.lsp.inlay_hint then
		map("n", "<leader>uh", function()
			vim.lsp.inlay_hint(0, nil)
		end, "Toggle Inlay hints")
	end

	map("n", "<leader>cd", vim.diagnostic.open_float, "Show line diagnostics")
	map("n", "]d", diagnostic_goto(true), "Next diagnostic")
	map("n", "[d", diagnostic_goto(false), "Previous diagnostic")

	map("n", "K", vim.lsp.buf.hover, "Hover")
	map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
	map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")

	map("n", "<leader>ca", "FzfLua lsp_code_actions", "Code action")
	map("n", "<leader>cA", function()
		vim.lsp.buf.code_action({
			context = {
				only = {
					"source",
				},
				diagnostics = {},
			},
		})
	end, "Source Action")

	map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
	map("n", "gd", "FzfLua lsp_definitions", "Go to Definition")
	map("n", "gD", "TSToolsGoToSourceDefinition", "Go to source definition")
	-- map("n", "gD", keymaps.lsp.declaration, "Go to declaration")
	--
	-- map("n", "gr", "FzfLua lsp_references", "Go to reference")
	map("n", "gR", "FzfLua lsp_references", "Go to reference")

	map("n", "gt", "FzfLua lsp_type_definitions", "Go to type definition")

	map("n", "gi", "FzfLua lsp_implementations", "Go to implementation")

	map("n", "gCi", "FzfLua incoming_calls", "Incoming calls")

	map("n", "gCo", "FzfLua outgoing_calls", "Outgoing calls")

	-- map("n", "gSd", "FzfLua lsp_document_symbols", "Document symbols")
	-- map("n", "gSw", "FzfLua lsp_live_workspace_symbols", "Workspace symbols")
end

return M
