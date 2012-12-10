set tabstop=2 softtabstop=2 shiftwidth=2 softtabstop=0

iabbrev ,# # =========================================================================
iabbrev .# # -------------------------------------------------------------------------

" -------------------------------------------------------------------------
" unite-ruby-require.vim
" -------------------------------------------------------------------------
  nnoremap <silent> ur :Unite ruby/require<CR>
  if isdirectory(expand('$HOME/.rbenv'))
    let g:unite_source_ruby_require_ruby_command = '$HOME/.rbenv/shims/ruby'
  endif
