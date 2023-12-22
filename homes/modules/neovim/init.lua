local set = vim.opt
local let = vim.g

vim.o.timeout = true
vim.o.timeoutlen = 300 

-- Recommended from nvim-tree to be at top of config
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

set.mouse = "a"
set.number = true
set.clipboard = unnamedplus
set.numberwidth = 2
set.shiftwidth = 2
set.tabstop = 2
set.expandtab = true
set.wrap = false
set.hidden = true 
set.termguicolors = true
let.mapleader = " "

-- Adds an exscape keymap for jj
vim.keymap.set("i", "jj", "<esc>")

require("which-key").register({ 
  ["<leader>/"] = { "<cmd>noh<cr>", "Clear search highlights"} 
})

vim.cmd("hi LineNr guibg=clear guifg=gray")
vim.cmd("hi SignColumn guibg=clear")

require("buffers")
require("cursorline").setup{}
require("file_explorer")
require("languages")
require("navigation")
require("search")
require("status_line")
require('terminal')
require('version_control')
require("my_yank")
require("text_edit_mode")

require('neoscroll').setup{ stop_eof = false; }
require('glow').setup{ style = "dark"; }
require("nvim-autopairs").setup{} 
require('nvim-web-devicons').setup{ color_icons = false; }
require"nvim-treesitter.configs".setup{ autotag = { enable = true; } }

-- Configures copilot to use <C-J> to accept suggestions
vim.keymap.set('i', '<C-J>', 'copilot#Accept("")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
