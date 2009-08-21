" ark.vim
"
" @Author Kazuhito Hokamura
"

function! s:ark_models(args)
endfunction

function! s:ark_views(args)
endfunction

function! s:ark_controllers(args)
endfunction

function! s:ark_test(args)
endfunction

function! s:init_ark_root()
    for l:dir in g:ark_root_dirs 
        if (match(expand('%:p'), l:dir) != -1 && isdirectory(l:dir) == 1)
            let b:ark_root = l:dir
        endif
    endfor
endfunction

function! s:init_perl_lib_path()
    let l:lib_path = $PERL5LIB

    for l:dir in g:ark_root_dirs 
        let l:lib_path = substitute(l:lib_path, l:dir . '/lib:\?', '', 'g')
    endfor

    if exists('b:ark_root')
        let l:add_path = b:ark_root . "/lib"
        if (l:lib_path == "")
            let l:lib_path = l:add_path
        else
            let l:lib_path = l:add_path . ":" . l:lib_path
        endif
    endif
    let $PERL5LIB = l:lib_path
endfunction

function! s:set_command()
    command! -buffer -nargs=* ArkModels :call <SID>ark_models(<q-args>)
    command! -buffer -nargs=* ArkViews :call <SID>ark_views(<q-args>)
    command! -buffer -nargs=* ArkControllers :call <SID>ark_controllers(<q-args>)
    command! -buffer -nargs=* ArkTest :call <SID>ark_test(<q-args>)
endfunction

function! s:init()
    call s:init_ark_root()
    call s:init_perl_lib_path()
    if exists('b:ark_root')
        call s:set_command()
    endif
endfunction

augroup ArkPluginInit
    autocmd!
    autocmd BufNewFile,BufRead * call s:init()
augroup END
