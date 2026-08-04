+++
title = "knife troubleshooting"

[menu.workstation_26_1]
title = "Troubleshooting"
identifier = "workstation_26_1/tools/knife/troubleshooting"
parent = "workstation_26_1/tools/knife"
weight = 200
+++

This page provides solutions to common issues you may encounter when using knife.

## Permission errors during installation

If you encounter permission errors during installation, change the ownership of Habitat directories to your user account:

```sh
sudo chown -R $(whoami) /hab
```

## Missing plugins after standalone installation

If you installed knife as a standalone application, it doesn't include knife cloud provider plugins (knife-ec2, knife-google, or knife-windows).

To get the knife plugins, install Chef Workstation, which includes knife and the knife plugins.

## SSL certificate errors

If you encounter SSL certificate errors, you can resolve them in the following ways:

### Skip SSL verification in development

In a development environment, you can skip SSL verification.

To skip SSL verification globally, add the following to your `~/.chef/config.rb` file:

```sh
echo "ssl_verify_mode :verify_none" >> ~/.chef/config.rb
```

To skip SSL verification for a single bootstrap operation, use the `--node-ssl-verify-mode none` option:

```sh
knife bootstrap <IP_ADDRESS> --node-ssl-verify-mode none
```

Replace `<IP_ADDRESS>` with the IP address of the target node.

### Fetch and verify Chef Infra Server certificates

To fetch and verify the Chef Infra Server certificates:

```sh
knife ssl fetch && knife ssl check
```

## Bootstrap operation times out

If a bootstrap operation times out, increase the timeout value using the `--session-timeout` option:

```sh
knife bootstrap <IP_ADDRESS> --session-timeout 300
```

Replace the following:

- `<IP_ADDRESS>`: IP address of the target node
- `300`: Timeout value in seconds (adjust as needed)

## SSH key permission errors

If you encounter SSH key permission errors, fix the key permissions:

```sh
chmod 600 ~/.ssh/<KEY_FILE>
```

Replace `<KEY_FILE>` with the name of your SSH key file, for example, `certificate.pem`.

## WinRM connection failures

If WinRM connections fail, test WinRM connectivity from your workstation:

```powershell
winrs -r:http://<SERVER>:5985 -u:<USERNAME> -p:<PASSWORD> cmd
```

Replace the following:

- `<SERVER>`: Hostname or IP address of the Windows server
- `<USERNAME>`: Administrator username
- `<PASSWORD>`: Administrator password

If the connection test fails, verify that:

- WinRM is enabled on the target Windows server
- Windows Firewall allows WinRM traffic on port 5985 (HTTP) or 5986 (HTTPS)
- The credentials are correct and have administrative privileges

For more information on configuring WinRM, see [Bootstrap prerequisites](knife_bootstrap#prerequisites).
