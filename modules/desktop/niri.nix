# 桌面会话：ly 登录 → niri 26.04，以及门户、字体、文件管理器、默认应用
{ pkgs, ... }:

{
  services.xserver.enable = false;
  services.displayManager.ly.enable = true;

  programs.niri = {
    enable = true;
    # niri-flake 默认钉在 25.08，跑不了配置里的 include / blur / recent-windows
    package = pkgs.niri;
  };

  # 门户：文件选择交给 nautilus
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.niri."org.freedesktop.impl.portal.FileChooser" = "nautilus";
  };

  # 文件管理器需要的后台服务
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # kitty 用的 Adwaita Mono 由这个包提供
  fonts.packages = [ pkgs.adwaita-fonts ];

  xdg.terminal-exec = {
    enable = true;
    settings.default = [ "kitty.desktop" ];
  };

  # 压缩包默认用 Ark 打开；不需要整块删掉即可
  xdg.mime.defaultApplications = {
    "application/zip" = "org.kde.ark.desktop";
    "application/x-7z-compressed" = "org.kde.ark.desktop";
    "application/vnd.rar" = "org.kde.ark.desktop";
    "application/x-rar" = "org.kde.ark.desktop";
    "application/x-tar" = "org.kde.ark.desktop";
    "application/x-compressed-tar" = "org.kde.ark.desktop";
    "application/gzip" = "org.kde.ark.desktop";
    "application/x-xz" = "org.kde.ark.desktop";
    "application/x-bzip2" = "org.kde.ark.desktop";
    "application/zstd" = "org.kde.ark.desktop";

    # 图片默认用 imv 打开（shorin 那套也是它）
    "image/png" = "imv.desktop";
    "image/jpeg" = "imv.desktop";
    "image/gif" = "imv.desktop";
    "image/webp" = "imv.desktop";
    "image/bmp" = "imv.desktop";
    "image/tiff" = "imv.desktop";
    "image/svg+xml" = "imv.desktop";
  };

  # fcitx5 / noctalia 等由 XDG autostart 拉起
  xdg.autostart.enable = true;
}
