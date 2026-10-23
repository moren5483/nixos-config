# 字体：kitty 用的 Adwaita Mono 等
{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    adwaita-fonts
  ];
}
