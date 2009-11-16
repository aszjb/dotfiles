" textobj-camelcase - Text objects for camel case.
" Version: 0.0.1
" Author: Kazuhito Hokamura
" License: MIT license (see <http://www.opensource.org/licenses/mit-license>)

if exists('g:loaded_textobj_camelcase')
  finish
endif

call textobj#user#plugin('camelcase', {
\      '-': {
\           '*pattern*': '[A-Za-z][a-z0-9]\+',
\           'select': ['ac', 'ic'],
\      },
\   })

let loaded_textobj_camelcase = 1
