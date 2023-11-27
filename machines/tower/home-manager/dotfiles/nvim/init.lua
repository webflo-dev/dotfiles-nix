require("util").load_modules("config", { "keymaps" })

require("lazy-nvim")

require("config.keymaps")

vim.cmd.colorscheme("tokyonight")
--vim.cmd.colorscheme("nightfox")
