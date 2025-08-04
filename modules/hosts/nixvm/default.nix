{config, ...}: {
  flake.modules.nixos."hosts/nixvm".imports = with config.flake.modules.nixos;
    [
      # Modules
      base
      ai
      gnome
      dev
      facter
      openssh
      shell
      vpn

      # Users
      root
      pol
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users.pol.imports = with config.flake.modules.homeManager; [
          base
          gnome
          dev
          facter
          shell
        ];
      }
    ];
}
