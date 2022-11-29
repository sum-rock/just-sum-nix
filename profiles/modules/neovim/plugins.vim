"" Lualine 
"" -----------------------------------------------------------------------------
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

"" Bufferline
"" -----------------------------------------------------------------------------
set termguicolors
lua << EOF
local present, bufferline = pcall(require, "bufferline")
if not present then
  return
end
bufferline.setup {
  options = {
    offsets = { {
      filetype = "NvimTree",
      text = "File Explorer",
      highlight = "Directory"
    } },
    separator_style = "thick"
  }
}
EOF


"" Toggleterm
"" -----------------------------------------------------------------------------
lua require("toggleterm").setup{float_opts = { border = 'curved' }}
nnoremap <c-t>h <Cmd>exe v:count1 . "ToggleTerm direction=horizontal"<cr>
nnoremap <c-t>f <Cmd>exe v:count1 . "ToggleTerm direction=float"<cr>
nnoremap <c-t>t <Cmd>exe v:count1 . "ToggleTerm direction=tab"<cr>
nnoremap <c-t>v <Cmd>exe v:count1 . "ToggleTerm direction=vertical"<cr>
tnoremap <c-t> <cmd>ToggleTerm<cr>
tnoremap <leader><esc> <c-\><c-n>


"" Git-Blame
"" -----------------------------------------------------------------------------
let g:gitblame_enabled = 1 
let g:gitblame_date_format = '%Y-%m-%d'
let g:gitblame_message_template = '        <author> ~ <date>'
let g:gitblame_ignored_filetypes = ['NvimTree']


"" Neoscroll 
"" -----------------------------------------------------------------------------
lua require('neoscroll').setup({ stop_eof = false })


"" NvimTree
"" -----------------------------------------------------------------------------
lua << EOF
require("nvim-tree").setup({
  filters = { dotfiles = true, },
})
EOF
nnoremap <c-n>n <cmd>NvimTreeToggle<cr>
nnoremap <c-n>g <cmd>NvimTreeFocus<cr>
nnoremap <c-n>c <cmd>NvimTreeCollapse<cr>
nnoremap <c-n>f <cmd>NvimTreeFindFile<cr>


"" Minimap 
"" -----------------------------------------------------------------------------
let g:minimap_width = 10
let g:minimap_auto_start = 0
let g:minimap_auto_start_win_enter = 1
let g:minimap_git_colors = 1
highlight minimapCursor ctermbg=59  ctermfg=228 guibg=#282828 guifg=#928374

nnoremap <leader>mm <cmd>MinimapToggle<cr>


"" Telescope 
"" -----------------------------------------------------------------------------
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


"" COC-Python 
"" -----------------------------------------------------------------------------
nnoremap <leader>fmt <cmd>call CocAction('format')<cr>
nnoremap <leader>imp <cmd>CocCommand pyright.organizeimports<cr>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"" Diffview
"" -----------------------------------------------------------------------------
nnoremap <leader>hst <cmd>DiffviewFileHistory %<cr>
