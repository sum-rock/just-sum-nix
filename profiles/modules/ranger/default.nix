{ 
  config, 
  pkgs, 
  home-manager, 
  ranger-devicons, 
  username, 
  ... 
}: 
{
  environment.systemPackages = with pkgs; [
    ranger
  ];

  home-manager.users.${username} = {
    xdg.configFile = {
      "ranger/rc.conf".source = ./rc.conf;
      "ranger/plugins/devicons2".source = "${ranger-devicons}";
    };
  };
}
