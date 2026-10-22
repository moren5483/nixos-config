# 系统配置入口：具体设置都在 modules/ 下
{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.deepseek-harness.nixosModules.default

    # 系统
    ./modules/system/boot.nix
    ./modules/system/locale.nix
    ./modules/system/network.nix
    ./modules/system/nix.nix
    ./modules/system/users.nix
    ./modules/system/packages.nix
    ./modules/system/env.nix
    ./modules/system/nvidia.nix
    ./modules/system/virtualisation.nix
    ./modules/system/distrobox.nix

    # 桌面
    ./modules/desktop/niri.nix
    ./modules/desktop/fcitx5.nix
    ./modules/desktop/qt.nix
    ./modules/desktop/flatpak.nix

    # 服务与应用
    ./modules/services.nix
    ./modules/apps.nix
    ./modules/gaming.nix
  ];

  system.stateVersion = "26.05";
}
