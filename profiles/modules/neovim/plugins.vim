" Lualine 
" -----------------------------------------------------------------------------
lua << EOF
local present, lualine = pcall(require, "lualine")
if not present then
  return
end
lualine.setup {
  options = { 
    theme = 'gruvbox-flat',
    icons_enabled = true
  }
}
EOF
"

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


" Toggleterm
" -----------------------------------------------------------------------------
lua require("toggleterm").setup{float_opts = { border = 'curved' }}
nnoremap <c-t>h <Cmd>exe v:count1 . "ToggleTerm direction=horizontal"<cr>
nnoremap <c-t>f <Cmd>exe v:count1 . "ToggleTerm direction=float"<cr>
nnoremap <c-t>t <Cmd>exe v:count1 . "ToggleTerm direction=tab"<cr>
nnoremap <c-t>v <Cmd>exe v:count1 . "ToggleTerm direction=vertical"<cr>
tnoremap <c-t> <cmd>ToggleTerm<cr>


" Git-Blame
" -----------------------------------------------------------------------------
let g:gitblame_enabled = 1  " turned off
let g:gitblame_date_format = '%Y-%m-%d'
let g:gitblame_message_template = '        <author> ~ <date>'
let g:gitblame_ignored_filetypes = ['nerdtree']


" Neoscroll 
" -----------------------------------------------------------------------------
lua require('neoscroll').setup()


" NERDTree
" -----------------------------------------------------------------------------
nnoremap <C-n>n <cmd>NERDTreeToggle<CR>
nnoremap <C-n>f <cmd>NERDTreeFocus<CR>

let NERDTreeMinimalUI=1


" Minimap 
" -----------------------------------------------------------------------------
let g:minimap_width = 10
let g:minimap_auto_start = 0
let g:minimap_auto_start_win_enter = 1
let g:minimap_git_colors = 1
highlight minimapCursor ctermbg=59  ctermfg=228 guibg=#282828 guifg=#928374

nnoremap <leader>mm <cmd>MinimapToggle<cr>


" Telescope 
" -----------------------------------------------------------------------------
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


" COC-Python 
" -----------------------------------------------------------------------------
nnoremap <leader>fmt <cmd>call CocAction('format')<cr>
nnoremap <leader>imp <cmd>CocCommand pyright.organizeimports<cr>
nnoremap def <Plug>(coc-definition)


" Diffview
" -----------------------------------------------------------------------------
nnoremap <leader>hst <cmd>DiffviewFileHistory %<cr>
