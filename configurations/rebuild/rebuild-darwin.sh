MODE="switch"
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
darwin-rebuild $MODE --flake github:sum-rock/just-sum-nix/$BRANCH
