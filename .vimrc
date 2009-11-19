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

"バックスペースで何でも消したい
set backspace=indent,eol,start

"タブバー常に表示
set showtabline=2 

"タブ文字可視化
set list
set listchars=tab:>\ 

"swapファイル作らない
set noswapfile

"他で編集されたら読み込み直す
set autoread

"ステータスラインの表示設定
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%=%l,%c%V%8P

"exモードの補完
set wildmode=list:longest,full

"補完
set complete=.,w,b,u,k
set completeopt=menu,preview,longest
set pumheight=20

"ftplugin有効
filetype plugin on

"シェルにパスを通す
let $PATH = '/opt/local/bin:'.$PATH

"twitterとかのアカウントが書いてあるファイル読み込み
let accountFile = $HOME."/.vim/info/account.vim"
if (filereadable(accountFile))
    execute "source " . accountFile
endif

" 新規windowを右側に開く
nnoremap <C-w>v :<C-u>belowright vnew<CR>

" set filetype
nnoremap <Space>sp :<C-u>set filetype=perl<CR>
nnoremap <Space>sh :<C-u>set filetype=php<CR>
nnoremap <Space>sj :<C-u>set filetype=javascript<CR>

"-----------------------
" autocmd
"------------------------

augroup MyAutoCmd
  autocmd!
augroup END

"mtとttをhtmlに
autocmd MyAutoCmd BufNewFile,BufRead *.mt set filetype=html
autocmd MyAutoCmd BufNewFile,BufRead *.tt set filetype=html

"markdownのfiletypeをセット
autocmd MyAutoCmd BufNewFile,BufRead *.md set filetype=mkd

"なぜかnoexpandtabになることがあるので
autocmd MyAutoCmd BufNewFile,BufRead * set expandtab

"ディレクト自動移動
autocmd MyAutoCmd BufRead * execute ":lcd " . expand("%:p:h")

" カレントバッファのファイルを再読み込み。filetypeがvimかsnippetsのときだけ。
nnoremap <silent> <Space>r :<C-u>
\ if &ft == 'vim' <Bar>
\     source % <Bar>
\ elseif &ft == 'snippet' <Bar>
\     call SnipMateReload() <Bar>
\ endif<CR>

function! SnipMateReload()
    if &ft == 'snippet'
        let ft = substitute(expand('%'), '.snippets', '', '')
        if has_key(g:did_ft, ft)
            unlet g:did_ft[ft]
        endif
        silent! call GetSnippets(g:snippets_dir, ft)
    endif
endfunction

"grepとかmakeのあとにエラーがあればQuickFixだす
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep
    \ if len(getqflist()) != 0 | copen | endif

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

" 開いてるファイルにのディレクトリに移動
command! -nargs=0 CD :execute 'lcd ' . expand("%:p:h")

"------------------------
" キーバインド
"------------------------
"leader設定
let mapleader = ','

"エスケープキー
inoremap <C-j> <esc>
vnoremap <C-j> <esc>

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

"改行
"nnoremap <CR> o<ESC>
"nnoremap <S-CR> O<ESC>

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

"文字コード変更して再読み込み
nnoremap <silent> eu :<C-u>e ++enc=utf-8<CR>
nnoremap <silent> ee :<C-u>e ++enc=euc-jp<CR>
nnoremap <silent> es :<C-u>e ++enc=cp932<CR>

"pasteモードトグル
nnoremap <Space>tp :<C-u>set paste!<CR>


"help
nnoremap <Space>h :<C-u>vert bel h<Space>

"svn
nnoremap <Space>cs :<C-u>!svn<Space>

"行末まで削除
inoremap <C-k> <C-o>D

"補完候補があってもEnterは改行
inoremap <expr> <CR> pumvisible() ? "\<C-e>\<CR>" : "\<CR>"

"スクロール
nnoremap <C-e> <C-e>M
nnoremap <C-y> <C-y>M
nnoremap <C-u> <C-u>M
nnoremap <C-d> <C-d>M

