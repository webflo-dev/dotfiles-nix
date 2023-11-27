local wezterm = require("wezterm")

wezterm.on("gui-startup", function()
	local frontend_tab, frontend_pane, window = wezterm.mux.spawn_window({
		workspace = "work",
		cwd = wezterm.home_dir .. "/dev/castor/frontend",
	})
	frontend_tab:set_title("frontend")
	frontend_pane:send_text("nps\n")

	local backend_tab, backend_pane = window:spawn_tab({
		cwd = wezterm.home_dir .. "/dev/castor/backend",
	})
	backend_tab:set_title("backend")
	backend_pane:send_text('ENABLE_TYPEORM_MIGRATION=false nps "start.app"\n')

	wezterm.mux.spawn_window({})

	-- wezterm.mux.set_active_workspace("work")
end)

wezterm.on("mux-startup", function()
	local tab, pane, window = wezterm.mux.spawn_window({})
	pane:split({ direction = "Top" })
end)

local config = {
	font = require("wezterm").font("monospace"),
	font_size = 10.0,

	color_schemes = {
		["webflo"] = require("webflo"),
	},
	color_scheme = "webflo",

	default_cursor_style = "BlinkingUnderline",

	window_close_confirmation = "NeverPrompt",
	hide_tab_bar_if_only_one_tab = true,

	window_padding = {
		top = "1cell",
		right = "3cell",
		bottom = "1cell",
		left = "3cell",
	},

	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.8,
	},

	-- window_background_opacity = 1.0,
	-- text_background_opacity = 1.0,

	keys = require("keys"),
}

return config
