# 游戏：Steam（含 Proton）与 ProtonPlus
{ pkgs, ... }:

{
  # Steam 需要官方 FHS 环境和 32 位库，必须走 programs.steam，
  # 不能直接塞进 environment.systemPackages
  programs.steam = {
    enable = true;

    # 串流 / 局域网传输用到的防火墙端口，不需要可以关掉
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Steam 与 Proton 依赖图形栈，32 位组件给老游戏和 Wine 用
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # 管理 Proton / Wine 版本的图形工具
  environment.systemPackages = [ pkgs.protonplus ];
}
