{
  config,
  ...
}:
{
  flake.modules.nixos."hosts/x13".imports =
    # Import the nixos modules for the host `x13`.
    with config.flake.modules.nixos;
    [
      # Modules
      base
      bluetooth
      desktop
      displaylink
      dev
      facter
      fwupd
      shell
      sound
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
          desktop
          dev
          email
          facter
          messaging
          games
          shell
          work
        ];
      }
    ];
}
