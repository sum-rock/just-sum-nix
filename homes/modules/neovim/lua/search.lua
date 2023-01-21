require("which-key").register({
  f = {
    name = "Find",
    f = { "<cmd>Telescope find_files<cr>", "Search Files" },
    g = { "<cmd>Telescope live_grep<cr>", "Grep all files" },
    b = { "<cmd>Telescope buffers<cr>", "Find Open Buffers" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help Tags" },
    s = { "<cmd>Telescope search_history<cr>", "View Search History" },
    r = { "<cmd>Telescope resume<cr>", "Resume the last search" },
    o = { "<cmd>Telescope oldfiles<cr>", "Search Previously Opened" }, 
  },
}, { prefrix = "<leader>" })

