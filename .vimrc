" -------------------------------------------------------------------------
" Basic settings.
"
" -------------------------------------------------------------------------
  set nocompatible " must be first!

  syntax on
  filetype on
  filetype indent on
  filetype plugin on

  set backspace=eol,indent,start        "backspace setting
  set expandtab
  set shiftround

  autocmd BufEnter * call SetTab()

  set autoindent smartindent
  set cindent             "for C indent.
  set wrapscan            "検索時に最後まで行ったら最初に戻る
  set number              "行番号表示

  set listchars=tab:>-,extends:<,trail:-
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue
  match ZenkakuSpace /　/

  set ambiwidth=double    "Display adjustment of width of character

  set incsearch           "インクリメンタル検索を行う
  set smartcase           "検索文字列に大文字が含まれている場合は区別して検索する
  set ignorecase          "検索文字列が小文字の場合は大文字小文字を区別なく検索する
  set hlsearch

  set showmatch           "括弧入力時の対応する括弧を表示 
  set showmode            "入力中のコマンドをステータスに表示する
  set title
  set ruler

  set laststatus=2
  set statusline=[%n]\ %t\ %y%{GetStatusEx()}\ [0x%B(%b)]\ %m%h%r=%l/%L,%c%V\ %P 
  set grepprg=internal    "alias grep -> vimgrep

  vnoremap <silent> / :<C-u>call <SID>range_search('/')<CR>
  vnoremap <silent> ? :<C-u>call <SID>range_search('?')<CR>

  set hidden              "変更中のファイルでも保存しないで他のファイルを表示することが出来るようにする
  set nobackup
  set complete+=k

  set enc=utf-8
  set fenc=utf-8
  set fencs=utf-8,euc-jp,sjis,iso-2022-jp,cp932
  set fileformats=unix,dos,mac
  set termencoding=utf-8

" -------------------------------------------------------------------------
" Function
"
" -------------------------------------------------------------------------
  function SetTab()
      if &syntax == 'ruby' || &syntax == 'html' || &syntax == 'xhtml' || &syntax == 'css' || &syntax == 'eruby' || &syntax == 'yaml' || &syntax == 'vim'
          execute 'set tabstop=2 | set softtabstop=2 | set shiftwidth=2 | set softtabstop=0'
      else
          execute 'set tabstop=4 | set softtabstop=4 | set shiftwidth=4 | set softtabstop=0'
      endif
  endf

  function! GetStatusEx()
  let str = &fileformat
      if has("multi_byte") && &fileencoding != ""
          let str = &fileencoding . ":" . str
      endif
      let str = "[" . str . "]"
      return str
  endfunction

  "  ビジュアルモード内を検索
  function! s:range_search(d)
      let s = input(a:d)
      if strlen(s) > 0
          let s = a:d . '\%V' . s . "\<CR>"
          call feedkeys(s, 'n')
      endif
  endfunction

" -------------------------------------------------------------------------
" Command
"
" -------------------------------------------------------------------------
  " :Rename fine_name でファイルを開いたままファイル名の変更
  command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

  command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor


" -------------------------------------------------------------------------
" Keybind
" -------------------------------------------------------------------------
  " for us key.
  nmap ; :

  " 論理移動
  noremap j gj
  noremap k gk
  noremap gj j
  noremap gk k

  " 検索後、真ん中にフォーカスをあわせる
  nmap n nzz 
  nmap N Nzz 
  nmap * *zz 
  nmap # #zz 
  nmap g* g*zz 
  nmap g# g#zz

  " hilight を消す
  nnoremap <silent> gh :let @/=''<CR>
  nnoremap g' cs'g
  nnoremap g" cs"G

  " paste/nopaste
  nnoremap ep :set paste<CR>
  nnoremap enp :set nopaste<CR>

  imap <C-j> <C-[>
  imap <C-f> <Right>
  imap <C-b> <Left>
  " 連続した改行の際にインデントを保持する
  inoremap <Return>  <Return>X<BS>

  "edit for .vimrc
  nnoremap ,. :<C-u>edit $MYVIMRC<Enter>
  nnoremap ,s. :<C-u>source $MYVIMRC<Enter>

  "shorcut for help
  "nnoremap <C-h> :<C-u>help<Space>
  "nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><Enter>

  " pbcopy for mac
  if has('mac') 
    nmap _ :.w !nkf -Ws \| pbcopy<CR><CR>
    vmap _ :w !nkf -Ws \| pbcopy<CR><CR>
    nmap - :set paste<CR>:r !pbpaste\|nkf -Sw<CR>:set nopaste<CR> 
  endif

  " current selected
  nnoremap gc `[V`]
  vnoremap gc :<C-u>normal gc<Enter>
  onoremap gc :<C-u>normal gc<Enter>


" -------------------------------------------------------------------------
" pathogen
"  
" see http://subtech.g.hatena.ne.jp/secondlife/20101012/1286886237
" -------------------------------------------------------------------------
  call pathogen#runtime_append_all_bundles()

