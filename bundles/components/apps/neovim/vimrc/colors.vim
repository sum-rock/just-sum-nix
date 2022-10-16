let g:gruvbox_number_column = 'bg2'
let g:gruvbox_contrast_dark = 'dark'

set background=dark
colorscheme gruvbox

highlight clear LineNr
highlight LineNr guifg=gray

autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE

