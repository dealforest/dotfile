"-------------------------------------------------------------------------------
"" デザイン
colorscheme koehler       " カラースキーム
set guifont=Osaka-Mono:h14 " フォント
set antialias             " アンチエイリアシング
set imdisable
"set transparency=230       " 半透明
set guioptions-=T         " ツールバー削除
highlight CursorLine ctermbg=black guibg=gray10  " カーソル行の色
" 挿入モード・検索モードでのデフォルトのIME状態設定
set iminsert=0 imsearch=0
"日本語入力中のカーソルの色
"highlight Cursor guifg=NONE guibg=Green
highlight CursorIM guifg=NONE guibg=Red
" メニューを英語に戻す
source $VIMRUNTIME/delmenu.vim
set langmenu=none
source $VIMRUNTIME/menu.vim
" 様々な箇所を英語に戻す
lang en_gb

map <silent> gw :macaction selectNextWindow:
map <silent> gW :macaction selectPreviousWindow:
"-------------------------------------------------------------------------------
" ウィンドウ
set sessionoptions+=resize " 行・列を設定する
set lines=48             " 行数
set columns=160           " 横幅
set cmdheight=1           " コマンドラインの高さ
set previewheight=5       " プレビューウィンドウの高さ
set splitbelow             " 横分割したら新しいウィンドウは下に
set splitright             " 縦分割したら新しいウィンドウは右に
"-------------------------------------------------------------------------------
" タブを使う
nnoremap <C-h>  gT
nnoremap <C-l>  gt
nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 6gt
nnoremap <Leader>7 7gt
nnoremap <Leader>8 8gt
nnoremap <Leader>9 9gt
