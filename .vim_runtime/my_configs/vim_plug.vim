" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'

" Initialize plugin system
call plug#end()
