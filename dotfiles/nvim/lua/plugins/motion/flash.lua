local function flash_jump(continue)
  require("flash").jump({
    continue = continue or false,
  })
end

local function flash_jump_to_line()
  require("flash").jump({
    search = { mode = "search", max_length = 0 },
    label = { after = { 0, 0 } },
    pattern = "^"
  })
end

local function flash_jump_with_word_under_cursor()
  require("flash").jump({
    pattern = vim.fn.expand("<cword>"),
  })
end

local function flash_jump_treesitter(pos)
  require("flash").treesitter({
    jump = {
      pos = pos
    }
  })
end

return {
  {
    "folke/flash.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
      multi_window = false,
      incremental = true,
      modes = {
        char = {
          jump_labels = true
        }
      }
    },
    -- stylua: ignore
    keys = {
      { "<C-g>", mode = { "n", "x", "o" }, flash_jump_to_line,                            desc = "Jump to a line" },
      { "S",     mode = { "n", "x", "o" }, function() flash_jump_treesitter("start") end, desc = "Flash Treesitter" },
      {
        "<C-s>",
        mode = { "n", "x", "o" },
        function() flash_jump_treesitter("range") end,
        desc = "Flash Treesitter (highlight)"
      },
      {
        "<M-s>",
        mode = { "n", "x", "o" },
        flash_jump_with_word_under_cursor,
        desc = "Flash Jump to word under cursor"
      },
      {
        -- "<M-s>",
        "R",
        mode = { "n", "o", "x" },
        function() require("flash").treesitter_search() end,
        desc = "Treesitter Search"
      },
      -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    },
  },
}
