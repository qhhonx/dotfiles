" https://github.com/yuki-ycino/fzf-preview.vim#others
" How to use fish user?
set shell=/bin/bash
let $SHELL = "/bin/bash"
let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'TwoDark'

" Use true color preview in Neovim
" Set the preview command to COLORTERM=truecolor
augroup fzf_preview
  autocmd!
  autocmd User fzf_preview#initialized call s:fzf_preview_settings()
augroup END

function! s:fzf_preview_settings() abort
  let g:fzf_preview_command = 'COLORTERM=truecolor ' . g:fzf_preview_command
  let g:fzf_preview_grep_preview_cmd = 'COLORTERM=truecolor ' . g:fzf_preview_grep_preview_cmd
endfunction

" Commands used to get the file list from project
" - follow symbolic links
" - search hidden files and directories
" - respect .(git|fd)ignore files, exclude .git and .gitmodules
let g:fzf_preview_filelist_command = "fd --follow --hidden --exclude .git"

" Commands used to get the file list from current directory
let g:fzf_preview_directory_files_command = "fd --follow --hidden --exclude .git"

" Keyboard shortcuts while fzf preview is active
let g:fzf_preview_preview_key_bindings = 'ctrl-d:preview-page-down,ctrl-u:preview-page-up,?:toggle-preview'

noremap [fzf-p] <Nop>
nmap <Leader>f [fzf-p]
xmap <Leader>f [fzf-p]

nnoremap <silent> [fzf-p]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> [fzf-p]t     :<C-u>CocCommand fzf-preview.BufferTags<CR>
nnoremap <silent> [fzf-p]b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <silent> [fzf-p]ca    :<C-u>CocCommand fzf-preview.CocDiagnostics<CR>
nnoremap <silent> [fzf-p]cr    :<C-u>CocCommand fzf-preview.CocReferences<CR>
nnoremap <silent> [fzf-p]cy    :<C-u>CocCommand fzf-preview.CocTypeDefinitions<CR>
nnoremap <silent> [fzf-p]d     :<C-u>CocCommand fzf-preview.DirectoryFiles<Space>
nnoremap <silent> [fzf-p]o     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]p     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [fzf-p]gf    :<C-u>CocCommand fzf-preview.GitFiles<CR>
nnoremap <silent> [fzf-p]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [fzf-p]j     :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> [fzf-p]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap <silent> [fzf-p]l     :<C-u>CocCommand fzf-preview.LocationList<CR>
nnoremap <silent> [fzf-p]f     :<C-u>CocCommand fzf-preview.ProjectFiles<CR>
nnoremap          [fzf-p]gr    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
