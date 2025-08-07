{config, ...}: {
  flake = {
    meta.users = {
      velen2077 = {
        email = "velen2077@proton.me";
        name = "velen2077";
        username = "velen2077";
        authorizedKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICghxZTe6k1LQIoDN1kqjWTQxe22WKSAB4qs0agKD9GY velen2077"
        ];
      };
    };
  };

  unify.modules.velen2077.nixos = {pkgs, ...}: {
    programs.fish.enable = true;

    users.users.velen2077 = {
      description = config.flake.meta.users.velen2077.name;
      isNormalUser = true;
      createHome = true;
      extraGroups = [
        "audio"
        "input"
        "networkmanager"
        "sound"
        "tty"
        "wheel"
      ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = config.flake.meta.users.velen2077.authorizedKeys;
      hashedPassword = "$6$SpG3sYsUt3IxXQLv$1v6tnDzULI4mM6bO.jXbJGuO/7rXcfdKJet4xBcylTG88dDyJrGdNpsKH9/eGwVIFSmQD6lIWWWE4CTUAMI820";
    };

    nix.settings.trusted-users = [config.flake.meta.users.velen2077.username];

    home-manager.users.velen2077 = {
      home.file = {
        ".face" = {
          source = ../../assets/home/velen2077/.face;
          recursive = true;
        };
        ".face.icon" = {
          source = ../../assets/home/velen2077/.face;
          recursive = true;
        };
      };
    };
  };
}
