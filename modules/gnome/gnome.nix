{inputs, ...}: {
  unify.modules.gnome = {
    nixos = {pkgs, ...}: {
      # Enable dconf so it can be configured by home-manager.
      programs.dconf.enable = true;

      xdg.portal.enable = true;

      services = {
        libinput.enable = true;
        desktopManager.gnome = {
          enable = true;
        };
        displayManager.gdm = {
          enable = true;
          autoSuspend = false;
        };
      };

      environment.gnome.excludePackages = with pkgs; [
        gnome-photos
        gnome-tour
        gedit
        cheese # webcam tool
        gnome-music
        # text editor
        epiphany # web browser
        geary # email reader
        gnome-characters
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
        yelp # Help view
        gnome-contacts
        gnome-initial-setup
      ];

      environment.systemPackages = with pkgs; [
        dconf-editor
        gnome-tweaks
      ];

      environment.persistence."/persist" = {
        directories = [
          "/var/lib/AccountsService"
        ];
        files = [
        ];
      };
    };

    home = {pkgs, ...}: {
      imports = [inputs.impermanence.homeManagerModules.impermanence];
      home.packages = with pkgs; [
        gnomeExtensions.appindicator
        gnomeExtensions.user-themes
      ];

      dconf.settings = {
        # Don't try to suspend while plugged in.
        "org/gnome/settings-daemon/plugins/power" = {
          sleep-inactive-ac-type = "nothing";
        };

        "org/gnome/desktop/interface" = {
          # gtk4 theme/scheme.
          color-scheme = "prefer-dark";
          # accent-color = "slate";
          show-battery-percentage = true;
        };

        # Enable minimise, maximise buttons.
        "org/gnome/desktop/wm/preferences" = {
          button-layout = ":appmenu,minimize,maximize,close";
        };

        # Wayland Mutter tweaks.
        "org/gnome/mutter" = {
          edge-tiling = true;
          dynamic-workspaces = true;
        };
        "org/gnome/desktop/wm/preferences" = {
          resize-with-right-button = true;
        };
        "org/gnome/desktop/interface" = {
          enable-hot-corners = true;
        };

        # Touchpad support and config.
        "org/gnome/desktop/peripherals/touchpad" = {
          tap-to-click = true;
          natural-scroll = true;
        };

        # Extension config.
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = with pkgs.gnomeExtensions; [
            appindicator.extensionUuid
            user-themes.extensionUuid
          ];
          # favorite-apps = [ "org.gnome.Nautilus.desktop" "kitty.desktop" "chromium-browser.desktop" "code.desktop" ];
          last-selected-power-profile = "performance";
        };
      };

      home.persistence."/persist" = {
        directories = [
          ".config/autostart"
          ".local/share/gvfs-metadata"
          ".local/share/gnome-shell"
        ];
        files = [
          ".config/monitors.xml"
        ];
      };
    };
  };
}
