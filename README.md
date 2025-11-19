# `mysql-py-nix-example`

> An example repository demonstrating how to use MySQL with Python in a Nix environment.

## Approach

- Core tool: `pkgs.mkShell`
- Philosophy: Minimal and reproducible development environment. Nix gathers Python, MySQL client libraries, uv, and other dependencies.
  Developers will handle the Python libraries using `uv sync`.
- Python3 libraries come from PyPI, downloaded every time the Python3 virtual environment is created.

## Setup and usage

1. Start a temporary MySQL database via `podman`

```sh
# Run a mysql instance on port 3306, with a created database 'testdb'
podman run --rm --name temp-mysql \
  -e MYSQL_ROOT_PASSWORD=mysecretpassword \
  -e MYSQL_DATABASE=testdb \
  -p 3306:3306 \
  mysql:8.0
```

2. In another terminal, enter the Nix environment

```sh
nix develop
```

3. Run the Python script to connect to the MySQL database

```sh
uv sync
python3 main.py
```
