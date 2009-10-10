"=============================================================================
"    Description: Grepヘルパー
"     Maintainer: fuenor@yahoo.co.jp
"                 http://sites.google.com/site/fudist/Home/grep
"  Last Modified: 2009-05-01 23:29
"        Version: 1.35
" vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker:
"=============================================================================
scriptencoding utf-8

"使い方
"
":Grep   : 通常のgrep
":VGrep  : vimgrepでgrep
":FGrep  : 正規表現を使わないで検索
":BGrep  : 現在開いているバッファのみ対象にgrep (無名バッファは検索できない。)
"
"    * メニューのツール(T)から実行する。
"    * .vimrcにキーマップを追加して実行する。
"      .vimrc設定例
"
"      "この設定例ではg,が使用できなくなります。好みに応じて変更して下さい。
"      nnoremap g,b  :BGrep<CR>
"      nnoremap g,e  :Grep!<CR>
"      nnoremap g,f  :FGrep!<CR>
"      nnoremap g,v  :VGrep!<CR>
"      "ヤンクした文字列でgrep
"      nnoremap g,rf :exec 'FGrep! '. expand(@0)<CR>
"      nnoremap g,rv :exec 'VGrep! '. expand(@0)<CR>
"      "選択中の文字列でgrep
"      vmap g,f  vgvyg,rf
"      vmap g,v  vgvyg,rv
"
"    * コマンドラインから実行する
"
":Grep
"
":Grep! のように'!'を指定すると、開いているファイルと同じディレクトリを基準にgrepします。
"したがって autochdir を設定している場合には違いはありません。
"メニューから実行する、では'!'を使用しています。
"
"grep後、検索レジスタにはgrepした文字列が登録されます。
"検索するファイルを指定する際、**/*.vimのように **/を付けて指定すると再帰的にgrepを行います。
"外部grepの場合は *.vim **/ のように最後に指定しても有効になります。
"
"外部grepを使用する場合、検索対象ファイルの文字エンコードは 現在開いているファイルと同じと仮定して実行されます。
"よって異なる文字エンコードのファイルは検索されません。
"vimgrepならファイルエンコードは自動判別されます。
"
"外部grepに独自のオプションを指定して実行したい場合は、 MyGrepcmd_useroptに設定します。
"
"let MyGrepcmd_useropt = '-hoge'
"


"----------以下は変更しないで下さい----------
if exists('disable_MyGrep') && disable_MyGrep != 0
  finish
endif
if !exists('fudist') && exists("loaded_MyGrep")
  finish
endif
let loaded_MyGrep = 1

"メニューへの登録
amenu <silent> 30.331 &Tools.Grep(&G)<Tab>:Grep  :Grep!<CR>
amenu <silent> 30.332 &Tools.Fgrep(&G)<Tab>:FGrep  :FGrep!<CR>
amenu <silent> 30.333 &Tools.GrepBuffer(&G)<TAB>:BGrep :BGrep<CR>
amenu <silent> 30.334 &Tools.VGrep(&V)<Tab>:VGrep  :VGrep!<CR>

if !exists('QFix_Height')
  let QFix_Height = 10
endif
if !exists('QFix_HeightMax')
  let QFix_HeightMax = 0
endif
if !exists('QFix_HeightDefault')
  let QFix_HeightDefault = QFix_Height
endif
if !exists('QFix_HeightFixMode')
  let QFix_HeightFixMode = 0
endif
if !exists('g:MyGrep_Damemoji')
  let g:MyGrep_Damemoji = 2
