" Tabの切り替え
function s:setTab(s)
    if (a:s == 2)
        setlocal softtabstop=2
        setlocal shiftwidth=2
        setlocal expandtab
    endif
    if (a:s == 4)
        setlocal softtabstop=4
        setlocal shiftwidth=4
        setlocal expandtab
    endif
    if (a:s == 't')
        setlocal softtabstop=4
        setlocal shiftwidth=4
        setlocal noexpandtab
    endif
endfunction
command! -nargs=1 Tab :call s:setTab(<q-args>)
