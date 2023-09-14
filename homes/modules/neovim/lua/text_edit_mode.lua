
function text_edit_mode_enable()
  vim.opt.wrap = true
  vim.opt.list = false 
  vim.opt.linebreak = true
  vim.opt.textwidth = 80

  vim.api.nvim_set_keymap('n', "j", "gj", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', "k", "gk", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', "j", "gj", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', "k", "gk", { noremap = true, silent = true })
end

function text_edit_mode_disable()
  vim.opt.wrap = false 
  vim.opt.list = true
  vim.opt.linebreak = false
  vim.opt.textwidth = 0 

  vim.api.nvim_set_keymap('n', "j", "j", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', "k", "k", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', "j", "j", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', "k", "k", { noremap = true, silent = true })
end

require("which-key").register({
  p = {
    name = "Paragraph Mode",
    e = { function() text_edit_mode_enable() end, "enable" },
    E = { function() text_edit_mode_disable() end, "disable" },
  } 
}, { prefix = "<leader>" })
