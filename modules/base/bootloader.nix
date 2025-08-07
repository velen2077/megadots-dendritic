{
  unify.modules.base = {
    nixos = {
      boot = {
        initrd.systemd.enable = true;
        loader = {
          efi.canTouchEfiVariables = true;
          timeout = 15;
          systemd-boot = {
            enable = true;
            configurationLimit = 10;
          };
        };
      };
    };
  };
}
