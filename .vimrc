"------------------------
" 基本設定
"------------------------

"色設定
syntax on
colorschem darkblue

"タブの設定
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent

"検索
set ignorecase
set smartcase
set hlsearch

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

"zshっぽい補完
set wildmode=longest,list

"ディレクト自動移動
au BufEnter * execute ":lcd " . expand("%:p:h")

"ftplugin有効
filetype plugin on

"mtをhtmlに
autocmd BufNewFile,BufRead *.mt set filetype=html


"------------------------
" 文字コードとかの設定
"------------------------

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

"改行コード
set fileformats=unix,dos,mac

"文字コード
"どんなにがんばっても文字化けするのでutf-8決め打ち
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
"set   encoding=utf-8
" 
"if has('win32') && has('kaoriya')
"  set   ambiwidth=auto
"else
"  set   ambiwidth=double
"endif
" 
"if has('iconv')
"  let s:enc_euc = 'euc-jp'
"  let s:enc_jis = 'iso-2022-jp'
" 
"  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
"    let s:enc_euc = 'euc-jisx0213,euc-jp'
"    let s:enc_jis = 'iso-2022-jp-3'
"  endif
" 
"  set   fileencodings&
"  let &fileencodings = &fileencodings.','.s:enc_jis.',cp932,'.s:enc_euc
" 
"  unlet s:enc_euc
"  unlet s:enc_jis
"endif
" 
"if has('win32unix')
"  set   termencoding=cp932
"elseif !has('macunix')
"  set   termencoding=euc-jp
"endif


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

"サーチハイライト消す
nnoremap <Esc><Esc> :<C-u>nohlsearch<CR><Esc>

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

"文字コード変更して再読み込み
nnoremap <silent> eu :<C-u>e ++enc=utf-8<CR>
nnoremap <silent> ee :<C-u>e ++enc=euc-jp<CR>
nnoremap <silent> es :<C-u>e ++enc=cp932<CR>

"タブを半角スペースに変換
nnoremap <silent> et :<C-u>%s/\t/    /g<CR>

"スクロールしたときに常にカーソルが真ん中にくる
nnoremap <C-e> <C-e>M
nnoremap <C-y> <C-y>M

nnoremap <C-k>p :<C-u>set paste<CR>
nnoremap <C-k>P :<C-u>set nopaste<CR>

"なぜかたまにexpandtabが無効になることがあるので
nnoremap <C-k>e :<C-u>set expandtab<CR>

"phpの構文チェック
"nnoremap ,l :<C-u>w<CR>:!php -l %<CR>

" vimrc再読み込み
nnoremap ,s :<C-u>source ~/.vimrc<CR>:source ~/.gvimrc<CR>

"------------------------
" プラグインの設定
"------------------------
"for align.vim
"選択範囲を整列
vmap o <leader>tsp

"for MRU.vim
nnoremap <silent> <Space>m :<C-u>MRU<CR>

"for surround.vim
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
" k : [% | %]

"autocmd FileType xhtml :set filetype=html
autocmd FileType * let b:surround_49  = "<h1>\r</h1>"
autocmd FileType * let b:surround_50  = "<h2>\r</h2>"
autocmd FileType * let b:surround_51  = "<h3>\r</h3>"
autocmd FileType * let b:surround_52  = "<h4>\r</h4>"
autocmd FileType * let b:surround_53  = "<h5>\r</h5>"
autocmd FileType * let b:surround_54  = "<h6>\r</h6>"

autocmd FileType * let b:surround_112 = "<p>\r</p>"
autocmd FileType * let b:surround_117 = "<ul>\r</ul>"
autocmd FileType * let b:surround_111 = "<ol>\r</ol>"
autocmd FileType * let b:surround_108 = "<li>\r</li>"
autocmd FileType * let b:surround_97  = "<a href=\"dummy\">\r</a>"
autocmd FileType * let b:surround_65  = "<a href=\"\r\"></a>"
autocmd FileType * let b:surround_105 = "<img src=\"\" alt=\"\r\" />"
autocmd FileType * let b:surround_73  = "<img src=\"\r\" alt=\"\" />"
autocmd FileType * let b:surround_100 = "<div>\r</div>"
autocmd FileType * let b:surround_68  = "<div class=\"section\">\r</div>"

autocmd FileType * let b:surround_104  = "<?php \r ?>"
autocmd FileType * let b:surround_107    = "[% \r %]"

" symfony.vimの設定
nnoremap <Space>sv :<C-u>Sview<CR>
nnoremap <Space>sa :<C-u>Saction<CR>
nnoremap <Space>sm :<C-u>Smodel<CR>
nnoremap <Space>sp :<C-u>Spartial<CR>
nnoremap <Space>ss :<C-u>Symfony
nnoremap <Space>sc :<C-u>Sconfig
nnoremap <Space>sl :<C-u>Slib

" ku
nnoremap <silent> <Space>kb :<C-u>Ku buffer<CR>
nnoremap <silent> <Space>kf :<C-u>Ku file<CR>
nnoremap <silent> <Space>kh :<C-u>Ku history<CR>
nnoremap <silent> <Space>kc :<C-u>Ku mrucommand<CR>
nnoremap <silent> <Space>km :<C-u>Ku mrufile<CR>

function! Ku_my_keymappings()
    inoremap <buffer> <silent> <Tab> /
    inoremap <buffer> <C-t> <Esc>:<C-u>KuDoAction tab-Right<CR>
    inoremap <buffer> <C-h> <Esc>:<C-u>KuDoAction left<CR>
    inoremap <buffer> <C-l> <Esc>:<C-u>KuDoAction right<CR>
endfunction

augroup KuSetting
autocmd!
autocmd FileType ku call ku#default_key_mappings(1)
    \ | call Ku_my_keymappings()
augroup END

call ku#custom_prefix('common', '~', $HOME)
call ku#custom_prefix('common', 'mone', $HOME.'/Works/sites/mone/www')
call ku#custom_prefix('common', 'mikke', $HOME.'/Works/sites/mikke/www')

