# Flatpak：启用服务，使用国内镜像，并以幂等方式安装 QQ / 微信
#
# 注意：安装要下载 1~2 GB，所以不能挂到 multi-user.target——
# 那会让 nixos-rebuild 的 activation 一直等它下完。改用 timer 在开机后
# 异步执行；已装过则 RemainAfterExit 直接秒退。
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

  systemd.timers.flatpak-apps = {
    description = "Run flatpak-apps shortly after boot";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "2min";
      Unit = "flatpak-apps.service";
    };
  };
}
