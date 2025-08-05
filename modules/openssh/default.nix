topLevel: {
  flake.modules.nixos.openssh = {
    config,
    hostConfig,
    lib,
    ...
  }: let
    hosts = lib.attrNames topLevel.config.flake.nixosConfigurations;
  in {
    services = {
      openssh = {
        enable = true;
        settings = {
          # Harden.
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          PermitRootLogin = "no";
          # Automatically remove stale sockets.
          StreamLocalBindUnlink = "yes";
          # Allow forwarding ports to everywhere.
          GatewayPorts = "clientspecified";
          # Let WAYLAND_DISPLAY be forwarded.
          AcceptEnv = "WAYLAND_DISPLAY";
          X11Forwarding = true;
        };

        hostKeys = [
          {
            path = "/etc/ssh/ssh_host_ed25519_key";
            type = "ed25519";
            comment = hostConfig.name;
          }
        ];
      };
    };

    # Passwordless sudo when SSH'ing with keys.
    security.pam.sshAgentAuth = {
      enable = true;
      authorizedKeysFiles = ["/etc/ssh/authorized_keys.d/%u"];
    };
  };
}
