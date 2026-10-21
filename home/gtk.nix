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

    # 图标主题不在这里写死：Noctalia 的 gtk-folder 模板会生成
    # Adwaita-Matugen-A/B 并通过 dconf 切换，settings.ini 写死会覆盖它

    font = {
      name = "Adwaita Sans";
      size = 11;
      package = pkgs.adwaita-fonts;
    };
  };
}
