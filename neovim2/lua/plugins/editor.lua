

return {

	{
		"rose-pine/neovim",

		-- commit = '92762f4fa2144c05db760ea254f4c399a56a7ef5'
		config = function()

			vim.cmd([[
				function! MyHighlights() abort
				" highlight IncSearch guibg=#d8c491 guifg=#101015
				" highlight Search guibg=#587781 guifg=#101015
				highlight Search guibg=#78b0a8 guifg=#101015
				" highlight Search    guibg=#a06060 guifg=#141020
				"highlight Normal    guibg=#191724
				highlight Normal    guibg=#15141f
				highlight NormalNC    guibg=#14131b
				highlight Conditional    guifg=#a184cf
				highlight Comment    guifg=#7e7a96
				highlight NvimTreeOpenedFile guibg=none guifg=#cf90ff
				highlight @namespace guifg=#af9998
				"highlight @type.builtin.cpp guifg=#a080e2
				"highlight @function guifg=#0838ea
				"highlight @type.cpp guifg=#a0a0d2
				highlight @type.qualifier.cpp guifg=#70a0d2
				highlight @field guifg=#dab9df
				highlight StorageClass guifg=#ca7a7a
				highlight String guifg=#afceac " Strings a little too bright imo.
				highlight Visual guibg=#383d39

				" highlight @property guifg=#eeeeee
				" highlight @property guifg=#ffffff
				highlight @property guifg=none
				highlight @property guifg=#dab9df
				highlight link @module @namespace

				endfunction

				augroup MyColors
				autocmd!
				autocmd ColorScheme rose-pine-main call MyHighlights()
				augroup END
			]])

			require("rose-pine").setup()
		end,
	},

	-- Smart and powerful comment plugin for neovim. Supports commentstring, dot repeat, left-right/up-down motions, hooks, and more
	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup({
				padding = true,
				sticky = true,
				ignore = nil,
				pre_hook = nil,
				post_hook = nil,
				mappings = {
					basic = true,       ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
					extra = true,       ---Includes `gco`, `gcO`, `gcA`
					extended = false,   ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
				},

				---LHS of toggle mapping in NORMAL
				---@type table
				toggler = {
					line = 'cc',    ---line-comment keymap
					block = 'gcb',  ---block-comment keymap
				},

				---LHS of operator-pending mapping in VISUAL mode
				---@type table
				opleader = {
					line = 'gc',    ---line-comment keymap
					block = 'gb',   ---block-comment keymap
				},
			})
		end
	},

	-- Use (neo)vim terminal in the floating/popup window.
	{
		'numToStr/FTerm.nvim',
		enabled = false,
		config = function()
			require 'FTerm'.setup ({
				dimensions  = {
					height = 0.8,
					width = 0.6,
				},
			})
			-- local fterm = require('FTerm');
			vim.api.nvim_create_user_command('FTermToggle', require('FTerm').toggle, { bang = true })
			vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
			vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>') -- Just open
			vim.keymap.set({'t','n'}, '<A-r>', '<C-\\><C-n><CMD>lua require("FTerm").run(\'r\')<CR>') -- Repeat
			vim.keymap.set({'t','n'}, '<A-n>', '<C-\\><C-n><CMD>lua require("FTerm").run(\'ninja\')<CR>') -- Ninja
		end
	},

	-- Better terminal.
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		keys = {
			{'<A-i>', '<cmd>0ToggleTerm<cr>', noremap=true, silent=true, mode={'n','i','t'} },
			{'<A-v>', '<cmd>5ToggleTerm direction="vertical" size=80<cr>', noremap=true, silent=true, mode={'n','i','t'} },

			-- Exec last python command and show
			-- {'<A-p>', '<cmd>0TermExec cmd=<C-r>python<cr>', noremap=true, silent=true, mode={'n','i','t'} },

			-- Exec ninja and either show (A-r) or do not show (A-t)
			{'<A-r>', '<cmd>0TermExec cmd=<C-r>ninja<Enter>', noremap=true, silent=true, mode={'n','i','t'} },
			{'<A-t>', '<cmd>0TermExec go_back=0 open=0 cmd=<C-r>ninja<cr>', noremap=true, silent=true, mode={'n','i','t'} },
		},
		opts = {
			direction = 'float',

			-- needed when using :TermExec with open=0
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
			end,

			winbar = {
				enabled = false,
				name_formatter = function(term) --  term: Terminal
					return term.name
				end
			},
			float_opts = {
				border = 'single',
				title_pos = 'right',
				width = function()
					return math.ceil(vim.o.columns * 0.75)
				end,
				height = function()
					return math.ceil(vim.o.lines * 0.8)
				end,

				col = function()
					return math.ceil(vim.o.columns * 0.2)
				end,
				row = function()
					return math.ceil(vim.o.lines * 0.1)
				end,
			},
			highlights = {
				FloatBorder = {
					guifg = "#333333",
					-- guibg = "#333",
				},
			},
		}
	},


		{
			'norcalli/nvim-colorizer.lua',
			config = function()
				require 'colorizer'.setup ({
					'css';
					'html';
					'javascript';
					'javascriptreact';
					'typescript';
					'typescriptreact';
					'vim';
					'dart';
					'python';
					'lua';
				},
				{
					mode = 'background';
					names = true;
					css = true;
					css_fn = true;
					rgb_fn = true;
				})
			end
		},

		{
			'Yggdroot/indentLine',
			config = function()
				vim.g.indentLine_enabled = 1
				vim.g.indentLine_char = '▏'
				--vim.g.indentLine_char_list = ['|', '¦', '┆', '┊']
				vim.g.indentLine_color_gui = '#1a2030'
				vim.g.indentLine_setConceal = 0
			end
		},

		{ -- lua `fork` of vim-web-devicons for neovim
				'kyazdani42/nvim-web-devicons',
				config = function()
					require'nvim-web-devicons'.get_icons()
				end
		},

	{
		"folke/todo-comments.nvim",
		event = 'BufEnter',
		dependencies = "nvim-lua/plenary.nvim",
		lazy = true,
		config = function()
			require("todo-comments").setup {
			}
		end
	},

	{
		'stevearc/aerial.nvim',
		enabled = true,
		-- lazy = true,
		keys = {
			{'<leader>a', '<cmd>lua require("aerial").toggle()<cr>', desc="ToggleAerial"},
		},
		opts = {
			backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
		},
		-- config = function() require('aerial').setup {
			-- vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
		-- }
		-- end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		},
	},

	--  Add/change/delete surrounding delimiter pairs with ease.
	{
		'kylechui/nvim-surround',
		lazy = true,
		-- event = 'InsertEnter',
		-- keys = {'c'},
		-- config = [[ require('plugins/nvim-surround') ]]
		config = function() require('nvim-surround').setup {
		} end
	},

	{
		'junegunn/vim-easy-align',
		lazy = true,
		keys = {
			{'ga', '<Plug>(EasyAlign)', noremap=true},
		},
		config = function()
		end
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		-- stylua: ignore
		keys = {
			-- { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			-- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		},
	},

	{
		"windwp/nvim-ts-autotag",
		lazy = true,
		ft = {"html", "jsx"},
		opts = {},
	},



}
