if !exists('loaded_snippet') || &cp
  finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec 'Snippet tra <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><CR>
\<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja" lang="ja"><CR>
\<head><CR>
\<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><CR>
\<meta http-equiv="content-style-type" content="text/css" /><CR>
\<meta http-equiv="content-script-type" content="text/javascript" /><CR>
\<title></title><CR>
\<link rel="shortcut icon" href="/favicon.ico" /><CR>
\<link rel="stylesheet" type="text/css" href="/css/base.css" media="all" /><CR>
\</head><CR>
\<body><CR>
\</body><CR>
\</html>'
