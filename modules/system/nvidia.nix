# NVIDIA 显卡驱动：Intel 核显 + NVIDIA 独显，PRIME sync（独显直连）
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

    # nixpkgs 的 production 分支（595.71.05），支持 Blackwell（RTX 50 系）
    package = config.boot.kernelPackages.nvidiaPackages.production;

    # 休眠时保留显存内容，避免唤醒后花屏；
    # 注意 sync 模式下 powerManagement.finegrained 必须保持关闭
    powerManagement.enable = true;

    # 安装 nvidia-settings 图形面板
    nvidiaSettings = true;

    # 独显直连：NVIDIA 负责渲染，Intel 负责把画面送到屏幕
    # 所有程序自动走独显，不再需要 nvidia-offload
    prime = {
      sync.enable = true;

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # 浏览器等应用的 VA-API 硬件解码
  hardware.graphics.extraPackages = [ pkgs.nvidia-vaapi-driver ];
}
