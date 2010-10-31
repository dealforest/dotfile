au BufNewFile,BufRead *.as   set filetype=actionscript
au BufNewFile,BufRead *.mxml set filetype=mxml

au BufNewFile *.mxml 0r $HOME/.vim/templates/actionscript-mxml.txt