endif
"2byte目が0x5cの「ダメ文字」
let g:MyGrep_DamemojiReplaceDefault = ['[]','[ーソЫⅨ噂浬欺圭構蚕十申曾箪貼能表暴予禄兔喀媾彌拿杤歃濬畚秉綵臀藹觸軆鐔饅鷭偆砡纊犾]', '[ー―‐／＼＋±×ＡァゼソゾタダチボポマミАЪЫЬЭЮЯклмнⅨ院閏噂云運雲荏閲榎厭円魁骸浬馨蛙垣柿顎掛笠樫機擬欺犠疑祇義宮弓急救掘啓圭珪型契形鶏芸迎鯨后梗構江洪浩港砿鋼閤降察纂蚕讃賛酸餐施旨枝止宗充十従戎柔汁旬楯殉淳拭深申疹真神秦須酢図厨繊措曾曽楚狙疏捜掃挿掻叩端箪綻耽胆蛋畜竹筑蓄邸甜貼転顛点伝怒倒党冬如納能脳膿農覗倍培媒梅鼻票表評豹廟描府怖扶敷法房暴望某棒冒本翻凡盆諭夕予余与誉輿養慾抑欲蓮麓禄肋録論倭僉兌兔兢竸兩兪几處凩凭咫喙喀咯喊喟啻嘴嘶嘲嘸奸媼媾嫋嫂媽嫣學斈孺宀廖彈彌彎弯彑彖悳忿怡恠戞拏拿拆擔拈拜掉掟掵捫曄杣杤枉杰枩杼桀桍栲桎檗歇歃歉歐歙歔毬毫毳毯漾濕濬濔濘濱濮炮烟烋烝瓠畆畚畩畤畧畫痣痞痾痿磧禺秉秕秧秬秡窖窩竈窰紂綣綵緇綽綫總縵縹繃縷隋膽臀臂膺臉臍艝艚艟艤蕁藜藹蘊蘓蘋藾蛔蛞蛩蛬襦觴觸訃訖訐訌諚諫諳諧蹇躰軆躱躾軅軈轆轎轗轜錙鐚鐔鐓鐃鐇鐐閔閖閘閙顱饉饅饐饋饑饒驅驂驀驃鵝鷦鷭鷯鷽鸚鸛黠黥黨黯纊倞偆偰偂傔垬埈埇犾劯砡硎硤硺葈蒴蕓蕙∵纊褜鍈銈蓜傔僘兊涖犱犾猤獷玽硺髜]', '[ーソЫⅨ噂浬欺圭構蚕十申曾箪貼能表暴予禄兔喀媾彌拿杤歃濬畚秉綵臀藹觸軆鐔饅鷭偆砡纊犾－ポл榎掛弓芸鋼旨楯酢掃竹倒培怖翻慾處嘶斈忿掟桍毫烟痞窩縹艚蛞諫轎閖驂黥埈蒴僴礰]']
if !exists('mygrepprg')
  let mygrepprg = 'internal'
endif
if !exists('g:MyGrep_ShellEncoding')
  let g:MyGrep_ShellEncoding = 'cp932'
endif
if !exists('g:MyGrep_DamemojiReplaceReg')
  let g:MyGrep_DamemojiReplaceReg = '(..)'
endif
if !exists('g:MyGrep_DamemojiReplace')
  let g:MyGrep_DamemojiReplace = '[]'
endif
if !exists('g:MyGrep_ExcludeReg')
  let g:MyGrep_ExcludeReg = '[~#]$\|\.bak$\|\.o$\|\.obj$\|\.exe$\|[/\\]tags$'
endif

if exists('enable_MyGrep')
  let disable_MyGrep = !enable_MyGrep
endif

if exists('disable_MyGrep') && disable_MyGrep != 0
  finish
endif

""""""""""""""""""""""""""""""
"ユーザ呼び出し用コマンド
""""""""""""""""""""""""""""""
command! -nargs=? -bang BGrep call BGrep("<args>", <bang>0)
command! -nargs=? -bang Grep  call Grep("<args>", <bang>0, 'Grep')
command! -nargs=? -bang FGrep call FGrep("<args>", <bang>0)
command! -nargs=? -bang VGrep call VGrep("<args>", <bang>0)

