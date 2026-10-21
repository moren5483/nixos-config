# Nix 自身设置：flakes、缓存镜像、信任用户、允许非自由软件
{ ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # 国内镜像优先，避免 cache.nixos.org 拉取慢
  nix.settings.substituters = [
    "https://deepseek-harness-nix.cachix.org"
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    "https://mirror.sjtu.edu.cn/nix-channels/store"
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
  ];

  nix.settings.trusted-public-keys = [
    "deepseek-harness-nix.cachix.org-1:5NrkwLN9veNMhiINtU5ZeV4isXFhFsOwn6Ms7J1M+TA="
  ];

  # jin 是 trusted-user，才能直接 nix build 往 store 里写
  nix.settings.trusted-users = [
    "root"
    "jin"
  ];

  nixpkgs.config.allowUnfree = true;
}
