-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

local keymap = vim.keymap
keymap.set("n", "<leader>gwt", function()
	telescope.extensions.git_worktree.git_worktrees()
end)
keymap.set("n", "<leader>agwt", function()
	telescope.extensions.git_worktree.create_git_worktree()
end)
