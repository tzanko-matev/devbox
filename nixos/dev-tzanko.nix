{ config, pkgs, ...}:
let
  # myEmacs = (import ./emacs-tzanko.nix {inherit pkgs; });
in
{
	environment.systemPackages = [pkgs.firefox pkgs.vim pkgs.git];
	services.xserver.enable = true;
	services.xserver.windowManager.xmonad.enable = true;
}
