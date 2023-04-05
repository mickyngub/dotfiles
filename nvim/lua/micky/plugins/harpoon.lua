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
keymap.set("n", "<leader>h1", function()
	ui.nav_file(1)
end)
keymap.set("n", "<leader>h2", function()
	ui.nav_file(2)
end)
