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
