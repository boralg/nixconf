{ pkgs ? import <nixpkgs> {} }:

pkgs.python39Packages.buildPythonApplication rec {
  pname = "purr";
  version = "0.2.0";

  src = ./.;

  propagatedBuildInputs = with pkgs.python39Packages; [
    pyyaml
    cryptography
  ];

  # If tests are available, enable this
  # checkPhase = ''
  #   ${python.interpreter} -m unittest discover
  # '';

  doCheck = false;

  meta = with pkgs.lib; {
    description = "A simple password manager backed by a human-readable YAML store";
    homepage = "https://nowhere.com"; 
    license = licenses.mit;
    maintainers = [ maintainers.yallo ];
  };
}
