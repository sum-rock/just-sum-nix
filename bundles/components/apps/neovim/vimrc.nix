{  }:

let
  options = builtins.readFile ./vimrc/options.vim;
  plugins = builtins.readFile ./vimrc/plugins.vim;
in

''
  ${options}
  ${plugins}
''
