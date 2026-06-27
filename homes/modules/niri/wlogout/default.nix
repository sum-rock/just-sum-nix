{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [ wlogout ];

  home-manager.users.${config.primaryUser} = {
    xdg.configFile."wlogout/layout".text = builtins.readFile ./layout;
    xdg.configFile."wlogout/style.css".text = (builtins.readFile ./style.css) + ''

      #lock     { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png")); }
      #logout   { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png")); }
      #reboot   { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png")); }
      #shutdown { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png")); }
    '';
  };
}
