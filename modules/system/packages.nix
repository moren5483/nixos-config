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
    thunar
    microsoft-edge
    mpv
    loupe

    # Thunar 配套：缩略图、U 盘自动挂载、剪贴板命令、自定义操作里的 python
    tumbler
    thunar-volman
    wl-clipboard
    python3

    # 系统监视器（GTK4/libadwaita，CPU/内存/磁盘/网络/进程/GPU）
    mission-center

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
