au BufNewFile,BufRead *.scpt set ft=applescript

autocmd FileType applescript :inoremap <buffer> <S-CR>  ¬<CR> 
