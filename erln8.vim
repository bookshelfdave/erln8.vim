"function! Erln8DisplayList()
"  let cmd = 'erln8 --list'
"  let erlangs = split(system(cmd), '\n')
"  call append(0, erlangs)
"endfunction
"
"
"function! Erln8DisplayBuildable()
"  let cmd = 'erln8 --buildable'
"  let erlangs = split(system(cmd), '\n')
"  call append(0, erlangs)
"endfunction
"
"function! Erln8List()
"  let fn = "list.erln8"
"  if(bufexists(fn))
"    let e8win = bufwinnr(fn)
"    if(e8win == -1)
"      execute "sbuffer " . bufnr(fn)
"    else
"      execute e8win . 'wincmd w'
"      return
"    endif
"  else
"    execute "new list.erln8"
"  endif
"  call Erln8DisplayList()
"endfunction
"
"
"function! Erln8Buildable()
"  let fn = "buildable.erln8"
"  if(bufexists(fn))
"    let e8win = bufwinnr(fn)
"    if(e8win == -1)
"      execute "sbuffer " . bufnr(fn)
"    else
"      execute e8win . 'wincmd w'
"      return
"    endif
"  else
"    execute "new buildable.erln8"
"  endif
"  call Erln8DisplayBuildable()
"endfunction


"--------------

function! E8Current()
  let cmd = "erln8 --show"
  let currentErlang = split(system(cmd), '\n')
  echo currentErlang[0]
endfunction

function! E8List()
  let cmd = 'erln8 --list'
  let erlangs = split(system(cmd), '\n')
  let es = []
  for e in erlangs
    let chunks = split(e, " -> ")
    call insert(es, chunks[0])
  endfor
  let sortedEs = sort(es)
  return sortedEs
endfunction

function! E8ListFull()
  let cmd = 'erln8 --list'
  let erlangs = split(system(cmd), '\n')
  let sortedEs = sort(erlangs)
  return sortedEs
endfunction

function! E8Use(vsn, bang)
  if a:bang == "!"
   echo "Forcing " . a:vsn
   let cmd = "erln8 --no-color --use " . a:vsn . " --force"
   echom split(system(cmd), '\n')[0]
  else
   echo "Using " . a:vsn
   let cmd = "erln8 --no-color --use " . a:vsn
   echom split(system(cmd), '\n')[0]
  endif
endfunction

function! E8ListComplete(arg, line, pos)
  let erls = E8List()
  " return the entire list if no character specified
  if a:arg == ''
    return erls
  end

  let matches = []
  let thereg = '\' . a:arg . '\c'
  for erl in erls
    if matchstr(erl, thereg) != ''
      call insert(matches, erl)
    endif
  endfor
  return matches
endfunction

command! -bang -complete=customlist,E8ListComplete -nargs=* Erln8Use call E8Use( <q-args>, "<bang>" )
command! Erln8Current call E8Current()
