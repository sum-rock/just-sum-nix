require("catppuccin").setup { 
  flavour = "frappe", 
  integrations = { 
    telescope=true,
    hop=true,
    treesitter=true,
    nvimtree=true,
    gitgutter=true,
    which_key=true,
  }
}

vim.cmd.colorscheme "catppuccin" 

local bufferline = require("bufferline")
local frappe = require("catppuccin.palettes").get_palette "frappe"

bufferline.setup {
  highlights = require("catppuccin.groups.integrations.bufferline").get {
    styles = { "italic", "bold" },
    custom = {
      all = {
        fill = { bg = "#000000" },
      },
      frappe = {
        background = { fg = frappe.text },
      },
      latte = {
        background = { fg = "#000000" },
      },
    },
  },
}
