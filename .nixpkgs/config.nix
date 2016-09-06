# https://ariya.io/2016/06/isolated-development-environment-using-nix
# https://www.mpscholten.de/nixos/2016/05/26/sharing-configuration-across-systems-with-nix.html


{
  packageOverrides = pkgs_: with pkgs_; {
    all = with pkgs; buildEnv {
      name = "all";
      paths = [
        aspell
        aspell-dict-en
        coreutils
        cvs
        jq
        tig
        tree
      ];
    };
  };
}
