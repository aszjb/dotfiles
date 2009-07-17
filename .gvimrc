"カラースキーマ
colorschem mymacvim

"ウインドウサイズ
set columns=180
set lines=45

"フォント
set guifont=Monaco:h12

"ズーム
nmap ,z :set guifont=Monaco:h18<CR>
nmap ,Z :set guifont=Monaco:h12<CR>:set columns=180<CR>:set lines=45<CR>

"¥をバックスラッシュに
map! ¥ \

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
