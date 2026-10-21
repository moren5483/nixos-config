# Qt 应用主题：用 qt6ct 读取 Noctalia 生成的配色方案
#
# 原来用 qgnomeplatform（platformTheme = "gnome"），它只读 GTK 的 theme 名，
# 不认 ~/.config/gtk-*/gtk.css 里的 @define-color 覆盖，所以壁纸换色它不跟。
# 改成 qt6ct：Noctalia 把配色写成 qt6ct/qt5ct 的 colors/noctalia.conf，
# qt6ct 读它 + adwaita-dark 控件风格。
{ ... }:

{
  qt = {
    enable = true;

    # 仅为了让 nixpkgs 装上 qt5ct / qt6ct 并配好 QT_PLUGIN_PATH
    platformTheme = "qt5ct";

    # 安装 adwaita-qt / adwaita-qt6，供 qt6ct 的 style=adwaita-dark 使用
    style = "adwaita-dark";
  };

  # Qt6 应用走 qt6ct（覆盖模块默认的 qt5ct）。
  # 代价：少数 Qt5 应用拿不到平台主题，会用默认 Fusion 风格。
  environment.variables.QT_QPA_PLATFORMTHEME = "qt6ct";
}
