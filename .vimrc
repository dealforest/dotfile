" -------------------------------------------------------------------------
" Basic settings.
" -------------------------------------------------------------------------
  set enc=utf-8
  set fenc=utf-8
  set fencs=utf-8,euc-jp,sjis,iso-2022-jp,cp932
  set fileformats=unix,dos,mac
  set termencoding=utf-8
  scriptencoding utf-8

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

  set directory=~/.vim/tmp

  set laststatus=2
  set statusline=[%n]\ %t\ %y%{GetStatusEx()}\ [0x%B(%b)]\ %m%h%r=%l/%L,%c%V\ %P 
  set grepprg=internal    "alias grep -> vimgrep

  set hidden              "変更中のファイルでも保存しないで他のファイルを表示することが出来るようにする
  set nobackup
  set complete+=k

  " for fast scroll
  set nocursorcolumn
  set nocursorline
  syntax sync minlines=256

  set tabstop=4 softtabstop=4 shiftwidth=4 softtabstop=0

  set directory=~/.vim/tmp

  set t_Co=256
  set splitright

  "「■」や「●」のカーソル移動の不便を回避
  if exists('&ambiwidth')
    set ambiwidth=double
  endif

  augroup vimrc
    autocmd!
  augroup END

" -------------------------------------------------------------------------
" Keybind
" -------------------------------------------------------------------------
  " for us key.
  nnoremap ; :

  " 論理移動
  noremap j gj
  noremap k gk
  noremap gj j
  noremap gk k

  " 検索後、真ん中にフォーカスをあわせる
  noremap n nzz
  noremap N Nzz
  noremap * *zz
  noremap # #zz
  noremap g* g*zz
  noremap g# g#zz

  " hilight を消す
  nnoremap <silent> gh :let @/=''<CR>
  nnoremap g' cs'g
  nnoremap g" cs"G

  " paste/nopaste
  nnoremap ep :set paste<CR>
  nnoremap enp :set nopaste<CR>

  " buffer control
  nnoremap <C-k><C-j> :bp<CR>
  nnoremap <C-k><C-k> :bn<CR>

  inoremap <C-j> <C-[>
  inoremap <C-f> <Right>
  inoremap <C-b> <Left>
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

  if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
  endif

" -------------------------------------------------------------------------
" NeoBunldle
" -------------------------------------------------------------------------
if filereadable(expand('~/.vim/bundle/neobundle.vim/autoload/neobundle.vim'))
  if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
  endif

  call neobundle#begin(expand('~/.vim/bundle/'))

  " http://vim-scripts.org/vim/scripts.html
  NeoBundleFetch 'Shougo/neobundle.vim'
  NeoBundle 'Shougo/neocomplcache'
  NeoBundle 'Shougo/neosnippet'
  NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
    \     'cygwin'  : 'make -f make_cygwin.mak',
    \     'mac'     : 'make -f make_mac.mak',
    \     'unix'    : 'make -f make_unix.mak',
    \    },
    \ }

  NeoBundleLazy 'Shougo/vimshell', {
        \   'autoload': {
        \     'commands': [ 'VimShell', "VimShellPop", "VimShellInteractive" ],
        \     'depends': [ 'Shougo/vimproc' ],
        \   }
        \ }
  NeoBundleLazy 'Shougo/unite.vim', {
        \   'autoload' : {
        \     'commands': [
        \       'Unite',
        \       'UniteWithBufferDir',
        \       'UniteWithCursorWord', 'UniteWithInput'
        \     ],
        \     'functions': 'unite#start',
        \   }
        \ }

  NeoBundle 'tsukkee/unite-tag'
  NeoBundle 'Shougo/neomru.vim'
  NeoBundle 'kana/vim-textobj-user'
  NeoBundle 'Lokaltog/vim-powerline'
  NeoBundle 'nathanaelkane/vim-indent-guides'
  NeoBundle 'thinca/vim-ref'
  NeoBundle 'tsaleh/vim-align'
  NeoBundle 'LeafCage/yankround.vim'
  NeoBundle 'vim-scripts/EnhCommentify.vim'
  NeoBundle 'vim-scripts/matchit.zip'
  NeoBundle 'bling/vim-bufferline'
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'bronson/vim-trailing-whitespace'
  NeoBundle 'vim-scripts/PreserveNoEOL'
  NeoBundle 'sjl/gundo.vim'

  NeoBundleLazy 'tpope/vim-surround'
  NeoBundleLazy 'hokaccha/vim-prove',      { 'autoload': { 'commands': [ 'Prove' ] } }
  NeoBundleLazy 'scrooloose/nerdtree',     { 'autoload': { 'commands': [ 'NERDTreeToggle' ] } }
  NeoBundleLazy 'thinca/vim-quickrun',     { 'autoload': { 'mappings': [ '<Plug>(quickrun)' ] } }
  NeoBundleLazy 'vim-scripts/taglist.vim', { 'autoload': { 'commands': [ 'Tlist' ] } }
  NeoBundleLazy 'scrooloose/syntastic',    { 'autoload': { 'commands': [ 'SyntasticCheck', 'SyntasticToggleMode' ] } }

  " colorscheme
  NeoBundle     'nanotech/jellybeans.vim'
  NeoBundleLazy 'tomasr/molokai'
  NeoBundleLazy 'vim-scripts/desert256.vim'
  NeoBundleLazy 'w0ng/vim-hybrid'

  " ruby
  NeoBundle     'rhysd/vim-textobj-ruby'
  NeoBundle     'tpope/vim-rails'
  NeoBundleLazy 'rhysd/unite-ruby-require.vim', { 'autoload': { 'unite_sources': 'ruby/require' } }
  NeoBundleLazy 'ujihisa/unite-rake',           { 'autoload': { 'unite_sources': 'rake' } }

  " syntax highlight
  NeoBundle 'cakebaker/scss-syntax.vim'
  NeoBundle 'groenewege/vim-less'
  NeoBundle 'kchmck/vim-coffee-script'
  NeoBundle 'motemen/xslate-vim'
  NeoBundle 'pangloss/vim-javascript'
  NeoBundle 'slim-template/vim-slim'
  NeoBundle 'tpope/vim-markdown'
  NeoBundle 'vim-perl/vim-perl'
  NeoBundle 'vim-ruby/vim-ruby'
  NeoBundle 'fatih/vim-go'
  NeoBundle 'vim-scripts/applescript.vim'
  NeoBundle 'vim-scripts/nginx.vim'
  NeoBundle 'wavded/vim-stylus'
  NeoBundle 'juvenn/mustache.vim'
  NeoBundle 'sophacles/vim-processing'
  NeoBundle 'leafgarland/typescript-vim'