""""""""""""""""""""""""""""""
"ユーザ呼び出し用コマンド本体
""""""""""""""""""""""""""""""
command! -bang ToggleDamemoji let MyGrep_Damemoji = <bang>0?2:!MyGrep_Damemoji|echo 'Damemoji '.(MyGrep_Damemoji?'ON':'OFF')
function! VGrep(word, mode)
  let g:MyGrep_UseVimgrep = 1
  call Grep(a:word, a:mode, 'VGrep')
endfunction

""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
function! VFGrep(word, mode)
  let pattern = escape(a:word, '\\/.*$^~[]')
  let pattern = substitute(pattern, '\n$', '', '')
  let g:MyGrep_UseVimgrep = 1
  call FGrep(pattern, a:mode, 'VFGrep')
endfunction

""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
function! FGrep(word, mode)
  let pattern = a:word
"  let pattern = escape(a:word, '\\/.*$^~[]')
"  let pattern = substitute(pattern, "\n$", '', '')
  let g:MyGrep_Regexp = 0
  call Grep(pattern, a:mode, 'FGrep')
endfunction

""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
function! Grep(word, mode, title)
  let pattern = a:word
  if pattern == ''
    let pattern = expand("<cword>")
    let pattern = input(a:title." : ", pattern)
  endif
"  let pattern = escape(pattern, '\\/.*$^~[]')
"  let pattern = substitute(pattern, '\n$', '', '')
  if pattern == ''
    let g:MyGrep_Regexp = 1
    let g:MyGrep_Ignorecase = 1
    let g:MyGrep_Recursive  = 0
    let g:MyGrep_UseVimgrep = 0
    return
  endif
"  let filepattern = '*.c *.cpp *.h *.txt *.vim *.php *.pl *.js'
  let filepattern = '*'
  if expand('%:e') != ''
    let filepattern = '*.' . expand('%:e')
  endif
  let filepattern = input("file : ", filepattern)
  if filepattern == '' | return | endif
  let @/ = pattern
  if match(pattern, '\C[A-Z]') != -1
    let g:MyGrep_Ignorecase = 0
  endif
  if a:mode
    let searchPath = expand('%:p:h')
  else
    let searchPath = getcwd()
  endif
  let fenc = &fileencoding
  if fenc == ''
    let fenc = &enc
  endif
  let prevPath = getcwd()
  let prevPath = escape(prevPath, ' ')
  call MyGrep(pattern, searchPath, filepattern, fenc)
  if g:QFix_SearchPath != ''
    silent exec 'lchdir ' . escape(g:QFix_SearchPath, ' ')
  endif
  let save_qflist = getqflist()
  if empty(save_qflist)
    redraw | echo 'QFixGrep : Not found!'
    if s:MyGrep_ErrorMes != ''
      echohl ErrorMsg
      redraw | echo s:MyGrep_ErrorMes
      echohl None
    endif
  else
    if &lines - g:QFix_HeightMax > 0 && g:QFix_Height > &lines - g:QFix_HeightMax
      let g:QFix_Height = &lines - g:QFix_HeightMax
    endif
    if g:QFix_HeightFixMode == 1
      let g:QFix_Height = g:QFix_HeightDefault
    endif
    silent! exec 'copen ' . g:QFix_Height
    let g:QFix_Win = bufnr('$')
  endif
  silent exec 'lchdir ' . prevPath
endfunction

""""""""""""""""""""""""""""""
"バッファのみgrep
"無名バッファは検索できない。
""""""""""""""""""""""""""""""
function! BGrep(word, mode)
  let pattern = a:word
  if pattern == ''
    let pattern = expand("<cword>")
    let pattern = input("Buffers grep : ", pattern)
  endif
