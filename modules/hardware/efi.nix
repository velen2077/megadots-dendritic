{
  flake.modules = {
    nixos.efi.boot.loader = {
      efi.canTouchEfiVariables = true;
      timeout = 15;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
    };

    homeManager.base = {pkgs, ...}: {
      home.packages = [
        pkgs.efivar
        pkgs.efibootmgr
      ];
    };
  };
}