" -------------------------------------------------------------------------
" fuf
" -------------------------------------------------------------------------
  nnoremap <unique> <silent> <C-S> :FufBuffer!<CR>
  nnoremap <silent> eff :FufFile!<CR>
  nnoremap <silent> efb :FufBuffer!<CR>
  nnoremap <silent> efe :FufFileWithCurrentBuffer!<CR>
  nnoremap <silent> efm :FufMruFile!<CR>
  nnoremap <silent> efj :FufMruFileInCwd!<CR>

  autocmd FileType fuf nmap <C-c> <ESC>
  let g:fuf_patternSeparator = ' '
  let g:fuf_modesDisable = ['mrucmd']
  let g:fuf_mrufile_exclude = '\v\~$|\.bak$|\.swp|\.svn$|\.(gif|jpg|png)$'
  let g:fuf_mrufile_maxItem = 2000
  let g:fuf_enumeratingLimit = 20
  "nnoremap <silent> <C-]> :FuzzyFinderTag! <C-r>=expand(｀<cword>｀)<CR><CR>

  "   from tokuhirom.
  "   let g:fuf_modesDisable = ['mrucmd']
  "   let g:fuf_file_exclude =
  "   '\v\~$|\.(o|exe|bak|swp|gif|jpg|png)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
  "   let g:fuf_mrufile_exclude =
  "   '\v\~$|\.bak$|\.swp|\.howm$|\.(gif|jpg|png)$'
  "   let g:fuf_mrufile_maxItem = 10000
  "   let g:fuf_enumeratingLimit = 20
  "   let g:fuf_keyPreview = '<C-]>'
  "   let g:fuf_previewHeight = 0
  "
  "   nmap bg :FufBuffer<CR>
  "   nmap bG :FufFile
  "   <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
  "   nmap gb :FufFile **/<CR>
  "   nmap br :FufMruFile<CR>
  "   nmap bq :FufQuickfix<CR>
  "   nmap bl :FufLine<CR>
  "   nnoremap <silent> <C-]> :FufTag! <C-r>=expand('<cword>')<CR><CR> 
  "

" -------------------------------------------------------------------------
" Align
" -------------------------------------------------------------------------
  vmap \t- :Align =><CR><CR>

" -------------------------------------------------------------------------
" zencoding.vim
" -------------------------------------------------------------------------
"  let g:user_zen_expandabbr_key = "<c-e>"
  let g:user_zen_expandabbr_key = ",e"

" -------------------------------------------------------------------------
" autocomplpop.vim
" -------------------------------------------------------------------------
  "補完候補表示したまま RET おして改行
  "inoremap <expr> <CR> pumvisible() ? "\<C-Y>\<CR>" : "\<CR>"
  "補完候補をbufferからも読み込むように対応
  "autocmd FileType * let g:AutoComplPop_CompleteOption = '.,w,b,u,t'
  "autocmd FileType perl let g:AutoComplPop_CompleteOption = ".,w,b,u,t,k~/.vim/dict/perl_functions.dict"
  "autocmd FileType ruby let g:AutoComplPop_CompleteOption = ".,w,b,u,t,k~/.vim/dict/ruby_functions.dict"
  "autocmd FileType javascript let g:AutoComplPop_CompleteOption = ".,w,b,u,t,k~/.vim/dict/javascript_functions.idct"

  "大文字小文字を区別しない
  "let g:AutoComplPop_IgnoreCaseOption = 1 

  "ポップアップメニューのカラーを設定
  "hi Pmenu guibg=#666666
  "hi PmenuSel guibg=#8cd0d3 guifg=#666666
  "hi PmenuSbar guibg=#333333

" -------------------------------------------------------------------------
" yankring.vim
" -------------------------------------------------------------------------
  let g:yankring_history_file = ".yankring_history"
  nnoremap ey :YRShow<CR>

" -------------------------------------------------------------------------
" yanktemp.vim
" -------------------------------------------------------------------------
  noremap <silent> sy :call YanktmpYank()<CR>
  noremap <silent> sp :call YanktmpPaste_p()<CR>
  noremap <silent> sP :call YanktmpPaste_P()<CR>

" -------------------------------------------------------------------------
" prove.vim
" -------------------------------------------------------------------------
  nnoremap <silent> ,, :Prove<CR>
"  let g:prove_lib_dirs = ['/Users/dealforest/local/lib']
"  let g:prove_local_lib_dir = $HOME . '/perl5'

" -------------------------------------------------------------------------
" quickrun.vim
" -------------------------------------------------------------------------
"  silent! nmap <unique> 好きなキー <Plug>(quickrun)
  if !exists('q:quickrun_config')
    let g:quickrun_config = {'*': { 'split': 'vertical rightbelow' }}
    let g:quickrun_config.applescript = { 'command' : 'osascript /Users/dealforest/work/programing/lang/applescript/quickrun/run.scpt' }
  endif

" -------------------------------------------------------------------------
" smartchr.vim
" -------------------------------------------------------------------------
"  autocmd FileType actionscript,javascript,perl inoremap <buffer> <expr> = smartchr#one_of(' = ', ' == ', ' === ', '=')

" -------------------------------------------------------------------------
" unite.vim
" -------------------------------------------------------------------------
"  let g:unite_enable_start_insert = 1 
  " less delay
"  let g:unite_update_time = 80
"  nmap bg :Unite -buffer-name=files buffer_tab file_mru file bookmark<CR>

" -------------------------------------------------------------------------
" Utility settings.
"
" -------------------------------------------------------------------------
  "  前回終了したカーソル行に移動
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif


  "  for flash publish
"  nnoremap <buffer> <C-W><CR> :!open -a "Adobe Flash CS4" "$HOME/bin/publish.jsfl"<CR>

  "  input datetime
  inoremap <expr> ,df strftime('%Y-%m-%d %H:%M:%S')
  inoremap <expr> ,dd strftime('%Y-%m-%d')
  inoremap <expr> ,dt strftime('%H:%M:%S')

  "  sequence increment
  nnoremap <silent> co :ContinuousNumber <C-a><CR>
  vnoremap <silent> co :ContinuousNumber <C-a><CR>