"  let pattern = escape(pattern, '\\/.*$^~[]')
"  let pattern = substitute(pattern, '\n$', '', '')
  if pattern == '' | return | endif
  let @/ = pattern
  let bufnr = bufnr('%')
  let save_cursor = getpos('.')
  silent! cexpr ''
  silent! pclose
  silent! cclose
  silent! exec ':bufdo | try | vimgrepadd /' . pattern . '/j % | catch | endtry'
  silent! exec 'b'.bufnr
  let g:QFix_MyJump = 1
  let g:QFix_SelectedLine = 1
  let g:QFix_SearchPath = expand('%:p:h')
  let g:QFix_SearchResult = ''
  let save_qflist = getqflist()
  if empty(save_qflist)
    redraw | echo 'QFixGrep : Not found!'
  else
    if &lines - g:QFix_HeightMax > 0 && g:QFix_Height > &lines - g:QFix_HeightMax
      let g:QFix_Height = &lines - g:QFix_HeightMax
    endif
    if g:QFix_HeightFixMode == 1
      let g:QFix_Height = g:QFix_HeightDefault
    endif
    silent! exec 'copen ' . g:QFix_Height
    let g:QFix_Win = bufnr('$')
  endif
endfunction

""""""""""""""""""""""""""""""
"grep helper
""""""""""""""""""""""""""""""
if !exists('g:MyGrepcmd')
  let g:MyGrepcmd = '"#prg#" #defopt# #recopt# #opt# #useropt# -f #searchWordFile# #searchPath#'
endif
if !exists('g:MyGrepcmd_useropt')
  let g:MyGrepcmd_useropt = ''
endif
if !exists('g:MyGrepcmd_regexp')
  let g:MyGrepcmd_regexp = '-nHIE'
endif
if !exists('g:MyGrepcmd_regexp_ignore')
  let g:MyGrepcmd_regexp_ignore = '-nHIEi'
endif
if !exists('g:MyGrepcmd_fix')
  let g:MyGrepcmd_fix = '-nHIF'
endif
if !exists('g:MyGrepcmd_fix_ignore')
  let g:MyGrepcmd_fix_ignore = '-nHIFi'
endif
"オプション
if !exists('g:MyGrep_StayGrepDir')
  let g:MyGrep_StayGrepDir = 1
endif
if !exists('g:MyGrep_Ignorecase')
  let g:MyGrep_Ignorecase = 1
endif
if !exists('g:MyGrep_Regexp')
  let g:MyGrep_Regexp = 1
endif
if !exists('g:MyGrep_Recursive')
  let g:MyGrep_Recursive = 0
endif

if !exists('g:MyGrep_yagrep_opt')
  let g:MyGrep_yagrep_opt = 0
endif
if !exists('g:QFix_SearchPath')
  let g:QFix_SearchPath = ''
endif

"一時的にvimgrepを使用したいときに非0。使用後リセットされる。
let g:MyGrep_UseVimgrep = 0

""""""""""""""""""""""""""""""
"汎用Grep関数
"vimgrepならfencは無視される。
"addflag : grep検索結果追加
""""""""""""""""""""""""""""""
function! MyGrepadd(pattern, searchPath, filepattern, fenc)
  return MyGrep(a:pattern, a:searchPath, a:filepattern, a:fenc, 1)
endfunction

function! MyGrep(pattern, searchPath, filepattern, fenc, ...)
  let addflag = 0
  if a:0 > 0
    let addflag = a:1
  endif
  let searchPath = a:searchPath
  let pattern = a:pattern
  let prevPath = getcwd()
  let prevPath = escape(prevPath, ' ')
  if g:MyGrep_ExcludeReg == ''
    let g:MyGrep_ExcludeReg = '^$'
  endif
  if exists('*QFixSaveHeight')
    call QFixSaveHeight(0)
  endif
  if a:fenc =~ 'le$'
    let g:MyGrep_UseVimgrep = 1
    redraw | echo 'Use vimgrep(fenc = '.a:fenc .')'
  endif
  if g:mygrepprg == 'internal' || g:mygrepprg == '' || g:MyGrep_UseVimgrep != 0
    silent! pclose
    silent! cclose
    let saved_ac = &autochdir
    set noautochdir
    let saved_ss = &shellslash
