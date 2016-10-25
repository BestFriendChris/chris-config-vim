if !exists('g:loaded_ctrlp')
  finish
end

let g:ctrlp_open_new_file = 't'
let g:ctrlp_open_multiple_files = 't'
let g:ctrlp_arg_map = 1
let g:ctrlp_mruf_relative = 1
let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/]node_modules$'
      \ }

nnoremap <Leader>gb :CtrlPBuffer<CR>
nnoremap <Leader>gg :CtrlPMixed<CR>
nnoremap <Leader>gl :CtrlPLine<CR>
nnoremap <Leader>gm :CtrlPMRU<CR>
nnoremap <Leader>gq :CtrlPQuickfix<CR>

if exists('g:loaded_rails')
  augroup ctrlp_bfc_rails
    autocmd!
    autocmd User Rails map <buffer> <LocalLeader>ra :CtrlP app<CR>
    autocmd User Rails map <buffer> <LocalLeader>rv :CtrlP app/views<CR>
    autocmd User Rails map <buffer> <LocalLeader>rc :CtrlP app/controllers<CR>
    autocmd User Rails map <buffer> <LocalLeader>rm :CtrlP app/models<CR>
    autocmd User Rails map <buffer> <LocalLeader>rj :CtrlP app/jobs<CR>
    autocmd User Rails map <buffer> <LocalLeader>rl :CtrlP lib<CR>
    autocmd User Rails map <buffer> <LocalLeader>rs :CtrlP spec<CR>
  augroup END
endif
