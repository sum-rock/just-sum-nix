set termguicolors
lua << EOF
local present, bufferline = pcall(require, "bufferline")
if not present then
  return
end
bufferline.setup {
  options = {
    offsets = { {
      filetype = "nerdtree",
      text = "File Explorer",
      highlight = "Directory"
    } },
    separator_style = "thick"
  }
}
EOF
