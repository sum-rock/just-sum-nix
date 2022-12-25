set mouse=a
set number
set numberwidth=2
set shiftwidth=2
set tabstop=2
set expandtab
set nowrap
set hidden    " Requred for toggleterm 


" Remaps
" -----------------------------------------------------------------------------
imap jj <esc>
vmap oo <esc>
nnoremap <Leader>/ <cmd>noh<cr>
nnoremap bn <cmd>bn<cr>
nnoremap bp <cmd>bp<cr>
nnoremap bw <cmd>bw<cr><cmd>bn<cr>


" Colors
" -----------------------------------------------------------------------------

set background=dark
colorscheme gruvbox-flat

highlight clear LineNr
highlight LineNr guifg=gray
highlight clear SignColumn

" :h coc-highlights
highlight CocInlayHint guibg=clear guifg=gray
highlight CocErrorSign guibg=clear
highlight CocWarningSign guibg=clear
highlight CocInfoSign guibg=clear
highlight CocHintSign guibg=clear

highlight GitGutterAdd guibg=clear
highlight GitGutterChange guibg=clear
highlight GitGutterDelete guibg=clear

" Required if using opacity alpha in alacritty.yml
" autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE