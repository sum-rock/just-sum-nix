require("chatgpt").setup {
  popup_input = {
    submit = "<C-s>",     -- Not default
  },
}

wk = require("which-key")
wk.register({
  c = {
    name = "ChatGPT",
    c = { "<cmd>ChatGPT<cr>", "Chat me up" },
    a = { "<cmd>ChatGPTActAs<cr>", "Chat as a thing"}
  },
}, { prefix = "<leader>" })
wk.register({
  c = {
    name = "ChatGPT",
    e = { function() require("chatgpt").edit_with_instructions() end, "Edit with instructions" },
  },
}, { prefix = "<leader>", mode = "v" })
