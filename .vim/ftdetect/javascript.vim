au BufNewFile,BufRead *.js set ft=javascript.javascript-jquery

autocmd FileType javascript :set dictionary=~/.vim/dict/javascript_functions.dict

au BufNewFile *.user.js 0r $HOME/.vim/templates/javascript-greasemonkey.txt
