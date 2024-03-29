local keymap = vim.keymap -- for conciseness

-- Don't use arrow keys
keymap.set({ "n", "v", "i" }, "<up>", "<nop>")
keymap.set({ "n", "v", "i" }, "<down>", "<nop>")
keymap.set({ "n", "v", "i" }, "<left>", "<nop>")
keymap.set({ "n", "v", "i" }, "<right>", "<nop>")
-- general keymaps
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("n", "<leader>w", ":w<CR>")
keymap.set("n", "<leader>q", ":q<CR>")

keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>")
keymap.set("n", "]]", "]]zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
keymap.set("x", "<leader>p", [["_dP]])
keymap.set({ "n", "v" }, "<leader>d", [["_d]])
-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")
-- delete single character without copying into register
keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window
keymap.set("n", "<leader>sw", "<C-w>x") -- switch window with the previous one
keymap.set("n", "<leader>s-", "5<C-w><")
keymap.set("n", "<leader>s=", "5<C-w>>")
keymap.set("n", "<leader>s_", "5<C-w>-")
keymap.set("n", "<leader>s+", "5<C-w>+")

-- buffer management
keymap.set("n", "[b", ":bprevious<CR>")
keymap.set("n", "]b", ":bnext<CR>")

keymap.set("n", "<leader>oo", ":options<CR>")

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

keymap.set({ "n", "v" }, "<leader><leader>", function()
	local closed_windows = {}
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then -- is_floating_window?
			vim.api.nvim_win_close(win, false) -- do not force
			table.insert(closed_windows, win)
		end
	end
end)
