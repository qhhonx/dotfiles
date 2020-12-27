"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => my_configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

source ~/.vim_runtime/my_configs/vim-plug.vim
source ~/.vim_runtime/my_configs/coc.vim
source ~/.vim_runtime/my_configs/nerdtree.vim

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
