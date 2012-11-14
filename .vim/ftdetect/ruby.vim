autocmd FileType ruby :set dictionary=~/.vim/dict/ruby_functions.dict

au BufNewFile *.rb 0r $HOME/.vim/templates/ruby-script.txt
