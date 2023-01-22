require('hop').setup()

local hop = require('hop')
local directions = require('hop.hint').HintDirection

require("which-key").register({
  w = {
    name = "Windows",
    q = { "<cmd>q<cr>", "Quit Window" },
    Q = { "<cmd>qa<cr>", "Quit All Windows" },
    h = { "<c-w>h", "Move Left" },
    j = { "<c-w>j", "Move Down" },
    k = { "<c-w>k", "Move Up" },
    l = { "<c-w>l", "Move Right" },
    s = { "<c-w>s", "Split Horizontally" },
    v = { "<c-w>v", "Split Vertically" },
  },
  h = {
    name = "Hop",
    f = { function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false }) end, "Hop Forward on" },
    F = { function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false }) end, "Hop Backward on" },
    t = { function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 }) end, "Hop Forward to" },
    T = { function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 }) end, "Hop Backward to" },
  }
}, { prefix = "<leader>" })

require("which-key").register({
  ["<C-U>"] = { "Scroll up" },
  ["<C-D>"] = { "Scroll down" },
  ["<C-B>"] = { "Scroll up greater" },
  ["<C-F>"] = { "Scroll down greater" },
  ["<C-Y>"] = { "Scroll up lesser" },
  ["<C-E>"] = { "Scroll down lesser" },
})
