local terms = require('toggleterm.terminal')
local Terminal = terms.Terminal
local tree_api = require("nvim-tree.api").tree

require("toggleterm").setup{
  size = function(term)
    if term.direction == "horizontal" then 
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    else
      return 20
    end
  end,
  float_opts = { border = "curved" }
}

local h_terminal = Terminal:new({ direction = "horizontal" })
local v_terminal = Terminal:new({ direction = "vertical" })
local f_terminal = Terminal:new({ direction = "float" })
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _h_terminal_toggle()
  if require("nvim-tree.view"):is_visible() then
    tree_api:close()
    h_terminal:toggle()
    tree_api:toggle()
    h_terminal:focus()
  else
    h_terminal:toggle()
  end
end
function _v_terminal_toggle()
  v_terminal:toggle()
end
function _f_terminal_toggle()
  f_terminal:toggle()
end
function _lazygit_toggle()
  lazygit:toggle()
end
function _close_all()
  local terminals = terms.get_all()
  for _, term in pairs(terminals) do term:close() end
end

local terminal_toggle_opts = {noremap = true, silent = true}
vim.keymap.set("n", "<leader>th", "<cmd>lua _h_terminal_toggle()<cr>", terminal_toggle_opts)
vim.keymap.set("n", "<leader>tv", "<cmd>lua _v_terminal_toggle()<cr>", terminal_toggle_opts)
vim.keymap.set("n", "<leader>tf", "<cmd>lua _f_terminal_toggle()<cr>", terminal_toggle_opts)
vim.keymap.set("n", "<leader>g", "<cmd>lua _lazygit_toggle()<cr>", terminal_toggle_opts)
vim.keymap.set("n", "<leader>tcc", "<cmd>lua _close_all()<cr>")
vim.keymap.set("t", "<leader>tcc", "<cmd>lua _close_all()<cr>")
vim.keymap.set("t", "<leader><esc>", "<c-\\><c-n>")
