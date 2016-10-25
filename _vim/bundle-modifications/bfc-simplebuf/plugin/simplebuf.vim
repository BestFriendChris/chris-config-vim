if exists('g:loaded_simplebuf')
  finish
end

let g:loaded_simplebuf = 1

if !exists('g:simplebuf_version')
  let g:simplebuf_version = 1
endif

" Trying out different versions to see what I like the best
if g:simplebuf_version ==# 1
  noremap <Leader>be :<C-u>ls<CR>:buffer<Space>
  noremap <Leader>bs :<C-u>ls<CR>:sbuffer<Space>
  noremap <Leader>bt :<C-u>ls<CR>:tab sbuffer<Space>
elseif g:simplebuf_version ==# 2
  function! s:Log(hl, msg)
    execute 'echohl ' . a:hl
    echo a:msg
    echohl NONE
  endfunction

  function! s:Capture(excmd) abort
    try
      redir => out
      exe 'silent! '.a:excmd
    finally
      redir END
    endtry
    return out
  endfunction

  function! s:SelectBuffer(bang) abort
    let bufs = split(s:Capture('buffers' . a:bang), "\n")
    call inputsave()
    let choice = inputlist(bufs)
    call inputrestore()

    if choice <=# 0
      return -1
    endif

    call filter(bufs, 'v:val =~# "^ *\\<'. choice . '\\>"')
    if len(bufs) !=# 1
      call s:Log('ErrorMsg', "\nInvalid buffer number: " . choice)
      return s:SelectBuffer(a:bang)
    else
      return choice
    endif
  endfunction


  function! s:ChooseBuffer(bang, type) abort
    if a:type ==# 'window'
      let scr = 'buffer '
    elseif a:type ==# 'split'
      let scr = 'sbuffer '
    elseif a:type ==# 'tab'
      let scr = 'tab sbuffer '
    else
      call s:Log('ErrorMsg', "\nInvalid buffer edit type: " . a:type)
      return ''
    end

    call s:Log('WarningMsg', "Choose buffer to open in " . a:type)
    let choice = s:SelectBuffer(a:bang)
    if choice <=# 0
      return ''
    endif

    return scr . choice
  endfunction

  command! -bang -nargs=0 Bedit  execute s:ChooseBuffer("<bang>", 'window')
  command! -bang -nargs=0 BSedit execute s:ChooseBuffer("<bang>", 'split')
  command! -bang -nargs=0 BTedit execute s:ChooseBuffer("<bang>", 'tab')

  noremap <Plug>(EditBuffer)      :<C-u>Bedit<CR>
  noremap <Plug>(EditBufferSplit) :<C-u>BSedit<CR>
  noremap <Plug>(EditBufferTab)   :<C-u>BTedit<CR>

  map <Leader>be <Plug>(EditBuffer)
  map <Leader>bs <Plug>(EditBufferSplit)
  map <Leader>bt <Plug>(EditBufferTab)
"elseif g:simplebuf_version ==# 2
  "function! Testme()
  "  let bufs = s:Capture('buffers') . "\n:tab sbuffer "
  "  call inputsave()
  "  let choice = input(bufs, '', 'buffer')
  "  call inputrestore()
  "  echo "\nChoice is: " . choice
  "endfunction
endif
