local M = {
	settings = {
		Lua = {
			telemetry = {
				enable = false,
			},
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- diagnostics = {
			-- 	globals = {
			-- 		"vim",
			-- 	},
			-- },
			runtime = { version = "LuaJIT" },
		},
	},

	-- on_init = function(client)
	-- 	local path = client.workspace_folders[1].name
	-- 	if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
	-- 		client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
	-- 			Lua = {
	-- 				telemetry = {
	-- 					enable = false,
	-- 				},
	-- 				runtime = {
	-- 					-- Tell the language server which version of Lua you're using
	-- 					-- (most likely LuaJIT in the case of Neovim)
	-- 					version = "LuaJIT",
	-- 				},
	-- 				workspace = {
	-- 					checkThirdParty = false,
	-- 					library = {
	-- 						vim.env.VIMRUNTIME,
	-- 					},
	-- 				},
	-- 			},
	-- 		})
	--
	-- 		client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
	-- 	end
	-- 	return true
	-- end,
}

return M
