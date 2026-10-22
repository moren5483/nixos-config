# 人脸认证：Howdy（ly 登录界面 + Noctalia 锁屏）
{ lib, ... }:

{
  services.howdy = {
    enable = true;

    # 人脸单独通过即可解锁；默认 required 等于二次验证
    control = "sufficient";

    # ASUS FHD webcam 的 IR 节点
    settings.video.device_path = "/dev/video2";
  };

  # ASUS 这类 Windows Hello 摄像头的 IR 补光灯默认不亮，由这个服务打开
  services.linux-enable-ir-emitter.enable = true;

  # services.howdy.enable 会让所有 PAM 服务默认都带上 howdy（含 sudo、sshd），
  # 这里关掉全局开关，只给下面两个服务单独开
  security.pam.howdy.enable = lib.mkForce false;

  # ly 登录界面
  security.pam.services.ly.howdy.enable = true;

  # Noctalia 锁屏在源码里写死用 "login" PAM 栈
  security.pam.services.login.howdy.enable = true;
}
