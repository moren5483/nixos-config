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
    ];
  };
}
