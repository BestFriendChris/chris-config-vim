if executable('ripper-tags')
  " MacVim has issues with zsh and bundler. Simple fix is to just change the
  " shell to bash
  if &shell =~? 'zsh'
    set shell=bash
  endif

  let g:Tlist_Ctags_Cmd = 'ripper-tags'
  let g:rails_ctags_arguments = ''
endif
