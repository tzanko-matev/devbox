{ config, pkgs, ...}:

{
	environment.systemPackages = [pkgs.emacs25];
}