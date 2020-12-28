" Select project files
nnoremap <silent><nowait> <space>f  :<C-u>CocCommand fzf-preview.ProjectFiles<CR>
nnoremap <silent><nowait> <space>g  :<C-u>CocCommand fzf-preview.ProjectGrep --add-fzf-arg=--nth=3<Space>
nnoremap <silent><nowait> <space>G  :<C-u>CocCommand fzf-preview.ProjectGrep --resume<Space>

