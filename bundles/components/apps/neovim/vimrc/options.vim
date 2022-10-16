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
let g:gruvbox_number_column = 'bg2'
let g:gruvbox_contrast_dark = 'dark'

set background=dark
colorscheme gruvbox

highlight clear LineNr
highlight LineNr guifg=gray

autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
