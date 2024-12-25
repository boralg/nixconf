{
  pkgs,
  lib,
}:
let
  path = ./.;
  scripts = builtins.attrNames (builtins.readDir path);
  scriptNames = (map (name: lib.removeSuffix ".sh" name) scripts);

  scriptPkgs = lib.genAttrs scriptNames (
    name: pkgs.writeShellScriptBin name (builtins.readFile "${path}/${name}.sh")
  );
in
scriptPkgs
