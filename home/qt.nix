# qt6ct / qt5ct 配置：指向 Noctalia 生成的配色方案
# 颜色方案本身由 Noctalia 模板写到 colors/noctalia.conf，这里只负责选中它。
{ config, ... }:

let
  colorsDir = "${config.xdg.configHome}";
in

{
  xdg.configFile."qt6ct/qt6ct.conf".text = ''
    [Appearance]
    color_scheme_path=${colorsDir}/qt6ct/colors/noctalia.conf
    custom_palette=true
    style=adwaita-dark

    [Interface]
    icon_theme=Adwaita
  '';

  xdg.configFile."qt5ct/qt5ct.conf".text = ''
    [Appearance]
    color_scheme_path=${colorsDir}/qt5ct/colors/noctalia.conf
    custom_palette=true
    style=adwaita-dark

    [Interface]
    icon_theme=Adwaita
  '';
}
