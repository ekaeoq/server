{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../users/root.nix
    ../../users/user.nix
  ];

  networking.hostName = "minimal";
  networking.firewall.allowedTCPPorts = [22];
}
