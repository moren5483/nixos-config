# 用户账户（clash-verge 组用于 TUN 模式）
{ ... }:

{
  users.users.jin = {
    isNormalUser = true;
    description = "jin";
    extraGroups = [
      "networkmanager"
      "wheel"
      "clash-verge"
      # Howdy 的 PAM 模块在用户进程里跑（noctalia 锁屏），要能读摄像头
      "video"
    ];
  };
}
