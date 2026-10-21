# NVIDIA 显卡驱动：Intel 核显 + NVIDIA 独显，走 PRIME offload
# 重新构建后需要重启才生效
{ config, pkgs, ... }:

{
  # 加载 nvidia 内核模块；nouveau 会被自动加入黑名单
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Wayland 必需，否则 niri 起不来
    modesetting.enable = true;

    # 595 系列只提供开源内核模块；不显式写这行会触发 nixpkgs 的断言
    open = true;

    # 595.104.02，支持 Blackwell（RTX 50 系）
    package = config.boot.kernelPackages.nvidiaPackages.production;

    # 休眠时保留显存内容，避免唤醒后花屏
    powerManagement.enable = true;

    # 安装 nvidia-settings 图形面板
    nvidiaSettings = true;

    # 混合输出：桌面仍由 Intel 渲染，需要独显时用 nvidia-offload 启动
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true; # 提供 nvidia-offload 命令
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # 浏览器等应用的 VA-API 硬件解码
  hardware.graphics.extraPackages = [ pkgs.nvidia-vaapi-driver ];
}
