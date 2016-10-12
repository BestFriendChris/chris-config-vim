if executable('ag')
  set grepprg=ag\ --vimgrep

  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nmap <Leader>aa :Ag<Space>
  nmap <Leader>aw :Ag <C-r><C-w><Space>
endif
