# ============================================================
#  Fcitx5 设置（迁移自 shorin-arch-setup 的 noctalia 版）
#
#  这是 NixOS 模块，由 configuration.nix 导入：
#      imports = [ ... ./home/fcitx5/system.nix ];
#  用户级的 rime 补丁在同目录的 fcitx5.nix 里，
#  fcitx5 的主题模板在 ../noctalia/ 下。
#
#  这些值会写到 /etc/xdg/fcitx5/ 下，作为系统级配置。
#  ~/.config/fcitx5 里的用户配置优先级更高，会把它整个盖住，
#  所以首次启用前要先把旧配置挪走：
#      mv ~/.config/fcitx5 ~/.config/fcitx5.bak
#  然后重启 fcitx5（注销重登，或 fcitx5 -r -d）。
# ============================================================
{ ... }:

{
  i18n.inputMethod.fcitx5.settings = {
    # ===== config：快捷键与行为 =====
    globalOptions = {
      Hotkey = {
        EnumerateWithTriggerKeys = true;
        EnumerateForwardKeys = "";
        EnumerateBackwardKeys = "";
        EnumerateSkipFirst = false;
        ModifierOnlyKeyTimeout = 250;
      };
      "Hotkey/TriggerKeys" = {
        "0" = "Super+space";
        "1" = "Zenkaku_Hankaku";
        "2" = "Hangul";
      };
      "Hotkey/ActivateKeys" = { "0" = "Hangul_Hanja"; };
      "Hotkey/DeactivateKeys" = { "0" = "Hangul_Romaja"; };
      # 单击 Shift 在中英文之间切换（配合 rime 里 Shift=noop，见 rime 那一段）
      "Hotkey/AltTriggerKeys" = {
        "0" = "Shift_L";
        "1" = "Shift_R";
      };
      "Hotkey/EnumerateGroupForwardKeys" = { "0" = "Super+space"; };
      "Hotkey/EnumerateGroupBackwardKeys" = { "0" = "Shift+Super+space"; };
      "Hotkey/PrevPage" = { "0" = "Up"; };
      "Hotkey/NextPage" = { "0" = "Down"; };
      "Hotkey/PrevCandidate" = { "0" = "Shift+Tab"; };
      "Hotkey/NextCandidate" = { "0" = "Tab"; };
      "Hotkey/TogglePreedit" = { "0" = "Control+Alt+P"; };

      Behavior = {
        ActiveByDefault = false;
        resetStateWhenFocusIn = "No";
        ShareInputState = "No";
        PreeditEnabledByDefault = true;
        ShowInputMethodInformation = true;
        showInputMethodInformationWhenFocusIn = false;
        CompactInputMethodInformation = true;
        ShowFirstInputMethodInformation = true;
        DefaultPageSize = 5;
        OverrideXkbOption = false;
        CustomXkbOption = "";
        EnabledAddons = "";
        DisabledAddons = "";
        PreloadInputMethod = true;
        AllowInputMethodForPassword = false;
        ShowPreeditForPassword = false;
        AutoSavePeriod = 30;
      };
    };

    # ===== profile：输入法列表 =====
    inputMethod = {
      "Groups/0" = {
        Name = "Default";
        "Default Layout" = "us";
        DefaultIM = "rime";
      };
      "Groups/0/Items/0" = {
        Name = "keyboard-us";
        Layout = "";
      };
      "Groups/0/Items/1" = {
        Name = "rime";
        Layout = "";
      };
      GroupOrder = { "0" = "Default"; };
    };

    # ===== conf/ 下的各插件配置 =====
    addons = {
      # 外观：竖排候选、字体、分数缩放
      classicui.globalSection = {
        "Vertical Candidate List" = true;
        WheelForPaging = true;
        Font = "\"Sans Serif 11\"";
        MenuFont = "\"Sans Serif 10\"";
        TrayFont = "\"Sans Serif 10\"";
        TrayOutlineColor = "#000000";
        TrayTextColor = "#ffffff";
        PreferTextIcon = false;
        ShowLayoutNameInIcon = true;
        UseInputMethodLanguageToDisplayText = true;
        # 由 noctalia 模板生成的 Matugen 主题（见 noctalia.nix）
        Theme = "Matugen";
        DarkTheme = "default-dark";
        UseDarkTheme = false;
        UseAccentColor = true;
        PerScreenDPI = false;
        ForceWaylandDPI = 0;
        EnableFractionalScale = true;
      };

      # 简繁转换（Ctrl+Shift+F）
      chhtrans = {
        globalSection = {
          Engine = "OpenCC";
          EnabledIM = "";
          OpenCCS2TProfile = "default";
          OpenCCT2SProfile = "default";
        };
        sections.Hotkey = { "0" = "Control+Shift+F"; };
      };

      # 保留你原来隐藏的那条通知
      notifications = {
        globalSection = { };
        sections.HiddenNotifications = { "0" = "wayland-diagnose-other"; };
      };

      # 标点（沿用你现有的设置）
      punctuation = {
        globalSection = {
          HalfWidthPuncAfterLetterOrNumber = true;
          TypePairedPunctuationsTogether = false;
          Enabled = true;
        };
        sections.Hotkey = { "0" = "Control+period"; };
      };
    };
  };
}
