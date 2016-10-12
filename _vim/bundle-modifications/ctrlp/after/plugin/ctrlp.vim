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

if exists('g:loaded_rails')
  augroup ctrlp_bfc
    autocmd!
    autocmd User Rails map <buffer> <Leader>ga :CtrlP app<CR>
    autocmd User Rails map <buffer> <Leader>gv :CtrlP app/views<CR>
    autocmd User Rails map <buffer> <Leader>gc :CtrlP app/controllers<CR>
    autocmd User Rails map <buffer> <Leader>gm :CtrlP app/models<CR>
    autocmd User Rails map <buffer> <Leader>gj :CtrlP app/jobs<CR>
    autocmd User Rails map <buffer> <Leader>gl :CtrlP lib<CR>
    autocmd User Rails map <buffer> <Leader>gs :CtrlP spec<CR>
  augroup END
endif
