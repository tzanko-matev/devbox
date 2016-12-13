{ config, pkgs, ... }:
{
  networking.interfaces = [
    { 
      name         = "enp0s8";
      ipAddress    = "10.5.5.5";
      prefixLength = 24;
    }
    { 
      name         = "enp0s9";
    }
  ];
}
