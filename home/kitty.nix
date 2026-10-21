# Kitty 终端
{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    # 配色由 Noctalia 按壁纸生成到 themes/noctalia.conf，
    # 这里只负责 include（放在配置末尾，会覆盖前面的颜色设置）
    extraConfig = "include themes/noctalia.conf";

    settings = {
      window_padding_width = 5; # 四边内边距
      hide_window_decorations = "yes"; # 无标题栏
      background_opacity = "0.8";
      font_family = "Adwaita Mono"; # 由 adwaita-fonts 提供
      font_size = 15;
      remember_window_size = "no";
      confirm_os_window_close = 0;
      shell = "${pkgs.fish}/bin/fish"; # NixOS 没有 /usr/bin/fish
    };
  };
}
