local icons = require("icons")


return {
  {
    'ibhagwan/fzf-lua',
    cmd = 'FzfLua',
    -- keys = {
    --   { '<leader>f<', '<cmd>FzfLua resume<cr>',                    desc = 'Resume last command' },
    --   {
    --     '<leader>fb',
    --     function()
    --       require('fzf-lua').grep_curbuf {
    --         winopts = {
    --           height = 0.6,
    --           width = 0.5,
    --           preview = { vertical = 'up:70%' },
    --         },
    --       }
    --     end,
    --     desc = 'Grep current buffer',
    --   },
    --   { '<leader>fc', '<cmd>FzfLua highlights<cr>',                desc = 'Highlights' },
    --   { '<leader>fd', '<cmd>FzfLua lsp_document_diagnostics<cr>',  desc = 'Document diagnostics' },
    --   { '<leader>fD', '<cmd>FzfLua lsp_workspace_diagnostics<cr>', desc = 'Workspace diagnostics' },
    --   { '<leader>ff', FilesPicker.pick,                            desc = 'Find files' },
    --   { '<leader>fg', '<cmd>FzfLua live_grep_glob<cr>',            desc = 'Grep' },
    --   { '<leader>fh', '<cmd>FzfLua help_tags<cr>',                 desc = 'Help' },
    --   { '<leader>fr', '<cmd>FzfLua oldfiles<cr>',                  desc = 'Recently opened files' },
    -- },
    keys = {

      { "<leader>/",  "<cmd>FzfLua live_grep_glob resume=true<cr>", desc = "Find in files (grep)" },
      { "<leader>,",  "<cmd>FzfLua buffers<cr>",                    desc = "Show buffers" },
      { "<leader>:",  "<cmd>FzfLua command_history<cr>",            desc = "Command history" },
      { "<leader>f",  "<cmd>FzfLua resume<cr>",                     desc = "FzfLua resume" },
      { "<leader>ff", "<cmd>FzfLua files<cr>",                      desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep_glob resume=true<cr>", desc = "Grep" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>",                   desc = "Recently opened files" },
      { "<leader>fw", "<cmd>FzfLua grep_cword<cr>",                 desc = "Search word under cursor" },
      { "<leader>gc", "<cmd>FzfLua git_commits<cr>",                desc = "Git commits" },
      { "<leader>gb", "<cmd>FzfLua git_branches<cr>",               desc = "Git branches" },
      { "<leader>gs", "<cmd>FzfLua git_status<cr>",                 desc = "Git status" },
      { "<leader>gS", "<cmd>FzfLua git_stash<cr>",                  desc = "Git stash" },
      { "<leader>gC", "<cmd>FzfLua git_bcommits<cr>",               desc = "Git branch commits" },
    },
    opts = function()
      local actions = require("fzf-lua.actions")
      local utils = require("fzf-lua.utils")


      local function hl_validate(hl)
        return not utils.is_hl_cleared(hl) and hl or nil
      end

      return {
        fzf_opts = {
          -- ['--info'] = 'default',
          -- ['--layout'] = 'reverse-list',
        },
        winopts = {
          height = 0.7,
          width = 0.8,
          preview = {
            hidden = "nohidden",
            scrollbar = false,
          },
          hl = {
            normal = hl_validate("TelescopeNormal"),
            border = hl_validate("TelescopeBorder"),
            help_normal = hl_validate("TelescopeNormal"),
            help_border = hl_validate("TelescopeBorder"),
            -- builtin preview only
            cursor = hl_validate("Cursor"),
            cursorline = hl_validate("TelescopePreviewLine"),
            cursorlinenr = hl_validate("TelescopePreviewLine"),
            search = hl_validate("IncSearch"),
            title = hl_validate("TelescopeTitle"),
          }
        },
        -- Make stuff better combine with the editor.
        fzf_colors = {
          ["fg"] = { "fg", "TelescopeNormal" },
          ["bg"] = { "bg", "TelescopeNormal" },
          ["hl"] = { "fg", "TelescopeMatching" },
          ["fg+"] = { "fg", "TelescopeSelection" },
          ["bg+"] = { "bg", "TelescopeSelection" },
          ["hl+"] = { "fg", "TelescopeMatching" },
          ["info"] = { "fg", "TelescopeMultiSelection" },
          ["border"] = { "fg", "TelescopeBorder" },
          ["gutter"] = { "bg", "TelescopeNormal" },
          ["prompt"] = { "fg", "TelescopePromptPrefix" },
          ["pointer"] = { "fg", "TelescopeSelectionCaret" },
          ["marker"] = { "fg", "TelescopeSelectionCaret" },
          ["header"] = { "fg", "TelescopeTitle" },
        },

        -- keymap = {
        --   builtin = {
        --     ['<C-/>'] = 'toggle-help',
        --     ['<C-a>'] = 'toggle-fullscreen',
        --     ['<C-i>'] = 'toggle-preview',
        --     ['<C-f>'] = 'preview-page-down',
        --     ['<C-b>'] = 'preview-page-up',
        --   },
        --   fzf = {
        --     ['alt-s'] = 'toggle',
        --     ['alt-a'] = 'toggle-all',
        --   },
        -- },
        files = {
          prompt = "Files " .. icons.common.prompt,
        },
        buffers = {
          keymap = {
            builtin = {
              ["<C-d>"] = false
            }
          },
          actions = {
            ["ctrl-x"] = false,
            ["ctrl-d"] = { actions.buf_del, actions.resume },
            -- ["ctrl-D"] = { close_all_buffers, actions.resume }
          },
          -- fzf_opts = {
          --   ["--header"] = buffers_header()
          -- },
        },
        grep = {
          header_prefix = icons.common.search .. ' ',
        },
        lsp = {
          symbols = {
            symbol_icons = icons.kinds,
          },
        },
        colorschemes = {
          -- winopts = { height = 0.33, width = 0.33, },
          winopts = { height = 0.33, width = 0.20 },
        },
      }
    end,
    config = function(_, opts)
      require('fzf-lua').setup(opts)

      require("fzf-lua").register_ui_select()

      -- Add the .gitignore toggle description for the files picker.
      -- require('fzf-lua.config').set_action_helpstr(FilesPicker.toggle, 'no-ignore<->ignore')
    end,
  },
}
