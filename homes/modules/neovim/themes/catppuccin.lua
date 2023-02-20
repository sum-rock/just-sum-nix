require("catppuccin").setup { 
  flavour = "mocha", 
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
local mocha = require("catppuccin.palettes").get_palette "mocha"

bufferline.setup {
  highlights = require("catppuccin.groups.integrations.bufferline").get {
    styles = { "italic", "bold" },
    custom = {
      all = {
        fill = { bg = "#000000" },
      },
      mocha = {
        background = { fg = mocha.text },
      },
      latte = {
        background = { fg = "#000000" },
      },
    },
  },
}
