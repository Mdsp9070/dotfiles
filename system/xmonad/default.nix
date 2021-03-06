{ pkgs, ...}:

{
  services = {
    xserver = {
      windowManager.xmonad = {
        enable = true;
        config = ./config.hs;
        enableContribAndExtras = true;
      };

      displayManager = {
        autoLogin = {
          enable = true;
          user = "matthew";
        };

        defaultSession = "none+xmonad";
      };
    };

    xrdp.defaultWindowManager = "xmonad";
  };
}
