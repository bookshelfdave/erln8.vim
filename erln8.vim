function! Erln8DisplayList()
  let cmd = 'erln8 --list'
  let erlangs = split(system(cmd), '\n')
  call append(0, erlangs)
endfunction


function! Erln8DisplayBuildable()
  let cmd = 'erln8 --buildable'
  let erlangs = split(system(cmd), '\n')
  call append(0, erlangs)
endfunction

function! Erln8List()
  let fn = "list.erln8"
  if(bufexists(fn))
    let e8win = bufwinnr(fn)
    if(e8win == -1)
      execute "sbuffer " . bufnr(fn)
    echo "Foo2"
    else
      execute e8win . 'wincmd w'
    echo "Foo3"
      return
    endif
  else
    echo "Foo1"
    execute "new list.erln8"
  endif
  call Erln8DisplayList()
endfunction



function! Erln8Buildable()
  let fn = "buildable.erln8"
  if(bufexists(fn))
    let e8win = bufwinnr(fn)
    if(e8win == -1)
      execute "sbuffer " . bufnr(fn)
    echo "Foo2"
    else
      execute e8win . 'wincmd w'
    echo "Foo3"
      return
    endif
  else
    echo "Foo1"
    execute "new buildable.erln8"
  endif
  call Erln8DisplayBuildable()
endfunction

function! ErlnCurrent()
  let cmd = "erln8 --show"
  let currentErlang = split(system(cmd), '\n')
  echo currentErlang[0]
endfunction

