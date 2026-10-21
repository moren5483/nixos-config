# GTK 主题、图标与字体
# GTK3 用 adw-gtk3-dark 与 libadwaita 的外观对齐；GTK4 仍由 color-scheme 控制深浅
{ pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    font = {
      name = "Adwaita Sans";
      size = 11;
      package = pkgs.adwaita-fonts;
    };
  };
}
