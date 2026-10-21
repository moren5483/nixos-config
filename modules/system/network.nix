# 主机名与网络：NetworkManager + 托盘小程序
{ ... }:

{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  programs.nm-applet.enable = true;
}
