vim.cmd("hi CocInlayHint guibg=clear guifg=gray")
vim.cmd("hi CocErrorSign guibg=clear")
vim.cmd("hi CocWarningSign guibg=clear")
vim.cmd("hi CocInfoSign guibg=clear")
vim.cmd("hi CocHintSign guibg=clear")

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}

vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

require("which-key").register({
    l = {
        name = "Language Server",
        f = { "<cmd>call CocAction('format')<cr>", "Format file" },
        g = {
            name = "Go to",
            d = { "<Plug>(coc-definition)", "To definition" },
            t = { "<Plug>(coc-type-definition)", "To the type definition" },
            i = { "<Plug>(coc-implementation)", "To implementations" },
            r = { "<Plug>(coc-references)", "To references" },
        },
        p = {
            name = "Python",
            i = { "<cmd>CocCommand pyright.organizeimports<cr>", "Sort imports" },
        },
    }, 
}, { prefix = "<leader>" })

