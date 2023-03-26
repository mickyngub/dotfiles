vim.api.nvim_set_keymap(
	"n",
	"<leader>zm",
	':ZenMode<CR> <BAR> :silent !osascript -e \'tell application "iTerm" to activate\' -e \'tell application "System Events" to keystroke "f" using {control down, command down}\'<CR>',
	{ silent = true }
)
