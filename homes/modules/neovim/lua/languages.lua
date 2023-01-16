vim.keymap.set("n", "<leader>fmt", "<cmd>call CocAction('format')<cr>", { silent = true })
vim.keymap.set("n", "<leader>imp", "<cmd>CocCommand pyright.organizeimports<cr>", { silent = true })
vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true })
vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { silent = true })
vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true })

vim.cmd("hi CocInlayHint guibg=clear guifg=gray")
vim.cmd("hi CocErrorSign guibg=clear")
vim.cmd("hi CocWarningSign guibg=clear")
vim.cmd("hi CocInfoSign guibg=clear")
vim.cmd("hi CocHintSign guibg=clear")
vim.cmd("hi GitGutterAdd guibg=clear")
vim.cmd("hi GitGutterChange guibg=clear")
vim.cmd("hi GitGutterDelete guibg=clear")
vim.cmd("hi LineNr guibg=clear guifg=gray")
vim.cmd("hi SignColumn guibg=clear")

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}

vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
