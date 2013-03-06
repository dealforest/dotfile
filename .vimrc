" -------------------------------------------------------------------------
" Basic settings.
" -------------------------------------------------------------------------
  set nocompatible " must be first!

  syntax on
  filetype off

  set backspace=eol,indent,start        "backspace setting
  set expandtab
  set shiftround

  set autoindent smartindent
  set cindent             "for C indent.
  set wrapscan            "検索時に最後まで行ったら最初に戻る
  set number              "行番号表示

  set list
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

  set hidden              "変更中のファイルでも保存しないで他のファイルを表示することが出来るようにする
  set nobackup
  set complete+=k

  set enc=utf-8
  set fenc=utf-8
  set fencs=utf-8,euc-jp,sjis,iso-2022-jp,cp932
  set fileformats=unix,dos,mac
  set termencoding=utf-8

  set tabstop=4 softtabstop=4 shiftwidth=4 softtabstop=0

  set directory=~/.vim/tmp

  set splitright

  "「■」や「●」のカーソル移動の不便を回避
  if exists('&ambiwidth')
    set ambiwidth=double
  endif

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

  " current selected
  nnoremap gc `[V`]
  vnoremap gc :<C-u>normal gc<Enter>
  onoremap gc :<C-u>normal gc<Enter>

" -------------------------------------------------------------------------
" NeoBunldle
" -------------------------------------------------------------------------
  if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#rc(expand('~/.vim/bundle/'))
  endif

  " http://vim-scripts.org/vim/scripts.html
  NeoBundle 'Shougo/neobundle.vim'
  NeoBundle 'Shougo/vimproc', {
        \ 'build' : {
        \     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
        \     'cygwin'  : 'make -f make_cygwin.mak',
        \     'mac'     : 'make -f make_mac.mak',
        \     'unix'    : 'make -f make_unix.mak',
        \    },
        \ }
  NeoBundle 'Shougo/vimshell'
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'tsukkee/unite-tag'
  NeoBundle 'Shougo/neocomplcache'
  NeoBundle 'Shougo/neosnippet'
  NeoBundle 'Lokaltog/vim-powerline'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'othree/eregex.vim'
  NeoBundle 'thinca/vim-ref'
  NeoBundle 'Align'
  NeoBundle 'YankRing.vim'
  NeoBundle 'EnhCommentify.vim'
  NeoBundle 'taglist.vim'
  NeoBundle 'matchit.zip'
  NeoBundle 'scrooloose/nerdtree'
  NeoBundle 'kana/vim-textobj-user'
  NeoBundle 'scrooloose/syntastic'
  NeoBundle 'nathanaelkane/vim-indent-guides'

  " colorscheme
"  NeoBundle 'vim-scripts/desert256.vim'
"  NeoBundle 'tomasr/molokai'
"  NeoBundle 'w0ng/vim-hybrid'
  NeoBundle 'nanotech/jellybeans.vim'

  NeoBundleLazy 'thinca/vim-quickrun',          { 'autoload': { 'mappings': [ '<Plug>(quickrun)' ] } }
  NeoBundleLazy 'airblade/vim-gitgutter',       { 'autoload': { 'commands': [ 'ToggleGitGutter' ] } }

  " for ruby
  NeoBundle 'vim-ruby/vim-ruby'
  NeoBundle 'rhysd/unite-ruby-require.vim'
  NeoBundle 'rhysd/vim-textobj-ruby'
  NeoBundle 'tpope/vim-rails'

  " for perl
  NeoBundleLazy 'hokaccha/vim-prove',           { 'autoload': { 'filetypes': ['perl'] } }

  " syntax highlight
  NeoBundle 'perl-mauke.vim'
  NeoBundle 'nginx.vim'
  NeoBundle 'cakebaker/scss-syntax.vim'
  NeoBundle 'slim-template/vim-slim'
  NeoBundle 'groenewege/vim-less'
  NeoBundle 'wavded/vim-stylus'
  NeoBundle 'vim-scripts/applescript.vim'
  NeoBundle 'motemen/xslate-vim'
  NeoBundle 'tpope/vim-markdown'
  NeoBundle 'pangloss/vim-javascript'
  NeoBundle 'kchmck/vim-coffee-script'

  filetype plugin on
  filetype indent on

