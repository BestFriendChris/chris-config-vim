if !exists('g:loaded_tsuquyomi')
  finish
endif

if exists('g:loaded_tsuquyomi_bfc')
  finish
endif

let g:loaded_tsuquyomi_bfc = 1

" Use syntastic if loaded
if exists('g:loaded_syntastic_plugin')
  let g:tsuquyomi_disable_quickfix = 1
  let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.
endif

" Add typescript to YouCompleteMe's whitelist
if exists('g:ycm_filetype_whitelist')
  let g:ycm_filetype_whitelist.typescript = 1
endif

augroup tsuquyomi_bfc
  autocmd!
  autocmd FileType typescript nmap <buffer> <silent> <LocalLeader>t : <C-u>echo tsuquyomi#hint()<CR>
  autocmd FileType typescript let b:syntastic_check_on_wq = 0
  autocmd FileType typescript let b:syntastic_always_populate_loc_list = 1
augroup END

let g:tsuquyomi_definition_split = 3 " TsuDefinition calls open in a new tab

