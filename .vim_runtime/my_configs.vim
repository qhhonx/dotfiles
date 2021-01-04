""""""""""""""""""""""""""""""
" => Load pathogen paths
""""""""""""""""""""""""""""""
let s:vim_runtime = expand('<sfile>:p:h')
call pathogen#infect(s:vim_runtime.'/my_plugins/{}')
call pathogen#helptags()

""""""""""""""""""""""""""""""
" => Load vim-plug
""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" Plug 'joshdick/onedark.vim'
" Plug 'rakr/vim-one'
Plug 'PhilRunninger/nerdtree-visual-selection'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'

Plug 'ryanoasis/vim-devicons'

" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => my_configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function to source only if file exists
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

" Function to source all .vim files in directory
function! SourceDirectory(file)
  for s:fpath in split(globpath(a:file, '*.vim'), '\n')
    call SourceIfExists(s:fpath)
  endfor
endfunction

call SourceDirectory('~/.vim_runtime/inspired')
call SourceDirectory('~/.vim_runtime/my_configs')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" scroll toward left
map <F7> 10zh
imap <F7> <ESC>10zhi

" scroll toward right
map <F8> 10zl
imap <F8> <ESC>10zli

" display line number
set number

" no word wrap
set nowrap

" no need show Insert/Replace/Visual mode
set noshowmode

" go to tab by number
nnoremap <leader>2 2gt
nnoremap <leader>1 1gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<cr>

" reserve space key
nunmap <space>
