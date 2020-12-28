" https://github.com/yuki-ycino/fzf-preview.vim#others
" How to use fish user?
set shell=/bin/bash
let $SHELL = "/bin/bash"

" Commands used to get the file list from project
" - follow symbolic links
" - search hidden files and directories
" - respect .(git|fd)ignore files, exclude .git and .gitmodules
let g:fzf_preview_filelist_command = "fd --follow --hidden --exclude .git $(git submodule | awk '{print '--exclude ' $2}')"

" Commands used to get the file list from current directory
let g:fzf_preview_directory_files_command = "fd --follow --hidden --exclude .git $(git submodule | awk '{print '--exclude ' $2}')"

" Select project files
nnoremap <silent><nowait> <space>f  :<C-u>CocCommand fzf-preview.ProjectFiles<CR>

" Select file from directory files (default to current working directory)
nnoremap <silent><nowait> <space>fd  :<C-u>CocCommand fzf-preview.DirectoryFiles<Space>

" Select file from git ls-files
nnoremap <silent><nowait> <space>fg  :<C-u>CocCommand fzf-preview.GitFiles<CR>

" Grep project files from args word
nnoremap <silent><nowait> <space>ff :<C-u>CocCommand fzf-preview.ProjectGrep<Space>

" Select references from coc.nvim (only coc extensions)
nnoremap <silent><nowait> <space>fcr  :<C-u>CocCommand fzf-preview.CocReferences<CR>

" Select diagnostics from coc.nvim (only coc extensions)
nnoremap <silent><nowait> <space>fca  :<C-u>CocCommand fzf-preview.CocDiagnostics<CR>

" Select type definitions from coc.nvim (only coc extensions)
nnoremap <silent><nowait> <space>fcy  :<C-u>CocCommand fzf-preview.CocTypeDefinitions<CR>

