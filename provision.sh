#!/bin/sh

echo "import /vagrant/nixos/configuration.nix" >/etc/nixos/configuration.nix
nixos-rebuild switch