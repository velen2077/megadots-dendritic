{lib, ...}: {
  flake.modules.nixos."hosts/nixvm" = {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      timeout = 15;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
    };
  };
}
