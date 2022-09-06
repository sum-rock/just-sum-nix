PROJECT_DIR="$(cd "$(dirname "$BASH_SOURCE[0]")" &> /dev/null && pwd)/.." 

set_files() {
  sudo rsync -a --delete --exclude "hardware-configuration.nix" \
    $PROJECT_DIR/nixos/ \
    /etc/nixos

  sudo chown -R root:root /etc/nixos
}
apply() {
  sudo nixos-rebuild switch
}
reverse() {
  sudo rsync -a --exclude "hardware-configuration.nix" \
    /etc/nixos/ \
    $PROJECT_DIR/nixos

  sudo chown -R $USER:users $PROJECT_DIR/nixos 
}

case $1 in
  set)
    set_files
    ;;
  apply)
    apply
    ;;
  deploy)
    set_files && apply
    ;;
  reverse)
    reverse
    ;;
esac
