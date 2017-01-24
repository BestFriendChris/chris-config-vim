augroup dutyl_bfc
  autocmd!
  if exists('g:loaded_syntastic_plugin')
    autocmd FileType d let b:syntastic_skip_checks = 1
  endif
augroup END
