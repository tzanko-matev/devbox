{ config, pkgs, ... }:
let
  vmConfigFile = ../config.json;

  vmConfig = if (builtins.pathExists vmConfigFile) then
    builtins.fromJSON (builtins.readFile vmConfigFile)
  else
    builtins.trace {} {};

  getUserModule = user:
  let
    path = builtins.toPath "/vagrant/nixos/dev-${user}.nix";
  in
    if (user!=null) && (builtins.pathExists path) then [path] else [];


  survey = import ../survery/default.nix {inherit pkgs;};

in
{
  environment.systemPackages = with pkgs; [
    survey.package
  ];
  
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowPing = true;
  services.nginx.enable = true;

  imports = getUserModule (vmConfig.username or null);
}
