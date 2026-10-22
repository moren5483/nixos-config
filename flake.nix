{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git?ref=nixos-26.05&shallow=1";

    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";

    noctalia.url = "github:noctalia-dev/noctalia/cachix";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # 新增 DeepSeek Harness 的 Flake 输入
    deepseek-harness.url = "github:moraxyc/deepseek-harness.nix";

    # 人脸认证（IR 摄像头），自带 NixOS 模块
    irlume.url = "github:archledger/irlume/v0.15.0";
    irlume.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, niri, noctalia, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        niri.nixosModules.niri
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jin = import ./home/home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}