" -------------------------------------------------------------------------
" NeoCompleCache.vim
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
    \ 'default': '',
    \ 'perl':       $HOME. '/.vim/dict/perl_functions.dict',
    \ 'ruby':       $HOME. '/.vim/dict/ruby_functions.dict',
    \ 'xs':         $HOME. '/.vim/dict/perl_xs.dict',
    \ 'javascript': $HOME. '/.vim/dict/javascript_functions.dict',
    \ 'php':        $HOME. '/.vim/dict/php_functions.dict'
  \ }

" -------------------------------------------------------------------------
" neosnippet.vim
" -------------------------------------------------------------------------
  " Plugin key-mappings.
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)

  " SuperTab like snippets behavior.
  imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  " For snippet_complete marker.
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif

" -------------------------------------------------------------------------
" unite.vim
" -------------------------------------------------------------------------
  let g:unite_enable_start_insert = 1
  " less delay
  let g:unite_update_time = 80
  nmap ee :Unite -buffer-name=files buffer_tab file_mru file<CR>
  nmap et :Unite -buffer-name=tags tag<CR>
  nmap eb :Unite buffer<CR>
  noremap ef :UniteWithBufferDir -buffer-name=files file<CR>

  " 除外パターン
  let g:unite_source_file_ignore_pattern = '\%(^\|/\)\.$\|\~$\|\.\%(o|exe|dll|bak|sw[po]\)$\|blib/'

  " mru の表示の日付フォーマットを変更
  let g:unite_source_file_mru_time_format = '(%Y-%m-%d %H:%M) '

  " ウィンドウを分割して開く
  au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')

  " ウィンドウを縦に分割して開く
  au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')

  " ESCキーを2回押すと
  au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
  au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" -------------------------------------------------------------------------
" vim-ref.vim
" -------------------------------------------------------------------------
"  let g:ref_alc_cmd='lynx -dump -nonumbers %s'
  nmap er :Unite ref/
  let g:ref_open = 'vsplit'
  let g:ref_refe_cmd = 'rurema'
  let g:ref_refe_version = 2

  nnoremap ,rr :<C-U>Ref refe<Space>

" -------------------------------------------------------------------------
" Align.vim
" -------------------------------------------------------------------------
  vmap \t- :Align =><CR><CR>

" -------------------------------------------------------------------------
" yankring.vim
" -------------------------------------------------------------------------
  let g:yankring_history_file = ".yankring_history"
  nnoremap <silent> ey :YRShow<CR>

" -------------------------------------------------------------------------
" quickrun.vim
" -------------------------------------------------------------------------
  silent! nmap <unique> ,r <Plug>(quickrun)
  silent! vmap <unique> ,r <Plug>(quickrun)
  if !exists('q:quickrun_config')
    let g:quickrun_config = { '*': { 'split': 'vertical rightbelow' } }
    let g:quickrun_config.sql = {
                \ 'command': 'mysql',
                \ 'exec':    ['%c %o < %s'],
                \ 'cmdopt':  '%{MakeMySQLCommandOptions()}',
                \ 'split':   'below',
                \ }
    let g:mysql_config_host = ''
    let g:mysql_config_port = ''
    let g:mysql_config_user = 'root'
  endif

" -------------------------------------------------------------------------
" vim-powerline.vim
" -------------------------------------------------------------------------
  let g:Powerline_symbols = 'fancy'
  set fillchars+=stl:\ ,stlnc:\

" -------------------------------------------------------------------------
" EnhancedCommentify.vim
" -------------------------------------------------------------------------
  let g:EnhCommentifyBindInInsert = 'NO'

" -------------------------------------------------------------------------
" eregex.vim
" -------------------------------------------------------------------------
  nnoremap / :M/
  nnoremap ? :M?
  nnoremap ,/ /
  nnoremap ,? ?

" -------------------------------------------------------------------------
" taglist.vim
" -------------------------------------------------------------------------
  set tags=tags
  nnoremap <silent> eq :Tlist<CR>

