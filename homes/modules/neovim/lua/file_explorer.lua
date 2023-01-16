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

vim.keymap.set("n", "<leader>nn", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>ng", "<cmd>NvimTreeFocus<cr>")
vim.keymap.set("n", "<leader>nc", "<cmd>NvimTreeCollapse<cr>")
vim.keymap.set("n", "<leader>nf", "<cmd>NvimTreeFindFile<cr>")