"function! SmoothScroll(action)
"   let l:h=winheight(0) / 6
"   let l:i=0
"   while l:i < l:h
"      let l:i = l:i + 1
"      if a:action=="down"
"         execute "normal 3\<C-e>"
"      elseif a:action=="up"
"         execute "normal 3\<C-y>"
"      end
"      redraw
"      sleep 1m
"   endwhile 
"endfunction
"
"nnoremap <silent> <C-d> :<C-u>call SmoothScroll("down")<CR>
"nnoremap <silent> <C-u> :<C-u>call SmoothScroll("up")<CR>

" <C-u>とかのundo
inoremap <C-u>  <C-g>u<C-u>
inoremap <C-w>  <C-g>u<C-w>

" \ って遠いよね
inoremap <C-]> \
cnoremap <C-]> \

" text object
"onoremap aa  a>
"vnoremap aa  a>
"onoremap ia  i>
"vnoremap ia  i>
"
"onoremap ar  a]
"vnoremap ar  a]
"onoremap ir  i]
"vnoremap ir  i]
 
nnoremap gc `[v`]
onoremap gc :normal gc<CR>

onoremap <silent> q
\      :for i in range(v:count1)
\ <Bar>   call search('.\&\(\k\<Bar>\_s\)\@!', 'W')
\ <Bar> endfor<CR>


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
" プラグインの設定
"------------------------


" symfony.vim
" nnoremap <Space>sv :<C-u>Sview<CR>
" nnoremap <Space>sa :<C-u>Saction<CR>
" nnoremap <Space>sm :<C-u>Smodel<CR>
" nnoremap <Space>sp :<C-u>Spartial<CR>
" nnoremap <Space>ss :<C-u>Symfony
" nnoremap <Space>sc :<C-u>Sconfig
" nnoremap <Space>sl :<C-u>Slib

" ku.vim
nnoremap <silent> <Space>kb :<C-u>Ku buffer<CR>
nnoremap <silent> <Space>kf :<C-u>Ku file<CR>
nnoremap <silent> <Space>kh :<C-u>Ku history<CR>
nnoremap <silent> <Space>kc :<C-u>Ku cmd_mru/cmd<CR>
nnoremap <silent> <Space>ks :<C-u>Ku cmd_mru/search<CR>
nnoremap <silent> <Space>km :<C-u>Ku file_mru<CR>

function! Ku_my_keymappings()
    inoremap <buffer> <silent> <Tab> /
    inoremap <buffer> <C-w>n <Esc>:<C-u>KuDoAction tab-Right<CR>
    inoremap <buffer> <C-w>p <Esc>:<C-u>KuDoAction tab-Left<CR>
    inoremap <buffer> <C-w>h <Esc>:<C-u>KuDoAction left<CR>
    inoremap <buffer> <C-w>l <Esc>:<C-u>KuDoAction right<CR>
    inoremap <buffer> <C-w>j <Esc>:<C-u>KuDoAction below<CR>
    inoremap <buffer> <C-w>k <Esc>:<C-u>KuDoAction above<CR>
    inoremap <buffer> <C-w>H <Esc>:<C-u>KuDoAction Left<CR>
    inoremap <buffer> <C-w>L <Esc>:<C-u>KuDoAction Right<CR>
    inoremap <buffer> <C-w>J <Esc>:<C-u>KuDoAction Bottom<CR>
    inoremap <buffer> <C-w>K <Esc>:<C-u>KuDoAction Top<CR>
endfunction

augroup KuSetting
autocmd!
autocmd FileType ku call ku#default_key_mappings(1)
    \ | call Ku_my_keymappings()
augroup END

call ku#custom_prefix('common', '~', $HOME)
call ku#custom_prefix('common', 'si', $HOME.'/Works/sites/shiraberu/www/dev')
call ku#custom_prefix('common', 'mikke', $HOME.'/Works/sites/mikke/www')

