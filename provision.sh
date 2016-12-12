#!/bin/sh

cp -f /vagrant/nixos/* /etc/nixos
nixos-rebuild switch
