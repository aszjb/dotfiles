if exists('b:did_ftplugin')
    finish
endif

if exists('b:perl_project_home')
    execute "setlocal path+=" . b:perl_project_home . '/root'
    "let g:perlpath = g:perlpath . b:perl_project_home . '/root'
endif

let b:did_ftplugin = 1
