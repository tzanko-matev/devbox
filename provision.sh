#!/bin/sh
REPO=/home/vagrant/devbox

mkdir -p $REPO
chmod 755 /home/vagrant
#TODO: We should check for overwriting
cp -r /vagrant/* $REPO
chown -R vagrant $REPO

cat >/etc/nixos/vagrant.nix <<EOF
# This file is overwritten by the vagrant-nixos plugin
{ config, pkgs, ... }:
{
  imports = [
    ./vagrant-hostname.nix
    ./vagrant-network.nix
    $REPO/nixos/configuration.nix
  ];
}
EOF

nixos-rebuild switch
