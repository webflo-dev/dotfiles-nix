return {
  {
    "echasnovski/mini.operators",
    version = false,
    config = function(_, opts)
      require("mini.operators").setup(opts)
    end,
  },

  {
    "echasnovski/mini.splitjoin",
    config = function(_, opts)
      require("mini.splitjoin").setup(opts)
    end
  },
}
