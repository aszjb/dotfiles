" textobj-template - Text objects for WAF template engine.
" Version: 0.0.1
" Author: Kazuhito Hokamura
" License: MIT license (see <http://www.opensource.org/licenses/mit-license>)

if exists('g:loaded_textobj_template')
  finish
endif

call textobj#user#plugin('template', {
\      'tt': {
\           'select-a': 'aTt',
\           'select-i': 'iTt',
\           '*pattern*': ['\[%-\? ', ' -\?%\]'],
\      },
\      'mt': {
\           'select-a': 'aTm',
\           'select-i': 'iTm',
\           '*pattern*': ['<?= ', ' ?>'],
\      },
\      'rhtml': {
\           'select-a': 'aTr',
\           'select-i': 'iTr',
\           '*pattern*': ['<%= ', ' %>'],
\      },
\      'django': {
\           'select-a': 'aTd',
\           'select-i': 'iTd',
\           '*pattern*': ['{\(%\|{\) ', ' \(%\|}\)}'],
\      },
\   })

let loaded_textobj_template= 1
