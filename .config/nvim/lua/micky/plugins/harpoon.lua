local harpoon = require("harpoon")
local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>a", function()
	harpoon:list():append()
end)
keymap.set("n", "<leader>ha", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
