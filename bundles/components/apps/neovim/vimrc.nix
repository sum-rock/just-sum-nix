{  }:

let
  airline = builtins.readFile ./vimrc/airline.vim;
  colors = builtins.readFile ./vimrc/colors.vim;
  minimap = builtins.readFile ./vimrc/minimap.vim;
  nerdtree = builtins.readFile ./vimrc/nerdtree.vim;
  options = builtins.readFile ./vimrc/options.vim;
  telescope = builtins.readFile ./vimrc/telescope.vim;
  neoscroll = builtins.readFile ./vimrc/neoscroll.vim;
in

''
  ${airline}
  ${colors}
  ${minimap}
  ${nerdtree}
  ${options}
  ${telescope}
  ${neoscroll}
''