"    set shellslash
    silent exec 'lchdir ' . escape(searchPath, ' ')
    if addflag
      silent! exec ':vimgrepadd /' . pattern . '/j ' . a:filepattern
    else
      silent! cexpr ''
      silent! exec ':vimgrep /' . pattern . '/j ' . a:filepattern
    endif
    "ここでバッファ削除
    let idx = 0
    let save_qflist = getqflist()
    for d in save_qflist
      if bufname(d.bufnr) =~ g:MyGrep_ExcludeReg
        call remove(save_qflist, idx)
        silent! exec 'silent! bd ' . d.bufnr
      else
        let idx = idx + 1
      endif
    endfor
    call setqflist(save_qflist)
    let &autochdir = saved_ac
"    let &shellslash = saved_ss
    if g:MyGrep_StayGrepDir == 0
      silent exec 'lchdir ' . prevPath
    endif
    let g:MyGrep_Regexp = 1
    let g:MyGrep_Ignorecase = 1
    let g:MyGrep_Recursive  = 0
    let g:MyGrep_UseVimgrep = 0
    " MyQFixライブラリを使用可能にする。
    let g:QFix_MyJump = 1
    let g:QFix_SelectedLine = 1
    let g:QFix_SearchPath = searchPath
    let g:QFix_SearchResult = ''
    return
  endif
  if !executable(g:mygrepprg)
    echohl ErrorMsg
    redraw|echom g:mygrepprg." is not executable!"
    echohl None
    let g:MyGrep_Regexp = 1
    let g:MyGrep_Ignorecase = 1
    let g:MyGrep_Recursive  = 0
    let g:MyGrep_UseVimgrep = 0
    return
  endif
  silent! pclose
  silent! cclose
  if g:MyGrep_ShellEncoding =~ 'utf8\c'
    let g:MyGrep_ShellEncoding = 'utf-8'
  endif
  if g:mygrepprg =~ 'yagrep\c'
    if g:MyGrep_yagrep_opt == 2
      let g:MyGrep_Damemoji = 0
    endif
  endif
  let _grepcmd = 'g:MyGrepcmd_regexp'
  if g:MyGrep_Regexp == 0
    let _grepcmd = 'g:MyGrepcmd_fix'
    let g:MyGrep_Regexp = 1
  else
    "だめ文字対策
    if g:MyGrep_Damemoji != 0 && a:fenc == 'cp932'
      let pp = substitute(pattern, g:MyGrep_DamemojiReplaceDefault[2], '', 'g')
      let pp = substitute(pp, '[\\.()?+{}\[\]*]', '', 'g')
      if pp =~ '^\s*$'
        let s:MyGrep_ErrorMes = "ダメ文字しか含まれていません!"
        silent! cexpr ''
        let g:MyGrep_Regexp = 1
        let g:MyGrep_Ignorecase = 1
        let g:MyGrep_Recursive  = 0
        let g:MyGrep_UseVimgrep = 0
        return
      endif
      let pattern = substitute(pattern, g:MyGrep_DamemojiReplaceDefault[g:MyGrep_Damemoji], g:MyGrep_DamemojiReplaceReg, 'g')
      let pattern = substitute(pattern, g:MyGrep_DamemojiReplace, g:MyGrep_DamemojiReplaceReg, 'g')
    endif
  endif
  if g:MyGrep_Ignorecase > 0
    let _grepcmd = _grepcmd.'_ignore'
  endif
  let g:MyGrep_Ignorecase = 1
  let grepcmd = substitute(g:MyGrepcmd, '#defopt#', {_grepcmd}, '')
  let grepcmd = substitute(grepcmd, '#useropt#', g:MyGrepcmd_useropt, '')
  let retval = s:ExecGrep(grepcmd, g:mygrepprg, searchPath, pattern, &enc, a:fenc, a:filepattern)
  let pattern = s:ParseFilepattern(a:filepattern)
  let retval = s:ParseSearchResult(retval, pattern, g:MyGrep_ShellEncoding, a:fenc)
  call s:SetQFix(retval, pattern, g:MyGrep_ShellEncoding, a:fenc, addflag)
  if g:MyGrep_StayGrepDir == 0
    silent exec 'lchdir ' . prevPath
  endif
  " MyQFixライブラリを使用可能にする。
  let g:QFix_MyJump = 1
  let g:QFix_SelectedLine = 1
  let g:QFix_SearchPath = searchPath
  let g:QFix_SearchResult = ''
