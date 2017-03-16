{ config, pkgs, ... }:
let
  vmConfigFile = ../config.json;

  vmConfig = if (builtins.pathExists vmConfigFile) then
    builtins.fromJSON (builtins.readFile vmConfigFile)
  else
    builtins.trace {} {};

  getUserModule = user:
  let
    #TODO The repo's path should not be here
    path = builtins.toPath "/home/vagrant/devbox/nixos/dev-${user}.nix";
  in
    if (user!=null) && (builtins.pathExists path) then [path] else [];


  survey = import ../survey/default.nix {inherit pkgs;};

in
{
  environment.systemPackages = with pkgs; [
    survey.package
  ];
  
  networking.firewall.allowedTCPPorts = [ 80 443 9200 5601];
  networking.firewall.allowPing = true;

  services.nginx.enable = true;
  services.nginx.config = builtins.readFile ./nginx.conf;
  
  #Enable Elasticsearch/Kibana
  services.elasticsearch.enable = true;
  services.kibana.enable = true;

  imports = getUserModule (vmConfig.username or null);
}
