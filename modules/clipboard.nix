{lib, ...}: {
  flake.modules = {
    homeManager.gui = {
      config,
      pkgs,
      ...
    }: let
      mod = config.wayland.windowManager.sway.config.modifier;

      rofi-cliphist = pkgs.writeShellApplication {
        name = "rofi-cliphist";
        runtimeInputs = [
          config.services.cliphist.package
          config.programs.rofi.package
        ];
      };
    in {
      services.cliphist.enable = true;

      wayland.windowManager = {
        sway.config.keybindings = {
          "--no-repeat ${mod}+p" = "exec ${lib.getExe rofi-cliphist} copy";
          "--no-repeat ${mod}+Shift+p" = "exec ${lib.getExe rofi-cliphist} type";
        };

        hyprland.settings.bind = [
          "SUPER, p, exec, ${lib.getExe rofi-cliphist} copy"
          "SUPER+SHIFT, p, exec, ${lib.getExe rofi-cliphist} type"
        ];
      };

      home.packages = with pkgs; [
        wl-clipboard-rs
      ];
    };

    nixvim.astrea.clipboard.register = "unnamedplus";
  };
}
