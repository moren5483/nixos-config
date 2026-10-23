# 桌面会话：ly 登录 → niri 26.04，以及门户和文件管理器依赖的后台服务
{ pkgs, ... }:

{
  services.xserver.enable = false;
  services.displayManager.ly.enable = true;

  programs.niri = {
    enable = true;
    # niri-flake 默认钉在 25.08，跑不了配置里的 include / blur / recent-windows
    package = pkgs.niri;
  };

  # 门户：文件选择用 xdg-desktop-portal-gtk 自带的 GTK 对话框
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.niri."org.freedesktop.impl.portal.FileChooser" = "gtk";
  };

  # 文件管理器需要的后台服务
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  xdg.terminal-exec = {
    enable = true;
    settings.default = [ "kitty.desktop" ];
  };

  # fcitx5 / noctalia 等由 XDG autostart 拉起
  xdg.autostart.enable = true;
}
