augroup filetypedetect
  autocmd! BufNewFile,BufRead *.t setf perl
  autocmd! BufNewFile,BufRead *.psgi setf perl
augroup END 
au BufNewFile,BufRead *.cgi set ft=perl
au BufNewFile,BufRead *.pm set ft=perl
au BufNewFile,BufRead *.pdat set ft=perl

autocmd FileType perl :set dictionary=~/.vim/dict/perl_functions.dict

au BufNewFile *.pl 0r $HOME/.vim/templates/perl-script.txt
au BufNewFile *.pm 0r $HOME/.vim/templates/perl-module.txt
au BufNewFile *.t  0r $HOME/.vim/templates/perl-test.txt
