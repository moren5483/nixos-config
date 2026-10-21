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
}
