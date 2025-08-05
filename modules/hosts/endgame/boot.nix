{lib, ...}: {
  flake.modules.nixos."hosts/endgame" = {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      timeout = 15;
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
      };
    };
  };
}
