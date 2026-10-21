# ============================================================
#  Noctalia 配置（home-manager）
#
#  目前只放了给 fcitx5 用的模板：把壁纸配色渲染成 fcitx5 的
#  「Matugen」主题（~/.local/share/fcitx5/themes/Matugen/theme.conf）。
#  以后 btop / fuzzel / kitty 之类的模板也可以加在这个目录里。
#
#  注意：Noctalia 自己的界面设置（settings.toml）是 GUI 运行时写入的，
#  不受这里管理；这里只管 ~/.config/noctalia/*.toml 这种声明式配置。
# ============================================================
{ ... }:

{
  xdg.configFile."noctalia/templates.toml".source = ./templates.toml;

  xdg.configFile."noctalia/templates/fcitx5-theme.conf".source =
    ./templates/fcitx5-theme.conf;
}
