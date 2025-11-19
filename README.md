# `mysql-py-nix-example`

> An example repository demonstrating how to use MySQL with Python in a Nix environment.

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
