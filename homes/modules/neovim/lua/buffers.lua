local lazy = require("bufferline.lazy")
local state = lazy.require("bufferline.state")
local commands = lazy.require("bufferline.commands")
local tree_api = require("nvim-tree.api").tree
local tree_view = require("nvim-tree.view")

require("bufferline").setup {
  options = {
    offsets = { 
      { filetype = "NvimTree", text = "File Explorer", highlight = "Directory" },
    },
    separator_style = "slim",
    indicator = { style = 'icon' },
    numbers = "ordinal",
    diagnostics = "coc",
  }
}

require("which-key").register({
  b = {
    name = "Buffers",
    n = { "<cmd>bn<cr>", "Next buffer" },
    p = { "<cmd>bp<cr>", "Previous buffer" },
    w = { "<cmd>lua _close_tab_eligantly()<cr>", "Wipeout buffer" },
    W = { "<cmd>lua _close_all_tabs_eligantly()<cr>", "Wipout all buffers" },
    s = { "<cmd>w<cr>", "Save/Write buffer" },
  },
}, { prefix = "<leader>" })

function _close_tab_eligantly()
  local this_index = commands.get_current_element_index(state)
  local last_index = #state.visible_components
  local preferred = this_index - 1
  local only_one_tab = false

  if preferred == 0 and last_index == 1 then only_one_tab = true end
  if preferred == 0 then preferred = this_index + 1 end

  if only_one_tab and tree_view:is_visible() then
    vim.cmd('enew')
    commands.go_to(this_index)
    tree_api:close()
    vim.cmd('w')
    vim.cmd('bw')
    tree_api:toggle()
  else
    vim.cmd('w')
    vim.cmd("bw")
  end

  commands.go_to(preferred)
end

function _close_all_tabs_eligantly()
  if tree_view:is_visible() then
    tree_api:close()
    vim.cmd('bufdo w')
    vim.cmd('bufdo bw')
    tree_api:toggle()
  else
    vim.cmd('bufdo w')
    vim.cmd('bufdo bw')
  end
end

