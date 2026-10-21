# 中文输入法：fcitx5 + 雾凇拼音（rime）
# 设置写到 /etc/xdg/fcitx5/ 作为系统级默认值；
# ~/.config/fcitx5 里的用户配置优先级更高，会覆盖这里。
{ pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      waylandFrontend = true;

      addons = with pkgs; [
        qt6Packages.fcitx5-chinese-addons
        fcitx5-gtk
        kdePackages.fcitx5-qt
        fcitx5-rime
      ];

      settings = {
        # ── config：快捷键与行为 ──
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
          # 单击 Shift 切换中英（配合 rime 的 Shift=noop，见 home/fcitx5）
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

        # ── profile：输入法列表 ──
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

        # ── conf/ 下各插件的配置 ──
        addons = {
          # 外观：候选窗、字体、分数缩放
          classicui.globalSection = {
            "Vertical Candidate List" = false;
            WheelForPaging = true;
            Font = "\"Sans Serif 11\"";
            MenuFont = "\"Sans Serif 10\"";
            TrayFont = "\"Sans Serif 10\"";
            TrayOutlineColor = "#000000";
            TrayTextColor = "#ffffff";
            PreferTextIcon = false;
            ShowLayoutNameInIcon = true;
            UseInputMethodLanguageToDisplayText = true;
        # Matugen 主题由 noctalia 模板渲染（见 home/noctalia）
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

          # 隐藏 wayland 诊断通知
          notifications = {
            globalSection = { };
            sections.HiddenNotifications = { "0" = "wayland-diagnose-other"; };
          };

          # 标点行为
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
    };
  };
}
