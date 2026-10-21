# Qt 应用主题：让 Qt 跟随 GTK（qgnomeplatform）+ Adwaita 深色风格
{ ... }:

{
  qt = {
    enable = true;

    # 等价于 shorin 的 QT_QPA_PLATFORMTHEME=gtk3：
    # 安装 qgnomeplatform / qgnomeplatform-qt6，让 Qt 读取 GTK 的配色与字体
    platformTheme = "gnome";

    # platformTheme = "gnome" 时必须指定一个同时支持 Qt 与 GTK 的 style，
    # 否则 nixpkgs 的断言会拦下来
    style = "adwaita-dark";
  };
}
