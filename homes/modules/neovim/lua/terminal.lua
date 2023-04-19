local M = {}

local terms = require('toggleterm.terminal')
local Terminal = terms.Terminal
local tree_api = require("nvim-tree.api").tree
local wo = vim.wo

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

local function toggle_any(any_terminal) 
  local visible_tree = require("nvim-tree.view"):is_visible() 
  local being_opened = not any_terminal:is_open()

  if visible_tree and any_terminal.direction ~= 'float' then
    tree_api.close()
    any_terminal:toggle()
    tree_api.open()
  else
    any_terminal:toggle()
  end

  if being_opened then 
    any_terminal:focus()
    any_terminal:set_mode("i")
    wo.cursorline = false
  end

end
  
function h_terminal_toggle()
  toggle_any(h_terminal)
end
function v_terminal_toggle()
  toggle_any(v_terminal)
end
function f_terminal_toggle()
  toggle_any(f_terminal)
end

function M.close_all()
  local terminals = terms.get_all()
  for _, term in pairs(terminals) do 
    if term:is_open() then term:close() end
  end
  h_terminal:close()
  v_terminal:close()
  f_terminal:close()
end

function M.kill_all()
  local terminals = terms.get_all()
  for _, term in pairs(terminals) do 
    term:shutdown()
  end
  h_terminal:shutdown()
  v_terminal:shutdown()
  f_terminal:shutdown()
end

require('which-key').register({
  [","] = {
    name = "Terminal",
    h = { "<cmd>lua h_terminal_toggle()<cr>", "Open horizontal terminal" },
    v = { "<cmd>lua v_terminal_toggle()<cr>", "Open vertical terminal" },
    f = { "<cmd>lua f_terminal_toggle()<cr>", "Open floating terminal" },
    q = { "<cmd>lua require('terminal').close_all()<cr>", "Close all visible terminals" },
    Q = { "<cmd>lua require('terminal').kill_all()<cr>", "Shutdown all terminals" },
  }
})
require('which-key').register({
  [","] = {
    name = "Terminal",
    q = { "<cmd>lua require('terminal').close_all()<cr>", "Close all visible terminals", mode="t" },
    Q = { "<cmd>lua require('terminal').kill_all()<cr>", "Shutdown all terminals", mode="t" },
    e = { "<c-\\><c-n>", "Switch to normal mode", mode="t" },
  }
})

return M
