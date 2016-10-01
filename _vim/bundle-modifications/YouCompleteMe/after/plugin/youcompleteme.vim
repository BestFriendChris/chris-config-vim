if !exists('g:loaded_youcompleteme')
  finish
endif

if exists('g:loaded_youcompleteme_bfc')
  finish
endif
let g:loaded_youcompleteme_bfc = 1

" Each plugin needs to opt in itself
let g:ycm_filetype_whitelist = {}
