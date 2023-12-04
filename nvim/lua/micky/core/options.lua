local opt = vim.opt -- for conciseness
local api = vim.api -- for conciseness
local cmd = vim.cmd -- for conciseness

local notify_status, notify = pcall(require, "notify")
if not notify_status then
	return
end
vim.notify = function(message, level, opts)
	return notify(message, level, opts) -- <-- Important to return the value from `nvim-notify`
end
-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

--clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.updatetime = 50

opt.scr = 10
opt.so = 2

-- disable continuation of comment

api.nvim_create_autocmd("BufEnter", {
	callback = function()
		opt.formatoptions = opt.formatoptions - { "c", "r", "o" }
	end,
})

-- Trigger `autoread` when files change on disk
cmd("set autoread")
cmd([[autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif]])

-- Notification after file change
cmd([[autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None]])
cmd([[autocmd BufRead,BufNewFile *.env.* set filetype=sh]])

cmd([[autocmd FileType fugitive nmap <buffer> <CR> gO]])
