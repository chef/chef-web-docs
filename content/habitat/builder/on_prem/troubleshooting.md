+++
title = "Troubleshooting Chef Habitat On-Prem Builder"

[menu]
  [menu.habitat]
    title = "Troubleshooting"
    identifier = "habitat/builder/on-prem/troubleshooting"
    parent = "habitat/builder/on-prem"
    weight = 500
+++

This section covers several common problems that you might encounter and how to solve them.

## Finding origin keys

On Linux or macOS:

```sh
ls -la /hab/cache/keys
ls -la $HOME/.hab/cache.keys
```

On Windows:

```powershell
ls C:\hab\cache\keys
```

## Network access and proxy settings

If the initial install fails, check that you have outgoing connectivity, and that you can successfully ping the following:

- `raw.githubusercontent.com`
- `bldr.habitat.sh`

If you have outgoing access with a proxy, ensure that HTTPS_PROXY is set correctly in your environment.

Your Habitat On-Prem Builder deployment also needs the following inbound port open:

- port 80

If you configured your proxy for the local session while installing Habitat Builder but are still receiving connection refusal errors like the one below, you may want to configure your proxy with the `/etc/environment` file or similar.

```shell
-- Logs begin at Mon 2019-06-10 09:02:13 PDT. --
Jun 10 09:35:15 <TargetMachine> hab[13161]: ∵ Missing package for core/hab-launcher
Jun 10 09:35:15 <TargetMachine> hab[13161]: » Installing core/hab-launcher
Jun 10 09:35:15 <TargetMachine> hab[13161]: ☁ Determining latest version of core/hab-launcher in the 'stable' channel
Jun 10 09:35:15 <TargetMachine> hab[13161]: ✗✗✗
Jun 10 09:35:15 <TargetMachine> hab[13161]: ✗✗✗ Connection refused (os error 111)
Jun 10 09:35:15 <TargetMachine> hab[13161]: ✗✗✗
Jun 10 09:35:15 <TargetMachine> systemd[1]: hab-sup.service: Main process exited, code=exited, status=1/FAILURE
Jun 10 09:35:15 <TargetMachine> hab[13171]: Supervisor not started.
Jun 10 09:35:15 <TargetMachine> systemd[1]: hab-sup.service: Unit entered failed state.
Jun 10 09:35:15 <TargetMachine> systemd[1]: hab-sup.service: Failed with result 'exit-code'
```

Please work with your enterprise network admin to ensure the appropriate firewall rules are configured for network access.

### Authentication failure when logging in

If you aren't able to log in, double check the settings that you configured your OAuth application with, as well as the URLs that you specified in your `bldr.env` file.

### Unable to retrieve OAuth token

If you were able to sign in to the authentication provider, but unable to authenticate with Chef Habitat's OAuth token, follow these steps:

1. Open the `bldr.env` and verify the following settings:

    - The `APP_URL` value ends with a forward slash (`/`).
    - The `OAUTH_REDIRECT_URL` value ends with a forward slash (`/`).
    - The `OAUTH_CLIENT_ID` setting is complete and correct.
    - The `OAUTH_CLIENT_SECRET` setting is complete and correct.

1. Apply changes to the `bldr.env` by running the install script:

    ```bash
    bash ./install.sh
    ```

1. Restart the Chef Habitat services:

    ```bash
    sudo systemctl restart hab-sup
    ```

### Self-signed certificate files are missing

If self-signed certificates are missing, verify the following:

- If your self-signed certificates are missing, copy them into the `/hab/cache/ssl` directory. The latest version of Chef Habitat On-Prem Builder expects certificates in that directory.

- Name your certificate files using the pattern `<APP_NAME>-cert.cert` or `<APP_NAME>-cert.pem`. For example, `automate-cert.cert` or `automate-cert.pem`.

- Don't use `cert.pem`, which is reserved for the Chef Habitat system.
   If you overwrite this file, Chef Habitat On-Prem Builder will fail.

After correcting those issues, restart the Chef Habitat services:

```bash
sudo systemctl restart hab-sup
```

### Connection refused (os error 111)

If you configured your proxy for the local session during installation but still see connection refused errors, try setting your proxy in the `/etc/environment` file or a similar system-wide location.
Work with your enterprise network admin to make sure the correct firewall rules are in place for network access.

