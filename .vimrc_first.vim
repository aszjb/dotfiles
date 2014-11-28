let g:vimrc_first_finish = 1

"perl5lib
"let $PERL5LIB = $HOME . '/perl5/perlbrew/perls/perl-5.14.2/lib/site_perl/5.14.2'

"シェルにパスを通す
call g:insert_path('/usr/local/bin')
call g:insert_path($HOME.'/local/bin')
"call g:insert_path($HOME.'/perl5/perlbrew/perls/perl-5.14.2/bin')
call g:insert_path($HOME.'/.nodebrew/current/bin')
call g:insert_path($HOME.'/.rbenv/shims')
