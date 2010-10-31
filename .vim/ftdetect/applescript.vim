au BufNewFile,BufRead *.scpt setf applescript

autocmd FileType applescript :inoremap <buffer> <S-CR>  ¬<CR> 
