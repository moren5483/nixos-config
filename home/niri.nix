# ============================================================
#  niri 配置（迁移自 shorin-arch-setup 的 noctalia 版本）
#
#  用法：把本文件和同目录的 niri/ 文件夹一起复制到 ~/nixos-config/home/，
#        在 home.nix 的 imports 里加 ./niri.nix，
#        并删掉原来那行 xdg.configFile."niri/config.kdl"。
#
#  前置条件（configuration.nix，系统级）：
#        programs.niri.package = pkgs.niri;   # nixpkgs 的 niri 26.04
# ============================================================
{ pkgs, ... }:

{
  # 整个 kdl 目录装到 ~/.config/niri：
  #   config.kdl 用 include 拆分出 layout / binds / windowrules / blur ...
  xdg.configFile."niri".source = ./niri;

  home.packages = with pkgs; [
    # cursor.kdl 里用的 breeze 光标主题（如果 ~/.nix-profile/share/icons 里没有
    # breeze_cursors，说明这个包里不带光标，改装 bibata-cursors 并把 cursor.kdl
    # 的 xcursor-theme 改成 "Bibata-Modern-Ice"）
    kdePackages.breeze

    # 图标主题：系统现在只有 hicolor/locolor，没有 Adwaita，
    # 不加的话 nautilus 等 GTK 应用会各种图标缺失
    adwaita-icon-theme
  ];
}
