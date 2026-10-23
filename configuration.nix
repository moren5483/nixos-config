# 系统配置入口 = 开关面板
#
# 开启/关闭一个功能：注释/取消注释对应的一行 import 即可。
#   - modules/system/   基础层，一般不动
#   - modules/features/ 功能开关，注释 = 关闭
#   - modules/desktop/  桌面会话，niri 是基础，别注释
#   - modules/apps/     应用组，注释 = 卸载这一组软件
{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.deepseek-harness.nixosModules.default

    # ===== 基础层（一般不动）=====
    ./modules/system/boot.nix
    ./modules/system/locale.nix
    ./modules/system/network.nix
    ./modules/system/nix.nix
    ./modules/system/users.nix
    ./modules/system/env.nix
    ./modules/system/packages.nix

    # ===== 功能开关（注释 = 关闭）=====
    ./modules/features/audio.nix
    ./modules/features/printing.nix
    ./modules/features/fonts.nix
    ./modules/features/nvidia.nix
    ./modules/features/gaming.nix
    ./modules/features/virtualisation.nix
    ./modules/features/flatpak.nix

    # ===== 桌面（niri 必需）=====
    ./modules/desktop/niri.nix
    ./modules/desktop/fcitx5.nix
    ./modules/desktop/qt.nix

    # ===== 应用组（注释 = 卸载）=====
    ./modules/apps/browser.nix
    ./modules/apps/files.nix
    ./modules/apps/media.nix
    ./modules/apps/monitor.nix
    ./modules/apps/archive.nix
    ./modules/apps/proxy.nix
    ./modules/apps/dsh.nix
  ];

  system.stateVersion = "26.05";
}
