"------------------------
" 基本設定
"------------------------

"色設定
syntax on
colorscheme mycolor

"タブの設定
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent

"検索
set incsearch
set ignorecase
set smartcase
set nohlsearch

"行数表示
set number

"対応する括弧表示しない
set noshowmatch

"コマンドラインの高さ
set cmdheight=1

"バックスペースで何でも消したい
set backspace=indent,eol,start

"タブバー常に表示
set showtabline=2 

"タブ文字可視化
set list
set listchars=tab:>\ 

"swapファイル作らない
set noswapfile

"backupしない
set nobackup
set backupdir=/tmp

"他で編集されたら読み込み直す
set autoread

"ステータスラインの表示設定
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%=%l,%c%V%8P

"exモードの補完
set wildmenu
set wildmode=list:longest,full

"補完
set complete=.,w,b,u,k
"set completeopt=menu,preview,longest
set pumheight=20

"ftplugin有効
filetype plugin on

" 新規windowを右側に開く
nnoremap <C-w>v :<C-u>belowright vnew<CR>

"windwowの高さ、幅
"set winheight=100
"set winwidth=78

" 下に開く
set splitbelow

"Visual blockで仮想編集を有効にする
set virtualedit+=block

" vimscriptをリロード
nnoremap <silent> <Space>r :<C-u>source %<CR>

" http://www.kaoriya.net/blog/2014/03/30/
set noundofile

" オムニ補完でpreviewを出さない
set completeopt=menuone

"-----------------------
" autocmd
"------------------------

augroup MyAutoCmd
  autocmd!
augroup END

"mtとttをhtmlに
autocmd MyAutoCmd BufNewFile,BufReadPost *.mt,*.tt,*.ejs set filetype=html

"jade
autocmd MyAutoCmd BufNewFile,BufReadPost *.jade set filetype=jade

"jsonnet
autocmd MyAutoCmd BufNewFile,BufReadPost *.jsonnet set filetype=jsonnet

"less
autocmd MyAutoCmd BufNewFile,BufReadPost *.less set filetype=less

"psgiとtはperl
autocmd MyAutoCmd BufNewFile,BufReadPost *.psgi,*.t set filetype=perl

"ruby
autocmd MyAutoCmd BufNewFile,BufReadPost *.ru,*.jbuilder set filetype=ruby

"asをactionscriptに
autocmd MyAutoCmd BufNewFile,BufReadPost *.as set filetype=actionscript

"markdown
autocmd MyAutoCmd BufNewFile,BufReadPost *.md,*.mkd,*.txt set filetype=markdown

"json
autocmd MyAutoCmd BufNewFile,BufReadPost *.json set filetype=json

"coffee
autocmd MyAutoCmd BufNewFile,BufReadPost *.coffee,Cakefile set filetype=coffee

"jsx
autocmd MyAutoCmd BufNewFile,BufReadPost *.jsx set filetype=javascript.jsx

"stylus
autocmd MyAutoCmd BufNewFile,BufReadPost *.styl set filetype=stylus

"autocmd BufNewFile *.rb call append(0, '# -*- coding: utf-8 -*-')

" 開いてるファイルにのディレクトリに移動
command! -nargs=0 CD :execute 'lcd ' . substitute(expand("%:p:h"), ' ', '\\ ', 'g')

" Markedで開く
command! -nargs=0 Marked :execute 'silent !open -a Marked %'

"ファイルを開いたときにディレクト自動移動
autocmd MyAutoCmd BufEnter * execute 'CD'

" see http://vim-users.jp/2009/11/hack96/
autocmd MyAutoCmd FileType *
\   if &l:omnifunc == ''
\ |   setlocal omnifunc=syntaxcomplete#Complete
\ | endif

"-----------------------
" 文字コードとかの設定
"------------------------
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

"改行コード
set fileformats=unix,dos,mac

" タブラインの設定
" from :help setting-tabline
set tabline=%!MyTabLine()

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " 強調表示グループの選択
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " タブページ番号の設定 (マウスクリック用)
    let s .= '%' . (i + 1) . 'T'

    " ラベルは MyTabLabel() で作成する
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " 最後のタブページの後は TabLineFill で埋め、タブページ番号をリセッ
  " トする
  let s .= '%#TabLineFill#%T'

  " カレントタブページを閉じるボタンのラベルを右添えで作成
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return expand("#".buflist[winnr - 1].":t")
endfunction

"------------------------
" キーバインド
"------------------------

"; to :
nnoremap ; :

"保存
nnoremap <Space>w :<C-u>write<CR>

"終了
nnoremap <Space>q :<C-u>quit<CR>

"上下移動
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

"単語検索
nnoremap * g*
nnoremap # g#

"サーチハイライトトグル
nnoremap <silent> <Space>th :set hlsearch!<CR>

