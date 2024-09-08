{
  buildFHSUserEnv,
  coreutils-full,
}:

buildFHSUserEnv {
  name = "bazelisk-env";
  extraOutputsToInstall = ["include" "dev"]; # TODO: make it saner?

  targetPkgs = pkgs: with pkgs; [
    coreutils-full
    zlib
    gcc
    gcc-unwrapped.lib
    pkg-config
    python3
    coreutils-full
  ];

  multiPkgs = pkgs: with pkgs; [
  ];

  profile = ''
    export BAZELISK_ENV=1
    export CC=$(which gcc)
    CMD=bazelisk
    if [ -v USE_SHELL ]; then
      CMD="$SHELL"
    fi
    # export PATH="${coreutils-full}/bin:$PATH"
  '';

  # runScript = ''$SHELL'';
  runScript = "$CMD"; # $@ will already be appended by nix
}
