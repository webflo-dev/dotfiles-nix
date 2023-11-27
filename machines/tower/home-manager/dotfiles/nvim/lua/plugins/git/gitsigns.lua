return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 200,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "   <author> 󰔠 <author_time:%h %d, %Y> 󰜘 <summary>",
			preview_config = {
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			signs = {
				add = {
					hl = "GitSignsAdd",
					text = "│",
					numhl = "GitSignsAddNr",
					linehl = "GitSignsAddLn",
				},
				change = {
					hl = "GitSignsChange",
					text = "│",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				delete = {
					hl = "GitSignsDelete",
					text = "│",
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				topdelete = {
					hl = "GitSignsDelete",
					text = "│",
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				changedelete = {
					hl = "GitSignsChange",
					text = "│",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				untracked = { hl = "GitSignsAdded", text = "┆", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

				map("n", "]h", gs.next_hunk, "Next Hunk")
				map("n", "[h", gs.prev_hunk, "Prev Hunk")

				map({ "n", "v" }, "<localleader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
				map({ "n", "v" }, "<localleader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")

				map("n", "<localleader>ghS", gs.stage_buffer, "Stage Buffer")
				map("n", "<localleader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<localleader>ghR", gs.reset_buffer, "Reset Buffer")
				map("n", "<localleader>ghp", gs.preview_hunk, "Preview Hunk")
				map("n", "<localleader>ghb", function()
					gs.blame_line({ full = true })
				end, "Blame Line")
				map("n", "<localleader>ghd", gs.diffthis, "Diff This")
				map("n", "<localleader>ghD", function()
					gs.diffthis("~")
				end, "Diff This ~")
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},
}
