if !exists(':Tagbar')
  finish
endif

let g:tagbar_left = 1
let g:tagbar_show_linenumbers = -1

nmap <silent> <LocalLeader>t :TagbarOpenAutoClose<CR>
