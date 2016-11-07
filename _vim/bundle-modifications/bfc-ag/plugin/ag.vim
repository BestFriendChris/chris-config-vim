if executable('ag')
  set grepprg=ag\ --vimgrep
  set grepformat=%f:%l:%c:%m

  command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap <Leader>aa :Ag<Space>
  nnoremap <Leader>aw :Ag <C-r><C-w><Space>
  nnoremap <Leader>aW :Ag <C-r><C-a><Space>
  vnoremap <Leader>aw y:Ag <C-r>"<Space>
endif
