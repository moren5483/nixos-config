# Flatpak：启用服务，使用国内镜像，并以幂等方式安装 QQ / 微信
# NixOS 的 services.flatpak 只有 enable，没有 packages 选项，
# 所以用一次性 systemd 服务在启动时补装（已装则秒退）
{ pkgs, ... }:

let
  # 上海交大镜像：flathub 的智能缓存，分支已预先缓存；
  # 文件未命中时 302 回源并在后台缓存。备选：https://mirrors.ustc.edu.cn/flathub
  flathub-mirror = "https://mirror.sjtu.edu.cn/flathub";
in

{
  services.flatpak.enable = true;

  systemd.services.flatpak-apps = {
    description = "Install Flatpak apps (QQ, WeChat)";
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [
      "network-online.target"
      "flatpak-system-helper.service"
    ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      FP=${pkgs.flatpak}/bin/flatpak

      # 先按官方地址建 remote（顺带导入 Flathub 的 GPG 公钥），再切到镜像
      $FP remote-add --system --if-not-exists \
        flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      $FP remote-modify --system flathub --url=${flathub-mirror}

      $FP install --system --noninteractive -y \
        flathub com.qq.QQ com.tencent.WeChat || true
    '';
  };
}
