# 用户配置入口：各模块放在子目录里
{ pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default

    ./kitty.nix
    ./fish.nix
    ./gtk.nix
    ./podman.nix
    ./distrobox.nix
    ./qt.nix
    ./vim/vim.nix
    ./niri/niri.nix
    ./fcitx5/fcitx5.nix
    ./noctalia/noctalia.nix
  ];

  home.username = "jin";
  home.homeDirectory = "/home/jin";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    # 个人工具，按需添加
  ];
}
