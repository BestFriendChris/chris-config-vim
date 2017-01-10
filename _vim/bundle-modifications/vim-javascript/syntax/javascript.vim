if exists('g:vim_javascript_loaded_before')
  finish
endif
let g:vim_javascript_loaded_before = 1

set foldmethod=syntax
set foldlevel=100
set conceallevel=1

hi Conceal NONE

let g:javascript_conceal_function       = "λ"
let g:javascript_conceal_null           = "ø"
let g:javascript_conceal_this           = "@"
let g:javascript_conceal_return         = "⇚"
let g:javascript_conceal_undefined      = "¿"
let g:javascript_conceal_NaN            = "ℕ"
let g:javascript_conceal_prototype      = "¶"
let g:javascript_conceal_static         = "•"
let g:javascript_conceal_super          = "Ω"
let g:javascript_conceal_arrow_function = "→"

augroup javascript_bfc
  autocmd!

  autocmd FileType javascript nnoremap <buffer> <Space> za
  autocmd FileType javascript nnoremap <buffer> <LocalLeader>c :let &conceallevel = !&conceallevel<CR>
augroup END
