return {
	{
		"folke/tokyonight.nvim",
		enabled = true,
		opts = {
			style = "moon",
			dim_inactive = true,
			transparent = true,
			styles = {
				floats = "transparent",
				sidebars = "transparent",
			},
			on_highlights = function(highlights, colors)
				highlights.CursorLine = {
					bg = "#143652",
				}

				highlights.Search = {
					bg = "#0A64AC",
				}

				highlights.CursorLineNr = {
					fg = "#FFFFFF",
				}

				highlights.LineNr = {
					fg = colors.dark5,
				}

				highlights.TreesitterContextLineNumber = {
					fg = highlights.CursorLineNr.fg,
				}

				highlights.WinSeparator = {
					bold = true,
					fg = colors.fg_gutter,
					-- fg = "#FFFFFF",
				}

				highlights.VertSplit = {
					fg = "#FFFFFF",
				}
			end,
		},
	},

	{
		"EdenEast/nightfox.nvim",
		enabled = false,
		opts = {
			options = {
				transparent = true,
				dim_inactive = true
			}
		}
	}


	-- { "decaycs/decay.nvim", as = "decay" },
	-- { "Yazeed1s/minimal.nvim" },
	-- { "yazeed1s/oh-lucy.nvim" },
}
