
" If in gvim and run-iterm-spec is installed, add some mappings
if has("gui_running")
  augroup iterm-rspec_bfc
    autocmd!

    if exists(":RunItermSpec")
      autocmd User Rails nmap <silent> <buffer> <D-R> :RunItermSpringSpec<CR>
    endif

    if exists(":RunItermSpecLine")
      autocmd User Rails nmap <silent> <buffer> <D-L> :RunItermSpringSpecLine<CR>
    endif

  augroup END
endif
