local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
require("lazy").setup({
	-- lua functions that many plugins use
	"nvim-lua/plenary.nvim",
	"joshdick/onedark.vim",
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation
	"szw/vim-maximizer", -- maximizes and restores current window
	-- essential plugins
	"tpope/vim-surround",
	"vim-scripts/ReplaceWithRegister",
	-- commenting with gc
	"numToStr/Comment.nvim",
	-- file explorer
	"nvim-tree/nvim-tree.lua",
	-- icons
	"nvim-tree/nvim-web-devicons",
	-- statusline
	"nvim-lualine/lualine.nvim",
	-- fuzzy finding w/ telescope
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- dependency for better sorting performance
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x" }, -- fuzzy finder
	-- autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"roobert/tailwindcss-colorizer-cmp.nvim",
				config = function()
					require("tailwindcss-colorizer-cmp").setup({
						color_square_width = 1.5,
					})
				end,
			},
		},
	}, -- completion plugin
	"hrsh7th/cmp-buffer", -- source for text in buffer
	"hrsh7th/cmp-path", -- source for file system paths
	-- snippets
	"L3MON4D3/LuaSnip", -- snippet engine
	"saadparwaiz1/cmp_luasnip", -- for autocompletion
	"rafamadriz/friendly-snippets", -- useful snippets
	-- managing & installing lsp servers, linters & formatters
	"williamboman/mason.nvim", -- in charge of managing lsp servers, linters & formatters
	"williamboman/mason-lspconfig.nvim", -- bridges gap b/w mason & lspconfig
	-- configuring lsp servers
	"hrsh7th/cmp-nvim-lsp", -- for autocompletion
	"hrsh7th/cmp-nvim-lsp-signature-help", -- for hinting function signature
	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		event = "LspAttach",
		config = function()
			require("lspsaga").setup({
				-- keybinds for navigation in lspsaga window
				scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
				-- use enter to open file with definition preview
				definition = {
					edit = "<CR>",
				},
			})
		end,
		dependencies = {
			{ "neovim/nvim-lspconfig" }, -- easily configure language servers
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	-- enhanced lsp uis
	"jose-elias-alvarez/typescript.nvim", -- additional functionality for typescript server (e.g. rename file & update imports)
	"onsails/lspkind.nvim", -- vs-code like icons for autocompletion
	-- formatting & linting
	"jose-elias-alvarez/null-ls.nvim", -- configure formatters & linters
	"jayp0521/mason-null-ls.nvim", -- bridges gap b/w mason & null-ls
	-- treesitter configuration
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		dependencies = { "windwp/nvim-ts-autotag" },
	},

	"nvim-treesitter/playground",
	-- git integration
	"windwp/nvim-autopairs", -- autoclose parens, brackets, quotes, etc...
	"lewis6991/gitsigns.nvim", -- show line modifications on left hand side
	-- harpoon
	"theprimeagen/harpoon",
	-- undotree
	"mbbill/undotree",
	-- fugitive
	"tpope/vim-fugitive",
	-- multiple cursors
	{ "mg979/vim-visual-multi", branch = "master" },
	-- markdown preview
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				theme = "hyper",
				config = {
					header = {
						"",
						"",
						" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
						" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
						" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
						" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
						" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
						" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
						"",
						"",
					},
					shortcut = {
						{
							icon = " ",
							icon_hl = "@variable",
							desc = "Files",
							group = "Label",
							action = "Telescope find_files",
							key = "f",
						},
					},
				},
			})
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	"dstein64/vim-startuptime",
	-- github copilot
	"github/copilot.vim",
	-- zen mode
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				plugins = {
					tmux = {
						enabled = true,
					},
				},
			})
		end,
	},
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end,
	},
	{
		"phaazon/hop.nvim",
		tag = "v2.0.3",
		config = function()
			require("hop").setup()
			vim.keymap.set("n", "s", "<CMD>HopChar1<CR>", { noremap = true })
			vim.keymap.set("x", "s", "<CMD>HopChar1<CR>", { noremap = true })

			vim.keymap.set("n", "<leader>l", "<CMD>HopLine<CR>", { noremap = true })
			vim.keymap.set("x", "<leader>l", "<CMD>HopLine<CR>", { noremap = true })
		end,
	},
})
