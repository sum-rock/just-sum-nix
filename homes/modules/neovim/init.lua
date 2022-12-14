local set = vim.opt

-- Recommended from nvim-tree to be at top of config
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

set.mouse = "a"
set.number = true
set.numberwidth = 2
set.shiftwidth = 2
set.tabstop = 2
set.expandtab = true
set.wrap = false
set.hidden = true 
set.background = "dark"
set.termguicolors = true

vim.cmd("colorscheme gruvbox-flat")

vim.keymap.set("i", "jj", "<esc>")
vim.keymap.set("n", "<leader>/", "<cmd>noh<cr>", { silent = true })


-- Buffer navigation
-- ============================================================================
vim.keymap.set("n", "bn", "<cmd>bn<cr>", { silent = true })
vim.keymap.set("n", "bp", "<cmd>bp<cr>", { silent = true })
vim.keymap.set("n", "bw", "<cmd>bw<cr><cmd>bn<cr>", { silent = true })


-- Highlights 
-- ============================================================================
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


-- NvimTree
-- ============================================================================
require("nvim-tree").setup{ 
  filters = { dotfiles = false },
  view = {
    adaptive_size = true,
  },
  update_focused_file = {
    enable = true,
  }
}
vim.keymap.set("n", "<c-n>n", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<c-n>g", "<cmd>NvimTreeFocus<cr>")
vim.keymap.set("n", "<c-n>c", "<cmd>NvimTreeCollapse<cr>")
vim.keymap.set("n", "<c-n>f", "<cmd>NvimTreeFindFile<cr>")


-- Git-Blame
-- ============================================================================
vim.g["gitblame_enabled"] = 1
vim.g["gitblame_date_format"] = "%Y-%m-%d"
vim.g["gitblame_message_template"] = '  <author> ~ <date>'
vim.g["gitblame_ignored_filetypes"] = {'NvimTree'}

vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
local git_blame = require('gitblame') -- Stored for lualine integration


-- Lualine
-- ============================================================================
require("lualine").setup {
  options = { 
    theme = 'gruvbox-flat',
    icons_enabled = true
  },
  sections = {
    lualine_c = { 
      { "filename", path=1 } 
    },
    lualine_x = {
      { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
    }
  }
}


-- Bufferline
-- ============================================================================
require("bufferline").setup {
  options = {
    offsets = { 
      { filetype = "NvimTree", text = "File Explorer", highlight = "Directory" },
    },
    separator_style = "thick"
  }
}


-- Toggleterm
-- ============================================================================
local Terminal = require('toggleterm.terminal').Terminal
local terminal_toggle_opts = {noremap = true, silent = true}

require("toggleterm").setup{
  size = function(term)
    if term.direction == "horizontal" then 
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    else
      return 20
    end
  end,
  float_opts = { border = "curved" }
}

local h_terminal = Terminal:new({ direction = "horizontal" })
local v_terminal = Terminal:new({ direction = "vertical" })
local f_terminal = Terminal:new({ direction = "float" })
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
local tree_api = require("nvim-tree.api").tree
local tree_view = view

function _h_terminal_toggle()
  if require("nvim-tree.view"):is_visible() then
    tree_api:close()
    h_terminal:toggle()
    tree_api:toggle()
    h_terminal:focus()
  else
    h_terminal:toggle()
  end
end
function _v_terminal_toggle()
  v_terminal:toggle()
end
function _f_terminal_toggle()
  f_terminal:toggle()
end
function _lazygit_toggle()
  lazygit:toggle()
end

vim.keymap.set("n", "<c-t>h", "<cmd>lua _h_terminal_toggle()<cr>", terminal_toggle_opts)
vim.keymap.set("n", "<c-t>v", "<cmd>lua _v_terminal_toggle()<cr>", terminal_toggle_opts)
vim.keymap.set("n", "<c-t>f", "<cmd>lua _f_terminal_toggle()<cr>", terminal_toggle_opts)
vim.keymap.set("n", "<leader>g", "<cmd>lua _lazygit_toggle()<cr>", terminal_toggle_opts)

vim.keymap.set("t", "<c-t>", "<cmd>ToggleTerm<cr>")
vim.keymap.set("t", "<leader><esc>", "<c-\\><c-n>")


-- Telescope
-- ============================================================================
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")


-- COC
-- ============================================================================
vim.keymap.set("n", "<leader>fmt", "<cmd>call CocAction('format')<cr>", { silent = true })
vim.keymap.set("n", "<leader>imp", "<cmd>CocCommand pyright.organizeimports<cr>", { silent = true })
vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true })
vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { silent = true })
vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true })

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)


-- Noescroll
-- ============================================================================
require('neoscroll').setup{ stop_eof = false }


-- Glow
-- ============================================================================
require('glow').setup{ style = "dark" }


-- Diffview
-- ============================================================================
vim.keymap.set("n", "<leader>h", "<cmd>DiffviewFileHistory %<cr>")


-- Minimap 
-- ============================================================================
vim.g["minimap_width"] = 10
vim.g["minimap_auto_start"] = 0
vim.g["minimap_auto_start_win_enter"] = 1
vim.g["minimap_git_colors"] = 1
vim.cmd("hi minimapCursor ctermbg=59 ctermfg=228 guibg=#282828 guifg=#928374")
vim.keymap.set("n", "<leader>m", "<cmd>MinimapToggle<cr>")


-- NvimHop
-- ============================================================================
require('hop').setup()

local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, {remap=true})
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
end, {remap=true})
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
end, {remap=true})


-- Nvim Cursorline
-- ============================================================================
require("cursorline_hi").setup{
  cursorline = {
    enable = true,
    timeout = 1000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  }
}


-- Autopairs 
-- ============================================================================
require("nvim-autopairs").setup{} 
