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
function _close_all()
  local terminals = terms.get_all()
  for _, term in pairs(terminals) do 
    if term:is_open() then term:toggle() end
  end
  if h_terminal:is_open() then h_terminal:toggle() end
  if v_terminal:is_open() then v_terminal:toggle() end
  if f_terminal:is_open() then f_terminal:toggle() end
end

require('which-key').register({
  [","] = {
    name = "Terminal",
    h = { "<cmd>lua _h_terminal_toggle()<cr>", "Open horizontal terminal" },
    v = { "<cmd>lua _v_terminal_toggle()<cr>", "Open vertical terminal" },
    f = { "<cmd>lua _f_terminal_toggle()<cr>", "Open floating terminal" },
    q = { "<cmd>lua _close_all()<cr>", "Close all visible terminals" },
  }
})
require('which-key').register({
  [","] = {
    name = "Terminal",
    q = { "<cmd>lua _close_all()<cr>", "Close all visible terminals", mode="t" },
    e = { "<c-\\><c-n>", "Switch to normal mode", mode="t" },
  }
})
