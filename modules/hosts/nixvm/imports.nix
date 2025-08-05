{config, ...}: {
  unify.hosts.nixos.nixvm = {
    users.velen2077.modules = config.unify.hosts.nixos.nixvm.modules;

    modules = with config.unify.modules; [
      base
      velen2077
    ];

    hostKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDjA5jkIlQ5iPFhi4Fo6y2zrReE30KJ6CRV+GLraU5h3 nixvm";

    tags = [
      "desktop"
    ];

    fqdn = "nixvm.extranet.casa";
  };
}
