local icons = require("icons")

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
			{ "MunifTanjim/nui.nvim", lazy = true },
			{ "nvim-tree/nvim-web-devicons", lazy = true },
		},
		cmd = "Neotree",
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			vim.g.neo_tree_remove_legacy_commands = 1
		end,
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle reveal=true<cr>", desc = "Explorer NeoTree" },
		},
		opts = {
			sources = { "filesystem" },

			filesystem = {
				bind_to_cwd = false,
				use_libuv_file_watcher = true,
				hijack_netrw_behavior = "disabled",
				follow_current_file = {
					enabled = true,
				},
				window = {
					mappings = {
						["<Right>"] = "open",
						["<Left>"] = "close_node",
						["l"] = "open",
						["h"] = "close_node",
					},
				},
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function()
						--auto close
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
				{
					event = "before_file_move",
					handler = function(data)
						require("plugins.lsp.util").rename_files_or_folder(data.source, data.destination)
					end,
				},
				{
					event = "before_file_rename",
					handler = function(data)
						require("plugins.lsp.util").rename_files_or_folder(data.source, data.destination)
					end,
				},
			},
			default_component_configs = {
				file_size = { enabled = false },
				type = { enabled = false },
				last_modified = { enabled = false },
				created = { enabled = false },
				symlink_target = { enabled = false },
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = icons.common.collapsed,
					expander_expanded = icons.common.expanded,
					expander_highlight = "NeoTreeExpander",
				},
				git_status = {
					symbols = {
						added = icons.git.added,
						deleted = icons.git.removed,
						modified = icons.git.modified,
						renamed = icons.git.renamed,
						untracked = icons.git.untracked,
						ignored = icons.git.ignored,
						unstaged = icons.git.untracked,
						staged = icons.git.staged,
						conflict = icons.git.conflict,
					},
				},
			},
			window = {
				--position = "float",
				position = "left",
				popup = {
					size = {
						height = "60%",
						width = "40%",
					},
					-- position = "20%",
				},
				mappings = {
					["<space>"] = "none",
					["<C-s>"] = "open_split",
					["<C-v>"] = "open_vsplit",
					["<C-t>"] = "open_tabnew",
					["a"] = {
						"add",
						config = {
							show_path = "relative", -- "none", "relative", "absolute"
						},
					},
					["m"] = {
						"move",
						config = {
							show_path = "relative",
						},
					},
					["c"] = {
						"copy",
						config = {
							show_path = "relative", -- "none", "relative", "absolute"
						},
					},
				},
			},
		},
	},
}
