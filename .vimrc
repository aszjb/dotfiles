"------------------------
" 基本設定
"------------------------

"色設定
syntax on
colorschem mycolor

"タブの設定
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent

"検索
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

"ディレクト自動移動
autocmd BufEnter * execute ":lcd " . expand("%:p:h")

"補完
set complete=.,w,b,u,k
set completeopt=menu,preview,longest
set pumheight=20

"ftplugin有効
filetype plugin on

"mtとttをhtmlに
autocmd BufNewFile,BufRead *.mt set filetype=html
autocmd BufNewFile,BufRead *.tt set filetype=html

"markdownのfiletypeをセット
autocmd BufNewFile,BufRead *.md set filetype=mkd

"noexpandtabになることがあるので
autocmd BufNewFile,BufRead * set expandtab

"シェルにパスを通す
let $PATH = '/opt/local/bin:'.$PATH

"twitterとかのアカウントが書いてあるファイル読み込み
let accountFile = $HOME."/.vim/info/account.vim"
if (filereadable(accountFile))
    execute "source " . accountFile
endif

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

"文字コード変更して再読み込み
nnoremap <silent> eu :<C-u>e ++enc=utf-8<CR>
nnoremap <silent> ee :<C-u>e ++enc=euc-jp<CR>
nnoremap <silent> es :<C-u>e ++enc=cp932<CR>

"pasteモードトグル
nnoremap <Space>tp :<C-u>set paste!<CR>

" カレントバッファのファイルを再読み込み
autocmd FileType vim nnoremap <silent> <Space>r :<C-u>execute "source %"<CR>

"help
nnoremap <Space>h :<C-u>vert bel h<Space>

"svn
nnoremap <C-s> :<C-u>!svn<Space>

"行末まで削除
inoremap <C-k> <C-o>D

"補完候補があってもEnterは改行
inoremap <expr> <CR> pumvisible() ? "\<C-e>\<CR>" : "\<CR>"

"スクロール
nnoremap <C-e> <C-e>M
nnoremap <C-y> <C-y>M
nnoremap <C-u> <C-u>M
nnoremap <C-d> <C-d>M

function! SmoothScroll(action)
   let l:h=winheight(0) / 6
   let l:i=0
   while l:i < l:h
      let l:i = l:i + 1
      if a:action=="down"
         execute "normal 3\<C-e>"
      elseif a:action=="up"
         execute "normal 3\<C-y>"
      end
      redraw
      sleep 1m
   endwhile 
endfunction

"nnoremap <silent> <C-d> :<C-u>call SmoothScroll("down")<CR>
"nnoremap <silent> <C-u> :<C-u>call SmoothScroll("up")<CR>

onoremap aa  a>
vnoremap aa  a>
onoremap ia  i>
vnoremap ia  i>

onoremap ar  a]
vnoremap ar  a]
onoremap ir  i]
vnoremap ir  i]
 
nnoremap gc `[v`]
onoremap gc :normal gc<CR>

onoremap <silent> q
\      :for i in range(v:count1)
\ <Bar>   call search('.\&\(\k\<Bar>\_s\)\@!', 'W')
\ <Bar> endfor<CR>

function! VisualCurrentIndentBlock()
    let current_indent = indent('.')
    let current_line   = line('.')
    let current_col    = col('.')
    let last_line      = line('$')

    let start_line = current_line
    while start_line != 1 && current_indent == indent(start_line - 1) 
        let start_line = start_line - 1
    endwhile

    let end_line = current_line
    while end_line != last_line && current_indent == indent(end_line + 1)
        let end_line = end_line + 1
    endwhile

    call cursor(start_line, current_col)
    normal V
    call cursor(end_line, current_col)
endfunction

nnoremap gi :call VisualCurrentIndentBlock()<CR>
onoremap gi :normal gi<CR>

"------------------------
" プラグインの設定
"------------------------

" align.vim
vmap o <leader>tsp

" surround.vim
"
" 1 : <h1>|</h1>
" 2 : <h2>|</h2>
" 3 : <h3>|</h3>
" 4 : <h4>|</h4>
" 5 : <h5>|</h5>
" 6 : <h6>|</h6>
"
" p : <p>|</p>
" u : <ul>|</ul>
" o : <ol>|</ol>
" l : <li>|</li>
" a : <a href="">|</a>
" A : <a href="|"></a>
" i : <img src="" alt"|" />
" I : <img src="|" alt="" />
" d : <div>|</div>
" D : <div class="section">|</div>
"
" h : <?php | ?>
" m : <% | %>

"autocmd FileType * let b:surround_49  = "<h1>\r</h1>"
"autocmd FileType * let b:surround_50  = "<h2>\r</h2>"
"autocmd FileType * let b:surround_51  = "<h3>\r</h3>"
"autocmd FileType * let b:surround_52  = "<h4>\r</h4>"
"autocmd FileType * let b:surround_53  = "<h5>\r</h5>"
"autocmd FileType * let b:surround_54  = "<h6>\r</h6>"
"
"autocmd FileType * let b:surround_112 = "<p>\r</p>"
"autocmd FileType * let b:surround_117 = "<ul>\r</ul>"
"autocmd FileType * let b:surround_111 = "<ol>\r</ol>"
"autocmd FileType * let b:surround_108 = "<li>\r</li>"
"autocmd FileType * let b:surround_97  = "<a href=\"dummy\">\r</a>"
"autocmd FileType * let b:surround_65  = "<a href=\"\r\"></a>"
"autocmd FileType * let b:surround_105 = "<img src=\"\" alt=\"\r\" />"
"autocmd FileType * let b:surround_73  = "<img src=\"\r\" alt=\"\" />"
"autocmd FileType * let b:surround_100 = "<div>\r</div>"
"autocmd FileType * let b:surround_68  = "<div class=\"section\">\r</div>"
"
"autocmd FileType * let b:surround_104  = "<?php \r ?>"
"autocmd FileType * let b:surround_107  = "<% \r %>"

" symfony.vim
nnoremap <Space>sv :<C-u>Sview<CR>
nnoremap <Space>sa :<C-u>Saction<CR>
nnoremap <Space>sm :<C-u>Smodel<CR>
nnoremap <Space>sp :<C-u>Spartial<CR>
nnoremap <Space>ss :<C-u>Symfony
nnoremap <Space>sc :<C-u>Sconfig
nnoremap <Space>sl :<C-u>Slib

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
call ku#custom_prefix('common', 'mone', $HOME.'/Works/sites/mone/www')
call ku#custom_prefix('common', 'mikke', $HOME.'/Works/sites/mikke/www')

" ark.vim
call ark#set_root_dir($HOME."/dev/perl/ark/ie-buglist.org")
call ark#set_root_dir($HOME."/Works/sites/shiraberu/www/trunk")

" vimshell
nnoremap <Space>v :VimShell<CR>
let g:VimShell_UserPrompt = 'getcwd()'
let g:VimShell_Prompt = $USER."$ "
