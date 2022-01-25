{
  description = "pystan";

  # 2022-01-24
  inputs.nixpkgs.url =
    "github:NixOS/nixpkgs/8ca77a63599ed951d6a2d244c1d62092776a3fe1";
  inputs.src = {
    url =
      "https://files.pythonhosted.org/packages/10/9f/dcecf31ac08842a675ec337a14439b37d75f6da42f034b1fd5eb90b10b84/pystan-2.19.1.1.tar.gz";
    flake = false;
  };

  outputs = { self, nixpkgs, src }: rec {

    defaultPackage.x86_64-linux = packages.x86_64-linux.pystan;

    packages.x86_64-linux.pystan =
      with import nixpkgs { system = "x86_64-linux"; };
      let python = python39;
      in python.pkgs.buildPythonPackage {
        pname = "pystan";
        version = "2.19.1.1";
        inherit src;

        doCheck = false;

        propagatedBuildInputs = with python.pkgs; [ cython numpy ];
        meta = with lib; {
          homepage = "https://pypi.org/project/pystan/2.19.1.1/";
          description =
            "Python interface to Stan, a package for Bayesian inference";
          license = licenses.gpl3;
        };
      };
  };
}
