{config, ...}: {
  configurations.nixos.nixvm.module = {
    imports = with config.flake.modules.nixos; [
      efi
      workstation
    ];
  };
}
