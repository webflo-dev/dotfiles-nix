local M = {}

function M.setup(lsp_dir)
	local lsp_autocmd_group = vim.api.nvim_create_augroup("LspAutocmds", { clear = true })
	vim.api.nvim_create_autocmd("LspAttach", {
		group = lsp_autocmd_group,
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)

			require("util").load_modules(lsp_dir .. ".attach", nil, function(module)
				module.attach(client, buffer, lsp_autocmd_group, lsp_dir)
			end)
		end,
	})
end

return M
