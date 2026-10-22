# Distrobox：把宿主字体共享给容器
{ ... }:

{
  xdg.configFile."distrobox/distrobox.conf".text = ''
    # 这个文件最后加载，会整体覆盖 NixOS 默认的
    # container_additional_volumes="/nix:/nix"，所以 /nix 要自己写回来。
    # 挂载只在 distrobox create 时生效，已有容器需要重建才会带上。
    container_additional_volumes="/nix:/nix /run/current-system/sw/share/X11/fonts:/usr/share/fonts/nix:ro"
  '';
}
