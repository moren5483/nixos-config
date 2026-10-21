# Flatpak：启用服务，并以幂等方式安装 QQ / 微信
# NixOS 的 services.flatpak 只有 enable，没有 packages 选项，
# 所以用一次性 systemd 服务在启动时补装（已装则秒退）
{ pkgs, ... }:

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
      ${pkgs.flatpak}/bin/flatpak remote-add --system --if-not-exists \
        flathub https://dl.flathub.org/repo/flathub.flatpakrepo

      ${pkgs.flatpak}/bin/flatpak install --system --noninteractive -y \
        flathub com.qq.QQ com.tencent.WeChat || true
    '';
  };
}
