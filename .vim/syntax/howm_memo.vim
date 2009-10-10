"
" Vim syntax file
"
" Language:howm
" Maintainer:
" Last Change:

scriptencoding cp932

if &background == 'dark'
  hi howmTodo ctermfg=DarkYellow ctermbg=Grey guifg=Yellow
  hi howmTodoUD ctermfg=Magenta ctermbg=Grey guifg=LightRed
  hi howmSchedule ctermfg=DarkGreen ctermbg=Grey guifg=Green
  hi howmReminder ctermfg=Blue ctermbg=Grey guifg=cyan
else
  hi howmTodo ctermfg=DarkYellow ctermbg=Grey guifg=DarkYellow
  hi howmTodoUD ctermfg=Magenta ctermbg=Grey guifg=darkMagenta
  hi howmSchedule ctermfg=DarkGreen ctermbg=Grey guifg=DarkGreen
  hi howmReminder ctermfg=Blue ctermbg=Grey guifg=Blue
endif
hi howmDeadline ctermfg=Red ctermbg=Grey guifg=Red
hi howmHoliday ctermfg=magenta ctermbg=Grey guifg=Magenta
hi howmSpecial ctermfg=Red ctermbg=Grey guifg=Red
hi howmFinished ctermfg=DarkGrey ctermbg=Grey guifg=DarkGrey

hi def link txtLabelDate        Constant
hi def link txtUrl              Underlined
hi def link txtFile             Underlined

if exists('g:QFixHowm_Title')
  exec 'syntax match Title display "^'.g:QFixHowm_Title.'\zs .*\ze" contains=ALL'
endif

let pattern = '\c^\[\d\{4}-\d\{2}-\d\{2}\( \d\{2}:\d\{2}\)\?]'
let epat = '\{1,3}\((\([0-9]\+\)\?\([-+*]\?\(Sun\|Mon\|Tue\|Wed\|Thu\|Fri\|Sat\)\?\))\)\?[0-9]*'
exec 'syntax match howmSchedule display "'.pattern.'@' . epat .'" contains=Underlined'
exec 'syntax match howmDeadline display "'.pattern.'!' . epat .'" contains=Underlined'
exec 'syntax match howmTodo     display "'.pattern.'+' . epat .'" contains=Underlined'
exec 'syntax match howmReminder display "'.pattern.'-' . epat .'" contains=Underlined'
exec 'syntax match howmTodoUD   display "'.pattern.'\~'. epat .'" contains=Underlined'
exec 'syntax match howmFinished display "'.pattern.'\."'
syntax match txtLabelDate display "\d\+-\k\+-\d\+\(\.\)\="
syntax match txtLabelDate display "\d\+/\k\+/\d\+\(\.\)\="
syntax match txtLabelDate display "\d\+:\k\+\(\.\)\="
syntax match txtLabelDate display "^\d\+:\k\+:\d\+\(\.\)\="

let pattern = '\d\{4}-\d\{2}-\d\{2}'
exec 'syntax match Underlined display "'.pattern.'"'

syntax match txtUrl  display "\(https\|http\|ftp\):[-!#%&+,./0-9:;=?@A-Za-z_~]\+"
syntax match txtFile display '\([A-Za-z]:[/\\]\|\~\/\)[-!#%&+,./0-9:;=?@A-Za-z_~\\]\+'


