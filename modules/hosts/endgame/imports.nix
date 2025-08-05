{config, ...}: {
  unify.hosts.nixos.endgame = {
    users.velen2077.modules = config.unify.hosts.nixos.endgame.modules;

    modules = with config.unify.modules; [
      base
      velen2077
    ];

    hostKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHTkWpPiKhu8OeEkT/Gyev8a0OK/aaOlSmz/VL+EXf3x endgame";

    tags = [
      "desktop"
    ];

    fqdn = "endgame.extranet.casa";
  };
}
