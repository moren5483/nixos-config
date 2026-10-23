# 媒体：mpv 播放器 + Loupe 看图（可裁剪/旋转/翻转）
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mpv
    loupe
  ];

  xdg.mime.defaultApplications = {
    "image/png" = "org.gnome.Loupe.desktop";
    "image/jpeg" = "org.gnome.Loupe.desktop";
    "image/gif" = "org.gnome.Loupe.desktop";
    "image/webp" = "org.gnome.Loupe.desktop";
    "image/bmp" = "org.gnome.Loupe.desktop";
    "image/tiff" = "org.gnome.Loupe.desktop";
    "image/svg+xml" = "org.gnome.Loupe.desktop";
  };
}
