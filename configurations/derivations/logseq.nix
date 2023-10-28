{ lib, pkgs, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "logseq";
  version = "0.9.18";

  src = pkgs.fetchurl {
    url = "https://github.com/logseq/logseq/releases/download/${version}/logseq-linux-x64-${version}.AppImage";
    hash = "sha256-+2BnVW0qWSJ/PIY3zl1c9qzcP9DZVp6E9B7AI6LqibE=";
    name = "${pname}-${version}.AppImage";
  };

  appimageContents = pkgs.appimageTools.extract {
    inherit pname src version;
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/${pname} $out/share/applications
    cp -a ${appimageContents}/{locales,resources} $out/share/${pname}
    cp -a ${appimageContents}/Logseq.desktop $out/share/applications/${pname}.desktop

    # remove the `git` in `dugite` because we want the `git` in `nixpkgs`
    chmod +w -R $out/share/${pname}/resources/app/node_modules/dugite/git
    chmod +w $out/share/${pname}/resources/app/node_modules/dugite
    rm -rf $out/share/${pname}/resources/app/node_modules/dugite/git
    chmod -w $out/share/${pname}/resources/app/node_modules/dugite

    mkdir -p $out/share/pixmaps
    ln -s $out/share/${pname}/resources/app/icons/logseq.png $out/share/pixmaps/${pname}.png

    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace Exec=Logseq Exec=${pname} \
      --replace Icon=Logseq Icon=${pname}

    runHook postInstall
  '';

  postFixup = ''
    # set the env "LOCAL_GIT_DIRECTORY" for dugite so that we can use the git in nixpkgs
    makeWrapper ${pkgs.electron_24}/bin/electron $out/bin/${pname} \
      --set "LOCAL_GIT_DIRECTORY" ${pkgs.git} \
      --add-flags $out/share/${pname}/resources/app \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}"
  '';

}
