" オレオレgrep
command! -complete=file -nargs=+ Grep call s:grep(<q-args>)
function! s:grep(args)
    execute 'vimgrep' '/' . a:args . '/j **/*'
    if len(getqflist()) != 0 | copen | endif
endfunction
