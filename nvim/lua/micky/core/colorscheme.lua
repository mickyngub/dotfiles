local status, _ = pcall(vim.cmd, "colorscheme onedark")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
if not status then
	print("Colorscheme not found!")
	return
end
vim.cmd([[highlight DiffAdd gui=none guifg=none guibg=#103235]])
vim.cmd([[highlight DiffChange gui=none guifg=none guibg=#272D43]])
vim.cmd([[highlight DiffText gui=none guifg=none guibg=#394b70]])
vim.cmd([[highlight DiffDelete gui=none guifg=none guibg=#3F2D3D]])
