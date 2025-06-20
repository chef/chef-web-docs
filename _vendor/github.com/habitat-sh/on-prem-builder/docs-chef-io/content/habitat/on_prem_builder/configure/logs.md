+++
title = "Configure Habitat Builder logs"

[menu]
  [menu.habitat]
    title = "Configure Builder logs"
    identifier = "habitat/on-prem-builder/configure/logs"
    parent = "habitat/on-prem-builder/configure"
    weight = 40
+++

This page explains how to configure Chef Habitat Builder logs.

## Supported log levels

You can set the log level to `error`, `warn`, `info`, `debug`, or `trace`.
For more details about logging in Chef Habitat, see the [Supervisor log configuration reference](/habitat/sup_log_configuration/) and the [Supervisor log key documentation](/habitat/sup_log_keys/).

## Configure the Habitat Builder log level

To enable and review debug logging for services in your Habitat installation, follow these steps:

1. Open the `/hab/user/builder-api/config/user.toml` file.
1. Set the value of `log_level` on the first line:

    ```toml
    log_level="<LOG_LEVEL>,tokio_core=error,tokio_reactor=error,zmq=error,hyper=error"
    ```

    Replace `<LOG_LEVEL>` with the desired log level, such as `debug` or `error`.

1. Save and close the file.
1. Restart Habitat:

    ```sh
    sudo systemctl restart hab-sup
    ```

1. To view the logs, run:

    ```sh
    journalctl -fu hab-sup
    ```

## Configure Rust logging

You can use the `RUST_LOG` environment variable to enable detailed logging and backtraces in Habitat Builder.

To see debug output and backtraces for a specific Habitat command, run:

```bash
# Linux/macOS
env RUST_LOG=debug RUST_BACKTRACE=1 <HAB_COMMAND>
```

Replace `<HAB_COMMAND>` with a Habitat CLI command, such as `hab sup run`.

To set Rust logging for Habitat Builder, follow these steps:

1. Open the `/hab/svc/builder-api/user.toml` file.
1. Set the second line to:

    ```toml
    RUST_LOG=debug RUST_BACKTRACE=1
    ```

### Log rotation

The `builder-api-proxy` service logs all access and errors (through Nginx) to log files in your service directory.
Because these files can grow large, you may want to set up log rotation.
The following sample logrotate configuration shows how you can manage these log files:

```bash
/hab/svc/builder-api-proxy/logs/host.access.log
/hab/svc/builder-api-proxy/logs/host.error.log
{
        rotate 7
        daily
        missingok
        notifempty
        delaycompress
        compress
        postrotate
                /bin/kill -USR1 `cat /hab/svc/builder-api-proxy/var/pid 2>/dev/null` 2>/dev/null || true
        endscript
}
```