" /usr/local/share/vim/vim74/filetype.vim
" comment out au BufNewFile,BufRead *.ino,*.pde  setf arduino

  call neobundle#end()

  filetype plugin indent on

  if neobundle#is_installed('neocomplcache')
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
  endif

  if neobundle#is_installed('neosnippet')
    " Plugin key-mappings.
    imap <C-l> <Plug>(neosnippet_expand_or_jump)
    smap <C-l> <Plug>(neosnippet_expand_or_jump)
    xmap <C-l> <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    let g:neosnippet#snippets_directory='~/.vim/snippets'

    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif
  endif

  if neobundle#is_installed('unite.vim')
    noremap ee :Unite -buffer-name=files buffer_tab file_mru file<CR>
    noremap et :Unite -buffer-name=tags tag<CR>
    noremap eb :Unite buffer<CR>
    noremap ef :UniteWithBufferDir -buffer-name=files file<CR>
    " search a file in the filetree
    nnoremap e<space> :Unite -start-insert file_rec/async<CR>
  endif

  if neobundle#is_installed('vim-ref.vim')
"    let g:ref_alc_cmd='lynx -dump -nonumbers %s'
    noremap er :Unite ref/

    let g:ref_open = 'vsplit'
    let g:ref_refe_cmd = 'rurema'
    let g:ref_refe_version = 2
  endif

  if neobundle#is_installed('vim-align')
    vnoremap \t- :Align =><CR><CR>
  endif

  if neobundle#is_installed('yankround.vim')
    nmap p <Plug>(yankround-p)
    nmap P <Plug>(yankround-P)
    nmap <C-p> <Plug>(yankround-prev)
    nmap <C-n> <Plug>(yankround-next)

    let g:yankround_max_history = 50
    let g:yankround_dir = '~/.cache/yankround'
  endif

  if neobundle#is_installed('vim-quickrun')
