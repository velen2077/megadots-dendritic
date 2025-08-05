topLevel: {
  flake.modules = {
    homeManager.dev = {config, ...}: {
      programs = {
        #git = {
        # enable = true;
        #userName = topLevel.config.flake.meta.users.${config.home.username}.name;
        #userEmail = topLevel.config.flake.meta.users.${config.home.username}.email;
        git = {
          enable = true;
          lfs.enable = true;

          ignores = [
            "result"
            "*.swp"
            "*.qcow2"
          ];

          extraConfig = {
            init.defaultBranch = "main";
            pull.rebase = false;
            # Sign all commits using ssh key
            commit.gpgsign = true;
            gpg.format = "ssh";
            user.signingkey = topLevel.config.flake.meta.users.${config.home.username}.authorizedKeys;
          };

          #signing = {
          #  key = cfg.key;
          #  signByDefault = true;
          #};

          aliases = {
            s = "status";
            d = "diff";
            a = "add";
            c = "commit";
            p = "push";
            co = "checkout";
          };

          userEmail = topLevel.config.flake.meta.users.${config.home.username}.email;
          userName = topLevel.config.flake.meta.users.${config.home.username}.name;
        };
      };
    };
  };
}
