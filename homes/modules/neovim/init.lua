local set = vim.opt
local let = vim.g

vim.o.timeout = true
vim.o.timeoutlen = 300 

-- Recommended from nvim-tree to be at top of config
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

set.mouse = "a"
set.number = true
set.numberwidth = 2
set.shiftwidth = 2
set.tabstop = 2
set.expandtab = true
set.wrap = false
set.hidden = true 
set.background = "dark"
set.termguicolors = true
let.mapleader = " "

vim.cmd("colorscheme gruvbox-flat")

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

require('neoscroll').setup{ stop_eof = false }
require('glow').setup{ style = "dark" }
require("nvim-autopairs").setup{} 

