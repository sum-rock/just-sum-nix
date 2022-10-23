{ config, pkgs, home-manager, username, ... }: 
{
  environment.systemPackages = with pkgs; [
    ranger
  ];

  home-manager.users.${username} = {
    xdg.configFile = {
      "ranger/rc.conf".source = ./rc.conf;
      "ranger/plugins/devicons2".source = pkgs.fetchFromGitHub {
        owner = "cdump";
        repo = "ranger-devicons2";
        rev = "master";
        sha256 = "sha256-e6lrqMTGTYC0jOTxYpFu+9M7XMX6DF5wvtaW5et7ADk=";
      };
    };
  };
}
