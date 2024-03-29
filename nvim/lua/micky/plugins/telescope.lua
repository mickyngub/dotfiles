-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

-- import telescope actions safely
local builtin_setup, builtin = pcall(require, "telescope.builtin")
if not builtin_setup then
	return
end

local keymap = vim.keymap

keymap.set("n", "<leader>ff", function()
	local opts = {}
	local ok = pcall(builtin.git_files, opts)
	if not ok then
		builtin.find_files(opts)
	end
end) -- Find a file either using git files or search the filesystem.
keymap.set("n", "<leader>FF", function()
	builtin.find_files({ no_ignore = true, hidden = true })
end)
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
keymap.set("n", "<leader>fm", "<cmd>Telescope media_files<cr>") -- find media files

-- configure telescope
telescope.setup({
	-- configure custom mappings
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous, -- move to prev result
				["<C-j>"] = actions.move_selection_next, -- move to next result
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
				["<leader><leader>"] = actions.close,
			},
			n = {
				["<leader><leader>"] = actions.close,
			},
		},
	},
	extensions = {
		media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			filetypes = { "png", "webp", "webm", "jpg", "jpeg", "pdf", "svg" },
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("media_files")
