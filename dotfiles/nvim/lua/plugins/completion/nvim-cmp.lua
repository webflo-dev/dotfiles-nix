local function get_lsp_completion_context(completion, source)
	local ok, source_name = pcall(function()
		return source.source.client.config.name
	end)
	if not ok then
		return nil
	end
	return completion and completion.detail or nil
	-- if source_name == "typescript-tools" then
	--   return completion.detail
	-- end
end

return {
	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			-- snippet engine
			"dcampos/nvim-snippy",
			-- sources
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-emoji",

			-- SASS completion
			"mmolhoek/cmp-scss",
		},
		config = function()
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

			local cmp = require("cmp")
			local cmp_default = require("cmp.config.default")()

			local format_menu = {
				buffer = "BUFFER",
				nvim_lsp = "LSP",
				path = "PATH",
				snippy = "SNIPPET",
				emoji = "EMOJI",
				copilot = " ",
			}

			local border_opts = {
				border = "single",
				-- winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
				winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
			}

			local opts = {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("snippy").expand_snippet(args.body)
					end,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 10 },
					{ name = "nvim_lsp_signature_help", priority = 9 },
					{ name = "buffer", priority = 8 },
					-- {
					--   name = "scss",
					--   priority = 100,
					--   option = {
					--     triggers = { "$" },                                   -- default value
					--     extension = ".scss",                                  -- default value
					--     pattern = [=[\%(\s\|^\)\zs\$[[:alnum:]_\-0-9]*:\?]=], -- default value
					--     folders = { "src/theme/variables" },
					--   },
					-- },
					{ name = "path", priority = 6 },
					{ name = "emoji", priority = 5 },
				}),
				sorting = cmp_default.sorting,
				formatting = {
					fields = { "abbr", "kind", "menu" },
					format = function(entry, item)
						local icons = require("icons").kinds
						if icons[item.kind] then
							item.kind = icons[item.kind] .. item.kind
						end
						item.menu = format_menu[entry.source.name]

						local completion_context = get_lsp_completion_context(entry.completion_item, entry.source)
						if completion_context ~= nil and completion_context ~= "" then
							item.menu = item.menu .. " ・" .. completion_context
						end

						return item
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-u>"] = cmp.mapping.scroll_docs(4),
					["<CR>"] = cmp.mapping.confirm({
						-- select = false,
						select = true,
						behavior = cmp.ConfirmBehavior.Replace,
					}),
					-- ["<Tab>"] = cmp.mapping(function(fallback)
					-- 	if cmp.visible() then
					-- 		cmp.select_next_item()
					-- 	elseif has_words_before() then
					-- 		cmp.complete()
					-- 	else
					-- 		fallback()
					-- 	end
					-- end, { "i", "s" }),
					-- ["<S-Tab>"] = cmp.mapping(function(fallback)
					-- 	if cmp.visible() then
					-- 		cmp.select_prev_item()
					-- 	else
					-- 		fallback()
					-- 	end
					-- end, { "i", "s" }),
				}),
				window = {
					completion = cmp.config.window.bordered(border_opts),
					documentation = cmp.config.window.bordered(border_opts),
				},
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
						-- hl_group = "LspCodeLens",
					},
				},
			}

			cmp.setup(opts)

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "nvim_lsp_document_symbol" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
