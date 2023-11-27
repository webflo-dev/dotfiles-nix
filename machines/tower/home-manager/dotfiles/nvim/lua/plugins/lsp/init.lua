local _dir = ...

return {

	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		cmd = "Mason",
		opts = {
			ensure_installed = {
				"eslint_d",
				"gofumpt",
				"goimports",
				"hadolint", -- docker-compose
				"markdownlint",
				"marksman",
				"prettier",
				"shfmt",
				"stylua",
				"codelldb",
			},
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			for _, tool in ipairs(opts.ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- "b0o/SchemaStore.nvim",
		},
		config = function()
			local servers = {
				"awk_ls",
				"bashls",
				"cssls",
				"cssmodules_ls",
				"dockerls",
				"docker_compose_language_service",
				"eslint",
				"gopls",
				"graphql",
				"html",
				"jsonls",
				"lua_ls",
				-- "lua-language-server",
				"prismals",
				"rust_analyzer",
				-- "tsserver",
				-- "vtsls",
				"yamlls",
			}

			local global_capabilities = {}

			require("util").load_modules(_dir .. ".setup", nil, function(module)
				module.setup(_dir)
			end)

			local setup_handler_opts = {
				capabilities = global_capabilities,
			}

			local setup_handler = require(_dir .. ".setup_handlers").setup(_dir, setup_handler_opts)

			require("mason-lspconfig").setup({
				ensure_installed = servers,
				handlers = { setup_handler },
			})
		end,
	},

	{
		"b0o/SchemaStore.nvim",
		lazy = true,
		version = false, -- last release is way too old
	},

	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		config = function()
			vim.api.nvim_create_autocmd("VimLeavePre", { command = [[silent! FidgetClose]] })

			require("fidget").setup({
				text = {
					spinner = "dots",
				},
			})
		end,
	},

	{
		"pmizio/typescript-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end,
			settings = {
				tsserver_max_memory = 1024,
				separate_diagnostic_server = false,
				code_lens = "off", -- implementations_only, references_only, off, all
				disable_member_code_lens = false,
				complete_function_calls = true,
				publish_diagnostic_on = "insert_leave", -- insert_leave, change

				-- fix_all, add_missing_imports, remove_unused, remove_unused_imports, organize_imports
				-- expose_as_code_action = "all",
				-- expose_as_code_action = {
				-- 	"fix_all",
				-- 	"add_missing_imports",
				-- 	"remove_unused",
				-- },
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "literals",
					-- includeInlayParameterNameHints = 'all',
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
	},

	{
		"luckasRanarison/clear-action.nvim",
		opts = {
			silent = false,
		},
	},
}
