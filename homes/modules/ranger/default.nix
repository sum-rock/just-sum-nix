{ config, pkgs, home-manager, ranger-devicons, ... }:
{
  environment.systemPackages = with pkgs; [
    ranger
  ];

  home-manager.users = {
    "${config.primary-user}" = {
      xdg.configFile = {
        "ranger/rc.conf".source = ./rc.conf;
        "ranger/plugins/devicons2".source = "${ranger-devicons}";
      };
    };
  };
  # allows sudo ranger to share the same configuration as primary user
  system.activationScripts.ranger = ''
    if [[ ! -d /root/.config/ranger ]]; then
      mkdir -p /root/.config
      ln -s /home/${config.primary-user}/.config/ranger /root/.config/ranger 
    fi
  '';
}
