"ウインドウサイズ
set columns=180
set lines=45

"フォント
set guifont=Monaco:h12

"ズーム
function! ZoomToggle()
    let normal_font = 'Monaco:h12'
    let zoom_font   = 'Monaco:h25'
    if &guifont == normal_font
        let font = zoom_font
        let columns = 78
        let lines = 22
    else
        let font = normal_font
        let columns = 180
        let lines = 45
    endif
    execute 'set guifont=' . font
    execute 'set columns=' . columns
    execute 'set lines=' . lines
endfunction
nnoremap <Space>tz :<C-u>call ZoomToggle()<CR>

"バックスラッシュ入力
noremap! ¥ \

"不透明度
set transparency=5

"タブのラベルファイル名のみ
set guitablabel=%t

"IMEオフ
set imdisable

"ツールバー非表示
set guioptions-=T

"カーソル行表示
set cursorline
"autocmd BufEnter * setlocal cursorline
"autocmd BufLeave * setlocal nocursorline

"---------------------------------------------------------------------------
" 日本語対応のための設定: from kaoriya
" Copyright (C) 2007 KaoriYa/MURAOKA Taro
"
" ファイルを読込む時にトライする文字エンコードの順序を確定する。漢字コード自
" 動判別機能を利用する場合には別途iconv.dllが必要。iconv.dllについては
" README_w32j.txtを参照。ユーティリティスクリプトを読み込むことで設定される。

let s:enc_cp932 = 'cp932'
let s:enc_eucjp = 'euc-jp'
let s:enc_jisx = 'iso-2022-jp'
let s:enc_utf8 = 'utf-8'

" 利用しているiconvライブラリの性能を調べる。
"
" 比較的新しいJISX0213をサポートしているか検査する。euc-jisx0213が定義してい
" る範囲の文字をcp932からeuc-jisx0213へ変換できるかどうかで判断する。
"
function! s:CheckIconvCapability()
  if !has('iconv') | return | endif
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_eucjp = 'euc-jisx0213,euc-jp'
    let s:enc_jisx = 'iso-2022-jp-3'
  else
    let s:enc_eucjp = 'euc-jp'
    let s:enc_jisx = 'iso-2022-jp'
  endif
endfunction

" 'fileencodings'を決定する。
"
" 利用しているiconvライブラリの性能及び、現在利用している'encoding'の値に応じ
" て、日本語で利用するのに最適な'fileencodings'を設定する。
"
function! s:DetermineFileencodings()
  if !has('iconv') | return | endif
  let value = 'ucs-bom,ucs-2le,ucs-2'
  if &encoding ==? 'utf-8'
    " UTF-8環境向けにfileencodingsを設定する
    let value = value. ','.s:enc_jisx. ','.s:enc_cp932. ','.s:enc_eucjp
  elseif &encoding ==? 'cp932'
    " CP932環境向けにfileencodingsを設定する
    let value = value. ','.s:enc_jisx. ','.s:enc_utf8. ','.s:enc_eucjp
  elseif &encoding ==? 'euc-jp' || &encoding ==? 'euc-jisx0213'
    " EUC-JP環境向けにfileencodingsを設定する
    let value = value. ','.s:enc_jisx. ','.s:enc_utf8. ','.s:enc_cp932
  else
    " TODO: 必要ならばその他のエンコード向けの設定をココに追加する
  endif
  if has('guess_encode')
    let value = 'guess,'.value
  endif
  let &fileencodings = value
endfunction

set encoding=japan
call s:CheckIconvCapability()
call s:DetermineFileencodings()

" MacOS Xメニューの日本語化 (メニュー表示前に行なう必要がある)
if has('mac')
  if exists('$LANG') && $LANG ==# 'ja_JP.UTF-8'
    set langmenu=ja_ja.utf-8.macvim
    set encoding=utf-8
    set ambiwidth=double
  endif
endif
