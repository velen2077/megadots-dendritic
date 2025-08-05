{config, ...}: {
  flake.modules.nixos."hosts/endgame".imports = with config.flake.modules.nixos;
    [
      # Modules
      base
      gnome
      #openssh
      shell
      vpn

      # Users
      velen2077
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users.velen2077.imports = with config.flake.modules.homeManager; [
          base
          gnome
          dev
          shell
        ];
      }
    ];
}
