" -------------------------------------------------------------------------
" Basic settings.
"
" -------------------------------------------------------------------------
  set nocompatible " must be first!

  syntax on
  filetype on
  filetype indent on
  filetype plugin on

  colorscheme desert

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

  "「■」や「●」のカーソル移動の不便を回避
  if exists('&ambiwidth')
    set ambiwidth=double
  endif

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

    " Chrome auto reload
    " see http://d.hatena.ne.jp/LukeSilvia/20101025/p1
    command! -bar ChromeReload silent !osascript -e 'tell application "Google Chrome" to reload active tab of window 1'
    command! -bar ChromeStartObserve ChromeStopObserve | autocmd BufWritePost <buffer> ChromeReload
    command! -bar ChromeStopObserve autocmd! BufWritePost <buffer>
    nnoremap <silent> <C-w><CR> :ChromeReload<CR><C-l>
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
" NeoCompleCache.vim
"  
" -------------------------------------------------------------------------
  let g:neocomplcache_enable_at_startup = 1 
  let g:neocomplcache_enable_auto_select = 1 

  " Use smartcase.
  let g:neocomplcache_enable_ignore_case = 0 
  let g:neocomplcache_enable_smart_case = 1 
  " Use camel case completion.
  let g:neocomplcache_enable_camel_case_completion = 1 
  " Use underbar completion.
  let g:neocomplcache_enable_underbar_completion = 1 
  " Set minimum syntax keyword length.
  let g:neocomplcache_min_syntax_length = 3 
  let g:neocomplcache_enable_quick_match = 1 
  let g:neocomplcache_enable_wildcard = 1 


  nnoremap <silent> ent :NeoComplCacheCachingTags<CR>

  imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>" 
  " <CR>: close popup and save indent.
  " inoremap <expr><CR>  neocomplcache#smart_close_popup() . (&indentexpr != '' " ? "\<C-f>\<CR>X\<BS>":"\<CR>")
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  " inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplcache#close_popup()
  inoremap <expr><C-e>  neocomplcache#cancel_popup() 

"  Define dictionary.
  let g:neocomplcache_dictionary_filetype_lists = { 
    \ 'default' : '', 
    \ 'perl' : $HOME. '/.vim/dict/perl_functions.dict',
    \ 'ruby' : $HOME. '/.vim/dict/ruby_functions.dict',
    \ 'xs' : $HOME. '/.vim/dict/perl_xs.dict',
    \ 'javascript' : $HOME. '/.vim/dict/javascript_functions.dict',
    \ 'php' : $HOME. '/.vim/dict/php_functions.dict',
    \ 'actionscript' : $HOME. '/.vim/dict/actionscript.dict',
    \ 'objc' : $HOME.'/.vim/dict/objc.dict'
  \ }


" -------------------------------------------------------------------------
" fuf
" -------------------------------------------------------------------------
  nnoremap <unique> <silent> <C-S> :FufBuffer!<CR>
  nnoremap <silent> eb :FufBuffer!<CR>
  nnoremap <silent> ee :FufFileWithCurrentBuffer!<CR>
  nnoremap <silent> em :FufMruFile!<CR>
  nnoremap <silent> efj :FufMruFileInCwd!<CR>

  autocmd FileType fuf nmap <C-c> <ESC>
  let g:fuf_patternSeparator = ' '
  let g:fuf_modesDisable = ['mrucmd']
  let g:fuf_mrufile_exclude = '\v\~$|\.bak$|\.swp|\.svn$|\.(gif|jpg|png)$'
  let g:fuf_mrufile_maxItem = 2000
  let g:fuf_enumeratingLimit = 20
  "nnoremap <silent> <C-]> :FuzzyFinderTag! <C-r>=expand(｀<cword>｀)<CR><CR>

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
"  let g:prove_lib_dirs = ['$HOME/local/lib']
"  let g:prove_local_lib_dir = $HOME . '/perl5'

" -------------------------------------------------------------------------
" snipMate.vim
" -------------------------------------------------------------------------
  ino <c-l> <c-r>=TriggerSnippet()<cr>
  snor <c-l> <esc>i<right><c-r>=TriggerSnippet()<cr>

" -------------------------------------------------------------------------
" quickrun.vim
" -------------------------------------------------------------------------
  silent! nmap <unique> er <Plug>(quickrun)
  if !exists('q:quickrun_config')
    let g:quickrun_config = {'*': { 'split': 'vertical rightbelow' }}
    let g:quickrun_config.applescript = { 'command' : 'osascript $HOME/work/programing/lang/applescript/quickrun/run.scpt' }
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
" vim-powerline.vim
" -------------------------------------------------------------------------
  let g:Powerline_symbols = 'fancy'
  set fillchars+=stl:\ ,stlnc:\

" -------------------------------------------------------------------------
" taglist.vim
" -------------------------------------------------------------------------
  set tags=tags
  nnoremap <silent> ew :Tlist<CR>

" -------------------------------------------------------------------------
" The NERD Tree
" -------------------------------------------------------------------------
  nnoremap <silent> et :NERDTree <CR>

" -------------------------------------------------------------------------
" Utility settings.
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

  "  shortcut filetype
  nnoremap <silent> sf :set ft=

"   load ~/.vimrc.local
  if filereadable(expand('$HOME/.vimrc.local'))
    source ~/.vimrc.local
  endif
     