" anyperl.vim
"let g:anyperl_projects = []
"call anyperl#add_project({
"    \ 'type': 'ark',
"    \ 'home': $HOME."/dev/perl/ark/ie-buglist.org",
"    \ 'libs': [$HOME."/dev/perl/ark/ie-buglist.org/ark/lib"]
"\})
"call anyperl#add_project({
"    \ 'type': 'shiraberu.ark',
"    \ 'home': $HOME."/Works/sites/shiraberu/www/dev",
"    \ 'libs': [$HOME."/Works/sites/shiraberu/www/dev/ark-perl/lib"]
"\})
"
"nnoremap <Space>pt :AnyperlTest<CR>
"nnoremap <Space>pj :AnyperlJumpModule<CR>
"nnoremap <Space>pd :AnyperlDoc<CR>


" 絶対パスで開く
let s:htdocs_dirs = [$HOME.'/dev/site/localhost/test']
function! GotoAbsFile()
    let fname = expand('<cfile>')
    let filepass = fname
    if (match(fname, '^/') != -1)
        for dir in s:htdocs_dirs
            if match(expand("%:p:h"), dir) != -1 && isdirectory(dir) == 1
                let filepass = dir . fname
                break
            endif
        endfor
    endif
    if filereadable(filepass)
        execute 'edit ' . filepass
    else
        echohl ErrorMsg
        echo 'no such file ' . fname
        echohl None
    endif
endfunction
nnoremap gaf :<C-u>call GotoAbsFile()<CR>


" クリップボード連携 
if has('mac')
    function! Pbcopy(type, ...)
        let reg_save = @@
        if a:0
            silent execute "normal! `<" . a:type . "`>y"
        elseif a:type == 'line'
            silent execute "normal! '[V']y"
        elseif a:type == 'block'
            silent execute "normal! `[\<C-V>`]y"
        else
            silent execute "normal! `[v`]y"
        endif
        call system('iconv -f utf-8 -t shift-jis | pbcopy', @@)
        let @@ = reg_save
    endfunction
    nnoremap <silent> <Space>y :<C-u>set opfunc=Pbcopy<CR>g@
    nnoremap <silent> <Space>yy :<C-u>set opfunc=Pbcopy<CR>g@g@
    vnoremap <silent> <Space>y :<C-u>call Pbcopy(visualmode(), 1)<CR>
    nnoremap <silent> <Space>p :<C-u>r !pbpaste<CR>
endif

" align.vimのおぺれーた
function! AlignTSP(type, ...)
    let reg_save = @@
    silent execute "normal! '[V']"
    normal o
    let @@ = reg_save
endfunction
vmap o <leader>tsp
nnoremap <silent> <Space>a :<C-u>set opfunc=AlignTSP<CR>g@

" ウインドウ単位で開いたファイルの履歴をたどる
" なんかvimgrepでバグる
"function! FileJumpPush()
"    if !exists('w:histories')
"        let w:histories = []
"    endif
"    let buf = bufnr('%')
"    if count(w:histories, buf) == 0
"        call add(w:histories, buf)
"    endif
"endfunction
"
"function! FileJumpPrev()
"    if exists('w:histories')
"        let buf = bufnr('%')
"        let current = match(w:histories, '^'.buf.'$')
"        if current != 0 && exists('w:histories[current - 1]')
"            execute 'buffer ' . w:histories[current - 1]
"        endif
"    endif
"endfunction
"
"function! FileJumpNext()
"    if exists('w:histories')
"        let buf = bufnr('%')
"        let current = match(w:histories, '^'.buf.'$')
"        if exists('w:histories[current + 1]')
"            execute 'buffer ' . w:histories[current + 1]
"        endif
"    endif
"endfunction
"
"augroup FileJumpAutoCmd
"    autocmd!
"augroup END
"autocmd FileJumpAutoCmd BufReadPre * call FileJumpPush()
"nnoremap <silent> ,p :<C-u>call FileJumpPrev()<CR>
"nnoremap <silent> ,n :<C-u>call FileJumpNext()<CR>
"

" acp.vim
let g:acp_behaviorSnipmateLength = 1

" see http://vim-users.jp/2009/11/hack96/
autocmd FileType *
\   if &l:omnifunc == ''
\ |   setlocal omnifunc=syntaxcomplete#Complete
\ | endif
