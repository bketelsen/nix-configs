{ inputs, lib, config, pkgs, ... }: {

  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
    users = {
        root.initialHashedPassword = "$6$o7Gbl6VwKt9Fzssj$mfBuXPilRBrvh4.A3c5Uj1XVd1eFF13KOleZwTo0fdmiUjWrplORTgeCboV26nPar8/B2WU0TxirdF/9f54yZ.";

      "bjk" = {
        isNormalUser = true;
        home = "${
        if pkgs.stdenvNoCC.isDarwin then "/Users" else "/home"
      }/bjk";
        extraGroups =
          [ "wheel" "networkmanager" "lxd" "docker" ]; # Enable ‘sudo’ for the user.
        hashedPassword =
          "$6$9WbAMICpXIHb7uuw$cI3/9WhKFWN0/ATSfMwhpQVib5jVWgBmjMaAWgHcO33tvXWFpg2Pg.epG6gz0mhOgVn2vkYgNO.XepgAXIYBK.";
        shell = pkgs.zsh;
      };
    };
  };


}
