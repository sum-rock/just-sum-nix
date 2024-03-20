return {
  plugins = {
    {
      "catppuccin/nvim",
      name = "catppuccin",
      config = function()
        require("catppuccin").setup {}
      end,
    },
  },
  lsp = {
    servers = {
      "pyright",
      "lua_ls",
    },
    config = {
      pyright = {
        typeCheckingMode = "basic"
      },
    },
  },
}
