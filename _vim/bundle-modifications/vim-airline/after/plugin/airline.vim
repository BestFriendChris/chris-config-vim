if !exists('g:loaded_airline')
  finish
endif

set laststatus=2
set noshowmode
set ttimeoutlen=500

let g:airline_left_sep=''
let g:airline_right_sep=''

let g:airline_theme='murmur'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_close_button = 0

let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <silent> <Leader>1 <Plug>AirlineSelectTab1
nmap <silent> <Leader>2 <Plug>AirlineSelectTab2
nmap <silent> <Leader>3 <Plug>AirlineSelectTab3
nmap <silent> <Leader>4 <Plug>AirlineSelectTab4
nmap <silent> <Leader>5 <Plug>AirlineSelectTab5
nmap <silent> <Leader>6 <Plug>AirlineSelectTab6
nmap <silent> <Leader>7 <Plug>AirlineSelectTab7
nmap <silent> <Leader>8 <Plug>AirlineSelectTab8
nmap <silent> <Leader>9 <Plug>AirlineSelectTab9

function! s:prev_buffer_or_tab()
  if tabpagenr('$') == 1
    execute "normal \<Plug>AirlineSelectPrevTab"
  else
    normal gT
  endif
endfunction

function! s:next_buffer_or_tab()
  if tabpagenr('$') == 1
    execute "normal \<Plug>AirlineSelectNextTab"
  else
    normal gt
  endif
endfunction

map <silent> <C-H> :call <SID>prev_buffer_or_tab()<CR>
map <silent> <C-L> :call <SID>next_buffer_or_tab()<CR>
