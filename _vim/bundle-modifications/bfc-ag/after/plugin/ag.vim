if executable('ag') && exists('g:loaded_rails')
  augroup ag_bfc_rails
    autocmd!
    autocmd User Rails nnoremap <buffer> <LocalLeader>aa :Ag<Space><Space>app lib spec
    autocmd User Rails nnoremap <buffer> <LocalLeader>aaa :Ag<Space><Space>app lib
    autocmd User Rails nnoremap <buffer> <LocalLeader>aas :Ag<Space><Space>spec

    autocmd User Rails nnoremap <buffer> <LocalLeader>aw :Ag <C-r><C-w> app lib spec
    autocmd User Rails nnoremap <buffer> <LocalLeader>awa :Ag <C-r><C-w> app lib
    autocmd User Rails nnoremap <buffer> <LocalLeader>aws :Ag <C-r><C-w> spec

    autocmd User Rails nnoremap <buffer> <LocalLeader>aW :Ag <C-r><C-a> app lib spec
    autocmd User Rails nnoremap <buffer> <LocalLeader>aWa :Ag <C-r><C-a> app lib
    autocmd User Rails nnoremap <buffer> <LocalLeader>aWs :Ag <C-r><C-a> spec

    autocmd User Rails vnoremap <buffer> <LocalLeader>aw y:Ag <C-r>" app lib spec
    autocmd User Rails vnoremap <buffer> <LocalLeader>awa y:Ag <C-r>" app lib
    autocmd User Rails vnoremap <buffer> <LocalLeader>aws y:Ag <C-r>" spec
  augroup END
endif
