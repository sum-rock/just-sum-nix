set mouse=a
set number
set numberwidth=2
set shiftwidth=2
set tabstop=2
set expandtab
set nowrap
set cursorline


" Remaps
" -----------------------------------------------------------------------------
imap jj <esc>
vmap oo <esc>
nnoremap <Leader>/ :noh<enter>
nnoremap bn :bn<enter>


" Colors
" -----------------------------------------------------------------------------

set background=dark
colorscheme gruvbox

highlight clear LineNr
highlight LineNr guifg=gray
highlight clear SignColumn

autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
