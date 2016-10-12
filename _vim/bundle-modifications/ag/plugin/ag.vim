if executable('ag')
  set grepprg=ag\ --vimgrep

  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
endif
