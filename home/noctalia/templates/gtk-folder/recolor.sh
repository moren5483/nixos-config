#!/usr/bin/env bash
# 按壁纸配色给 Adwaita 的文件夹图标重新上色。
#
# 图标源直接取系统里已安装的 Adwaita（adwaita-icon-theme），
# 仓库里只放这一个脚本，不放任何 SVG。
# 生成到 ~/.local/share/icons/Adwaita-Matugen-A|B，
# 两个名字轮流切换是为了让 GTK 丢掉旧的图标缓存。

set -euo pipefail

BODY="{{colors.secondary_fixed_dim.default.hex}}"
TOP="{{colors.secondary.default.hex}}"
SHADOW="{{colors.secondary_container.default.hex}}"

# 找 Adwaita：优先 XDG_DATA_DIRS（NixOS 的 profile / 系统路径都在里面）
SRC=""
IFS=':' read -r -a dirs <<< "${XDG_DATA_DIRS:-/usr/share}"
for d in "${dirs[@]}" "$HOME/.nix-profile/share" "$HOME/.local/share"; do
    if [[ -n "$d" && -d "$d/icons/Adwaita/scalable/places" ]]; then
        SRC="$d/icons/Adwaita"
        break
    fi
done
if [[ -z "$SRC" ]]; then
    echo "recolor: Adwaita icon theme not found" >&2
    exit 1
fi

# A/B 轮流，避免同名目录被 GTK 当成旧缓存
CURRENT="$(dconf read /org/gnome/desktop/interface/icon-theme 2>/dev/null | tr -d "'" || true)"
if [[ "$CURRENT" == "Adwaita-Matugen-A" ]]; then
    NAME="Adwaita-Matugen-B"
else
    NAME="Adwaita-Matugen-A"
fi
DEST="$HOME/.local/share/icons/$NAME"

rm -rf "$DEST"
mkdir -p "$DEST/scalable/places"

cat > "$DEST/index.theme" <<EOF
[Icon Theme]
Name=$NAME
Comment=Adwaita folders recolored from the wallpaper palette
Example=folder
Inherits=Adwaita,AdwaitaLegacy,hicolor
Hidden=true

Directories=scalable/places

[scalable/places]
Context=Places
Size=48
Type=Scalable
EOF

# -L 解引用软链（Adwaita 里有些图标是 symlink）
cp -L "$SRC"/scalable/places/*.svg "$DEST/scalable/places/"

# Adwaita 原版 folder.svg 的四种蓝
sed -i \
    -e "s/#a4caee/$BODY/g" \
    -e "s/#afd4ff/$TOP/g" \
    -e "s/#c0d5ea/$TOP/g" \
    -e "s/#438de6/$SHADOW/g" \
    -e "s/#62a0ea/$SHADOW/g" \
    "$DEST"/scalable/places/*.svg

dconf write /org/gnome/desktop/interface/icon-theme "'$NAME'"
