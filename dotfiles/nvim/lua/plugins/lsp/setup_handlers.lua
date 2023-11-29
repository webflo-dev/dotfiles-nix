-- local __dir = ...

local M = {}

function M.setup(lsp_dir, opts)
	local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	local capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		has_cmp and cmp_nvim_lsp.default_capabilities() or {},
		opts.capabilities or {}
	)

	local function setup(server)
		local server_opts = {
			capabilities = vim.deepcopy(capabilities),
		}

		local has_custom_config, custom_config = pcall(require, lsp_dir .. ".servers." .. server)

		if has_custom_config then
			if type(custom_config) == "function" then
				custom_config = custom_config()
			end
			server_opts = vim.tbl_deep_extend("force", server_opts, custom_config)
		end

		local has_coq, coq = pcall(require, "coq")
		if has_coq then
			server_opts = coq.lsp_ensure_capabilities(server_opts)
		end

		require("lspconfig")[server].setup(server_opts)
	end

	return setup
end

return M
