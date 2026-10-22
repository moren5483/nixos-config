# 容器：Podman + Distrobox（在 NixOS 里跑别的发行版）
{ pkgs, ... }:

{
  # distrobox 的后端用 rootless podman，不需要 docker
  virtualisation.podman = {
    enable = true;

    # 容器里要能解析域名（默认网络 dns_enabled 是关的）
    defaultNetwork.settings.dns_enabled = true;
  };

  # distrobox 只是一组 shell 脚本，真正的容器由 podman 管
  environment.systemPackages = [ pkgs.distrobox ];
}
