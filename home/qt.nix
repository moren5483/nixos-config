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

  # 启动器里隐藏 qt5ct / qt6ct 的设置窗口。
  # 系统 profile 里有同名 .desktop（来自 qt.platformTheme），
  # 用户目录放一个 NoDisplay=true 的同名文件就能盖掉它。
  xdg.desktopEntries.qt5ct = {
    name = "Qt5 Settings";
    noDisplay = true;
  };

  xdg.desktopEntries.qt6ct = {
    name = "Qt6 Settings";
    noDisplay = true;
  };
}
