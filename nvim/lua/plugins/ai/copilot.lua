return {

  -- { 'Exafunction/codeium.vim' },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    build = ":Copilot auth",
    cmd = { "Copilot" },
    opts = {
      panel = {
        enabled = false,
        auto_refresh = true,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<C-CR>",
        },
        layout = {
          position = "right", -- | top | left | right
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        -- debounce = 75,
        keymap = {
          accept = "<M-a>",
          accept_word = "<M-w>",
          accept_line = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        javascript = true,
        typescript = true,
        css = true,
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        terraform = false,
        sh = function()
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)) or "", "^%.env.*") then
            -- disable for .env files
            return false
          end
          return true
        end,
        -- ["*"] = false, -- disable for all other filetypes and ignore default `filetypes`
      },
    },
  },
}
