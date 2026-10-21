{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.deepseek-harness.nixosModules.default # 导入 DeepSeek Harness 模块
  ];

  # ====== 引导与内核 ======
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # ====== 内存优化 ======
  zramSwap.enable = true;

  # ====== 网络 ======
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  # ====== 本地化与时区 ======
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "zh_CN.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  # ====== 显示管理器 ======
  services.xserver.enable = false;
  services.displayManager.ly.enable = true;

  # ====== 字体 ======
  # kitty 里用的 Adwaita Mono 由这个包提供
  fonts.packages = with pkgs; [
    adwaita-fonts
  ];

  # ====== 窗口管理器 (Niri) ======
  programs.niri.enable = true;

  # ====== 文件管理器及配套服务 (Nautilus) ======
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.niri = {
      "org.freedesktop.impl.portal.FileChooser" = "nautilus";
    };
  };

  # ====== 默认终端设置 ======
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [ "kitty.desktop" ];
    };
  };

  # ====== 压缩包默认用 Ark 打开 ======
  # 不需要的话把整个 xdg.mime.defaultApplications 块删掉即可
  xdg.mime.defaultApplications = {
    "application/zip" = "org.kde.ark.desktop";
    "application/x-7z-compressed" = "org.kde.ark.desktop";
    "application/vnd.rar" = "org.kde.ark.desktop";
    "application/x-rar" = "org.kde.ark.desktop";
    "application/x-tar" = "org.kde.ark.desktop";
    "application/x-compressed-tar" = "org.kde.ark.desktop";
    "application/gzip" = "org.kde.ark.desktop";
    "application/x-xz" = "org.kde.ark.desktop";
    "application/x-bzip2" = "org.kde.ark.desktop";
    "application/zstd" = "org.kde.ark.desktop";
  };

  # ====== 中文输入法 (Fcitx5) ======
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        qt6Packages.fcitx5-chinese-addons
        fcitx5-gtk
        kdePackages.fcitx5-qt
        fcitx5-rime
      ];
    };
  };

  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    # 让 Edge 走原生 Wayland，不再每次启动拉 Xwayland
    # microsoft-edge 的 wrapper 见到这个变量会自动加 --ozone-platform-hint=auto
    # --enable-wayland-ime=true --enable-features=WaylandWindowDecorations
    NIXOS_OZONE_WL = "1";
  };

  xdg.autostart.enable = true;

  # ====== 音频 (PipeWire) ======
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # ====== 打印服务 ======
  services.printing.enable = true;

  # ====== Clash Verge 代理与 TUN 模式 ======
  programs.clash-verge = {
    enable = true;
    serviceMode = true;
    tunMode = true;
  };

  # ====== 用户账户 ======
  users.users."jin" = {
    isNormalUser = true;
    description = "jin";
    extraGroups = [ "networkmanager" "wheel" "clash-verge" ];
  };

  # ====== 软件包安装 ======
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    kitty
    nautilus
    microsoft-edge

    # KDE 归档管理器 Ark 及其解压后端
    # 注意：顶层的 pkgs.ark 是 posit 的 R 内核（0.1.x），不是这个 Ark！
    # KDE Ark 在 kdePackages 下，对应上游 KDE Gear 26.08.2
    kdePackages.ark
    unzip
    zip
    p7zip   # 7z 等
    unrar   # rar（unfree，已由 allowUnfree 放行）
  ];

  # ====== DeepSeek Harness 桌面应用 ======
  programs.dsh.desktop.enable = true;

  # ====== Nix 与国内镜像加速 ======
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # 添加 DSH 的 Cachix 缓存，并保留你原有的镜像源
  nix.settings.substituters = [
    "https://deepseek-harness-nix.cachix.org"
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    "https://mirror.sjtu.edu.cn/nix-channels/store"
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
  ];

  # 信任 DSH 的缓存公钥
  nix.settings.trusted-public-keys = [
    "deepseek-harness-nix.cachix.org-1:5NrkwLN9veNMhiINtU5ZeV4isXFhFsOwn6Ms7J1M+TA="
  ];

  # 解决之前提示 "you are not a trusted user" 的问题
  nix.settings.trusted-users = [ "root" "jin" ];

  nixpkgs.config.allowUnfree = true;

  # ====== 系统版本 ======
  system.stateVersion = "26.05";
}