" -------------------------------------------------------------------------
" nertdtree
" -------------------------------------------------------------------------
  nnoremap <silent> ew :NERDTreeToggle <CR>

" -------------------------------------------------------------------------
" vim-gitgutter
" -------------------------------------------------------------------------
  let g:gitgutter_enabled = 0
  nnoremap <silent> ed :ToggleGitGutter <CR>

" -------------------------------------------------------------------------
" vim-indent-guides
" -------------------------------------------------------------------------
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_auto_colors = 0
  let g:indent_guides_color_change_persent = 30
  let g:indent_guides_guide_size = 1
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#221212 ctermbg=234
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#262626 ctermbg=236

" -------------------------------------------------------------------------
" Function
" -------------------------------------------------------------------------
  function! s:range_search(d)
      let s = input(a:d)
      if strlen(s) > 0
          let s = a:d . '\%V' . s . "\<CR>"
          call feedkeys(s, 'n')
      endif
  endfunction

  function! GetStatusEx()
  let str = &fileformat
      if has("multi_byte") && &fileencoding != ""
          let str = &fileencoding . ":" . str
      endif
      let str = "[" . str . "]"
      return str
  endfunction

  " http://potix2.blogspot.jp/2011/12/quickrunsqlmysql.html
  function! MakeMySQLCommandOptions()
    if !exists("g:mysql_config_host")
      let g:mysql_config_host = input("host> ")
    endif
    if !exists("g:mysql_config_port")
      let g:mysql_config_port = input("port> ")
    endif
    if !exists("g:mysql_config_user")
      let g:mysql_config_user = input("user> ")
    endif
    if !exists("g:mysql_config_pass")
      let g:mysql_config_pass = inputsecret("password> ")
    endif
    if !exists("g:mysql_config_db")
      let g:mysql_config_db = input("database> ")
    endif

    let optlist = []
    if g:mysql_config_user != ''
      call add(optlist, '-u ' . g:mysql_config_user)
    endif
    if g:mysql_config_host != ''
      call add(optlist, '-h ' . g:mysql_config_host)
    endif
    if g:mysql_config_pass != ''
      call add(optlist, '-p' . g:mysql_config_pass)
    endif
    if g:mysql_config_port != ''
      call add(optlist, '-P ' . g:mysql_config_port)
    endif
    if exists("g:mysql_config_otheropts")
      call add(optlist, g:mysql_config_otheropts)
    endif

    call add(optlist, g:mysql_config_db)
    return join(optlist, ' ')
  endfunction

" -------------------------------------------------------------------------
" Customize settings.
" -------------------------------------------------------------------------
  " 前回終了したカーソル行に移動
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

  " open vertical help
  nmap ,h :vert help 

  " for spell
  nnoremap <silent> <C-a> :setl spell!<Return>

  " for window controll
  nnoremap <silent> <C-w><C-l> :vertical resize -6<Return>
  nnoremap <silent> <C-w><C-h> :vertical resize +6<Return>
  nnoremap <silent> <C-w><C-k> :resize -6<Return>
  nnoremap <silent> <C-w><C-j> :resize +6<Return>

  " input datetime
  inoremap <expr> ,df strftime('%Y-%m-%d %H:%M:%S')
  inoremap <expr> ,dd strftime('%Y-%m-%d')
  inoremap <expr> ,dt strftime('%H:%M:%S')

  iabbrev ,= =========================================================================
  iabbrev ,- -------------------------------------------------------------------------

  " :Rename fine_name でファイルを開いたままファイル名の変更
  command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

  " ビジュアルモード内を検索
  vnoremap <silent> / :<C-u>call <SID>range_search('/')<CR>
  vnoremap <silent> ? :<C-u>call <SID>range_search('?')<CR>

  " for inifinity undo
  if has('persistent_undo')
    set undodir=~/.vim/undo
    set undofile
  endif

  colorscheme jellybeans

  " load ~/.vimrc.local
  if filereadable(expand('$HOME/.vimrc.local'))
    source ~/.vimrc.local
  endif
