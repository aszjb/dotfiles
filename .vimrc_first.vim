let g:vimrc_first_finish = 1

"perl5lib
"let $PERL5LIB = $HOME . '/perl5/perlbrew/perls/perl-5.14.2/lib/site_perl/5.14.2'

" パスを追加する関数
let s:paths = split($PATH, ':')
function! s:insert_path(path)
    let index = index(s:paths, a:path)
    if index != -1
        call remove(s:paths, index)
    endif
    call insert(s:paths, a:path)
    let $PATH = join(s:paths, ':')
endfunction

"シェルにパスを通す
call s:insert_path('/usr/local/bin')
call s:insert_path($HOME.'/local/bin')
"call s:insert_path($HOME.'/perl5/perlbrew/perls/perl-5.14.2/bin')
call s:insert_path($HOME.'/.nodebrew/current/bin')
call s:insert_path($HOME.'/.rbenv/shims')
