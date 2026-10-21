# 虚拟化：QEMU/KVM + libvirtd + virt-manager（含嵌套虚拟化）
{ pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      # 只跑本机架构的虚拟机，qemu_kvm 比完整 qemu 小很多
      package = pkgs.qemu_kvm;

      # 给 Windows 11 之类需要 TPM 的虚拟机
      swtpm.enable = true;
    };
  };

  # 嵌套虚拟化：让客户机内部也能再跑 KVM。
  # 当前内核 Intel 默认 nested=Y，这里显式声明，换内核/换机器时行为不变。
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  programs.virt-manager.enable = true;

  # virt-manager 的自动连接配置写在 dconf 里
  programs.dconf.enable = true;

  # 让 jin 能管理虚拟机；图形界面首次操作仍会走 polkit 授权
  users.groups.libvirtd = { };
  users.users.jin.extraGroups = [ "libvirtd" ];
}
