{ pkgs ? import <nixpkgs> { } }:

pkgs.python39Packages.buildPythonApplication rec {
  pname = "shovel";
  version = "0.1.0";

  src = ./.;

  propagatedBuildInputs = with pkgs.python39Packages; [
  ];

  # If tests are available, enable this
  # checkPhase = ''
  #   ${python.interpreter} -m unittest discover
  # '';

  doCheck = false;

  meta = with pkgs.lib; {
    description = "A script to manage a NixOS configuration structured in Shovel-style";
    homepage = "https://nowhere.com";
    license = licenses.mit;
    maintainers = [ maintainers.yallo ];
  };
}
