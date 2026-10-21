# 会话环境变量：输入法（fcitx5）与 Edge 的 Wayland 开关
{ ... }:

{
  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";

    # microsoft-edge 的 wrapper 见到这个变量会自动加 Wayland 参数，
    # 不再每次启动都拉起 Xwayland
    NIXOS_OZONE_WL = "1";
  };
}
