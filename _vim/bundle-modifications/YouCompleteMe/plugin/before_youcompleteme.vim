let s:save_cpo = &cpo
set cpo&vim

" Initially disable YouCompleteMe
let g:loaded_youcompleteme = 1
let g:youcompleteme_disabled = 1

augroup youcompleteme_bfc
  autocmd!
  autocmd User EnableYouCompleteMe unlet g:loaded_youcompleteme
                               \ | unlet g:youcompleteme_disabled
                               \ | runtime! plugin/youcompleteme.vim
                               \ | execute 'augroup youcompleteme_bfc | autocmd! | augroup END | augroup! youcompleteme_bfc'
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
