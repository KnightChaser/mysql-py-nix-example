{
  description = "Python development environment with MySQL support";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          python312
          uv
          pkg-config
          libmysqlclient
          openssl
        ];

        env = {
          # 1. Build-time: Tells uv/pip where to find header files (mysql.h)
          PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.libmysqlclient}/lib/pkgconfig";

          # 2. Run-time: Tells Python where to find the compiled .so files
          LD_LIBRARY_PATH = "${pkgs.libmysqlclient}/lib:${pkgs.openssl.out}/lib";
        };

        shellHook = ''
          echo "MySQL Dev Environment Loaded"

          if [ ! -d ".venv" ]; then
             echo "Creating virtual environment..."
             uv venv
          fi

          source .venv/bin/activate

          echo "Python: $(python --version)"
          echo "UV: $(uv --version)"
        '';
      };
    };
}
