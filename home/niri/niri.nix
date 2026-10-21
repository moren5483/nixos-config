# ============================================================
#  niri 配置（迁移自 shorin-arch-setup 的 noctalia 版本）
#
#  kdl 放在 ./config 里，整个目录会装到 ~/.config/niri，
#  config.kdl 用 include 把 layout / binds / blur 等串起来。
# ============================================================
{ pkgs, ... }:

{
  xdg.configFile."niri".source = ./config;

  home.packages = with pkgs; [
    # cursor.kdl 里用的 breeze 光标主题
    kdePackages.breeze
    # 系统原本只有 hicolor/locolor，补上 Adwaita 图标
    adwaita-icon-theme
  ];
}
