"---------------------------------------------------------------------------
" Vi互換をオフ
set nocompatible

"---------------------------------------------------------------------------
" Vundle
filetype off
set rtp+=~/.vim/vundle/
call vundle#rc()

" Bundle 'AutoClose'
Bundle 'Changed'
Bundle 'EnhCommentify.vim'
Bundle 'FavEx'
Bundle 'Highlight-UnMatched-Brackets'
Bundle 'minibufexpl.vim'
Bundle 'quickrun'
Bundle 'ref.vim'
Bundle 'smartchr'
Bundle 'surround.vim'
Bundle 'unite.vim'

filetype plugin indent on

"---------------------------------------------------------------------------
" 行数を表示
set number
" 新しい行のインデントを現在行と同じにする
set autoindent
" バックアップ取らない
set nobackup
" 他で書き換えられたら自動で読み直す
set autoread
" スワップファイル作らない
set noswapfile
" バックアップファイルを作るディレクトリ
" set backupdir=$HOME/vimbackup
" バックアップをとる場合
"set backup
" バックアップファイルを作るディレクトリ
"set backupdir=~/backup
" スワップファイルを作るディレクトリ
"set directory=~/swap
" スワップファイル用のディレクトリ
" set directory=$HOME/vimbackup
" ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
" set browsedir=buffer
" クリップボードをWindowsと連携
set clipboard=unnamed
" タブの代わりに空白文字を挿入する
set expandtab
" 変更中のファイルでも、保存しないで他のファイルを表示
set hidden
" インクリメンタルサーチを行う
set incsearch
" タブ文字、行末など不可視文字を表示する
set list
" listで表示される文字のフォーマットを指定する
" set listchars=eol:~,tab:>\ ,extends:<
" Tab、行末の半角スペースを明示的に表示する
" set listchars=tab:^\ ,trail:~
set listchars=tab:>\ ,trail:~
" シフト移動幅
set shiftwidth=4
" 閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
" 検索時に大文字を含んでいたら大/小を区別
set smartcase
" 新しい行を作ったときに高度な自動インデントを行う
set smartindent
" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
" ファイル内の <Tab> が対応する空白の数
set tabstop=4
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" 検索をファイルの先頭へループしない
set nowrapscan
" Windowsでディレクトリパスの区切り文字に / を使えるようにする
set shellslash

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
autocmd BufWritePre * :%s/\t/  /ge
" 日本語入力をリセット
" autocmd BufNewFile,BufRead * set iminsert=0
" タブ幅をリセット
autocmd BufNewFile,BufRead * set tabstop=4 shiftwidth=4

"---------------------------------------------------------------------------
" ;でコマンド入力( ;と:を入れ替)
noremap ; :
noremap : ;

" Shift+hjklで移動量を大きく
noremap H 3h
noremap J 3j
noremap K 3k
noremap L 3l

"---------------------------------------------------------------------------
" CTRL-hjklでウィンドウ移動
nnoremap <C-j> ;<C-w>j
nnoremap <C-k> ;<C-k>j
nnoremap <C-l> ;<C-l>j
nnoremap <C-h> ;<C-h>j

"---------------------------------------------------------------------------
" バッファの移動
nmap <C-p> ;bp<CR>
nmap <C-n> ;bn<CR>

" Escの2回押しでハイライト消去
nmap <ESC><ESC> ;nohlsearch<CR><ESC>

"---------------------------------------------------------------------------
" カーソル行をハイライト
  set cursorline
  " カレントウィンドウにのみ罫線を引く
  augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
  augroup END

:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

"---------------------------------------------------------------------------
" Highlight-UnMatched-Brackets
set matchpairs+=<:>

"---------------------------------------------------------------------------
" minibufexpl.vim
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBuffs = 1

"---------------------------------------------------------------------------
" Smartchr.vim
" inoremap <expr> = smartchr#one_of(' = ', ' == ', '=')
inoremap <expr> , smartchr#one_of(', ', ',')

"---------------------------------------------------------------------------
" Unite
nnoremap [unite] <Nop>
nmap <Space>f [unite]

"unite general settings
"インサートモードで開始
let g:unite_enable_start_insert = 1
"最近開いたファイル履歴の保存数
let g:unite_source_file_mru_limit = 50

"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''

"現在開いているファイルのディレクトリ下のファイル一覧。
"開いていない場合はカレントディレクトリ
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
"レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
"ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
"ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
"uniteを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  "ESCでuniteを終了
  nmap <buffer> <ESC> <Plug>(unite_exit)
  "入力モードのときjjでノーマルモードに移動
  imap <buffer> jj <Plug>(unite_insert_leave)
  "入力モードのときctrl+wでバックスラッシュも削除
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  "ctrl+jで縦に分割して開く
  nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  "ctrl+jで横に分割して開く
  nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  "ctrl+oでその場所に開く
  nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
  inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
endfunction"}}}

