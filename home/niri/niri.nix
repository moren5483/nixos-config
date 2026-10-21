# ============================================================
#  niri 配置（迁移自 shorin-arch-setup 的 noctalia 版本）
#
#  kdl 放在 ./config 里，整个目录会装到 ~/.config/niri，
#  config.kdl 用 include 把 layout / binds / blur 等串起来。
# ============================================================
{ pkgs, lib, ... }:

{
  xdg.configFile."niri".source = ./config;

  # niri 会 include ~/.local/share/niri/colors.kdl（由 Noctalia 按壁纸生成）。
  # include 一个不存在的文件会让 niri 拒绝加载整个配置，所以首次先放一份占位；
  # 之后 Noctalia 会覆盖它。
  home.activation.niriColorsSeed = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    colors="$HOME/.local/share/niri/colors.kdl"
    if [ ! -e "$colors" ]; then
      mkdir -p "$(dirname "$colors")"
      printf 'layout {\n  focus-ring {\n    active-color \"#bec2ff\"\n    inactive-color \"#131316\"\n  }\n}\n' > "$colors"
    fi
  '';

  home.packages = with pkgs; [
    # cursor.kdl 里用的 breeze 光标主题
    kdePackages.breeze
    # 系统原本只有 hicolor/locolor，补上 Adwaita 图标
    adwaita-icon-theme
  ];
}
