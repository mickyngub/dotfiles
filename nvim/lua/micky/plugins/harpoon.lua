local harpoon_mark_status, mark = pcall(require, "harpoon.mark")
if not harpoon_mark_status then
	return
end

local harpoon_ui_status, ui = pcall(require, "harpoon.ui")
if not harpoon_ui_status then
	return
end

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>a", mark.add_file)
keymap.set("n", "<leader>he", ui.toggle_quick_menu)
keymap.set({ "n", "i", "v" }, "<leader><leader>", function()
	local closed_windows = {}
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then -- is_floating_window?
			vim.api.nvim_win_close(win, false) -- do not force
			table.insert(closed_windows, win)
		end
	end
end)
keymap.set("n", "<leader>h1", function()
	ui.nav_file(1)
end)
keymap.set("n", "<leader>h2", function()
	ui.nav_file(2)
end)
