vim.g.mapleader = ';'
vim.g.maplocalleader = '|'

--require('plugins/impatient_nvim')

local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	--print('Installing packer...')
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
	vim.cmd [[packadd packer.nvim]]
end

local keymap = vim.api.nvim_set_keymap


function toggle_lsp()
	if table.getn(vim.lsp.get_active_clients()) == 0 then
		vim.cmd('LspStart');
		print('Turning LSP On')
	else
		vim.cmd('LspStop');
		print('Turning LSP Off')
	end
end

-- todo FIX THIS
function lsp_on_attach(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	--─────────────────────────────────────────────────--
	buf_set_keymap('n', '<space>e',   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',  opts)
	buf_set_keymap('n', '[d',         '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',              opts)
	buf_set_keymap('n', ']d',         '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',              opts)
	buf_set_keymap('n', '<space>q',   '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',            opts)

	buf_set_keymap('n', 'gD',         '<Cmd>lua vim.lsp.buf.declaration()<CR>',                   opts)
	buf_set_keymap('n', 'gd',         '<Cmd>lua vim.lsp.buf.definition()<CR>',                    opts)
	buf_set_keymap('n', 'K',          '<Cmd>lua vim.lsp.buf.hover()<CR>',                         opts)
	buf_set_keymap('n', 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>',                opts)
	buf_set_keymap('n', '[ls',        '<cmd>lua vim.lsp.buf.signature_help()<CR>',                opts)
	buf_set_keymap('n', '<space>D',   '<cmd>lua vim.lsp.buf.type_definition()<CR>',               opts)
	buf_set_keymap('n', '<space>rn',  '<cmd>lua vim.lsp.buf.rename()<CR>',                        opts)
	buf_set_keymap('n', 'gr',         '<cmd>lua vim.lsp.buf.references()<CR>',                    opts)
	buf_set_keymap("n", "<space>f",   '<cmd>lua vim.lsp.buf.formatting()<CR>',                    opts)
	-- code action is integrated with telescope, for more see "telescope.lua" file
	-- buf_set_keymap('n', '<space>ca',    '<cmd>lua vim.lsp.buf.code_action()<CR>',                   opts)
	-- buf_set_keymap('n', '<leader>wa',    '<cmd>lua vim.lsp.buf.add_workleader_folder()<CR>',          opts)
	-- buf_set_keymap('n', '<leader>wr',    '<cmd>lua vim.lsp.buf.remove_workleader_folder()<CR>',       opts)
	-- buf_set_keymap('n', '<leader>wl',   '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workleader_folders()))<CR>', opts)
end

function setup_maps()
	local keymap = vim.api.nvim_set_keymap
	local cmd = vim.cmd

	keymap('', '<C-h>', '<C-w>h', {noremap=true})
	keymap('', '<C-k>', '<C-w>k', {noremap=true})
	keymap('', '<C-j>', '<C-w>j', {noremap=true})
	keymap('', '<C-l>', '<C-w>l', {noremap=true})
	keymap('n', '<leader>w', [[:%s/\s\+$//e<CR>]], {noremap=true})

	-- Delete markers from asm
	cmd('command CleanAsm %s/^\\W*\\..*// | :g/^$/d')

	-- Allow 'jk' to exit insert mode
	keymap('i', 'jk', '<ESC>', {noremap=false})

	-- Allow C-c to exit a quickfix window.
	cmd([[ autocmd BufWinEnter quickfix map <buffer> <C-c> :q<CR> ]])

	-- Toggle LSP
	keymap('n', '<space>l', [[<Cmd>lua toggle_lsp()<CR>]], {silent=true})

	-- to quit vim
	cmd([[ autocmd BufEnter * nmap silent <buffer> <Leader>q :bd<CR> ]])
	cmd([[  cnorea wd w\|:bd ]])

	-- to save file
	keymap('i', '<C-s>',    '<ESC>:w <CR>', { noremap=true, silent=true })
	keymap('n', '<C-s>',    '<ESC>:w <CR>', { noremap=true, silent=true })

	-- scroll window up/down
	keymap('i', '<C-e>', '<ESC><C-e>', { silent=true })
	keymap('i', '<C-y>', '<ESC><C-y>', { silent=true })
	keymap('n', '<C-h>', 'zh', { silent=true })     -- left
	keymap('n', '<C-l>', 'zl', { silent=true })     -- right

	-- clear Search Results
	keymap('n', '//', ':noh <CR>', { silent=true })

	-- Resize splits more quickly
	-- resize up and down
	keymap('n', ';k',   ':resize +3 <CR>',          { noremap=true, silent=true })
	keymap('n', ';j',   ':resize -3 <CR>',          { noremap=true, silent=true })
	-- resize right and left
	keymap('n', ';l',   ':vertical resize +3 <CR>', { noremap=true, silent=true })
	keymap('n', ';h',   ':vertical resize -3 <CR>', { noremap=true, silent=true })

	-- Visual indent
	keymap('v', '<',   '<gv', { noremap=true, silent=true })
	keymap('v', '>',   '>gv', { noremap=true, silent=true })

	-- going back to normal mode which works even in vim's terminal
	-- you will need this if you use floaterm to escape terminal
	cmd([[ tmap <Esc> <c-\><c-n> ]])

	-- move selected line(s) up or down
	keymap('v', 'J', ":m '>+1<CR>gv=gv", {noremap=true, silent=true})
	keymap('v', 'K', ":m '<-2<CR>gv=gv", {noremap=true, silent=true})

end

function setup_colors()

	local cmd = vim.cmd
	--cmd('colorscheme rvcs')
	cmd("colorscheme everblush | hi Normal guibg=#010102 | hi Whitespace guibg=#010104 | hi Comment guifg=#606080 | hi! link TSComment Comment | hi CursorLine guibg=#101016 | hi SignColumn guibg=none | hi NvimTreeFolderName guifg=#63639a | hi VertSplit guibg=#151522 | hi Search guifg=black guibg=#AFbe20 | hi Pmenu guifg=gray guibg=#101010 | hi PmenuSel guifg=vanilla guibg=#101030 | hi TSNumber guifg=lightyellow | hi bashTSParameter guifg=#f0d0f0 | hi! link cppTSField cppTSVariable")

end

function setup_config()
	local exec  = vim.api.nvim_exec -- execute Vimscript
	local set   = vim.opt           -- global options
	local cmd   = vim.cmd           -- execute Vim commands
	-- local fn    = vim.fn            -- call Vim functions
	-- local g     = vim.g             -- global variables
	-- local b     = vim.bo            -- buffer-scoped options
	-- local w     = vim.wo            -- windows-scoped options

	set.guifont		      = 'DroidSansMono Nerd Font 11'
	set.termguicolors   = true      -- Enable GUI colors for the terminal to get truecolor
	set.list            = true      -- show whitespace
	set.listchars = {
		nbsp       = '⦸',      -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
		extends    = '»',      -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
		precedes   = '«',      -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
		tab        = '  ',     --  '▷─' WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
		trail      = '•',      -- BULLET (U+2022, UTF-8: E2 80 A2)
		space      = ' ',
	}
	set.fillchars = {
		diff        = '∙',      -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
		eob         = ' ',      -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
		fold        = '·',      -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
		vert        = ' ',      -- remove ugly vertical lines on window division
	}



	if root then
		set.shada         = ''            -- Don't create root-owned files.
		set.shadafile     = 'NONE'
	else
		local backup_dir  = vim.fn.expand('~/.cache/nvim')
		set.swapfile        = false
		--set.backup        = true                      -- make backups before writing
		set.backup        = false                      -- make backups before writing
		set.undofile      = false                     --persistent undos - undo after you re-open the file
		set.writebackup   = true                      --Make backup before overwriting the current buffer
		set.backupcopy    = 'yes'                     --Overwrite the original backup file
		set.directory     = backup_dir .. '/swap'     -- directory to place swap files in
		set.backupdir     = backup_dir .. '/backedUP' -- where to put backup files
		set.undodir       = backup_dir .. '/undos'    -- where to put undo files
		set.viewdir       = backup_dir .. '/view'     -- where to store files for :mkview
		-- Defaults:
		--   Neovim: !,'100,<50,s10,h
		--
		-- - ! save/restore global variables (only all-uppercase variables)
		-- - '100 save/restore marks from last 100 files
		-- - <50 save/restore 50 lines from each register
		-- - s10 max item size 10KB
		-- - h do not save/restore 'hlsearch' setting
		--
		-- Our overrides:
		-- - '0 store marks for 0 files
		-- - <0 don't save registers
		-- - f0 don't store file marks
		-- - n: store in ~/.cache/nvim/shada
		set.shada = "'100,<50,f50,n~/.cache/nvim/shada/shada"
	end

	set.mouse  = 'a'

	set.clipboard       = set.clipboard + "unnamedplus" --copy & paste
	set.wrap            = true         -- don't automatically wrap on load
	set.showmatch       = true 	        -- show the matching part of the pair for [] {} and ()

	set.cursorline      = true 	        -- highlight current line
	set.number          = true          -- show line numbers
	--set.relativenumber  = true	        -- show relative line number
	set.relativenumber  = false	        -- show relative line number

	set.incsearch       = true 	        -- incremental search
	set.hlsearch        = true 	        -- highlighted search results
	set.ignorecase      = true 	        -- ignore case sensetive while searching
	set.smartcase       = true

	set.scrolloff       = 5             -- when scrolling, keep cursor 1 lines away from screen border
	set.sidescrolloff   = 5             -- keep 30 columns visible left and right of the cursor at all times
	set.backspace       = 'indent,start,eol' -- make backspace behave like normal again
	--set.mouse = "a"  		-- turn on mouse interaction
	set.updatetime      = 500           -- CursorHold interval
	set.timeoutlen      = 900
	--set.ttimeoutlen     = 450
	set.ttimeoutlen     =  50

	--set.softtabstop     = 4
	--set.shiftwidth      = 4             -- spaces per tab (when shifting), when using the >> or << commands, shift lines by 4 spaces
	--set.tabstop         = 4             -- spaces per tab
	set.softtabstop     = 4
	set.shiftwidth      = 4             -- spaces per tab (when shifting), when using the >> or << commands, shift lines by 4 spaces
	set.tabstop         = 4             -- spaces per tab
	set.smarttab        = true          -- <tab>/<BS> indent/dedent in leading whitespace
	set.autoindent      = true          -- maintain indent of current line
	set.expandtab       = false         -- don't expand tabs into spaces
	set.shiftround      = true

	set.splitbelow      = true      -- open horizontal splits below current window
	set.splitright      = true      -- open vertical splits to the right of the current window
	set.laststatus      = 2         -- always show status line
	--set.colorcolumn = "79"        -- vertical word limit line

	set.hidden          = true      -- allows you to hide buffers with unsaved changes without being prompted
	set.inccommand      = 'split'   -- live preview of :s results
	set.shell           = 'zsh'     -- shell to use for `!`, `:!`, `system()` etc.
	set.lazyredraw      = true      -- faster scrolling

	set.wildignore      = set.wildignore + '*.o,*.rej,*.so' -- patterns to ignore during file-navigation
	set.completeopt     = 'menuone,noselect,noinsert'       -- completion options


	------------------------------------------------
	--    Automation
	------------------------------------------------

	-- highlight on yank
	exec([[
	augroup YankHighlight
	autocmd!
	autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500, on_visual=true}
	augroup end
	]], false)

	-- jump to the last position when reopening a file
	cmd([[
	if has("autocmd")
		au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
		endif
		]])

		-- Don't recenter buffer offset when switching buffers
		cmd([[
		"au BufLeave * if !&diff | let b:winview = winsaveview() | endif
		"au BufEnter * if exists('b:winview') && !&diff | call   winrestview(b:winview) | endif

		" Save current view settings on a per-window, per-buffer basis.
		function! AutoSaveWinView()
		if !exists("w:SavedBufView")
			let w:SavedBufView = {}
			endif
			let w:SavedBufView[bufnr("%")] = winsaveview()
			endfunction

			" Restore current view settings.
			function! AutoRestoreWinView()
			let buf = bufnr("%")
			if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
				let v = winsaveview()
				let atStartOfFile = v.lnum == 1 && v.col == 0
				if atStartOfFile && !&diff
					call winrestview(w:SavedBufView[buf])
					endif
					unlet w:SavedBufView[buf]
					endif
					endfunction

					" When switching buffers, preserve window view.
					if v:version >= 700
						autocmd BufLeave * call AutoSaveWinView()
						autocmd BufEnter * call AutoRestoreWinView()
						endif
						]])
end

return require('packer').startup(function()
			use 'wbthomason/packer.nvim'

			use {'nvim-telescope/telescope.nvim', requires = {
				{'nvim-lua/popup.nvim'},
				{'nvim-lua/plenary.nvim'},
				{'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
			}, config = function()
				require('telescope').setup{
					defaults = {
						vimgrep_arguments = {
							'rg',
							'--color=never',
							'--no-heading',
							'--with-filename',
							'--line-number',
							'--column',
							'--smart-case'
						},

						initial_mode = "insert",
						selection_strategy  = "reset",
						sorting_strategy    = "ascending",
						layout_strategy     = "horizontal",
						layout_config = {
							horizontal = {
								mirror = false,
								prompt_position = "top"
							},
							vertical = {
								mirror = false
							},
						},
						file_ignore_patterns= {},
						file_sorter         =  require'telescope.sorters'.get_fuzzy_file,
						generic_sorter      = require'telescope.sorters'.get_generic_fuzzy_sorter,
						file_previewer      = require'telescope.previewers'.vim_buffer_cat.new,
						grep_previewer      = require'telescope.previewers'.vim_buffer_vimgrep.new,
						qflist_previewer    = require'telescope.previewers'.vim_buffer_qflist.new,

						prompt_prefix       = "🔎︎ ",
						selection_caret     = "➤ ",
						entry_prefix        = "  ",
						winblend            = 0,
						border              = {},
						borderchars         = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
						color_devicons      = true,
						use_less            = true,
						set_env             = { ['COLORTERM'] = 'truecolor' },  -- default = nil,
						path_display        = {'absolute'},                     -- How file paths are displayed ()


						-- Developer configurations: Not meant for general override
						buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
					},

					extensions = {
						fzf = {
							fuzzy                     = true,     -- false will only do exact matching
							override_generic_sorter   = false,    -- override the generic sorter
							override_file_sorter      = true,     -- override the file sorter
							case_mode                 = "smart_case", -- or "ignore_case" or "respect_case". the default case_mode is "smart_case"
						}
					}
				}
				require('telescope').load_extension('fzf')
				vim.api.nvim_command[[
				augroup ReplaceNetrw
				autocmd VimEnter * silent! autocmd! FileExplorer
				autocmd StdinReadPre * let s:std_in=1
				autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | call luaeval("require('telescope.builtin').file_browser({cwd = _A})", argv()[0]) | endif
				augroup END
				]]

				vim.api.nvim_command("autocmd FileType clap_input call compe#setup({ 'enabled': v:false }, 0)")
				local keymap = vim.api.nvim_set_keymap
				--      --> Launch Telescope without any argument
				keymap('n', "\\\\", "<cmd>lua require('telescope.builtin').builtin() <CR>", {silent=true, noremap=true})
				--       --> show all availabe MAPPING
				keymap('n', "<leader>M", "<cmd>lua require('telescope.builtin').keymaps() <CR>", {silent=true, noremap=true})
				--       --> show buffers/opened files
				keymap('n', "<C-b>", "<cmd>lua require('telescope.builtin').buffers() <CR>", {silent=true, noremap=true})
				--       --> Find Files
				-- NOTE1: to get project root's directory, extra plugin (github.com/ygm2/rooter.nvim) is used.
				-- any config related to project root is in seperate config file (lua/plugin_confs/rooter_nvim.lua)
				-- to change settings related to working directory, refer to rooter_nvim.lua config file
				-- Find files from current file's project
				keymap('n', "<C-p>", ":Telescope find_files <cr>", {silent=true, noremap=true})
				-- show all files from current working directory
				keymap('n', "<C-f>", "<cmd>lua require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h') }) <CR>", {silent=true, noremap=true})
				--       --> Code Action
				-- for example, in flutter/dart you can wrap or delete widgets using code action.
				-- for more see :help builtin.lsp_code_actions() or :help builtin.lsp_range_code_actions()
				keymap('n', "<leader>ca", "<cmd>lua  require('telescope.builtin').lsp_code_actions( {layout_config={width=50, height=20} } ) <CR>", {silent=true, noremap=true})
				keymap('x', "<leader>ca", "<cmd>lua  require('telescope.builtin').lsp_range_code_actions( {layout_config={width=50, height=25} } ) <CR>", {silent=true, noremap=true})
			end
		}

		use { -- Use (neo)vim terminal in the floating/popup window.
		'voldikss/vim-floaterm',
		config = function()
			-- Set floating window border line color to cyan, and background to orange
			vim.cmd("hi FloatermBorder guibg=none guifg=grey")
			-- Set floaterm window's background to black
			vim.cmd("hi Floaterm guibg=black")
			-- Set floaterm window background to gray once the cursor moves out from it
			vim.cmd("hi FloatermNC guibg=gray")
			vim.g.floaterm_title = 'Terminal: $1/$2'
			-- Set it to 'split' or 'vsplit' if you don't want to use floating or popup window.
			vim.g.floaterm_wintype = 'float'
			-- Type Number (number of columns) or Float (between 0 and 1). If Float, the width is relative to &columns.
			vim.g.floaterm_width = 0.6
			-- Type Number (number of lines) or Float (between 0 and 1). If Float, the height is relative to &lines.
			vim.g.floaterm_height = 0.7

			-- Mappings
			local keymap = vim.api.nvim_set_keymap
			local g = vim.g

			g.floaterm_keymap_toggle = 'tt'         -- toggle open/close floaterm
			g.floaterm_keymap_prev   = 'tk'         -- go to previous floaterm window
			g.floaterm_keymap_next   = 'tj'         -- go to next floaterm window
			--g.floaterm_keymap_new    = 'tn'         -- create new terminal
			--g.floaterm_keymap_kill   = 'tq'         -- quit current terminal
			--create new floaterm window
			keymap('n', 'tn',':FloatermNew<CR>',    { noremap=true, silent=true })
			-- exit floaterm window
			keymap('n', 'tq',':FloatermKill<CR>',   { noremap=true, silent=true })

			-------------------------------------------
			-- Build And Run
			-------------------------------------------
			-- compile, run or compile and run program.
			-- it depends on python script, https://github.com/shaeinst/lazy-builder. visit to know more.

			local lazy_builder_py = "~/.local/share/nvim/custom_tools/lazy-builder/build.py"
			local build_path = "~/.cache/build_files"
			local run       = ":w | :FloatermNew python "..lazy_builder_py.." -o "..build_path.." -r 1 % <CR>"
			local build     = ":w | :FloatermNew time python "..lazy_builder_py.." -o "..build_path.." -b 1 % <CR>"
			local buildrun  = ":w | :FloatermNew time python "..lazy_builder_py.." -o "..build_path.." -br 1 % <CR>"
			keymap('n', '<Leader>r', run,       { noremap=true, silent=true }) -- Run
			keymap('n', '<Leader>o', build,     { noremap=true, silent=true }) -- build
			keymap('n', '<Leader>O', buildrun,  { noremap=true, silent=true }) -- build and run
		end}

		use { 
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
					'*';

				},
				{
					mode = 'background';
					names = true;
					css = true;
					css_fn = true;
				})
			end
		}

		use { "mangeshrex/everblush.vim" }

		use {
			'Yggdroot/indentLine',
			config = function()
				vim.g.indentLine_enabled = 1
				vim.g.indentLine_char = '▏'
				--vim.g.indentLine_char_list = ['|', '¦', '┆', '┊']
				vim.g.indentLine_color_gui = '#1a2030'
			end
		}

		use {
			'akinsho/nvim-bufferline.lua',
			requires = 'kyazdani42/nvim-web-devicons',
			config = function()
				require('bufferline').setup {
					options = {
						numbers                 = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string
						always_show_bufferline = false, -- don't show bufferline if there is only one file is opened
						--- @deprecated, please specify numbers as a function to customize the styling
						-- number_style            = "ssubscript",  -- options -> "superscript" | "" | { "none", "subscript" }, buffer_id at index 1, ordinal at index 2
						close_command           = "bdelete! %d",        -- can be a string | function, see "Mouse actions"
						right_mouse_command     = "bdelete! %d",        -- can be a string | function, see "Mouse actions"
						left_mouse_command      = "buffer %d",          -- can be a string | function, see "Mouse actions"
						middle_mouse_command    = nil,                  -- can be a string | function, see "Mouse actions"
						-- NOTE: this plugin is designed with this icon in mind,
						-- and so changing this is NOT recommended, this is intended
						-- as an escape hatch for people who cannot bear it for whatever reason
						indicator_icon = '▎',
						--indicator_icon      = '',
						buffer_close_icon   = '',
						modified_icon       = '●',
						close_icon          = '',
						left_trunc_marker   = '',
						right_trunc_marker  = '',

						--- name_formatter can be used to change the buffer's label in the bufferline.
						--- Please note some names can/will break the
						--- bufferline so use this at your discretion knowing that it has
						--- some limitations that will *NOT* be fixed.
						name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
							-- remove extension from markdown files for example
							if buf.name:match('%.md') then
								return vim.fn.fnamemodify(buf.name, ':t:r')
							end
						end,

						max_name_length = 18,
						max_prefix_length = 15, -- prefix used when a buffer is de-duplicate
						tab_size = 18,

						show_close_icon = false,
						show_buffer_icons = true,   -- disable filetype icons for buffers
						show_buffer_close_icons = false,
						show_tab_indicators = false,

						view = "multiwindow",
						-- can also be a table containing 2 custom separators
						-- [focused and unfocused]. eg: { '|', '|' }
						separator_style = {"", ""}, -- options "slant" | "thick" | "thin" | { 'any', 'any' },
						offsets = {{filetype = "NvimTree", text = "Explorer", text_align = "left"}},    -- options function , text_" "h always_show_bufferline = false
					},

					highlights = {
						fill = {
							guibg = "#21252d",
						},
						background  = {
							guifg = '#FFFFFF',
							guibg = "#21252d",
						},
						separator_selected = {
							guifg = "#060606"
						},
						separator = {
							guifg = "#141414"
						},
						close_button_selected = {
							guibg = "#21252d",
							guifg = "#F1252d",
						},
					},
				}
				vim.cmd("autocmd BufDelete * if len(getbufinfo({'buflisted':1})) -1 < 1 | set showtabline=1 | endif")

				local keymap = vim.api.nvim_set_keymap
				local options = { noremap=true, silent=true }
				-- Move to previous/next
				keymap('n', '<leader>]',   ':BufferLineCycleNext<CR>',      options)
				keymap('n', '<leader>[',   ':BufferLineCyclePrev<CR>',      options)
				keymap('n', '<leader>p', ':BufferLineCyclePrev<CR>', {silent=true,noremap=true})
				keymap('n', '<leader>n', ':BufferLineCycleNext<CR>', {silent=true,noremap=true})
				keymap('n', '<leader>a', ':BufferLineCyclePrev<CR>', {silent=true,noremap=true})
				keymap('n', '<leader>d', ':BufferLineCycleNext<CR>', {silent=true,noremap=true})
				-- Allow to switch buffers, even in insert mode.
				keymap('i', '<leader>]',   '<ESC> | :BufferLineCycleNext<CR> | :startinsert<CR>',      options)
				keymap('i', '<leader>[',   '<ESC> | :BufferLineCyclePrev<CR> | :startinsert<CR>',      options)
				-- Re-order to previous/next
				keymap('n', '<Leader>.',    ':BufferLineMoveNext<CR>',        options)
				keymap('n', '<Leader>,',    ':BufferLineMovePrev<CR>',        options)
				-- Close buffer
				-- nnoremap <silent>    <A-c> :BufferClose<CR>
				keymap('n', '<Leader>q',    ':bd<CR>',        options)
				-- Magic buffer-picking mode
				keymap('n', '<Leader>?',    ':BufferLinePick<CR>',        options)
				-- go to buffer number
				keymap('n', '<Leader>1', ':BufferLineGoToBuffer 1<CR>', options)
				keymap('n', '<Leader>2', ':BufferLineGoToBuffer 2<CR>', options)
				keymap('n', '<Leader>3', ':BufferLineGoToBuffer 3<CR>', options)
				keymap('n', '<Leader>4', ':BufferLineGoToBuffer 4<CR>', options)
				keymap('n', '<Leader>5', ':BufferLineGoToBuffer 5<CR>', options)
				keymap('n', '<Leader>6', ':BufferLineGoToBuffer 6<CR>', options)
				keymap('n', '<Leader>7', ':BufferLineGoToBuffer 7<CR>', options)
				keymap('n', '<Leader>8', ':BufferLineGoToBuffer 8<CR>', options)
				keymap('n', '<Leader>9', ':BufferLineGoToBuffer 9<CR>', options)
			end
		}

		-- The Status Line / Status Bar
		use {
		'feline-nvim/feline.nvim', tag = 'v0.3.3',
		requires = {
			'nvim-lua/lsp-status.nvim',
		},
		config = function()
			local lsp = require('feline.providers.lsp')
			local vi_mode_utils = require('feline.providers.vi_mode')
			local lsp_status = require('lsp-status')

			local b = vim.b
			local fn = vim.fn

			local components = {
				active = {},
				inactive = {}
			}

			components.active[1] = {
				{
					provider = '▊ ',
					hl = {
						fg = 'skyblue'
					}
				},
				{
					provider = 'vi_mode',
					hl = function()
						return {
							name = vi_mode_utils.get_mode_highlight_name(),
							fg = vi_mode_utils.get_mode_color(),
							style = 'bold'
						}
					end,
					right_sep = ' '
				},
				{
					provider = 'file_info',
					hl = {
						fg = 'black',
						bg = 'fg',
						style = 'bold'
					},
					left_sep = {
						' ', 'slant_left_2',
						{str = ' ', hl = {bg = 'fg', fg = 'NONE'}}
					},
					right_sep = {'slant_right_2', ' '}
				},
				{
					provider = 'file_size',
					enabled = function() return fn.getfsize(fn.expand('%:p')) > 0 end,
					right_sep = {
						' ',
						{
							str = ' ',
							hl = {
								fg = 'fg',
								bg = 'bg'
							}
						},
					}
				},
				{
					provider = function()
						local name_with_path = os.getenv('VIRTUAL_ENV')
						local venv = {};
						for match in (name_with_path.."/"):gmatch("(.-)".."/") do
							table.insert(venv, match);
						end
						return  "" .. venv[#venv]
					end,
					enabled = function() return os.getenv('VIRTUAL_ENV') ~= nil end,
					right_sep = " ",
				},
				{
					provider = 'git_branch',
					hl = {
						fg = 'white',
						bg = 'black1',
						style = 'bold'
					},
					right_sep = function()
						local val = {hl = {fg = 'NONE', bg = 'black1'}}
						if b.gitsigns_status_dict then val.str = ' ' else val.str = '' end
						return val
					end
				},
				{
					provider = 'git_diff_added',
					icon = {
						str = ' +',
						hl = {
							fg = 'green' ,
							style = 'bold',
						},
					},
					hl = {
						fg = 'green' ,
						style = 'bold',
					},
				},
				{
					provider = 'git_diff_changed',
					icon = {
						str = ' ~',
						hl = {
							fg = 'orange' ,
							style = 'bold',
						},
					},
					hl = {
						fg = 'orange' ,
						style = 'bold',
					},
				},
				{
					provider = 'git_diff_removed',
					icon = {
						str = ' -',
						hl = {
							fg = 'red' ,
							style = 'bold',
						},
					},
					hl = {
						fg = 'red' ,
						style = 'bold',
					},
					right_sep = function()
						local val = {hl = {fg = 'NONE', bg = 'black1'}}
						if b.gitsigns_status_dict then val.str = ' ' else val.str = '' end
						return val
					end
				},
			}

			components.active[2] = {
				{
					provider = 'diagnostic_errors',
					enabled = function() return lsp.diagnostics_exist('Error') end,
					hl = { fg = 'red' }
				},
				{
					provider = 'diagnostic_warnings',
					enabled = function() return lsp.diagnostics_exist('Warning') end,
					hl = { fg = 'yellow' }
				},
				{
					provider = 'diagnostic_hints',
					enabled = function() return lsp.diagnostics_exist('Hint') end,
					hl = { fg = 'cyan' }
				},
				{
					provider = 'diagnostic_info',
					enabled = function() return lsp.diagnostics_exist('Information') end,
					hl = { fg = 'skyblue' }
				},
				{
					provider = function()
						local msg = ''
						local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
						local clients = vim.lsp.get_active_clients()
						if next(clients) == nil then return msg end
						for _, client in ipairs(clients) do
							local filetypes = client.config.filetypes
							if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
								return "LSP[" .. client.name .. "]"
							end
						end
						return msg
					end,
					hl = {
						style = 'italic'
					},
					left_sep = {
						' ',
						{
							str = ' ',
							hl = {
								fg = 'fg',
								bg = 'bg'
							}
						}
					}

				},
				{
					provider = function ()
						lsp_status.register_progress()
						return lsp_status.status()
					end
				},

			}

			components.active[3] = {
				{
					provider = '  %l:%-2c- %L ',
					left_sep = ' ',
					hl = {
						fg = 'black',
						bg = 'fg',
						style = 'bold'
					},
				},
				{
					provider = 'scroll_bar',
					hl = {
						fg = 'black',
						bg = 'fg',
						style = 'bold',
						left_sep = ' ',
						right_sep = ' '
					}
				}
			}

			components.inactive[1] = {
				{
					provider = 'file_info',
					hl = {
						fg = 'black',
						bg = 'white1',
						style = 'bold'
					},
					-- left_sep = {
					--     str = ' ',
					--     hl = {
					--         fg = 'black',
					--         bg = 'white',
					--     }
					-- },
					right_sep = {
						{
							str = ' ',
							hl = {
								fg = 'black',
								bg = 'bg',
							}
						},
						-- 'slant_right'
					}
				}
			}

			-- This table is equal to the default colors table
			local colors = {
				fg          = '#C8C8C8',
				--bg          = '#1F1F23',
				bg          = '#101020',
				black       = "#000000",
				--black1      = '#1B1B1B',
				black1          = '#101020',
				skyblue     = '#50B0F0',
				cyan        = '#009090',
				green       = '#60A040',
				oceanblue   = '#0066cc',
				magenta     = '#C26BDB',
				orange      = '#FF9000',
				red         = '#D10000',
				violet      = '#9E93E8',
				white       = '#FFFFFF',
				white1      = '#808080',
				yellow      = '#E1E120'
			}

			-- This table is equal to the default separators table
			local separators        = {
				vertical_bar        = '┃',
				vertical_bar_thin   = '│',
				left                = '',
				right               = '',
				block               = '█',
				left_filled         = '',
				right_filled        = '',
				slant_left          = '',
				slant_left_thin     = '',
				slant_right         = '',
				slant_right_thin    = '',
				slant_left_2        = '',
				slant_left_2_thin   = '',
				slant_right_2       = '',
				slant_right_2_thin  = '',
				left_rounded        = '',
				left_rounded_thin   = '',
				right_rounded       = '',
				right_rounded_thin  = '',
				circle              = '●'
			}

			-- This table is equal to the default vi_mode_colors table
			local vi_mode_colors = {
				['NORMAL']      = 'green',
				['OP']          = 'green',
				['INSERT']      = 'red',
				['VISUAL']      = 'skyblue',
				['LINES']       = 'skyblue',
				['BLOCK']       = 'skyblue',
				['REPLACE']     = 'violet',
				['V-REPLACE']   = 'violet',
				['ENTER']       = 'cyan',
				['MORE']        = 'cyan',
				['SELECT']      = 'orange',
				['COMMAND']     = 'green',
				['SHELL']       = 'green',
				['TERM']        = 'green',
				['NONE']        = 'yellow'
			}

			-- This table is equal to the default force_inactive table
			local force_inactive = {
				filetypes = {
					'NvimTree',
					'packer',
					'startify',
					'fugitive',
					'fugitiveblame',
					'qf',
					'help'
				},
				buftypes = {
					'terminal'
				},
				bufnames = {}
			}

			-- This table is equal to the default disable table
			local disable = {
				filetypes = {},
				buftypes = {},
				bufnames = {}
			}

			-- This table is equal to the default update_triggers table
			local update_triggers = {
				'VimEnter',
				'WinEnter',
				'WinClosed',
				'FileChangedShellPost'
			}

			require('feline').setup({
				colors = colors,
				separators = separators,
				vi_mode_colors = vi_mode_colors,
				force_inactive = force_inactive,
				disable = disable,
				update_triggers = update_triggers,
				components = components
			})
		end
	}

	-- Lsp stuff
	--[[
	use { -- A collection of common configurations for Neovim's built-in language server client
			'neovim/nvim-lspconfig',
			config = function()
					vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
					vim.lsp.diagnostic.on_publish_diagnostics, {
						underline = true,
						signs = true,
						update_in_insert = false,
						virtual_text = {
							true,
							spacing = 6,
							--severity_limit='Error'  -- Only show virtual text on error
						},
					}
					)

					vim.api.nvim_command "sign define DiagnosticSignError text=✗ texthl=DiagnosticSignError linehl= numhl="
					vim.api.nvim_command "sign define DiagnosticSignWarn  text=⚠ texthl=DiagnosticSignWarn  linehl= numhl="
					vim.api.nvim_command "sign define DiagnosticSignInfo  text= texthl=DiagnosticSignInfo  linehl= numhl="
					vim.api.nvim_command "sign define DiagnosticSignHint  text= texthl=DiagnosticSignHint  linehl= numhl="
					vim.api.nvim_command "hi DiagnosticUnderlineError cterm=underline gui=underline guisp=#840000"
					vim.api.nvim_command "hi DiagnosticUnderlineHint cterm=underline  gui=underline guisp=#17D6EB"
					vim.api.nvim_command "hi DiagnosticUnderlineWarn cterm=underline  gui=underline guisp=#2f2905"

			end
	}
	use {
			'williamboman/nvim-lsp-installer',
			config = function()
					lsp_installer = require("nvim-lsp-installer")
					local function make_server_ready(attach)
						lsp_installer.on_server_ready(function(server)
							local opts = {}
							opts.on_attach = attach

							opts.autostart = false

							if server.name == "clangd" then
								--print(server.name, server._default_options)
								--table.insert(server._default_options.cmd, "-log=verbose")
								--print("ClangdOpts",table.concat(server._default_options.cmd,", "))
							end

							-- for lua
							if server.name == "sumneko_lua" then
								-- only apply these settings for the "sumneko_lua" server
								opts.settings = {
									Lua = {
									diagnostics = {
										-- Get the language server to recognize the 'vim', 'use' global
										globals = {'vim', 'use', 'require'},
									},
									workspace = {
										-- Make the server aware of Neovim runtime files
										library = vim.api.nvim_get_runtime_file("", true),
									},
									-- Do not send telemetry data containing a randomized but unique identifier
									telemetry = {
										enable = false,
									},
									},
								}
							end

							-- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
							server:setup(opts)
							vim.cmd "do User LspAttachBuffers"
						end)
					end

					local function install_server(server)
						local lsp_installer_servers = require'nvim-lsp-installer.servers'
						local ok, server_analyzer = lsp_installer_servers.get_server(server)
						if ok then
							if not server_analyzer:is_installed() then
							server_analyzer:install(server)   -- will install in background
							-- lsp_installer.install(server)     -- install window will popup
							end
						end
					end
					--─────────────────────────────────────────────────--

					local servers = {
					"sumneko_lua",        -- for Lua
					-- "rust_analyzer",      -- for Rust
					-- "pyright",            -- for Python
					-- "clangd",             -- for C/C++
					-- "bashls",             -- for Bash
					}

					-- setup the LS
					make_server_ready(lsp_on_attach)    -- LSP mappings

					-- install the LS
					for _, server in ipairs(servers) do
					install_server(server)
					end
			end
	}
	use { "williamboman/mason.nvim",
		config = function()
			require('mason').setup()
		end
	}
	--]]
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}
	require("mason").setup()
	require("mason-lspconfig").setup()
	require('mason-lspconfig').setup_handlers {
		function (server_name)
			require('lspconfig')[server_name].setup{
				autostart=false
			}
		end
	}
	
	use { -- Utility functions for getting diagnostic status and progress messages from LSP servers, for use in the Neovim statusline
			'nvim-lua/lsp-status.nvim',
			--config = [[ require('plugins/lspstatus') ]]
	}

	if packer_bootstrap then
		require('packer').sync()
	end	

	setup_maps()
	setup_config()
	setup_colors()
end
)
