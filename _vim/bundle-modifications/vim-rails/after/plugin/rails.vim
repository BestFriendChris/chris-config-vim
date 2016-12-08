if exists('g:loaded_rails')
  augroup bfc_rails_search
    autocmd!
    " Support `foo?` and `@bar` keyword styles
    autocmd User Rails setlocal iskeyword+=?,@-@

    " Search for instance variable
    autocmd User Rails nnoremap <buffer> <LocalLeader>si /@\<<C-R><C-W>\><CR>

    " Search for getter usage (ignoring instance variables)
    autocmd User Rails nnoremap <buffer> <LocalLeader>sg /@\@1<!\<<C-R><C-W>\><CR>

    " Search for setter usage (ignoring instance variables)
    autocmd User Rails nnoremap <buffer> <LocalLeader>ss /@\@1<!\<<C-R><C-W>\>\( *\(\|\|\)\?=\)\@=<CR>
  augroup END
endif
