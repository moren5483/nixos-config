# 系统监视器：mission-center（GTK4/libadwaita，CPU/内存/磁盘/网络/进程/GPU）
{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.mission-center ];
}
