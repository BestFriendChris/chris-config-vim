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
