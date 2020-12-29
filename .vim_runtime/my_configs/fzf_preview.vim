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

" Select project files
nnoremap <silent><nowait> <leader>ff  :<C-u>CocCommand fzf-preview.ProjectFiles<CR>

" Select file from directory files (default to current working directory)
nnoremap <silent><nowait> <leader>fd  :<C-u>CocCommand fzf-preview.DirectoryFiles<Space>

" Select file from git ls-files
nnoremap <silent><nowait> <leader>fg  :<C-u>CocCommand fzf-preview.GitFiles<CR>

" Grep project files from args word
nnoremap <silent><nowait> <leader>fr  :<C-u>CocCommand fzf-preview.ProjectGrep<Space>

" Select references from coc.nvim (only coc extensions)
nnoremap <silent><nowait> <leader>fcr  :<C-u>CocCommand fzf-preview.CocReferences<CR>

" Select diagnostics from coc.nvim (only coc extensions)
nnoremap <silent><nowait> <leader>fca  :<C-u>CocCommand fzf-preview.CocDiagnostics<CR>

" Select type definitions from coc.nvim (only coc extensions)
nnoremap <silent><nowait> <leader>fcy  :<C-u>CocCommand fzf-preview.CocTypeDefinitions<CR>

