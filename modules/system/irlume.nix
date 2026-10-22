# 人脸认证：Irlume（ly 登录界面 + Noctalia 锁屏）
{ inputs, ... }:

{
  imports = [ inputs.irlume.nixosModules.irlume ];

  services.irlume = {
    enable = true;

    # ASUS FHD webcam：video0 是彩色摄像头，video2 是 IR 摄像头
    rgbDevice = "/dev/video0";
    irDevice = "/dev/video2";

    pam.services = {
      # ly 是文本模式的登录器，模块内置了它的 keyring 处理
      ly = { };

      # Noctalia 的锁屏在源码里写死用 "login" PAM 栈，而且只做
      # pam_authenticate（verify-only），所以这里必须用 lock 配置（sufficient）
      login = { profile = "lock"; };
    };
  };
}
