# 系统级软件包
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # 基础工具
    vim
    wget
    git
    fastfetch

    # 桌面应用
    kitty
    nautilus
    microsoft-edge
    mpv
    loupe
    imagemagick # 供 noctalia 的图标染色脚本使用

    # 归档：Ark 及解压后端
    # 注意：顶层的 pkgs.ark 是 posit 的 R 内核，KDE Ark 在 kdePackages 下
    kdePackages.ark
    unzip
    zip
    p7zip
    unrar # unfree，已由 allowUnfree 放行

    # niri 26.04 跑 X11 应用（QQ / Steam / Wine）需要
    xwayland-satellite
  ];
}
