





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

set.conceallevel = 0 -- Don't hide e.g. Markdown brackets and such

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
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=200, on_visual=true}
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
