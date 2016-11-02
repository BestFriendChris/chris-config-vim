let g:vo_modules_load = "checkbox"
let g:vo_modules_load .= ':smart_paste'
setlocal foldcolumn=5

" Using the localColorScheme plugin
let b:colors_name='vo_dark'

" Tab Indentation
vnoremap <buffer> <Tab> >
vnoremap <buffer> <S-Tab> <
nnoremap <buffer> <Tab> mp>>`pl
nnoremap <buffer> <S-Tab> mp<<`ph
inoremap <buffer> <Tab> <C-T>
inoremap <buffer> <S-Tab> <C-D>

" Simplified checkbox mappings
if !exists('b:percentage')
  let b:percentage=0
endif
nmap <buffer> <LocalLeader>x <LocalLeader>cx
nmap <silent> <buffer> <LocalLeader>p :let b:percentage = ( b:percentage ? 0 : 1 )<CR>:let b:percentage<CR>

function! s:MaybeCBText()
  return '[_] ' . (b:percentage ? '% ' : '')
endfunction

nnoremap <buffer> <LocalLeader>O        O<C-r>=<SID>MaybeCBText()<CR>
nnoremap <buffer> <LocalLeader>o        o<C-r>=<SID>MaybeCBText()<CR>
nnoremap <buffer> <LocalLeader><Return> o<C-r>=<SID>MaybeCBText()<CR>
inoremap <buffer> <LocalLeader><Return> <Return><C-r>=<SID>MaybeCBText()<CR>

" These mappings are overridding my mappings. :-(
unmap <buffer>   <C-K>
unmap <buffer>   <C-N>

" vim:ft=vim
