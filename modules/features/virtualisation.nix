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

      # virtiofs 共享目录的后端；没有它建虚拟机会报
      # "Unable to find a satisfying virtiofsd"
      vhostUserPackages = [ pkgs.virtiofsd ];
    };
  };

  # libvirtd 的 PATH 默认只放了 qemu 和 netcat，virtiofsd 要显式加进去
  systemd.services.libvirtd.path = [ pkgs.virtiofsd ];

  # 嵌套虚拟化：让客户机内部也能再跑 KVM。
  # 当前内核 Intel 默认 nested=Y，这里显式声明，换内核/换机器时行为不变。
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  programs.virt-manager.enable = true;

  # 修 virt-manager 的 .ui 界面不翻译的问题（上游 bug）：
  # 它的 Python 只调了 Python 层的 gettext.bindtextdomain，没同步给 libc；
  # 而 GTK Builder 走 glib → libc 的 dgettext，在 NixOS 上找不到 /nix/store 里的
  # .mo，于是菜单/对话框标题/按钮全是英文，只有 Python 里的 _() 字符串是中文。
  # 这里在 virtinst 导入时补一次 libc 层的 bindtextdomain。
  programs.virt-manager.package = pkgs.virt-manager.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      printf '\n# NixOS: bind gettext domain to libc so GTK Builder finds the .mo\nimport ctypes as _ctypes\n_ctypes.CDLL(None).bindtextdomain(b"virt-manager", BuildConfig.gettext_dir.encode())\n' >> virtinst/__init__.py
    '';
  });

  # virt-manager 的自动连接配置写在 dconf 里
  programs.dconf.enable = true;

  # 让 jin 能管理虚拟机；图形界面首次操作仍会走 polkit 授权
  users.groups.libvirtd = { };
  users.users.jin.extraGroups = [ "libvirtd" ];
}