endfunction

let s:MyGrep_ErrorMes = ''
""""""""""""""""""""""""""""""
"検索語ファイルを作成してgrep
""""""""""""""""""""""""""""""
function! s:ExecGrep(cmd, prg, searchPath, searchWord, from_encoding, to_encoding, filepattern)
  " iconv が使えない
  let s:MyGrep_ErrorMes = ''
  if a:from_encoding != a:to_encoding && !has('iconv')
"    echoe 'QFixGrep : not found iconv!'
    let s:MyGrep_ErrorMes = 'QFixGrep : not found iconv!'
    return
  endif

  let cmd = a:cmd
  " プログラム設定
  let prg = escape(a:prg, '\\')
  let cmd = substitute(cmd, '#prg#', prg, 'g')

  let sPath = '*'
  let ropt = ''
  let opt = ''

  " 検索パス設定
  if match(a:filepattern, '\*\*/') != -1
    let g:MyGrep_Recursive = 1
  endif
  if g:MyGrep_Recursive == 1
    let ropt = '-r'
    let g:MyGrep_Recursive = 0
  endif
  if g:mygrepprg =~ 'yagrep\c'
    if a:to_encoding =~ 'cp932\c'
      let opt = '--ctype=SJIS'
    elseif a:to_encoding =~ 'euc\c'
      let opt = '--ctype=EUC'
    elseif a:to_encoding =~ 'utf-8\c'
      let opt = '--ctype=UTF8'
    endif
    let opt = opt .' -s'
    if g:MyGrep_yagrep_opt == 0
      let opt = ' -s'
    endif
  endif
  let cmd = substitute(cmd, '#recopt#', ropt, '')
  let cmd = substitute(cmd, '#opt#', opt, '')
  let cmd = substitute(cmd, '#searchPath#', escape(sPath, '\\'), 'g')

  " 検索語ファイル作成
  if match(cmd, '#searchWordFile#') != -1
    let tempname = tempname()
    let opencmd = 'split'
    if a:from_encoding != a:to_encoding
      let opencmd = opencmd.' ++enc='.a:to_encoding
    endif
    let opencmd = opencmd.' '.tempname
    silent! exe opencmd
    unlet opencmd
    call setline(1, a:searchWord)
    silent! setlocal binary noendofline
    silent! exec 'set fenc='.a:to_encoding
    silent! w
    silent! bwipeout
    let cmd = substitute(cmd, '#searchWordFile#', s:GrepEscapeVimPattern(tempname), 'g')
  endif

  " 検索実行
  let prevPath = getcwd()
  let prevPath = escape(prevPath, ' ')
  silent exec 'lchdir ' . escape(a:searchPath, ' ')
"  let g:ggg = cmd
  let retval = system(cmd)
  if exists('tempname')
    call delete(tempname)
  endif
  return retval
endfunction

