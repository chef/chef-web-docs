+++
title = "Backup and Restore"
draft = false
gh_repo = "license-service"

[menu]
  [menu.overview]
    title = "Backup and Restore"
    identifier = "overview/licensing/local/Backup and Restore"
    parent = "overview/licensing/local"
    weight = 30
+++

This document provides guidance for backing up and restoring license data.

## Backup license data

Use SCP to backup your license data to a remote server.

```sh
scp <DB_PATH> <USERNAME>:<PASSWORD>@<REMOTE_SERVER>:<REMOTE_DIRECTORY_PATH>
scp <FILE_PATH> <USERNAME>:<PASSWORD>@<REMOTE_SERVER>:<REMOTE_DIRECTORY_PATH>
```

Replace the following:

- `<DB_PATH>`: the local file path matching the `db_path` parameter value found in `/hab/default.toml`
- `<FILE_PATH>`: the local file path matching the `file_path` parameter value found in the `/hab/default.toml`
- `<USERNAME>`: the username to log in to the remote server
- `<PASSWORD>`: the remote server password
- `<REMOTE_SERVER>`: the remote server URL or IP address
- `<REMOTE_DIRECTORY_PATH>`: the directory the files will be copied to

## Restore license data

Use SCP to restore your license data from a remote server.

```sh
scp <USERNAME>:<PASSWORD>@<REMOTE_SERVER>:<REMOTE_DIRECTORY_PATH> <DB_PATH>
scp <USERNAME>:<PASSWORD>@<REMOTE_SERVER>:<REMOTE_DIRECTORY_PATH> <FILE_PATH>
```

Replace the following:

- `<DB_PATH>`: the local file path matching the `db_path` parameter value found in `/hab/default.toml`
- `<FILE_PATH>`: the local file path matching the `file_path` parameter value found in the `/hab/default.toml`
- `<USERNAME>`: the username to log in to the remote server
- `<PASSWORD>`: the remote server password
- `<REMOTE_SERVER>`: the remote server URL or IP address
- `<REMOTE_DIRECTORY_PATH>`: the directory the files are backed up to
