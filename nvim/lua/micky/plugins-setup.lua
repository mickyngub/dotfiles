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

vim.cmd([[highlight ConflictAdd guibg=#103235]])
vim.cmd([[highlight ConflictText guibg=#394b70]])

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
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	"rebelot/kanagawa.nvim",
	"AlexvZyl/nordic.nvim",
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
		event = "LspAttach",
		config = function()
			require("lspsaga").setup({
				-- keybinds for navigation in lspsaga window
				scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
				-- use enter to open file with definition preview
				definition = {
					keys = {
						edit = "<CR>",
					},
				},
				finder = {
					keys = {
						toggle_or_open = "<CR>",
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
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mason-null-ls").setup({
				-- Each of one of these needs to be added in the configuration for none-ls.nvim
				ensure_installed = {
					-- Formatters
					"prettier",
					"stylua",
					-- Deprecated LSPs in none-ls plugin
					"eslint_d",
				},
			})
		end,
		lazy = true,
	},
	{
		"nvimtools/none-ls.nvim", -- configure formatters & linters
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
			"nvim-lua/plenary.nvim",
			"jay-babu/mason-null-ls.nvim",
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
	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("harpoon").setup()
		end,
	},
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
						[[                                                                       ]],
						[[                                                                       ]],
						[[                                                                       ]],
						[[                                                                       ]],
						[[                                                                     ]],
						[[       ████ ██████           █████      ██                     ]],
						[[      ███████████             █████                             ]],
						[[      █████████ ███████████████████ ███   ███████████   ]],
						[[     █████████  ███    █████████████ █████ ██████████████   ]],
						[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
						[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
						[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
						[[                                                                       ]],
						[[                                                                       ]],
						[[                                                                       ]],
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
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
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
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				tailwind = "lsp",
				mode = "virtualtext",
				css = true,
			},
		},
		config = function()
			require("colorizer").setup()
		end,
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
			replace_engine = {
				["sed"] = {
					cmd = "sed",
					args = {
						"-i",
						"",
						"-E",
					},
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
		branch = "master",
		config = function()
			require("focus").setup({
				autoresize = {
					minwidth = 28,
				},
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
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = function()
			require("git-conflict").setup({
				highlights = { -- They must have background color, otherwise the default color will be used
					incoming = "ConflictAdd",
					current = "ConflictText",
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-media-files.nvim",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"RRethy/nvim-treesitter-textsubjects",
		config = function()
			require("nvim-treesitter.configs").setup({
				textsubjects = {
					enable = true,
					prev_selection = ",", -- (Optional) keymap to select the previous selection
					keymaps = {
						["."] = "textsubjects-smart",
						[";"] = "textsubjects-container-outer",
						["i;"] = {
							"textsubjects-container-inner",
							desc = "Select inside containers (classes, functions, etc.)",
						},
					},
				},
			})
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		opts = {
			-- add any opts here
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-3-5-sonnet-20241022",
				temperature = 0,
				max_tokens = 4096,
			},
		},
		build = ":AvanteBuild", -- This is optional, recommended tho. Also note that this will block the startup for a bit since we are compiling bindings in Rust.
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to setup it properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
})
