local show_dotfiles = true
local function toggle_hidden_files()
  show_dotfiles = not show_dotfiles
  require("mini.files").refresh({
    content = {
      filter = function(fs_entry)
        if show_dotfiles then
          return true
        end
        return not vim.startswith(fs_entry.name, ".")
      end
    }
  })
end

local function map_for_open_split(buf_id, lhs, direction)
  local MiniFiles = require("mini.files")

  local rhs = function()
    -- Make new window and set it as target
    local new_target_window
    vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
      vim.cmd(direction .. " split")
      new_target_window = vim.api.nvim_get_current_win()
    end)

    MiniFiles.set_target_window(new_target_window)
  end

  -- Adding `desc` will result into `show_help` entries
  local desc = "Split " .. direction
  vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

return {
  {
    "echasnovski/mini.files",
    opts = {
      options = {
        use_as_default_explorer = false,
      },
      windows = {
        preview = true,
        width_focus = 100,
        width_nofocus = 50,
        width_preview = 100,
      },
    },
    keys = {
      {
        "<leader>z",
        function()
          local exclude_ft = { "neo-tree" }
          if vim.tbl_contains(exclude_ft, vim.bo.filetype) then
            return
          end
          local MiniFiles = require("mini.files")
          if not MiniFiles.close() then
            MiniFiles.open(vim.api.nvim_buf_get_name(0), true)
          end
        end,
        desc = "Open mini.files (directory of current file)",
      },
      {
        "<leader>Z",
        function()
          local exclude_ft = { "neo-tree" }
          if vim.tbl_contains(exclude_ft, vim.bo.filetype) then
            return
          end
          local MiniFiles = require("mini.files")
          if not MiniFiles.close() then
            MiniFiles.open(vim.loop.cwd(), true)
          end
        end,
        desc = "Open mini.files (cwd)",
      },
    },
    config = function(_, opts)
      local MiniFiles = require("mini.files")

      MiniFiles.setup(opts)

      -- Toggle hidden files
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id

          -- Toggle hidden files
          vim.keymap.set("n", "g.", toggle_hidden_files, { buffer = buf_id })

          -- Open split
          map_for_open_split(buf_id, "gs", "belowright horizontal")
          map_for_open_split(buf_id, "gv", "belowright vertical")
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          require("plugins.lsp.util").rename_files_or_folder(event.data.from, event.data.to)
        end,
      })
    end,
  },
}
