" anyperl.vim - For perl coindg helper.
"
" Author:  Kazuhito Hokamura <http://webtech-walker.com>
" Version: 0.0.1
" License: MIT License <http://www.opensource.org/licenses/mit-license.php>


" init {{{1
"=============================================================================

function! anyperl#enable()
    augroup anyperlInit
        autocmd!
        autocmd anyperlInit BufNewFile,BufRead * call <SID>init()
    augroup END
endfunction

function! s:init()
    for project in g:anyperl_projects
        if !exists('project.home')
            continue
        endif
        if expand('%:p:h') =~ '^'.project.home
            let b:perl_project_home = substitute(project.home, '/\+$', '', '')
            let b:perl_project_test = b:perl_project_home . '/t'
            let b:perl_project_libs = []

            let perl_project_lib = b:perl_project_home . '/lib'
            if isdirectory(perl_project_lib)
                let b:perl_project_libs += [ perl_project_lib ]
            endif
            if exists('project.libs')
                let b:perl_project_libs += project.libs
            endif

            if exists('project.type')
                let project_ft = project.type . '.' . &filetype
                execute 'set filetype='.project_ft
            endif
            return
        endif
    endfor

    " automatic search directory
    let t_dir = finddir('t', '.;')
    if t_dir != ''
        let b:perl_project_home = substitute(fnamemodify(t_dir, ':p'),
        \                                    '\/t\/$', '', '')
        let b:perl_project_test = b:perl_project_home . '/t'
        let b:perl_project_libs = []

        let perl_project_lib    = b:perl_project_home . '/lib'
        if isdirectory(perl_project_lib)
            let b:perl_project_libs += [ perl_project_lib ]
        endif
    endif
endfunction



" add_project {{{1
"=============================================================================

function! anyperl#add_project(data)
    call add(g:anyperl_projects, a:data)
endfunction



" test(prove) {{{1
"=============================================================================

function! anyperl#run_test(test_file)
    if a:test_file == ''
        let test_path = expand('%:p')
        if !filereadable(test_path)
            let test_path = tempname() . expand('%:e')
            let original_bufname = bufname('')
            let original_modified = &l:modified
                silent keepalt write `=test_path`
                if original_bufname == ''
                    silent 0 file
                endif
            let &l:modified = original_modified
        endif
    else
        let test_path = fnamemodify(a:test_file, ':p')
        if !filereadable(test_path) && !isdirectory(test_path)
            call s:error('no such file or directory')
            return
        endif
    endif

    let lib_dirs = ''
    if exists('b:perl_project_libs')
        for lib_dir in b:perl_project_libs
            let lib_dirs .= ' -I' . lib_dir
        endfor
    endif

    let command = ''
    if exists('b:perl_project_home')
        let command = printf('cd %s;', b:perl_project_home)
    endif
    let command .= printf('prove -vr %s %s', lib_dirs, test_path)

    call s:open_window('[anyperl] test', 'prove', command, 'rightbelow')
endfunction 



" module open {{{1
"=============================================================================

function! anyperl#module_open(module)
    let module      = s:get_module_name(a:module)
    let module_path = s:get_module_path(module)

    if module_path != ''
        execute 'edit ' . module_path
    else
        call s:error(module . ' is not found')
    endif
endfunction



" perldoc {{{1
"=============================================================================

function! anyperl#perl_doc(module)
    let module    = s:get_module_name(a:module)
    let class_cmd = 'perldoc -otext -T ' . module
    let func_cmd  = 'perldoc -otext -f ' . module

    let command = ''
    for c in [class_cmd, func_cmd]
        silent! call system(c)
        if !v:shell_error
            let command = c
            break
        endif
    endfor

    if command == ''
        call s:error('no documentation found for ' . module)
        return
    endif

    call s:open_window('[anyperl] doc', 'man', command, 'vertical belowright')
endfunction




" util function {{{1
"=============================================================================

function! s:gsub(str, pat, rep)
    return substitute(a:str, '\v'.a:pat, a:rep, 'g')
endfunction

function! s:error(str)
    echohl ErrorMsg
    echomsg a:str
    echohl None
endfunction

function! s:open_window(bufname, filetype, command, win_pos)
    if !bufexists(a:bufname)
        execute a:win_pos . ' new'
        setlocal bufhidden=unload
        setlocal nobuflisted
        setlocal buftype=nofile
        setlocal noswapfile
        execute 'setlocal filetype=' . a:filetype
        silent file `=a:bufname`
        nnoremap <buffer> <silent> q <C-w>c
    else
        let bufnr = bufnr(a:bufname)
        let winnr = bufwinnr(bufnr)
        if winnr == -1
            execute a:win_pos . ' split'
            execute bufnr 'buffer'
            execute 'setlocal filetype=' . a:filetype
        else
            execute winnr 'wincmd w'
        endif
    endif

    silent % delete _
    call append(0, 'now loading...')
    redraw
    silent % delete _
    call append(0, '')
    execute 'silent! read !' a:command
    1
endfunction

function! s:get_module_name(module)
    if a:module == ''
        return s:get_cursor_module_name()
    else
        return a:module
    endif
endfunction

function! s:get_cursor_module_name()
    let regex = '[a-zA-Z0-9:_]\+'
    let orig_pos = getpos('.')[1:2]

    let start_col = searchpos('[a-zA-Z0-9:_]\+', 'bW')[1]
    let end_col   = searchpos('[a-zA-Z0-9:_]\+', 'ceW')[1]

    let module_name = strpart(getline('.'),
    \                        start_col - 1,
    \                        end_col - start_col + 1)

    call cursor(orig_pos)

    return module_name
endfunction

function! s:get_module_path(module)
    let lib_dirs = []
    if exists('b:perl_project_libs')
        let lib_dirs += b:perl_project_libs
    endif
    let lib_dirs += split(system('perl -e "print join \":\", @INC"'), ':')

    for dir in lib_dirs
        let module_path = dir . '/' . s:gsub(a:module, '::', '/') . '.pm'
        if filereadable(module_path)
            return module_path
        endif
    endfor
endfunction


"__END__
" vim: set fdm=marker:
