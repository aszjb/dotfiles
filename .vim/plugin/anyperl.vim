" anyperl.vim - For perl coindg helper.
"
" Author:  Kazuhito Hokamura <http://webtech-walker.com>
" Version: 0.0.1
" License: MIT License <http://www.opensource.org/licenses/mit-license.php>

if exists('g:loaded_anyperl')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=? -complete=file AnyperlTest :call anyperl#run_test(<q-args>)
command! -nargs=? AnyperlModuleOpen :call anyperl#module_open(<q-args>)
command! -nargs=? AnyperlDoc :call anyperl#perl_doc(<q-args>)

if !exists('g:anyperl_enable')
    let g:anyperl_enable = 1
endif

if !exists('g:anyperl_projects')
    let g:anyperl_projects = []
endif

if g:anyperl_enable
    call anyperl#enable()
endif

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_anyperl = 1
