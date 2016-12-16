{ config, pkgs, ... }:
let
  survey = import ../survery/default.nix {inherit pkgs;};

in
{
  environment.systemPackages = with pkgs; [
    git
    vim
    survey.package
  ];
  
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowPing = true;
  services.nginx.enable = true;
}
