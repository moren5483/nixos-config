# 归档：KDE Ark 及解压后端（顶层的 pkgs.ark 是 posit 的 R 内核，不是这个）
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.ark
    unzip
    zip
    p7zip
    unrar # unfree，已由 allowUnfree 放行
  ];

  # 压缩包默认用 Ark 打开
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
  };
}
