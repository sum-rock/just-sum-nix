return {
  colorscheme = "catppuccin",
  plugins = {
    {
      "catppuccin/nvim",
      name = "catppuccin",
      config = function()
        require("catppuccin").setup { flavour = "mocha", }
      end,
    },
    {
      "github/copilot.vim",
      name = "copilot",
      lazy = false,
      config = function()
        vim.keymap.set('i', '<C-a>', 'copilot#Accept("")', {
          expr = true,
          replace_keycodes = false
        })
        vim.g.copilot_no_tab_map = true
      end,
    },
  },
  lsp = {
    servers = {
      "pyright",
    },
    config = {
      pyright = {
        typeCheckingMode = "basic"
      },
    },
  },
}
