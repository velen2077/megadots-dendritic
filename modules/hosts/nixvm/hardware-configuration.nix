{config, ...}: {
  flake.modules.nixos."hosts/nixvm" = {
    boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "sr_mod" "virtio_pci" "virtio_blk"];
    boot.initrd.kernelModules = ["amdgpu"];
    boot.kernelModules = ["kvm-amd" "amdgpu"];
    boot.extraModulePackages = [];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    #networking.useDHCP = true;
    # networking.interfaces.enp6s0.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform.system = "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = true;
  };
}
