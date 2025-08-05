topLevel: {
  flake.modules.nixos.openssh = {
    config,
    hostConfig,
    lib,
    ...
  }: let
    #TODO: Need to make domain a var and not hardcoded.
    hosts = lib.attrNames topLevel.config.flake.nixosConfigurations;
    domain = "extranet.casa";
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

    programs.ssh = {
      # Each hosts public key.
      knownHosts = lib.genAttrs hosts (hostname: {
        publicKeyFile = ../hosts/${hostname}/keys/ssh_host_ed25519_key.pub;
        extraHostNames =
          [
            "${hostname}.${domain}"
          ]
          ++
          # Alias for localhost if it's the same host.
          (lib.optional (hostname == config.networking.hostName) "localhost");
      });
    };

    # Passwordless sudo when SSH'ing with keys.
    security.pam.sshAgentAuth = {
      enable = true;
      authorizedKeysFiles = ["/etc/ssh/authorized_keys.d/%u"];
    };
  };
}
