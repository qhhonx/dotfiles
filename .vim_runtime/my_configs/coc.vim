"You can also use g:coc_global_extensions in vimrc to make coc.nvim install extensions for you when extension not found.
let g:coc_global_extensions=
  \ [
    \ 'coc-rust-analyzer',
    \ 'coc-json',
    \ 'coc-vimlsp',
    \ 'coc-fzf-preview',
    \ 'coc-go',
  \ ]

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use <C-k> to trigger completion.
inoremap <silent><expr> <C-k> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent><nowait> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

noremap [coc-p] <Nop>
nmap <Leader>c [coc-p]
xmap <Leader>c [coc-p]

nmap     <nowait> <silent> [coc-p]c  <Plug>(coc-codeaction-selected)j
nmap     <nowait> <silent> [coc-p]f  <Plug>(coc-fix-current)
nmap     <nowait> <silent> [coc-p]l  <Plug>(coc-codeaction-line)
nmap     <nowait> <silent> [coc-p]r  <Plug>(coc-rename)
xmap     <nowait> <silent> [coc-p]c  <Plug>(coc-codeaction-selected)

nnoremap <nowait> <silent> [coc-p]a  :<C-u>CocList diagnostics<cr>
nnoremap <nowait> <silent> [coc-p]m  :<C-u>CocList commands<cr>
nnoremap <nowait> <silent> [coc-p]e  :<C-u>CocList extensions<cr>
nnoremap <nowait> <silent> [coc-p]j  :<C-u>CocNext<CR>
nnoremap <nowait> <silent> [coc-p]k  :<C-u>CocPrev<CR>
nnoremap <nowait> <silent> [coc-p]o  :<C-u>CocList outline<cr>
nnoremap <nowait> <silent> [coc-p]p  :<C-u>CocListResume<CR>
nnoremap <nowait> <silent> [coc-p]s  :<C-u>CocList -I symbols<cr>

