{ config, pkgs, home-manager, ranger-devicons, ... }: 
{
  environment.systemPackages = with pkgs; [
    ranger
  ];

  home-manager.users.${config.primary-user} = {
    xdg.configFile = {
      "ranger/rc.conf".source = ./rc.conf;
      "ranger/plugins/devicons2".source = "${ranger-devicons}";
    };
  };
}
