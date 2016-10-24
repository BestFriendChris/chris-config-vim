nnoremap <leader>gr :set operatorfunc=<SID>GrepOperator<CR>g@
vnoremap <leader>gr :<C-u>call <SID>GrepOperator(visualmode())<CR>

function! s:GrepOperator(type)
  let saved_unamed_register = @@

  if a:type ==# 'v'
    execute "normal! `<v`>y"
  elseif a:type ==# 'char'
    execute "normal! `[v`]y"
  else
    return
  end

  silent execute "grep! " . substitute(shellescape(@@), '\(#\|%\)', '\\\1', 'g')
  cwindow

  let @@ = saved_unamed_register
endfunction
