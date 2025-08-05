{
  unify.modules.base.nixos = {
    # Set the time zone.
    time.timeZone = "Europe/London";

    # Update the xkb layout to British.
    services.xserver = {
      xkb.layout = "gb";
    };

    # Configure console keymap.
    console.keyMap = "uk";
  };
}
