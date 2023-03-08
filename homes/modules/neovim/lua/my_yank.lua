require("yanky").setup {}
require('which-key').register({
  p = { "<Plug>(YankyPutAfter)", "Put After" },
  P = { "<Plug>(YankyPutBefore)", "Put Before" },
  g = {
    name = "Yanky G",
    p = { "<Plug>(YankyGPutAfter)", "G Put After" },
    P = { "<Plug>(YankyGPutBefore)", "G Put Before" },
  },
  ["<C-n>"] = { "<Plug>(YankyCycleForward)", "Yanky cycle forward" },
  ["<C-p>"] = { "<Plug>(YankyCycleBackward)", "Yanky cycle backward" },
})
