{
  flake.modules.nixos."hosts/nixvm" = {
    networking.domain = "extranet.casa";
  };
}
