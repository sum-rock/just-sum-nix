delete_subvolume_recursively() {
  IFS=$'\n'
  for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
    delete_subvolume_recursively "/mnt/$i"
  done
  echo "Deleting subvolume $1"
  read -p "Continue (y/n)?" choice
  case "$choice" in
  y | Y) btrfs subvolume delete "$1" ;;
  n | N) exit ;;
  *) echo "invalid" ;;
  esac
}

delete_subvolume_recursively "$1"
