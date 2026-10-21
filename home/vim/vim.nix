# Vim 配置：把仓库里的 vimrc 软链到 ~/.vimrc
# 系统里的 vim 9.2 已带 +clipboard / +job，fcitx5-remote 也在 PATH 中
{ ... }:

{
  home.file.".vimrc".source = ./vimrc;
}
