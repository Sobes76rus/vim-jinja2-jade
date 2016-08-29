setlocal foldmethod=expr
setlocal foldexpr=GetJinaj2JadeFold(v:lnum)

function! GetJinja2JadeFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        return -1
    endif

    return 1
endfunction
