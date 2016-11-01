if !exists('g:loaded_youcompleteme') || exists('g:youcompleteme_disabled')
  finish
endif

if !exists('g:ycm_filetype_whitelist')
  let g:ycm_filetype_whitelist = {}
endif

" Each plugin needs to opt in itself
silent! unlet! g:ycm_filetype_whitelist['*']
