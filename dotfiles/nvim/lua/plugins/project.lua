return {
	{
		"webflo-dev/nvim-sessions",
		config = true,
		commands = {
			"Session",
		},
		keys = {
			{ "<leader>pl", "<cmd>Session list<cr>", desc = "show sessions" },
			{ "<leader>pn", "<cmd>Session new<cr>", desc = "create new session" },
			{ "<leader>pu", "<cmd>Session update<cr>", desc = "update session" },
		},
	},

	-- {
	-- 	"aaditeynair/conduct.nvim",
	-- 	dependencies = "nvim-lua/plenary.nvim",
	-- 	cmd = {
	-- 		"ConductNewProject",
	-- 		"ConductLoadProject",
	-- 		"ConductLoadLastProject",
	-- 		"ConductLoadProjectConfig",
	-- 		"ConductReloadProjectConfig",
	-- 		"ConductDeleteProject",
	-- 		"ConductRenameProject",
	-- 		"ConductProjectNewSession",
	-- 		"ConductProjectLoadSession",
	-- 		"ConductProjectDeleteSession",
	-- 		"ConductProjectRenameSession",
	-- 	},
	-- },
}