```shell
-- Logs begin at Mon 2019-06-10 09:02:13 PDT. --
Jun 10 09:35:15 <TargetMachine> hab[13161]: ∵ Missing package for core/hab-launcher
Jun 10 09:35:15 <TargetMachine> hab[13161]: » Installing core/hab-launcher
Jun 10 09:35:15 <TargetMachine> hab[13161]: ☁ Determining latest version of corehab-launcher in the 'stable' channel
Jun 10 09:35:15 <TargetMachine> hab[13161]: ✗✗✗
Jun 10 09:35:15 <TargetMachine> hab[13161]: ✗✗✗ Connection refused (os error 111)
Jun 10 09:35:15 <TargetMachine> hab[13161]: ✗✗✗
Jun 10 09:35:15 <TargetMachine> systemd[1]: hab-sup.service: Main process exited,code=exited, status=1/FAILURE
Jun 10 09:35:15 <TargetMachine> hab[13171]: Supervisor not started.
Jun 10 09:35:15 <TargetMachine> systemd[1]: hab-sup.service: Unit entered failed state.
Jun 10 09:35:15 <TargetMachine> systemd[1]: hab-sup.service: Failed with result 'exit-code'
```

### Error "sorry, too many clients already"

If the Habitat services don't start as expected, use `journalctl -fu hab-sup` to check the service logs (see below for enabling debug logging).

If you see a PostgreSQL error saying "sorry, too many clients already," you may need to increase the number of allowed connections to the database.

To increase the connection limit, run:

```bash
echo 'max_connections=200' | hab config apply builder-datastore.default $(date +%s)
```

Wait for the datastore service to restart.
If it doesn't restart automatically, run:

```bash
sudo systemctl restart hab-sup
```

### Error "Too many open files"

If you see this error in the supervisor logs, you may need to increase the file ulimit on your system.
Chef Habitat On-Prem Builder includes an expanded file limit in its systemd configuration, but some distributions (for example, CentOS 7) may require additional configuration.

Add the following lines to the end of your `/etc/security/limits.conf` file, then restart your system:

```text
* soft nofile 65535
* hard nofile 65535
```

### Error "Text file busy"

If you see a "Text file too busy" error during install, try running the install step again.

### Error when bootstrapping core packages

You may see the following error when bootstrapping core packages.
If this happens, the bootstrap process will keep retrying, and the upload will eventually succeed.
Let the process continue until it completes.

```shell
✗✗✗
✗✗✗ Pooled stream disconnected
✗✗✗
```

If some packages don't upload, try re-uploading them manually with the `hab pkg upload` command.

This error may also indicate that your installation doesn't have enough CPU, RAM, or other resources.
Consider allocating more resources (for example, if running on a VM) or moving to a larger instance.

### Error uploading large packages

By default, Chef Habitat On-Prem Builder has a 2 GB package limit.
If you need to increase this limit, update the Chef Habitat On-Prem Builder configuration.

To change the upload limit, follow these steps:

1. Create a file named `config.toml` with the following content:

    ```toml
    [nginx]
    max_body_size = "<MAX_BODY_SIZE>"
    proxy_send_timeout = 360
    proxy_read_timeout = 360

    [http]
    keepalive_timeout = "360s"
    ```

    Replace `<MAX_BODY_SIZE>` with your desired size limit, for example, `3072m` for 3 GB.

1. Apply the new configuration:

    ```bash
    hab config apply builder-api-proxy.default $(date +%s) config.toml
    ```

After you apply the configuration, try the upload again.

If you still have issues, you may need to adjust the timeout for the Chef Habitat client.
Set the `HAB_CLIENT_SOCKET_TIMEOUT` environment variable to the desired timeout in seconds.
For example:

```bash
HAB_CLIENT_SOCKET_TIMEOUT=360 hab pkg upload -u <BLDR_URL> -z <AUTH_TOKEN> <HART_FILE>
```

### Package shows up in the Builder UI and `hab pkg search`, but `hab pkg install` fails

If you run into a situation where you have a package populated in the Chef Habitat On-Prem Builder, but it's failing to install with a `Not Found` status, it's possible that there was a prior problem with populating the MinIO backend with the package artifact.

If you have the package artifact on-disk (for example, in the `hab/cache/artifacts` directory), you can try to upload the missing package again with the following command (update the parameters as appropriate):

```bash
hab pkg upload -u <BLDR_URL> -z <AUTH_TOKEN> --force <PACKAGE_HART_FILE>
```

### on-prem-archive.sh fails during `populate-depot` with `403` error when uploading core packages

When you populate your Chef Habitat On-Prem Builder with upstream core packages, you might see a repeated error for every package:

```sh
Uploading hart files.

[1/958] Uploading ./core-img-0.5.4-20190201011741-x86_64-linux.hart to the depot at https://bldr.example.com
    75 B / 75 B | [=========================================] 100.00 % 384 B/s
✗✗✗
✗✗✗ [403 Forbidden]
✗✗✗
```

Make sure you've created the `core` origin in your Habitat Builder deployment.
The upload fails if the `core` origin doesn't exist.
After you create the `core` origin, try the upload again.

## Support

You can post questions or issues on the [Habitat Forum](https://discourse.chef.io/), on our [Slack channel](https://community.chef.io/slack), or file issues directly at the [Github repo](https://github.com/habitat-sh/on-prem-builder/issues).
