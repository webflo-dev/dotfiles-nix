local function autocmd_group(name, clear)
  return vim.api.nvim_create_augroup("__" .. name, { clear = (clear == nil or clear) })
end

vim.api.nvim_create_autocmd("TextYankPost", {
  group = autocmd_group("highlight_on_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Hihglight on yank",
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = autocmd_group("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
  desc = "Resize splits if window got resized",
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = autocmd_group("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Go to last loc when opening a buffer",
})

local close_with_q_group = autocmd_group("close_with_q", false)
local close_with_q = function(event)
  vim.bo[event.buf].buflisted = false
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, noremap = true })
end

vim.api.nvim_create_autocmd("FileType", {
  group = close_with_q_group,
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "copilot.*",
    "gitsigns",
    "help",
    "lspinfo",
    "man",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "octo",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = close_with_q,
  desc = "Close some filetypes with <q>",
})
-- vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
-- 	group = close_with_q_group,
-- 	pattern = { "*" },
-- 	callback = function(event)
-- 		if vim.bo.buftype == "nofile" or (vim.bo.buftype == "" and vim.bo.filetype == "") then
-- 			close_with_q(event)
-- 		end
-- 	end,
-- })

vim.api.nvim_create_autocmd("TermOpen", {
  group = autocmd_group("term_setlocal"),
  -- pattern = "term://*",
  callback = function()
    -- vim.opt_local.number = false
    -- vim.opt_local.relativenumber = false
    -- vim.opt_local.list = false
    -- vim.opt_local.signcolumn = "no"
    -- vim.opt_local.foldcolumn = 0
    -- vim.opt_local.statscolumn = ""
    -- vim.opt_local.cursorline = false
    -- vim.opt_local.scrolloff = 0
    -- vim.cmd.startinsert()
    vim.cmd([[
		    setlocal nonu
		    setlocal nornu
		    setlocal nolist
		    setlocal signcolumn=no
		    setlocal foldcolumn=0
		    setlocal statuscolumn=
		    setlocal nocursorline
		    setlocal scrolloff=0
		    startinsert
		  ]])
  end,
  desc = "Set options for terminal buffers",
})

vim.api.nvim_create_autocmd("FileType", {
  group = autocmd_group("json_no_conceal"),
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.conceallevel = 0
  end,
  desc = "Disable conceal for json files",
})

vim.api.nvim_create_autocmd("FileType", {
  group = autocmd_group("window_border"),
  pattern = { "lspinfo" },
  callback = function()
    vim.api.nvim_win_set_config(0, { border = "rounded" })
  end,
  desc = "Set borders to few floating windows",
})

local cursor_line_group = autocmd_group("LocalCursorLine")
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
  group = cursor_line_group,
  pattern = { "*" },
  callback = function()
    vim.opt_local.cursorline = true
  end,
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
  group = cursor_line_group,
  pattern = { "*" },
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
