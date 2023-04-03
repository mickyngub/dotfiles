local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

nvimtree.setup({
	--	change folder arrow icons
	renderer = {
		icons = {
			glyphs = {
				git = {
					unstaged = "u",
					ignored = "󰽅",
				},
			},
		},
	},
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
	update_focused_file = {
		enable = true,
		update_root = true,
	},
	diagnostics = {
		enable = true,
	},
})
