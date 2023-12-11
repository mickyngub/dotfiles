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
vim.g.vimwiki_map_prefix = "<leader>v"

local OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

require("lazy").setup({
	-- lua functions that many plugins use
	{
		"nvim-lua/plenary.nvim",
		dependencies = {
			{ "sindrets/diffview.nvim" },
			{
				"folke/todo-comments.nvim",
			},
		},
	},
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
	"ray-x/lsp_signature.nvim",
	{
		"nvimdev/lspsaga.nvim",
		branch = "main",
		commit = "76696bed4397c3b58563c246dc1f7856ed4af023",
		event = "LspAttach",
		config = function()
			require("lspsaga").setup({
				-- keybinds for navigation in lspsaga window
				scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
				-- use enter to open file with definition preview
				definition = {
					edit = "<CR>",
				},
				finder = {
					keys = {
						expand_or_jump = "<CR>",
					},
				},
				symbol_in_winbar = {
					enable = false,
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
	"nvimtools/none-ls.nvim", -- configure formatters & linters
	-- bridges gap b/w mason & null-ls
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
	},
	-- treesitter configuration
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		dependencies = { "windwp/nvim-ts-autotag", "JoosepAlviste/nvim-ts-context-commentstring" },
	},

	"nvim-treesitter/playground",
	-- git integration
	"windwp/nvim-autopairs", -- autoclose parens, brackets, quotes, etc...
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
			require("scrollbar.handlers.gitsigns").setup()
		end,
	}, -- show line modifications on left hand side
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
			require("fidget").setup({
				progress = {
					ignore_done_already = true,
					ignore_empty_message = false,
					ignore = {
						"null-ls",
					},
					display = {
						render_limit = 4,
					},
				},
				notification = {
					override_vim_notify = true,
				},
			})
		end,
		dependencies = { "neovim/nvim-lspconfig" },
	},
	{
		"phaazon/hop.nvim",
		tag = "v2.0.3",
		config = function()
			require("hop").setup()
			vim.keymap.set({ "n", "x" }, "s", ":HopChar1MW<CR>", { noremap = true })
		end,
	},
	"ThePrimeagen/git-worktree.nvim",
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			require("chatgpt").setup({})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	"vimwiki/vimwiki",
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				tailwind = "lsp",
				mode = "virtualtext",
				css = true,
			},
		},
	},
	{
		"chentoast/marks.nvim",
		config = function()
			require("marks").setup({})
		end,
	},
	{
		"nvim-pack/nvim-spectre",
		opts = {
			mapping = {
				["send_to_qf"] = {
					map = "<leader>QF",
					cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
					desc = "send all item to quickfix",
				},
			},
		},
	},
	"gelguy/wilder.nvim",
	{
		"junegunn/fzf.vim",
		dependencies = {
			"junegunn/fzf",
		},
	},
	{
		"stevearc/oil.nvim",
		opts = {
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
			},
			-- Optional dependencies
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("oil").setup()
			end,
		},
	},
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			-- require('hlslens').setup() is not required
			require("scrollbar.handlers.search").setup({
				-- hlslens config overrides
			})
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup({})
		end,
	},
	{
		"piersolenski/wtf.nvim",
		config = function()
			if not OPENAI_API_KEY then
				print("Please provide an OpenAI API key for wtf plugin.")
				return
			end
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			openai_api_key = OPENAI_API_KEY,
		},
		keys = {
			{
				"<leader>wtf",
				mode = { "n", "x" },
				function()
					require("wtf").ai()
				end,
				desc = "Debug diagnostic with AI",
			},
			{
				mode = { "n" },
				"<leader>WTF",
				function()
					require("wtf").search()
				end,
				desc = "Search diagnostic with Google",
			},
		},
	},
	{
		"nvim-focus/focus.nvim",
		version = "*",
		config = function()
			require("focus").setup({
				ui = {
					signcolumn = false, -- Display signcolumn in the focussed window only
				},
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			-- duplicated in options.lua
			vim.opt.termguicolors = true
			require("notify").setup({
				background_colour = "#000000",
			})
		end,
	},
	{
		"dmmulroy/tsc.nvim",
		config = function()
			require("tsc").setup()
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	},
	{
		"rbong/vim-flog",
		lazy = true,
		cmd = { "Flog", "Flogsplit", "Floggit" },
		dependencies = {
			"tpope/vim-fugitive",
		},
	},
})
