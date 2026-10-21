# Noctalia Shell：启用服务 + 声明式模板
# 模板把壁纸配色渲染进 fcitx5 的 Matugen 主题；界面设置由 GUI 写入
# ~/.local/state/noctalia/settings.toml，不在这里管理。
{ ... }:

{
  programs.noctalia = {
    enable = true;
    systemd.enable = true;
  };

  xdg.configFile."noctalia/templates.toml".source = ./templates.toml;
  xdg.configFile."noctalia/templates/fcitx5-theme.conf".source = ./templates/fcitx5-theme.conf;

  # niri 焦点框/边框配色的模板（输出到 ~/.local/share/niri/colors.kdl）
  xdg.configFile."noctalia/templates/niri-colors.kdl".source = ./templates/niri-colors.kdl;

  # kitty 的配色模板（背景用壁纸派生的 secondary_container）
  xdg.configFile."noctalia/templates/kitty-colors.conf".source = ./templates/kitty-colors.conf;
}