"タブ切り替え
nnoremap <C-l> gt
nnoremap <C-h> gT

"タブ文字（\t）を入力
inoremap <C-Tab> <C-v><Tab>

"ビジュアルモードで選択して検索
vnoremap * "zy:let @/ = @z<CR>n

"ビジュアルモードで選択して置換。とりあえず/だけエスケープしとく
vnoremap <C-s> "zy:%s/<C-r>=escape(@z,'/')<CR>/

"入力モードで削除
inoremap <C-d> <Del>
inoremap <C-h> <BackSpace>

"コマンドモードでemacsチックに
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-h> <BackSpace>

"コマンドモードの履歴
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

"コマンドモードでペースト
cnoremap <C-y> <C-r>"

"文字コード変更して再読み込み
nnoremap <silent> eu :<C-u>e ++enc=utf-8<CR>
nnoremap <silent> ee :<C-u>e ++enc=euc-jp<CR>
nnoremap <silent> es :<C-u>e ++enc=cp932<CR>

"pasteモードトグル
nnoremap <Space>tp :<C-u>set paste!<CR>

"help
nnoremap <Space>h :<C-u>vert bel h<Space>

"補完候補があってもEnterは改行
inoremap <expr> <CR> pumvisible() ? "\<C-e>\<CR>" : "\<CR>"

"スクロール
nnoremap <C-e> <C-e>j
nnoremap <C-y> <C-y>k
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" <C-u>とかのundo
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" ファイルタイプの変更
nnoremap <Space>f :<C-u>setf<Space>
 
" 最後に選択したテキスト
nnoremap gc `[v`]
vnoremap gc :<C-u>normal gc<CR>
onoremap gc :<C-u>normal gc<CR>

" コピペ
nnoremap y "xy
vnoremap y "xy
nnoremap d "xd
vnoremap d "xd
nnoremap c "xc
vnoremap c "xc
vnoremap p "xp
nnoremap <C-p> :<C-u>set opfunc=OverridePaste<CR>g@
nnoremap <C-p><C-p> :<C-u>set opfunc=OverridePaste<CR>g@g@

function! OverridePaste(type, ...)
    if a:0
        silent execute "normal! `<" . a:type . "`>\"xp"
    elseif a:type == 'line'
        silent execute "normal! '[V']\"xp"
    elseif a:type == 'block'
        silent execute "normal! `[\<C-V>`]\"xp"
    else
        silent execute "normal! `[v`]\"xp"
    endif
endfunction

" インデント選択
function! VisualCurrentIndentBlock(type)
    let current_indent = indent('.')
    let current_line   = line('.')
    let current_col    = col('.')
    let last_line      = line('$')

    let start_line = current_line
    while start_line != 1 && current_indent <= indent(start_line) || getline(start_line) == ''
        let start_line -= 1
    endwhile
    if a:type ==# 'i'
        let start_line += 1
    endif

    let end_line = current_line
    while end_line != last_line && current_indent <= indent(end_line) || getline(end_line) == ''
        let end_line += 1
    endwhile
    if a:type ==# 'i'
        let end_line -= 1
    endif

    call cursor(start_line, current_col)
    normal! V
    call cursor(end_line, current_col)
endfunction

nnoremap vii :call VisualCurrentIndentBlock('i')<CR>
nnoremap vai :call VisualCurrentIndentBlock('a')<CR>
onoremap ii :normal vii<CR>
onoremap ai :normal vai<CR>

"------------------------
" go
"------------------------

filetype off
filetype plugin off
let g:gofmt_command = 'goimports'
let $GOROOT = '/usr/local/opt/go/libexec'
let $GOPATH = $HOME . '/local'
set rtp+=$GOROOT/misc/vim
set rtp+=$GOPATH/src/github.com/nsf/gocode/vim
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
"auto BufWritePre *.go Fmt
filetype plugin on
syntax on
nnoremap <silent> ,f :<C-u>Fmt<CR>:<C-u>write<CR>

"------------------------
" その他の設定のロード
"------------------------

" プロジェクト毎に読み込む設定ファイル
function! s:vimrc_project(loc)
    let files = findfile('.vimrc.project', escape(a:loc, ' ') . ';', -1)
    for i in reverse(filter(files, 'filereadable(v:val)'))
        source `=i`
    endfor
endfunction

augroup vimrc-project
    autocmd!
    autocmd BufNewFile,BufReadPost * call s:vimrc_project(expand('<afile>:p:h'))
augroup END

" プラグインの設定ファイルをロード
let bundle_vimrc = $HOME."/.vimrc.bundle"
if (filereadable(bundle_vimrc))
    execute "source " . bundle_vimrc
endif

" local設定ファイルをロード
let local_vimrc = $HOME."/.vimrc.local"
if (filereadable(local_vimrc))
    execute "source " . local_vimrc
endif
