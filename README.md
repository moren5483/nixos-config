# NixOS 配置（nixos-config）

niri + Home Manager 的 NixOS 配置，按「一个功能一个文件」组织。
`configuration.nix` 是唯一的系统开关面板：**注释掉一行 import = 关闭一个功能 / 卸载一组软件**。

## 结构

```
nixos-config/
├── flake.nix                     # 输入：nixpkgs / niri / noctalia / home-manager / dsh
├── flake.lock                    # 锁定所有输入版本（必须提交）
├── configuration.nix             # ★ 唯一系统开关面板
├── hardware-configuration.nix    # nixos-generate-config 生成，别手改
│
├── modules/                      # ───── 系统层（NixOS 模块）─────
│   ├── system/                   # 基础层，一般不动
│   │   ├── boot.nix              # systemd-boot、内核、zram
│   │   ├── locale.nix            # 时区、zh_CN locale
│   │   ├── network.nix           # NetworkManager + nm-applet
│   │   ├── nix.nix               # 镜像源、GC、trusted-users、allowUnfree
│   │   ├── users.nix             # 用户 jin 与附加组
│   │   ├── env.nix               # 会话变量（输入法、NIXOS_OZONE_WL）
│   │   └── packages.nix          # ⚠ 基础工具：vim/git/wget/fastfetch/xwayland-satellite
│   │
│   ├── features/                 # ★ 功能开关：注释掉整行 = 整个功能关闭
│   │   ├── audio.nix             # PipeWire + rtkit（关掉就没声音）
│   │   ├── printing.nix          # CUPS
│   │   ├── fonts.nix             # Adwaita Mono 等字体
│   │   ├── nvidia.nix            # NVIDIA + PRIME offload（关掉回 nouveau，需重启）
│   │   ├── gaming.nix            # Steam + proton-ge + protonplus + 32 位图形栈
│   │   ├── virtualisation.nix    # libvirtd + virt-manager + QEMU/KVM
│   │   └── flatpak.nix           # flatpak 服务 + 交大镜像 + QQ/微信
│   │
│   ├── desktop/                  # 桌面会话（niri 是基础，别注释）
│   │   ├── niri.nix              # niri + ly + portal + gvfs/udisks2 + terminal-exec
│   │   ├── fcitx5.nix            # 输入法
│   │   └── qt.nix                # qt6ct 主题跟随壁纸
│   │
│   └── apps/                     # ★ 应用组：注释 = 卸载这一组
│       ├── browser.nix           # microsoft-edge
│       ├── files.nix             # thunar + tumbler + thunar-volman + wl-clipboard + python3
│       ├── media.nix             # mpv + loupe
│       ├── archive.nix           # KDE Ark + unzip/zip/p7zip/unrar
│       ├── proxy.nix             # clash-verge（TUN 模式）
│       └── dsh.nix               # DeepSeek Harness 桌面端
│
└── home/                         # ───── 用户层（Home Manager）─────
    ├── home.nix                  # ★ 用户层开关面板：同样一行一个
    ├── kitty.nix                 # 主题 + 字体 + 透明度
    ├── fish.nix                  # 交互式 fish 配置
    ├── gtk.nix                   # GTK 主题 / 图标
    ├── qt.nix                    # qt6ct 用户侧
    ├── thunar.nix                # ╭ 与下面的目录成对
    ├── thunar/                   # ╰ thunar.xml / uca.xml / helpers.rc / volman.xml
    ├── vim/
    │   ├── vim.nix
    │   └── vimrc
    ├── niri/
    │   ├── niri.nix              # 整个 config/ 目录装到 ~/.config/niri
    │   └── config/
    │       ├── config.kdl        # 主文件：environment / input / include
    │       ├── binds.kdl         # 键位
    │       ├── layout.kdl        # 布局、间隙、焦点环
    │       ├── windowrules.kdl
    │       ├── animations.kdl
    │       ├── blur.kdl
    │       ├── cursor.kdl
    │       ├── outputs.kdl
    │       ├── supertab.kdl
    │       └── noctalia.kdl      # Noctalia 生成的配色
    ├── fcitx5/
    │   ├── fcitx5.nix
    │   └── rime/default.custom.yaml
    └── noctalia/
        ├── noctalia.nix
        ├── templates.toml
        └── templates/            # 把壁纸配色渲染进 kitty/fcitx5/gtk/niri
```

## 怎么开关

功能与软件都在 `configuration.nix` 的 `imports` 里，一行对应一个：

```nix
imports = [
  # ...
  ./modules/features/gaming.nix     # ← 注释掉这行就等于关掉 Steam 全套
  ./modules/apps/archive.nix        # ← 注释掉这行就等于卸载 Ark 和解压后端
];
```

用户层同理，在 `home/home.nix` 的 `imports` 里注释：

```nix
imports = [
  ./kitty.nix      # ← 注释掉就回到默认终端配置
  ./thunar.nix     # ← 注释掉就不再部署 Thunar 的配置和右键菜单
];
```

## 约定

1. **模块必须自包含**：每个模块只设置自己关心的选项，不定义被别人引用的自定义 option。
   这样注释掉 import 不会让求值报 `option does not exist`。
2. **MIME 关联跟着应用走**：压缩包关联写在 `apps/archive.nix`，图片关联在 `apps/media.nix`，
   文件夹关联在 `apps/files.nix`。注释掉应用组，对应的关联也一起消失，不会留下悬空引用。
3. **不要注释 `system/packages.nix`**：`xwayland-satellite` 是 niri 跑 X11 应用的前提，
   `git`/`vim` 之类也在这里。
4. **注释 `features/audio.nix` 会没有声音**；**注释 `features/nvidia.nix` 会退回 nouveau，且必须重启**。

## 常用命令

```bash
# 应用配置
sudo nixos-rebuild switch --flake /home/jin/nixos-config#nixos

# 只验证求值、不切换
nix flake check /home/jin/nixos-config

# 更新所有输入（nixpkgs / niri / noctalia / home-manager / dsh）
nix flake update

# 回滚到上一个能用的系统代
sudo nixos-rebuild switch --rollback

# 清理旧代（14 天前）
sudo nix-collect-garbage --delete-older-than 14d
sudo nix store optimise
```
