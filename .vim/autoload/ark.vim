" ark.vim

function! ark#set_root_dir(path)
    if !exists('g:ark_root_dirs')
        let g:ark_root_dirs = []
    endif
    let l:path = substitute(a:path, '/\+$', '', '')
    let g:ark_root_dirs += [l:path]
endfunction

