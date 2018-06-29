" SqlPipe
"
"--------------------------------------------------------------------------------
" Script to pipe the current sql script into a command and show it in a
" scratch buffer
"
"--------------------------------------------------------------------------------
"
" Default mapping applied to both 'sql' files and output buffer:
"   map <buffer><silent> <LocalLeader>r <Plug>(sqlpipe-run)
"
" To override mappings, define a function like the following:
"   function! SqlPipe_override_mapping()
"     map <buffer><silent> <Leader>sr <Plug>(sqlpipe-run)
"   endfunction

function! s:CopyToTempFile(temp_file)
  let l:save_modified=&modified
  silent execute 'write! '.a:temp_file
  let &modified=l:save_modified
endfunction

function! s:LoadCmd()
  let l:first_line = getline(1)
  if matchstrpos(l:first_line, '^--SQLPIPE:')[1] == 0
    " if the first line starts with '--SQLPIPE:', strip it out and save
    let b:SqlPipe__cmd = substitute(l:first_line, '^--SQLPIPE:', '', '')
  else
    if exists("b:SqlPipe__cmd")
      unlet b:SqlPipe__cmd
    endif
  endif
endfunction

function! s:EnsureSqlOutputWindowOpen()
  if !exists("b:SqlPipe__output_window_name")
    let b:SqlPipe__output_window_name="Sql Output - ".expand("%")
  endif

  if !bufexists(b:SqlPipe__output_window_name)
    let l:sql_buffer_nr = bufnr("%")
    new
    let b:SqlPipe__output_window_name=getbufvar(l:sql_buffer_nr, "SqlPipe__output_window_name")
    let b:SqlPipe__sql_winid=getbufvar(l:sql_buffer_nr, "SqlPipe__sql_winid")
    let b:SqlPipe__sql_buffer_nr=l:sql_buffer_nr
    let b:SqlPipe__is_output=1
    call setbufvar(l:sql_buffer_nr, 'SqlPipe__output_window_nr', win_getid(winnr()))

    setlocal buftype=nofile bufhidden=hide noswapfile
    silent execute "file ".b:SqlPipe__output_window_name
    call s:SetupMappings()
    call win_gotoid(b:SqlPipe__sql_winid)
  endif
endfunction

function! s:EnsureOnSqlFile()
  if exists('b:SqlPipe__is_output')
    call win_gotoid(b:SqlPipe__sql_winid)
  endif
endfunction

function! s:EnsureOnOutputScratch()
  if !bufexists(b:SqlPipe__output_window_name)
    call EnsureSqlOutputWindowOpen()
  endif
  if exists('b:SqlPipe__output_window_nr')
    call win_gotoid(b:SqlPipe__output_window_nr)
  endif
endfunction

function! s:RunFromFile(temp_file)
  call s:EnsureOnOutputScratch()
  let l:winview = winsaveview()
  let l:cmd = getbufvar(b:SqlPipe__sql_buffer_nr, 'SqlPipe__cmd')

  echo "Refreshing..."
  silent execute "%d | call append(0, 'Reloaded at '.strftime('%Y-%m-%d %T'))"
  silent execute "call append(1, '--------------------------------------------------------------------------------')"
  silent execute "$read ! cat ".a:temp_file." | ".l:cmd

  call winrestview(l:winview)
endfunction

function! s:Run()
  let l:current_nr = win_getid(winnr())
  let l:winview = winsaveview()

  call s:EnsureOnSqlFile()

  call s:LoadCmd()

  if !exists("b:SqlPipe__cmd")
    if !exists("b:SqlPipe__helped")
      call append(0, "-- To use SqlPipe, add the psql command to pipe your sql into as the first line:")
      call append(1, "--SQLPIPE: psql -d database")
      let b:SqlPipe__helped = 1
    else
      echo "Add SQLPIPE command to first line to use"
    endif
  else
    if exists("b:SqlPipe__helped")
      unlet b:SqlPipe__helped
    endif

    call s:EnsureSqlOutputWindowOpen()
    call s:CopyToTempFile(b:SqlPipe__temp_file)
    call s:RunFromFile(b:SqlPipe__temp_file)
  endif

  call win_gotoid(l:current_nr)
  call winrestview(l:winview)
endfunction

function! s:SetupMappings()
  noremap <buffer><silent> <Plug>(sqlpipe-run) :<C-u>call <SID>Run()<CR>

  if exists('*SqlPipe_override_mapping')
    call SqlPipe_override_mapping()
  else
    map <buffer><silent> <LocalLeader>r <Plug>(sqlpipe-run)
  endif
endfunction

function! s:Initialize()
  let b:SqlPipe__temp_file=tempname()
  let b:SqlPipe__sql_winid=win_getid(winnr())

  call s:SetupMappings()
endfunction

augroup bfc_sqlpipe
  autocmd!

  autocmd FileType sql execute s:Initialize()
augroup END
