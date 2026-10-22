# Thunar（Xfce 文件管理器）：配置与右键自定义操作
{ ... }:

{
  # 设置：视图模式、窗口大小、隐藏书签等
  xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/thunar.xml".source = ./thunar/thunar.xml;

  # 可移动设备自动挂载
  xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/thunar-volman.xml".source = ./thunar/thunar-volman.xml;

  # xfce 的「打开终端」默认程序
  xdg.configFile."xfce4/helpers.rc".source = ./thunar/helpers.rc;

  # 右键自定义操作（复制路径、在此打开终端、粘贴为链接、粘贴剪贴板图片）
  xdg.configFile."Thunar/uca.xml".source = ./thunar/uca.xml;
}
