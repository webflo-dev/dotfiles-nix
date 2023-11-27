local icons = require("icons")

return {
  {
    "rcarriga/nvim-notify",
    lazy = false,
    priority = 10000,
    opts = {
      background_colour = "#00000000",
      fps = 144,
      timeout = 1500,
      render = "wrapped-compact", -- default, minimal, simple, compact, wrapped-compact
      icons = {
        DEBUG = icons.common.debug,
        ERROR = icons.diagnostics.Error,
        INFO = icons.diagnostics.Info,
        TRACE = icons.diagnostics.Hint,
        WARN = icons.diagnostics.Warn,
      },
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    init = function()
      vim.opt.termguicolors = true
      vim.notify = require("notify")
      -- vim.api.nvim_create_autocmd("User", {
      --   pattern = "VeryLazy",
      --   callback = function()
      --     vim.opt.termguicolors = true
      --     vim.notify = require("notify")
      --   end,
      -- })
    end,
  },

}
