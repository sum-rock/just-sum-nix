{  }:

let
  airline = builtins.readFile ./vimrc/airline.vim;
  nvim-tree = builtins.readFile ./vimrc/nvim-tree.vim;
in

''
  ${airline}
  ${nvim-tree}
''
