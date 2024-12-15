{
  pkgs,
  lib,
  path,
}:

let
  scripts = builtins.attrNames (builtins.readDir path);
  genScript =
    name:
    let
      baseName = builtins.baseNameOf name;
      nameWithoutExt = builtins.replaceStrings [ ".sh" ] [ "" ] baseName;
    in
    pkgs.writeShellScriptBin nameWithoutExt (builtins.readFile "${path}/${name}");
  scriptPkgs = lib.lists.flatten (map genScript scripts);
in
scriptPkgs
