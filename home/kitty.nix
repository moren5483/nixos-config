# Kitty 终端
{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Frappe";

    settings = {
      window_padding_width = 5; # 四边内边距
      hide_window_decorations = "yes"; # 无标题栏
      background_opacity = "0.8";
      font_family = "Adwaita Mono"; # 由 adwaita-fonts 提供
      font_size = 15;
      remember_window_size = "no";
      confirm_os_window_close = 0;
      shell = "${pkgs.fish}/bin/fish"; # NixOS 没有 /usr/bin/fish
    };
  };
}
