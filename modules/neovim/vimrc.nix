{  }:

let
  airline = builtins.readFile ./vimrc/airline.vim;
  nerdtree = builtins.readFile ./vimrc/nerdtree.vim;
  colors = builtins.readFile ./vimrc/colors.vim;
  options = builtins.readFile ./vimrc/options.vim;
in

''
  ${options}
  ${airline}
  ${nerdtree}
  ${colors}
''