{
  buildFHSUserEnv,
  coreutils-full,
  lib,
  bashInteractiveFHS,
}:

buildFHSUserEnv {
  name = "bazelisk-env";
  extraOutputsToInstall = ["include" "dev"]; # TODO: make it saner?
  # this is necesarry to make sure we don't inherit things from nixos that we don't want to inherit
  # like non-FHS bash interactive in /run/current-system/sw/bin
  # extraBwrapArgs = [ "--tmpfs" "/run" ];  #[ "--tmpfs" "/run/current-system/sw/bin" ];
  extraBwrapArgs = [
    "--ro-bind" "/run" "/.host-run"
    "--tmpfs" "/run"
    "--ro-bind" "/run/systemd" "/run/systemd"
    "--ro-bind" "/run/nscd" "/run/nscd"
  ];

  # NOTE: since /run/current-system is inaccessible
  # EVERY required tool must be specified here
  targetPkgs = pkgs: with pkgs; [
    coreutils-full
    zlib
#    gcc
    gcc-unwrapped
    binutils
    gcc-unwrapped.lib
    pkg-config
    python3
    coreutils-full
    bazelisk
    git
    which
    python3
    patch
    # (lib.hiPrio bashInteractiveFHS)
    # debug
    iputils
    host
  ];

  multiPkgs = pkgs: with pkgs; [
  ];

  profile = ''
    export BAZELISK_ENV=1
    export CC=$(which gcc)
    CMD=bazelisk
    if [ -v USE_SHELL ]; then
      CMD="/usr/bin/bash"
    fi
    # export PATH="${coreutils-full}/bin:$PATH"
    # this makes sure bash and sh resolve to bashInteractiveFHS
    export PATH="/usr/bin:$PATH"
  '';

  # runScript = ''$SHELL'';
  runScript = "$CMD"; # $@ will already be appended by nix
}