"    silent! nmap <unique> ,r <Plug>(quickrun)
"    silent! vmap <unique> ,r <Plug>(quickrun)
  endif

  if neobundle#is_installed('vim-powerline')
    let g:Powerline_symbols = 'fancy'
    set fillchars+=stl:\ ,stlnc:\
  endif

  if neobundle#is_installed('EnhCommentify.vim')
    let g:EnhCommentifyBindInInsert = 'NO'
  endif

  if neobundle#is_installed('taglist.vim')
    nnoremap <silent> eq :Tlist<CR>
  endif

  if neobundle#is_installed('nerdtree')
    nnoremap <silent> ew :NERDTreeToggle <CR>
  endif

  if neobundle#is_installed('vim-indent-guides')
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_auto_colors = 0
    let g:indent_guides_color_change_persent = 30
    let g:indent_guides_guide_size = 1
    autocmd vimrc VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#221212 ctermbg=234
    autocmd vimrc VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#262626 ctermbg=236
  endif

  if neobundle#is_installed('vim-trailing-whitespace')
    nnoremap \<Space> :FixWhitespace <CR>
  endif

  if neobundle#is_installed('gundo.vim')
    nnoremap <silent> er :GundoToggle<CR>
  endif

  if neobundle#is_installed('syntastic')
    nnoremap <silent> ea :SyntasticToggleMode<Return>
    nnoremap <silent> es :SyntasticCheck<Return>
  endif

  if neobundle#is_installed('unite-ruby-require.vim')
    nnoremap <silent> ur :Unite ruby/require<CR>
    if isdirectory(expand('$HOME/.rbenv'))
      let g:unite_source_ruby_require_ruby_command = '$HOME/.rbenv/shims/ruby'
    endif
  endif

  let s:bundle = neobundle#get('unite.vim')
  function! s:bundle.hooks.on_source(bundle)
    let g:unite_enable_start_insert = 1
    " less delay
    let g:unite_update_time = 80

    " 除外パターン
    let g:unite_source_file_ignore_pattern = '\%(^\|/\)\.$\|\~$\|\.\%(o|exe|dll|bak|sw[po]\)$\|blib/'

    " mru の表示の日付フォーマットを変更
    let g:unite_source_file_mru_time_format = '(%Y-%m-%d %H:%M) '

    " ウィンドウを分割して開く
    autocmd vimrc FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    autocmd vimrc FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')

    " ウィンドウを縦に分割して開く
    autocmd vimrc FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
    autocmd vimrc FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')

    " ESCキーを2回押すと
    autocmd vimrc FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
    autocmd vimrc FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

    let g:unite_source_history_yank_enable = 1
    try
        let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
        call unite#filters#matcher_default#use(['matcher_fuzzy'])
    catch
    endtry
  endfunction
  unlet s:bundle

  let s:bundle = neobundle#get('vim-quickrun')
  function! s:bundle.hooks.on_source(bundle)
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
    endif
  endfunction
  unlet s:bundle

  let s:bundle = neobundle#get('taglist.vim')
  function! s:bundle.hooks.on_source(bundle)
    set tags=tags
  endfunction
  unlet s:bundle

  let s:bundle = neobundle#get('syntastic')
  function! s:bundle.hooks.on_source(bundle)
    let g:syntastic_auto_jump=1
    let g:syntastic_mode_map = {
      \ 'mode'              : 'passive',
      \ 'active_filetypes'  : [],
      \ 'passive_filetypes' : ['c', 'cpp', 'objc'],
      \ }
    let g:syntastic_ruby_checkers = ['rubocop']
  endfunction
  unlet s:bundle

endif

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

" -------------------------------------------------------------------------
" Customize settings.
" -------------------------------------------------------------------------
  " 前回終了したカーソル行に移動
  autocmd vimrc BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

  " open vertical help
"  nnoremap ,h :vert help

  " for spell
"  nnoremap <silent> <C-a> :setl spell!<Return>

  " for window controll
  nnoremap <silent> <C-w><C-l> :vertical resize -6<Return>
  nnoremap <silent> <C-w><C-h> :vertical resize +6<Return>
  nnoremap <silent> <C-w><C-k> :resize -6<Return>
  nnoremap <silent> <C-w><C-j> :resize +6<Return>

  nnoremap <silent> <Space>q :only<Return>

  noremap <Space>h ^
  noremap <Space>l $
  noremap <Space>m %

  " input datetime
"  inoremap <expr> ,df strftime('%Y-%m-%d %H:%M:%S')
"  inoremap <expr> ,dd strftime('%Y-%m-%d')
"  inoremap <expr> ,dt strftime('%H:%M:%S')

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

  syntax on
  colorscheme jellybeans

  autocmd vimrc FileType go    set tabstop=2 softtabstop=2 shiftwidth=2
  autocmd vimrc FileType sh    set tabstop=2 softtabstop=2 shiftwidth=2
  autocmd vimrc FileType zsh   set tabstop=2 softtabstop=2 shiftwidth=2
  autocmd vimrc FileType cpp   set tabstop=2 softtabstop=2 shiftwidth=2
  autocmd vimrc FileType css   set tabstop=2 softtabstop=2 shiftwidth=2
  autocmd vimrc FileType vim   set tabstop=2 softtabstop=2 shiftwidth=2
  autocmd vimrc FileType ruby  set tabstop=2 softtabstop=2 shiftwidth=2
  autocmd vimrc FileType yaml  set tabstop=2 softtabstop=2 shiftwidth=2
  autocmd vimrc FileType slim  set tabstop=2 softtabstop=2 shiftwidth=2
  autocmd vimrc FileType html  set tabstop=2 softtabstop=2 shiftwidth=2
  autocmd vimrc FileType xhtml set tabstop=2 softtabstop=2 shiftwidth=2

  " load ~/.vimrc.local
  if filereadable(expand('$HOME/.vimrc.local'))
    source ~/.vimrc.local
  endif
