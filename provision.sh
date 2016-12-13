#!/bin/sh

#Set up /etc/nixos to be a clone of this repo

if [ -d "/etc/nixos/.git" ] ; then
  # If it is not set-up already, clone the repo
  # This hardware-configuration.nix is created while seting up nixos. It contains 
  # hardware description and is not part of the repo
  cp /etc/nixos/hardware-configuration.nix /home/vagrant/nixos/
  rm -rf /etc/nixos

  # Temporary copy the repo to etc, because we don't have git installed yet
  cp -rf /vagrant/* /etc/nixos
  cp /home/vagrant/hardware-configuration.nix /etc/nixos
  # Provision the OS
  nixos-rebuild switch
  
  # Now we have git already. We can replace /etc/nixos with a git repo
  rm -rf /etc/nixos
  git clone /vagrant /etc/nixos
  cp /home/vagrant/hardware-configuration.nix /etc/nixos
  # No need to call nixos-rebuild here, since we called it earlier with the same
  # data  
else
  # The repository was set up already. Sync with the current branch and run
  # provisioning
  
  # Get current branch
  BRANCH=`git rev-parse --abbrev-ref HEAD`
  pushd /etc/nixos
  # TODO: This can potentially mess up the etc/nixos repo if there are local 
  # changes there. Should think about better solutions
  git fetch --all
  git checkout origin/$BRANCH
  nixos-rebuild switch
fi
