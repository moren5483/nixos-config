# ============================================================
#  fcitx5 用户级配置（home-manager）
#
#  系统级的 i18n.inputMethod.fcitx5.settings 在同目录的 system.nix，
#  由 configuration.nix 导入。
# ============================================================
{ ... }:

{
  # 让 Shift 交给 fcitx5 的 AltTriggerKeys 切换中英，
  # 避免 Rime 自己也处理一次 Shift
  xdg.dataFile."fcitx5/rime/default.custom.yaml".source = ./rime/default.custom.yaml;
}
