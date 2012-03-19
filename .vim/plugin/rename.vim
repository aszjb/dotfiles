" Rename
function! DoRename(file)
    execute "file " . a:file
    call delete(expand('#'))
    write!
endfunction
function! Rename(file, bang)
    if filereadable(a:file)
        if a:bang == '!'
            call DoRename(a:file)
        else
            echohl ErrorMsg
            echomsg 'File exists (add ! to override)'
            echohl None
        endif
    else
        call DoRename(a:file)
    endif
endfunction
command! -nargs=1 -bang -complete=file Rename call Rename(<q-args>, "<bang>")
