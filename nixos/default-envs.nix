{ config, ... }:
{
  environment.sessionVariables = rec {
    TERMINAL = "alacritty";
    LAUNCHER = "j4-dmenu-desktop";
    BROWSER = "brave";
  };
}
