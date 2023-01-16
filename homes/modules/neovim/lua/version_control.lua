local git_blame = require('gitblame') -- Stored for lualine integration

vim.cmd("hi GitGutterAdd guibg=clear")
vim.cmd("hi GitGutterChange guibg=clear")
vim.cmd("hi GitGutterDelete guibg=clear")

vim.g["gitblame_enabled"] = 1
vim.g["gitblame_date_format"] = "%Y-%m-%d"
vim.g["gitblame_message_template"] = '  <author> ~ <date>'
vim.g["gitblame_ignored_filetypes"] = {'NvimTree'}

vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text

vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>")
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>")