""""""""""""""""""""""""""""""
"ファイルパターンを変換
""""""""""""""""""""""""""""""
function! s:ParseFilepattern(filepattern)
  let filepattern = a:filepattern
  let filepattern = substitute(filepattern, '\*\*/', '', 'g')
  let filepattern = substitute(filepattern, '\s\+', ' ', 'g')
  let filepattern = substitute(filepattern, '^\s\|\s$', '', 'g')
  if filepattern == '*'
    let filepattern = '.*'
  else
    let filepattern = substitute(filepattern, ' ', '$\\|', 'g')
    let filepattern = substitute(filepattern, '\.', '\\.', 'g')
    let filepattern = substitute(filepattern, '^*', '\.*', 'g')
    let filepattern = substitute(filepattern, '\\|\*', '\\|\.\*', 'g')
    let filepattern = filepattern.'$'
  endif
  return filepattern
endfunction

""""""""""""""""""""""""""""""
"quickfix登録前処理
""""""""""""""""""""""""""""""
function! s:ParseSearchResult(searchResult, filepattern, shellenc, fenc)
  if &enc == a:shellenc && &enc == 'cp932' && a:fenc != 'cp932'
    return a:searchResult
  endif
  let parseResult = ''
  let searchResult = a:searchResult
  let prevfname = ''
  let mtime = 0
  while 1
    let idx = match(searchResult, "\<NL>")
    if idx == -1
      break
    endif
    let buf          = strpart(searchResult, 0, idx)
    let searchResult = strpart(searchResult, idx + 1)
    let bufidx       = matchend(buf, ":[0-9]\\+:", 0, 1)
    let extidx       = match(buf, ":[0-9]\\+:", 0, 1)
    let file         = strpart(buf, 0, bufidx)
    let file         = iconv(file, a:shellenc, &enc)
    let fname        = strpart(buf, 0, extidx)
    let fname        = iconv(fname, a:shellenc, &enc)
    let ext          = strpart(buf, 0, extidx)
    let buf          = strpart(buf, bufidx)
    let content      = iconv(buf, a:fenc, &enc)
    let content      = strpart(content, 0, 1024-strlen(file)-32)
    if ext =~ a:filepattern && fname !~ g:MyGrep_ExcludeReg
      let parseResult = parseResult . file . content . "\<NL>"
    endif
  endwhile
  return parseResult
endfunction

""""""""""""""""""""""""""""""
"quickfixに登録
""""""""""""""""""""""""""""""
function! s:SetQFix(result, filepattern, shellenc, fenc, addflag)
  let result = a:result
  let tmpfile = tempname()
  let saved_verbose = &verbose
  set verbose&vim
  exe 'redir! > ' . tmpfile
  silent echon result
  redir END
  let &verbose = saved_verbose

  let saved_efm = &efm
  set errorformat=%f:%\\s%#%l:%m
  if a:addflag
    silent! execute 'silent! caddfile ' . tmpfile
  else
    silent! cexpr ''
    silent! execute 'silent! cgetfile ' . tmpfile
  endif
  let &errorformat = saved_efm
  call delete(tmpfile)
  "grepの結果が前処理なしに直接渡されている場合
  let save_qflist = getqflist()
  if &enc == a:shellenc && &enc == 'cp932' && a:fenc != 'cp932'
"    let save_qflist = getqflist()
    let idx = 0
    let saved_ss = &shellslash
"    set shellslash
    for d in save_qflist
      if bufname(d.bufnr) !~ a:filepattern || empty(d.lnum) || empty(bufname(d.bufnr)) || bufname(d.bufnr) =~ g:MyGrep_ExcludeReg
        call remove(save_qflist, idx)
        silent! exec 'silent! bw ' . d.bufnr
      else
        let d.text = iconv(d.text, a:fenc, &enc)
        let idx = idx + 1
      endif
    endfor
"    let &shellslash = saved_ss
    call setqflist(save_qflist)
  endif
  return 0
endfunction

""""""""""""""""""""""""""""""
"正規表現エスケープ
""""""""""""""""""""""""""""""
function! s:GrepEscapeVimPattern(pattern)
  let retval = escape(a:pattern, '\\.*+@{}<>~^$()|?[]%=&')
  let retval = retval
  return retval
endfunction

