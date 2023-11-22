local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins"},
    --    { import = "plugins/core" },
--    { import = "plugins/tests" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  dev = {
    -- directory where you store your local plugin projects
    path = vim.fn.stdpath("config") .. "/plugins",
    fallback = false,
  },
  install = {
    missing = true,
    -- colorscheme = { "tokyonight" },
    colorscheme = { "nightfly" },
  },
  ui = {
    border = "rounded",
  },
  checker = {
    enabled = false,
    notify = false,
    frequency = 3600,
  },
  change_detection = {
    enabled = false
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        -- "matchparen",
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
})
