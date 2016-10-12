if executable('ag')
  set grepprg=ag\ --vimgrep
  set grepformat=%f:%l:%c:%m

  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nmap <Leader>aa :Ag<Space>
  nmap <Leader>aw :Ag <C-r><C-w><Space>
endif
