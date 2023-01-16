local tree_api = require("nvim-tree.api").tree
local tree_view = view

require("nvim-tree").setup{ 
  filters = { dotfiles = false },
  view = {
    adaptive_size = true,
  },
  update_focused_file = {
    enable = true,
  }
}

vim.keymap.set("n", "<c-n>n", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<c-n>g", "<cmd>NvimTreeFocus<cr>")
vim.keymap.set("n", "<c-n>c", "<cmd>NvimTreeCollapse<cr>")
vim.keymap.set("n", "<c-n>f", "<cmd>NvimTreeFindFile<cr>")

