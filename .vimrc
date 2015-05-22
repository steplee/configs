set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

""""""""""""""""""""""""""""""""""""""""
"" Stephen Custom

Bundle 'scrooloose/syntastic'
Bundle 'flazz/vim-colorschemes'
Bundle 'travitch/hasksyn'
Bundle 'xolox/vim-session'
Bundle 'xolox/vim-misc'
Bundle 'tpope/vim-surround'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'airblade/vim-gitgutter'
Bundle 'morhetz/gruvbox'

Bundle 'Valloric/YouCompleteMe'

""
""""""""""""""""""""""""""""""""""""""""

" Bars, panels, and files
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'bling/vim-airline'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'

" Text manipulation
Bundle 'vim-scripts/Align'
Bundle 'vim-scripts/Gundo'
Bundle 'tpope/vim-commentary'
Bundle 'godlygeek/tabular'
Bundle 'michaeljsmith/vim-indent-object'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on


colorscheme wombat256mod


set syntax=on
syntax on
syntax enable
" lines to cursor (prevents scrolling)
set so=17
set ruler
set number
set wildmenu
set wildmode=list:longest,full
set cmdheight=1
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase

set foldmethod=indent
set foldnestmax=5
set foldlevelstart=99
set foldcolumn=0
let mapleader = ","
let g:mapleader = ","
set tm=2000
noremap ,, ,
set formatprg="PARINIT='rTbgqR B=.,?_A_a Q=_s>|' par\ -w72"
set autoread
set history=700
set formatoptions-=cro
let g:session_autosave = 'no'
let g:session_autoload = 'no'

set cmdheight=1
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set mat=2
set noerrorbells
set vb t_vb=
if &term =~ '256color'
  set t_ut=
endif
map <silent> <leader>r :redraw!<CR>
nnoremap <leader>ma :set mouse=a<cr>
nnoremap <leader>mo :set mouse=<cr>
set mouse=a

" keyboard shortcuts
let mapleader = ','
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <leader>l :Align
nnoremap <leader>a :Ag<space>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>d :NERDTreeTabsToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nnoremap <leader>] :TagbarToggle<CR>
nnoremap <leader><space> :call whitespace#strip_trailing()<CR>
nnoremap <leader>g :GitGutterToggle<CR>
noremap <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>


" Adjust signscolumn and syntastic to match wombat
hi! link SignColumn LineNr
hi! link SyntasticErrorSign ErrorMsg
hi! link SyntasticWarningSign WarningMsg


" Syntastic shit

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
