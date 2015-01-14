set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.nvim/bundle/Vundle.vim
call vundle#begin()
"call vundle#begin('~/some/path/here')

Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'file:///home/gmarik/path/to/plugin'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

Plugin 'scrooloose/nerdtree.git'

" Support bundles
Bundle 'jgdavey/tslime.vim'
Bundle 'Shougo/vimproc.vim'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/syntastic'
Bundle 'moll/vim-bbye'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'vim-scripts/gitignore'

" Git
Bundle 'tpope/vim-fugitive'
Bundle 'int3/vim-extradite'

" Bars, panels, and files
Bundle 'scrooloose/nerdtree'
Bundle 'bling/vim-airline'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'

" Text manipulation
Bundle 'vim-scripts/Align'
Bundle 'vim-scripts/Gundo'
Bundle 'tpope/vim-commentary'
Bundle 'godlygeek/tabular'
Bundle 'michaeljsmith/vim-indent-object'

" Allow pane movement to jump out of vim into tmux
Bundle 'christoomey/vim-tmux-navigator'

" All of your Plugins must be added before the following line
call vundle#end()            " required

set mouse=a
set ttymouse=xterm2

filetype plugin indent on    " required
