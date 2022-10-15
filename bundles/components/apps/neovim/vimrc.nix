{  }:

let
  airline = builtins.readFile ./vimrc/airline.vim;
  bufferline = builtins.readFile ./vimrc/bufferline.vim;
  colors = builtins.readFile ./vimrc/colors.vim;
  minimap = builtins.readFile ./vimrc/minimap.vim;
  nerdtree = builtins.readFile ./vimrc/nerdtree.vim;
  options = builtins.readFile ./vimrc/options.vim;
  telescope = builtins.readFile ./vimrc/telescope.vim;
  neoscroll = builtins.readFile ./vimrc/neoscroll.vim;
in

''
  ${airline}
  ${bufferline}
  ${colors}
  ${minimap}
  ${nerdtree}
  ${options}
  ${telescope}
  ${neoscroll}
''
