" Vim Airliner
" -----------------------------------------------------------------------------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline_theme="base16_gruvbox_dark_hard"


" Bufferline
" -----------------------------------------------------------------------------
set termguicolors
lua << EOF
local present, bufferline = pcall(require, "bufferline")
if not present then
  return
end
bufferline.setup {
  options = {
    offsets = { {
      filetype = "nerdtree",
      text = "File Explorer",
      highlight = "Directory"
    } },
    separator_style = "thick"
  }
}
EOF


" Git-Blame
" -----------------------------------------------------------------------------
let g:gitblame_enabled = 1
let g:gitblame_date_format = '%Y-%m-%d'
let g:gitblame_message_template = '|   <author> ~ <date>   |'
let g:gitblame_ignored_filetypes = ['nerdtree']

" Minimap 
" -----------------------------------------------------------------------------
let g:minimap_width = 10
let g:minimap_auto_start = 0
let g:minimap_auto_start_win_enter = 1
let g:minimap_git_colors = 1

:highlight minimapCursor ctermbg=59  ctermfg=228 guibg=#282828 guifg=#928374


" Neoscroll 
" -----------------------------------------------------------------------------
lua require('neoscroll').setup()


" NERDTree 
" -----------------------------------------------------------------------------
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-N> :NERDTreeToggle<CR>

let NERDTreeMinimalUI=1


" Telescope 
" -----------------------------------------------------------------------------
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" COC-Python 
" -----------------------------------------------------------------------------
nnoremap <leader>pyo <cmd>CocCommand python.organizeimports<cr>
nnoremap <leader>pyf <cmd>call CocAction('format')<cr>

