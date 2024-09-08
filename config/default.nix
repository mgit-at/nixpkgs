{ config, pkgs, lib, ... }:

with lib;

{
  # services.module.enable = true;
  environment.systemPackages = with pkgs; [ git bazelisk bazelisk-env ];
}
