{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      foliate = prev.foliate.overrideAttrs (old: {
        # TODO: depend more on `old`
        desktopItems = [
          (pkgs.makeDesktopItem {
            name = old.pname;
            desktopName = "Foliate X11";
            exec = "GDK_BACKEND=x11 ${old.pname} %U";
            icon = "com.github.johnfactotum.Foliate";
          })
        ];
        nativeBuildInputs = old.nativeBuildInputs ++ [
          pkgs.copyDesktopItems
        ];
      });
    })
  ];
}
