if !exists('g:loaded_elm')
  finish
endif

" Add elm to YouCompleteMe's whitelist
if exists('g:ycm_filetype_whitelist')
  let g:ycm_filetype_whitelist.elm = 1
endif

augroup elm_bfc
  autocmd!
  if exists('g:loaded_syntastic_plugin')
    autocmd FileType elm let b:syntastic_check_on_wq = 0
                     \ | let b:elm_syntastic_show_warnings = 1
  endif
  if executable('elm-format')
    autocmd FileType elm nmap <buffer> <silent> <LocalLeader>f :<C-u>ElmFormat<CR>
  endif
  autocmd FileType elm let b:ycm_semantic_triggers = { 'elm' : ['.'] }
                   \ | setlocal shiftwidth=4 softtabstop=4
                   \ | silent! doauto User EnableYouCompleteMe
augroup END

let g:elm_jump_to_error = 1
let g:elm_make_show_warnings = 1
let g:elm_detailed_complete = 1
let g:elm_format_autosave = 1
let g:elm_format_fail_silently = 1
