if !exists("g:loaded_unimpaired")
  finish
endif

if exists("g:loaded_unimpaired_bfc")
  finish
endif

let g:loaded_unimpaired_bfc = 1

function! s:MapNextFamilyClose(map,cmd)
  let map = '<Plug>unimpaired'.toupper(a:map)
  let cmd = '".(v:count ? v:count : "")."'.a:cmd
  let end = '"<CR>'.(a:cmd == 'l' || a:cmd == 'c' ? 'zv' : '')
  execute 'nnoremap <silent> '.map.'Open     :<C-U>exe "'.cmd.'open'.end
  execute 'nnoremap <silent> '.map.'Close    :<C-U>exe "'.cmd.'close'.end

  execute 'nmap <silent> ]['.a:map .' '.map.'Open'
  execute 'nmap <silent> []'.a:map .' '.map.'Close'
endfunction

call s:MapNextFamilyClose('q', 'c')
call s:MapNextFamilyClose('l', 'l')
