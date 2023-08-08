--
-- My (@steplee) vim rc.
--
-- Based in large part on [roshnivim, which seems to have been renamed Abstract](https://github.com/Abstract-IDE/Abstract)
-- I prefer having everything in one file though, so this file is pretty long.
--
-- NOTE: If you are trying to edit this in ~/.config/nvim/, you probably don't want to.
--       Instead, edit it in the repo then run 'installConfig.sh'
--       If you really do want to edit it, run 'chmod u+w ~/.config/nvim/init.lua'
--



vim.g.mapleader = ';'
vim.g.maplocalleader = '|'

-- Only saves 3-4ms on my desktop...
require('impatient')

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
		-- print('Turning LSP On')
	else
		vim.cmd('LspStop');
		-- print('Turning LSP Off')
	end
end

-- todo TEST THIS
-- function my_lsp_on_attach(client, bufnr)
	-- print('attach lsp to', bufnr)
function my_lsp_on_attach()
	print('attach lsp')
	-- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	-- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
	-- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	local buf_set_keymap = function(mode, lhs, rhs, opts)
      vim.keymap.set(mode, lhs, rhs, opts)
    end

	-- Mappings.
	local opts = { noremap=true, silent=true, buffer=true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	--─────────────────────────────────────────────────--
	--[[
	buf_set_keymap('n', '<space>e',   '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>',  opts)
	buf_set_keymap('n', '[d',         '<cmd>lua vim.diagnostic.goto_prev()<CR>',              opts)
	buf_set_keymap('n', ']d',         '<cmd>lua vim.diagnostic.goto_next()<CR>',              opts)
	buf_set_keymap('n', '<space>q',   '<cmd>lua vim.diagnostic.set_loclist()<CR>',            opts)

	buf_set_keymap('n', 'gD',         '<Cmd>lua vim.lsp.buf.declaration()<CR>',                   opts)
	buf_set_keymap('n', 'gd',         '<Cmd>lua vim.lsp.buf.definition()<CR>',                    opts)
	buf_set_keymap('n', 'K',          '<Cmd>lua vim.lsp.buf.hover()<CR>',                         opts)
	buf_set_keymap('n', 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>',                opts)
	buf_set_keymap('n', '[ls',        '<cmd>lua vim.lsp.buf.signature_help()<CR>',                opts)
	buf_set_keymap('n', '<space>D',   '<cmd>lua vim.lsp.buf.type_definition()<CR>',               opts)
	buf_set_keymap('n', '<space>rn',  '<cmd>lua vim.lsp.buf.rename()<CR>',                        opts)
	buf_set_keymap('n', 'gr',         '<cmd>lua vim.lsp.buf.references()<CR>',                    opts)
	buf_set_keymap("n", "<space>f",   '<cmd>lua vim.lsp.buf.formatting()<CR>',                    opts)
	buf_set_keymap("n", "<C-m>",      '<cmd>lua vim.lsp.buf.completion()<CR>',                    opts)
	buf_set_keymap("n", "<C-h>",      '<cmd>lua vim.lsp.buf.incoming_calls()<CR>',                    opts)
	buf_set_keymap("n", "<C-g>",      '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>',                    opts)
	--]]

	-- New keymaps that mostly use '\' as a prefix
	buf_set_keymap('n', '\\e',   '<cmd>lua vim.diagnostic.open_float()<CR>',  opts)
	buf_set_keymap('n', '\\[',         '<cmd>lua vim.diagnostic.goto_prev()<CR>',              opts)
	buf_set_keymap('n', '\\]',         '<cmd>lua vim.diagnostic.goto_next()<CR>',              opts)
	buf_set_keymap('n', '\\q',   '<cmd>lua vim.diagnostic.set_loclist()<CR>',            opts)

	buf_set_keymap('n', '\\D',         '<Cmd>lua vim.lsp.buf.declaration()<CR>',                   opts)
	buf_set_keymap('n', '\\d',         '<Cmd>lua vim.lsp.buf.definition()<CR>',                    opts)
	buf_set_keymap('n', 'K',          '<Cmd>lua vim.lsp.buf.hover()<CR>',                         opts)
	buf_set_keymap('n', '\\i',         '<cmd>lua vim.lsp.buf.implementation()<CR>',                opts)
	buf_set_keymap('n', '\\s',        '<cmd>lua vim.lsp.buf.signature_help()<CR>',                opts)
	buf_set_keymap('n', '\\D',   '<cmd>lua vim.lsp.buf.type_definition()<CR>',               opts)
	buf_set_keymap('n', '\\r',  '<cmd>lua vim.lsp.buf.rename()<CR>',                        opts)
	buf_set_keymap('n', '\\l',         '<cmd>lua vim.lsp.buf.references()<CR>',                    opts)
	buf_set_keymap("n", "\\f",   '<cmd>lua vim.lsp.buf.formatting()<CR>',                    opts)
	buf_set_keymap("n", "<C-m>",      '<cmd>lua vim.lsp.buf.completion()<CR>',                    opts)
	buf_set_keymap("n", "\\g",      '<cmd>lua vim.lsp.buf.incoming_calls()<CR>',                    opts)
	buf_set_keymap("n", "\\h",      '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>',                    opts)

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
	-- keymap('', '<C-j>', '<C-w>j', {noremap=true})
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
	--vim.api.nvim_exec("source fnamemodify($MYVIMRC,':h')/localPlugins/uwu.vim", false)
	-- cmd("source localPlugins/uwu.vim");
	-- cmd("source ~/.config/nvim/localPlugins/uwu.vim");
	-- actually, just place in <cfg>/nvim/colors

	-- want to get rid of this soon, shouldn't load then replace a big lua table
	-- cmd('colorscheme rvcs')
	cmd("colorscheme uwu | hi Normal guibg=#010102 | hi Whitespace guibg=#010104 | hi Comment guifg=#69698a | hi! link TSComment Comment | hi CursorLine guibg=#101016 | hi SignColumn guibg=none | hi NvimTreeFolderIcon guifg=#7a7aaa | hi NvimTreeSymlink guifg=#9a4a7a | hi NvimTreeOpenedFile guifg=#73a3ff | hi NvimTreeFolderName guifg=#63639a | hi VertSplit guibg=#151522 | hi Search guifg=black guibg=#AFbe20 | hi Pmenu guifg=gray guibg=#101010 | hi PmenuSel guifg=vanilla guibg=#101030 | hi TSNumber guifg=lightyellow | hi bashTSParameter guifg=#f0d0f0 | hi! link cppTSField cppTSVariable | hi! Statement guifg=#73439a")
	cmd("hi! link @type.qualifier.cpp keyword | hi! link @type.cpp TSType | hi! link @type.builtin.cpp TSType | hi! link @storageclass.cpp keyword")
	cmd("hi! @constant.cpp guifg=#5080f0 | hi! link @boolean.cpp @number.cpp")
	cmd("hi! TabLineFill guibg=#020202 | hi! TabLine guibg=#050505 gui=none guifg=#909090 | hi! TabLineSel guibg=#000000 gui=bold guifg=#e0e0e0")
	cmd([[
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun]])

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

return require('packer').startup{function()
			use 'wbthomason/packer.nvim'
			use 'lewis6991/impatient.nvim'

			--[[
			use { -- Supposed to be faster then the default filtetype.vim
					'nathom/filetype.nvim',
							config = function() require('filetype').setup({
								overrides = {
									extensions = {
										ll = "llvm"
									}
								}
							})
						vim.g.did_load_filetypes = 1
						end
			}
			--]]

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

						mappings = {
							n = {
								['<c-q>'] = require('telescope.actions').delete_buffer
							},
							i = {
								['<c-q>'] = require('telescope.actions').delete_buffer
							}
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
				--keymap('n', "<C-b>", "<cmd>lua require('telescope.builtin').buffers() <CR>", {silent=true, noremap=true})
				-- keymap('n', "<C-b>", "<cmd>lua require('telescope.builtin').buffers() sort_lastused=1 only_cwd=1<CR>", {silent=true, noremap=true})
				-- keymap('n', "<C-b>", "<cmd>lua require('telescope.builtin').buffers({sort_lastused=1, only_cwd=1})<CR>", {silent=true, noremap=true})
				keymap('n', "<leader>d", "<cmd>lua require('telescope.builtin').buffers({sort_mru=1, only_cwd=1, ignore_current_buffer=1})<CR>", {silent=true, noremap=true})
				keymap('n', "<leader>b", "<cmd>lua require('telescope.builtin').buffers({sort_mru=1})<CR>", {silent=true, noremap=true})
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

				-- live_grep, but not in "build" dir.
				keymap('n', "<leader>g", "<cmd>lua require('telescope.builtin').live_grep({file_ignore_pattern={\"build\"}}) <CR>", {silent=true, noremap=true})
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

			--[[
			local lazy_builder_py = "~/.local/share/nvim/custom_tools/lazy-builder/build.py"
			local build_path = "~/.cache/build_files"
			local run       = ":w | :FloatermNew python "..lazy_builder_py.." -o "..build_path.." -r 1 % <CR>"
			local build     = ":w | :FloatermNew time python "..lazy_builder_py.." -o "..build_path.." -b 1 % <CR>"
			local buildrun  = ":w | :FloatermNew time python "..lazy_builder_py.." -o "..build_path.." -br 1 % <CR>"
			keymap('n', '<Leader>r', run,       { noremap=true, silent=true }) -- Run
			keymap('n', '<Leader>o', build,     { noremap=true, silent=true }) -- build
			keymap('n', '<Leader>O', buildrun,  { noremap=true, silent=true }) -- build and run
			--]]

			-- Write-all, search for last command with 'make', then execute it, then pop up floaterm.
			-- Note: floaterm window must already exist!
			-- Zsh version (history -N):
			local build       = vim.api.nvim_replace_termcodes(":FloatermSend $(history -32 | grep make | grep -v history | tail -1 | cut -f 3,4,5,6,7,8,9,10,11,12,13,14  -d \\ )",true,true,true)
			keymap('n', '<Leader>o', ":wa | execute('" .. build .. "') | :FloatermToggle <CR>", {noremap=true, silent=true})

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

		use { "shaeinst/roshnivim-cs" }
		-- Now I included this locally
		-- use { "mangeshrex/everblush.vim", commit='3bc7c97' }

		use {
			'Yggdroot/indentLine',
			config = function()
				vim.g.indentLine_enabled = 1
				vim.g.indentLine_char = '▏'
				--vim.g.indentLine_char_list = ['|', '¦', '┆', '┊']
				vim.g.indentLine_color_gui = '#1a2030'
			end
		}

		use { -- lua `fork` of vim-web-devicons for neovim
				'kyazdani42/nvim-web-devicons',
				config = function()
					require'nvim-web-devicons'.get_icons()
				end
		}
		--[[
		use {
			'akinsho/nvim-bufferline.lua',
			requires = 'kyazdani42/nvim-web-devicons',
			enabled=false,
			config = function()
				require('bufferline').setup {
					options = {
						numbers                 = "buffer_id", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string
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
						indicator = {
							style = "icon",
							icon = '▎' },
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
						tab_size = 6,

						show_close_icon = false,
						show_buffer_icons = true,   -- disable filetype icons for buffers
						show_buffer_close_icons = false,
						show_tab_indicators = false,

						-- mode = "tabs",
						mode = "buffers",
						-- can also be a table containing 2 custom separators
						-- [focused and unfocused]. eg: { '|', '|' }
						separator_style = {"", ""}, -- options "slant" | "thick" | "thin" | { 'any', 'any' },
						offsets = {{filetype = "NvimTree", text = "Explorer", text_align = "left"}},    -- options function , text_" "h always_show_bufferline = false
					},

					highlights = {
						fill = {
							--bg = "#111520",
						},
						background  = {
							fg = '#babada',
							--bg = "#212540",
						},
						tab_selected  = {
							fg = '#FFFFFF',
							bg = "#41496d",
						},
						buffer_selected  = {
							fg = '#FFFFFF',
							bg = "#121232",
						},
						separator_selected = {
							fg = "#324666"
						},
						separator = {
							fg = "#212540"
						},
						close_button_selected = {
							bg = "#21252d",
							fg = "#F1252d",
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
		--]]

		-- The Status Line / Status Bar
		use {
		-- 'feline-nvim/feline.nvim', tag = 'v0.3.3',
		'feline-nvim/feline.nvim',
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
				--[[{
					provider = 'diagnostic_warnings',
					enabled = function() return lsp.diagnostics_exist('Warning') end,
					hl = { fg = 'yellow' }
				},
				{
					provider = 'diagnostic_info',
					enabled = function() return lsp.diagnostics_exist('Information') end,
					hl = { fg = 'skyblue' }
				},--]]
				{
					provider = 'diagnostic_hints',
					enabled = function() return lsp.diagnostics_exist('Hint') end,
					hl = { fg = 'cyan' }
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
								bg = 'bgInactive',
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
				-- bg          = '#101020',
				bg          = '#121225',
				bgInactive          = '#060609',
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
				white1      = '#606070',
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
				theme = colors,
				separators = separators,
				vi_mode_colors = vi_mode_colors,
				force_inactive = force_inactive,
				disable = disable,
				update_triggers = update_triggers,
				components = components
			})
		end
	}

	-- The interaction of nvim's LSP client, the lspconfig helper, and the mason helper
	-- is pretty confusing, and I still don't fully understand it.
	-- But I have it configured as I want:
	-- I can use :LspInstall clangd
	-- Then :LspStart when I want it on
	-- Also, <space>l will toggle it on/off
	-- Note: the function @my_lsp_on_attach is executed when attached
	-- use {
		-- "williamboman/mason.nvim",
		-- "williamboman/mason-lspconfig.nvim",
		-- "neovim/nvim-lspconfig",
	-- }
	use {
		"neovim/nvim-lspconfig",
		config = [[
			require("mason").setup()
			require("mason-lspconfig").setup()

			require('mason-lspconfig').setup_handlers {
			function (server_name)
				require('lspconfig')[server_name].setup {
					autostart=false,
					-- on_attach=my_lsp_on_attach
				}
			end
			}
			vim.api.nvim_create_autocmd('LspAttach', {
				desc = 'LSP actions',
				callback = my_lsp_on_attach })


		]],
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		}
	}

	use {
			'nvim-lua/lsp-status.nvim',
	}

	use {
		'kyazdani42/nvim-tree.lua',
		config = function()
			local gl        = vim.g
			local keymap    = vim.api.nvim_set_keymap
			local options   = { noremap=true, silent=true }
			local cmd       = vim.cmd           -- execute Vim commands
			cmd('autocmd ColorScheme * highlight highlight NvimTreeBg guibg=None')
			cmd('autocmd FileType NvimTree setlocal winhighlight=Normal:NvimTreeBg')
			--gl.nvim_tree_quit_on_open          = 1   --0 by default, closes the tree when you open a file
			--gl.nvim_tree_indent_markers        = 1   --0 by default, this option shows indent markers when folders are open
			--gl.nvim_tree_highlight_opened_files= 1   --0 by default, will enable folder and file icon highlight for opened files/directories.
			require'nvim-tree'.setup {
				renderer = {
					highlight_opened_files = "name"
				},
				actions = {
					open_file = {
						quit_on_open = true,
						resize_window = false,
						window_picker ={
							enable = false
						}
					},
				},
				respect_buf_cwd = false,

				disable_netrw       = true,
				hijack_netrw        = true,
				--open_on_setup       = false,
				--ignore_ft_on_setup  = {},
				--auto_close          = false,
				open_on_tab         = false,
				hijack_cursor       = false,
				update_cwd          = false,
				-- option was renamed
				--update_to_buf_dir   = {
				hijack_directories   = {
					enable = true,
					auto_open = true,
				},
				diagnostics = {
					enable = false,
					icons = {
						hint = "",
						info = "",
						warning = "",
						error = "",
					}
				},
				git = {
					enable = false,
				},
				update_focused_file = {
					enable      = true,
					update_cwd  = true, -- XXX(SLEE) Looks like this is what I want: if file is not an ancestor, then cwd to its parent
					ignore_list = {}
				},
				system_open = {
					cmd  = nil,
					args = {}
				},
				filters = {
					dotfiles = false,
					custom = {}
				},

				view = {
					width = 45,
					-- height = 30,
					hide_root_folder = false,
					side = 'left',
					--auto_resize = false,
					--[[mappings = {
						custom_only = false,
						list = {
							{ key = "-",     cb = ":lua require'nvim-tree'.on_keypress('dir_up')<CR>:lua require'nvim-tree'.on_keypress('refresh')<CR>" },
						}
					}--]]
				}
			}

			-- Note: global map
			keymap('n', '<leader>f',   ':NvimTreeFindFileToggle<CR>',      options)
		end
	}

	use {
			'nvim-treesitter/nvim-treesitter',
			-- commit='4cccb6f494eb255b32a290d37c35ca12584c74d0',
			-- commit='239bb86b54d07a955caa0200053484298879ca59',
			run = ':TSUpdate',
			config = function()
				require'nvim-treesitter.configs'.setup {
					highlight = {
						enable  = {"c", "cpp", "python", "javascript", "lua", "rust"}, -- enable = true (false will disable the whole extension)
						custom_captures = {
						-- Highlight the @foo.bar capture group with the "Identifier" highlight group.
							-- ["foo.bar"] = "Identifier",
							["type.qualifier.cpp"] = "Keyword", -- THIS IS BROKEN v0.10
							["type.cpp"] = "TSType",
							["type.builtin.cpp"] = "TSType",
							["storageclass.cpp"] = "Keyword",
							["storageclass"] = "Keyword",
						},
						-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
						-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
						-- Using this option may slow down your editor, and you may see some duplicate highlights.
						-- Instead of true it can also be a list of languages
						additional_vim_regex_highlighting = false,
					},
				}
			end
	}

	use { -- Smart and powerful comment plugin for neovim. Supports commentstring, dot repeat, left-right/up-down motions, hooks, and more
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
	}

	use {
			'folke/trouble.nvim',
			config = function()
					require("trouble").setup {
						position    = "bottom", -- position of the list can be: bottom, top, left, right
						height      = 7, -- height of the trouble list when position is top or bottom
						width       = 50, -- width of the list when position is left or right
						icons       = true, -- use devicons for filenames
						mode        = "workspace_diagnostics", -- lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
						fold_open   = "", -- icon used for open folds
						fold_closed = "", -- icon used for closed folds
					--[[
						action_keys = { -- key mappings for actions in the trouble list
							-- map to {} to remove a mapping, for example:
							-- close = {},
							close           = "q", -- close the list
							cancel          = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
							refresh         = "r", -- manually refresh
							jump            = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
							open_split      = { "<c-x>" }, -- open buffer in new split
							open_vsplit     = { "<c-v>" }, -- open buffer in new vsplit
							open_tab        = { "<c-t>" }, -- open buffer in new tab
							jump_close      = {"o"}, -- jump to the diagnostic and close the list
							toggle_mode     = "m", -- toggle between "workspace" and "document" diagnostics mode
							toggle_preview  = "P", -- toggle auto_preview
							hover           = "K", -- opens a small poup with the full multiline message
							preview         = "p", -- preview the diagnostic location
							close_folds     = {"zM", "zm"}, -- close all folds
							open_folds      = {"zR", "zr"}, -- open all folds
							toggle_fold     = {"zA", "za"}, -- toggle fold of current file
							previous        = "k", -- preview item
							next            = "j" -- next item
						},
					]]
						indent_lines    = true, -- add an indent guide below the fold icons
						auto_open       = false, -- automatically open the list when you have diagnostics
						auto_close      = true, -- automatically close the list when you have no diagnostics
						auto_preview    = false, -- automatyically preview the location of the diagnostic. <esc> to close preview and go back to last window
						auto_fold       = false, -- automatically fold a file trouble list at creation
						signs = {
							-- icons / text used for a diagnostic
							error       = "",
							warning     = "",
							hint        = "",
							information = "",
							other       = "﫠"
						},
						use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
					}
			end
	}

	--[[
	use { --  Use treesitter to auto close and auto rename html tag, work with html,tsx,vue,svelte,php.
			"windwp/nvim-ts-autotag",
			requires = {
				{'nvim-treesitter/nvim-treesitter'},
			},
			config = function()
				require('nvim-ts-autotag').setup({
					filetypes = { 'html', 'javascript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue' },
				})
			end
	}
	--]]

	-- Usage:
	--       TodoQuickFix
	--       TodoLocList
	--       TodoTrouble
	--       TodoTelescope
	use {
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup {
			}
		end
	}


	use {
		'stevearc/aerial.nvim',
		config = function() require('aerial').setup {
			vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
		}
		end
	}

	use {
		'dcampos/nvim-snippy',
		event = 'InsertEnter',
		requires = {
			{'honza/vim-snippets', before='nvim-snippy'}
		},

		config = function() require('snippy').setup {
			mappings = {
				is = {
					['<Tab>'] = 'expand_or_advance',
					['<S-Tab>'] = 'previous',
					-- ['<C-g>'] = 'expand_or_advance',
					-- ['<C-r>'] = 'previous',
				},
				nx = {
					['<leader>x'] = 'cut_text',
				},
			},
		}
		end

	}

	use {
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		requires = {
			{ 'hrsh7th/cmp-nvim-lsp', after='nvim-cmp'}, -- nvim-cmp source for neovim builtin LSP client
			{ 'hrsh7th/cmp-nvim-lua', after='nvim-cmp'}, -- nvim-cmp source for nvim lua
			{ 'hrsh7th/cmp-buffer', after='nvim-cmp'}, -- nvim-cmp source for buffer words.
			{ 'hrsh7th/cmp-path', after='nvim-cmp'}, -- nvim-cmp source for filesystem paths.
			-- { 'saadparwaiz1/cmp_luasnip', after='nvim-cmp'}, -- luasnip completion source for nvim-cmp
		},

		-- Here I disable the annoying autocomplete and you must type C-j to enter complete mode.
		config = function()
			local cmp = require('cmp')
			cmp.setup {
				completion = {autocomplete=false},
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
						require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},

				formatting = {
					fields = {'menu', 'abbr', 'kind'},
					format = function(entry, item)
						local menu_icon = {
							nvim_lsp = 'λ',
							luasnip = '⋗',
							snippy = '⋗',
							buffer = 'Ω',
							path = '/',
						}

						item.menu = menu_icon[entry.source.name]
						return item
					end,
				},

				window = {
				-- completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered(),
				},
				-- mapping = cmp.mapping.preset.insert({
				mapping = {
					['<C-f>'] = cmp.mapping.scroll_docs(-4),
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					-- ['<C-Space>'] = cmp.mapping.complete({config={sources={{name='snippy'}}}}),
					['<C-Space>'] = cmp.mapping.complete(),
					-- Don't need this because it overrides C-n
					['<C-j>'] = function() if cmp.visible() then cmp.select_next_item() else cmp.complete() end end,
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					['<C-l>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				-- }),
				},
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					-- { name = 'vsnip' }, -- For vsnip users.
					-- { name = 'luasnip' }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					{ name = 'snippy' }, -- For snippy users.
					{ name = 'path' }, -- Show fs path
				}, {
					{ name = 'buffer' },
				})
			}
			-- Set configuration for specific filetype.
			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
				}, {
					{ name = 'buffer' },
				})
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
				{ name = 'buffer' }
				}
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
				{ name = 'path' }
				}, {
				{ name = 'cmdline' }
				})
			})

			-- Set up lspconfig.
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
			-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup { capabilities = capabilities }
			-- FIXME: This is a little incorrect, because we call the setup() in mason. How to just update capabilityies?
			-- require('lspconfig')['clangd'].setup { capabilities = capabilities }
		end
	}

	use { --  Add/change/delete surrounding delimiter pairs with ease.
		'kylechui/nvim-surround',
		-- event = 'InsertEnter',
		keys = {'c'},
		-- config = [[ require('plugins/nvim-surround') ]]
		config = function() require('nvim-surround').setup {
		} end
	}


	if packer_bootstrap then
		require('packer').sync()
	end	
	setup_maps()
	setup_config()
	setup_colors()
end, config = {
  -- Move to lua dir so impatient.nvim can cache it
  compile_path = vim.fn.stdpath('config')..'/plugin/packer_compiled.lua'
}}
