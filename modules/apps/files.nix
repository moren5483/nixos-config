# 文件管理器组：Thunar + 缩略图 + 可移动设备 + 剪贴板命令 + 自定义操作用的 python
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    thunar
    tumbler
    thunar-volman
    wl-clipboard
    python3
  ];

  # 文件夹默认用 Thunar 打开
  xdg.mime.defaultApplications."inode/directory" = "thunar.desktop";
}
