au BufNewFile,BufRead *.as   setf actionscript
au BufNewFile,BufRead *.mxml setf mxml

autocmd FileType actionscript :set dictionary=~/.vim/dict/actionscript.dict

au BufNewFile *.mxml 0r $HOME/.vim/templates/actionscript-mxml.txt
