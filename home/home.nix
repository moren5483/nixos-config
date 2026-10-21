{ config, pkgs, inputs, ... }:

{
  # ====== 基本信息 ======
  home.username = "jin";
  home.homeDirectory = "/home/jin";
  home.stateVersion = "26.05";

  # ====== Niri 配置 ======
  xdg.configFile."niri/config.kdl".source = ./niri-config.kdl;

  # ====== Kitty ======
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Frappe";

    settings = {
      # 窗口内边距（单个值 = 四边都是 5；只想左右边距写 "0 5"）
      window_padding_width = 5;
      # 隐藏标题栏
      hide_window_decorations = "yes";
      # 背景透明度
      background_opacity = "0.8";
      # 字体
      font_family = "Adwaita Mono";
      font_size = 15;
      # 不记住窗口大小
      remember_window_size = "no";
      # 关闭窗口不询问
      confirm_os_window_close = 0;
      # 默认 shell 用 fish（NixOS 没有 /usr/bin/fish）
      shell = "${pkgs.fish}/bin/fish";
    };
  };

  # ====== Fish（Home Manager 管理）======
  programs.fish = {
    enable = true;

    # 去掉启动欢迎语
    interactiveShellInit = ''
      set -g fish_greeting
    '';
  };

  # ====== Noctalia Shell ======
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;
  };

  # ====== 用户级软件包 ======
  home.packages = with pkgs; [
    # 个人工具，按需添加
  ];
}
