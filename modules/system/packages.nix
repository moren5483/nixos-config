# 基础系统工具（⚠ 建议保留：命令行和 niri 跑 X11 应用都依赖它们）
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # 命令行基础
    vim
    wget
    git
    fastfetch

    # 默认终端（xdg.terminal-exec 指向 kitty.desktop）
    kitty

    # niri 26.04 跑 X11 应用（QQ / Steam / Wine）需要
    xwayland-satellite
  ];
}
