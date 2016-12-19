#!/bin/sh

cat >/etc/nixos/vagrant.nix <<EOF
# This file is overwritten by the vagrant-nixos plugin
{ config, pkgs, ... }:
{
  imports = [
    ./vagrant-hostname.nix
    ./vagrant-network.nix
    /vagrant/nixos/configuration.nix
  ];
}
EOF

nixos-rebuild switch
