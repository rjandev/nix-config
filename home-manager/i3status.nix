{
  config,
  lib,
  pkgs,
  ...
}:

let
  home = pkgs.home-manager;
in
{
  home.file.".config/i3blocks/config".text = ''
    # Global properties
    separator=true
    separator_block_width=15

    [documentation]
    full_text=Documentation
    website=https://vivien.github.io/i3blocks
    command=xdg-open "$website"
    color=#f12711

    [DISK]
    command=df -h / | awk '/\//{ printf(" disk: %4s/%s \n", $3, $2) }'
    interval=2
    color=#C9E3DB

    [time]
    command=date '+%Y-%m-%d %H:%M:%S'
    interval=1
  '';
}
