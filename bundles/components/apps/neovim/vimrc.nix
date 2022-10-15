{  }:

let
  airline = builtins.readFile ./vimrc/airline.vim;
  nerdtree = builtins.readFile ./vimrc/nerdtree.vim;
  colors = builtins.readFile ./vimrc/colors.vim;
  options = builtins.readFile ./vimrc/options.vim;
  telescope = builtins.readFile ./vimrc/telescope.vim;
  neoscroll = builtins.readFile ./vimrc/neoscroll.vim;
in

''
  ${options}
  ${airline}
  ${nerdtree}
  ${colors}
  ${telescope}
  ${neoscroll}
''
