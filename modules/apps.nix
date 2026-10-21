# 第三方应用：Clash Verge（TUN 代理）、DeepSeek Harness 桌面端
{ ... }:

{
  programs.clash-verge = {
    enable = true;
    serviceMode = true;
    tunMode = true;
  };

  programs.dsh.desktop.enable = true;
}
