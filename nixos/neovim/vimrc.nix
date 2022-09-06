{  }:

let
  airline = builtins.readFile ./vimrc/airline.vim;

in

''
  ${airline}
''
