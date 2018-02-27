if executable('ag') && exists('g:loaded_rails')
  augroup ag_bfc_rails
    autocmd!

    autocmd User Rails nnoremap <buffer> <LocalLeader>a* :Ag '\b<C-r><C-w>\b' app lib config spec
    autocmd User Rails nnoremap <buffer> <LocalLeader>a*a :Ag '\b<C-r><C-w>\b' app lib config
    autocmd User Rails nnoremap <buffer> <LocalLeader>a*s :Ag '\b<C-r><C-w>\b' spec

    autocmd User Rails nnoremap <buffer> <LocalLeader>aw :Ag <C-r><C-w> app lib config spec
    autocmd User Rails nnoremap <buffer> <LocalLeader>awa :Ag <C-r><C-w> app lib config
    autocmd User Rails nnoremap <buffer> <LocalLeader>aws :Ag <C-r><C-w> spec

    autocmd User Rails nnoremap <buffer> <LocalLeader>aW :Ag <C-r><C-a> app lib config spec
    autocmd User Rails nnoremap <buffer> <LocalLeader>aWa :Ag <C-r><C-a> app lib config
    autocmd User Rails nnoremap <buffer> <LocalLeader>aWs :Ag <C-r><C-a> spec

    autocmd User Rails vnoremap <buffer> <LocalLeader>aw y:Ag <C-r>" app lib config spec
    autocmd User Rails vnoremap <buffer> <LocalLeader>awa y:Ag <C-r>" app lib config
    autocmd User Rails vnoremap <buffer> <LocalLeader>aws y:Ag <C-r>" spec
  augroup END
endif
