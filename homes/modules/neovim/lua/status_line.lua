local git_blame = require('gitblame') -- Stored for lualine integration

require("lualine").setup {
  options = { 
    theme = 'auto',
    icons_enabled = true,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
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
