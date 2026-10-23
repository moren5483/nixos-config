# 代理：Clash Verge（服务模式 + TUN）
{ ... }:

{
  programs.clash-verge = {
    enable = true;
    serviceMode = true;
    tunMode = true;
  };
}
