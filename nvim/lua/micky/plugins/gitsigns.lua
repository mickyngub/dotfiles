-- import gitsigns plugin safely
local setup, gitsigns = pcall(require, "gitsigns")
if not setup then
	return
end

local keymap = vim.keymap

keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>")

-- configure/enable gitsigns
gitsigns.setup({
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 100,
		ignore_whitespace = false,
	},
})
