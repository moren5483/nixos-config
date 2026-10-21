# Fish shell
{ ... }:

{
  programs.fish = {
    enable = true;

    # 去掉启动欢迎语
    interactiveShellInit = "set -g fish_greeting";
  };
}
