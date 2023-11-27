local map = vim.keymap.set

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bD", "<cmd>bufdo bwipeout<cr>", { desc = "Wipeout all buffers" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- map(
--   "n",
--   "<leader>ur",
--   "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-l><cr>",
--   { desc = "Redraw / clear hlsearch / diff update" }
-- )

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
map("v", "y", "myy`y")
map("v", "Y", "myY`y")

-- No copy
-- map("v", "p", '"_dP', { desc = "Paste replace visual selection without copying it"})
map("x", "<leader>p", [["_dP]], { desc = "Past without copy" })
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank without copy" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank without copy" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without copy" })
map({ "n", "v" }, "x", '"_x', { desc = "Delete char without copy" })
map("n", "dd", function()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return [["_dd]]
	else
		return [[dd]]
	end
end, { expr = true, desc = "Delete line without yank empty line" })

-- keeping it centered
-- map("n", "z", "zz")
map("n", "G", "Gzz")
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-b>", "<C-b>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- map("n", "cn", "*``cgn")
-- map("n", "cN", "*``cgN")
-- map("v", "cn", [[g:mc . "``cgn"]], { expr = true })
-- map("v", "cN", [[g:mc . "``cgN"]], { expr = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- windows
--map("n", "<C-W>m", "<C-W>_<C-W>|", { desc = "Maximize current window" })
map("n", "<C-W>m", "<C-W>s<C-W>T", { desc = "Open buffer in new tab (Maximize)" })

-- tabs
map("n", "[t", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
map("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })
-- map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<leader><tab>q", "<cmd>tabclose<cr>", { desc = "Close Tab" })
-- map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
-- map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- map("n", "<leader><tab>h", "<cmd>tabfirst<cr>", { desc = "First Tab" })

map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

map("n", "<leader>t", require("util").float_term, { desc = "floating terminal" })

-- gitui
map("n", "<leader>gg", function()
	require("util").float_term({ "gitui" }, { esc_esc = false, ctrl_hjkl = false })
end, { desc = "gitui" })

map("n", "<leader>gz", function()
	require("util").float_term({ "ranger" }, { esc_esc = false, ctrl_hjkl = false })
end, { desc = "ranger" })
