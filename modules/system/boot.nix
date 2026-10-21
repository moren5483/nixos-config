# 引导与内核：systemd-boot、最新内核、zram 内存压缩
{ pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_6_18;

  zramSwap.enable = true;
}
