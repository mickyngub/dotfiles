local keymap = vim.keymap -- for conciseness

vim.keymap.set("n", "s", function()
	local current_window = vim.fn.win_getid()
	local windows_on_tabpage = vim.api.nvim_tabpage_list_wins(0)
	local focusable_windows_on_tabpage = vim.tbl_filter(function(win)
		return vim.api.nvim_win_get_config(win).focusable
	end, windows_on_tabpage)

	-- If there are multiple focusable windows, target them, else just target the current window
	if #focusable_windows_on_tabpage > 1 then
		require("leap").leap({ target_windows = focusable_windows_on_tabpage })
	else
		require("leap").leap({ target_windows = { current_window } })
	end
end)
