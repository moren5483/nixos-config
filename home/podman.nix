# Podman 镜像加速：用户级 registries.conf（覆盖系统 /etc/containers/registries.conf）
{ ... }:

{
  xdg.configFile."containers/registries.conf".text = ''
    # 不带前缀的镜像名（如 archlinux）按这个顺序查找
    unqualified-search-registries = ["docker.io"]

    # docker.io 走国内镜像；镜像失败时会回退到官方源
    [[registry]]
    location = "docker.io"

    [[registry.mirror]]
    location = "docker.m.daocloud.io"

    [[registry.mirror]]
    location = "docker.1ms.run"

    [[registry.mirror]]
    location = "docker.nju.edu.cn"
  '';
}
