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
require("which-key").register({
  n = {
    name = "File Explorer",
    n = { "<cmd>NvimTreeToggle<cr>", "Toggle Explorer" },
    g = { "<cmd>NvimTreeFocus<cr>", "Focus on Explorer" },
    c = { "<cmd>NvimTreeCollapse<cr>", "Collapse Directories in Explorer" },
    f = { "<cmd>NvimTreeFindFile<cr>", "Find file in Explorer" },
  },
}, { prefix = "<leader>" })

