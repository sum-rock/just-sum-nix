if [ "$EUID" -ne 0 ] ; then 
  echo "Must run rebuild as root!"
  exit
fi

MODE="boot"
BRANCH="master"

while getopts ":b:m:" o; do
  case "$o" in
    b)
      BRANCH=$OPTARG
      ;;
    m)
      MODE=$OPTARG
      ;;
    *)
      echo "Invalid option" 
      exit 1
      ;;
  esac
done

nix-collect-garbage
nixos-rebuild $MODE --option eval-cache false --flake github:sum-rock/just-sum-nix/$BRANCH
