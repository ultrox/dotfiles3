let mapleader =" "
filetype plugin on
syntax enable
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'
Plug 'mhinz/vim-signify'

Plug 'tpope/vim-fugitive'

call plug#end()

