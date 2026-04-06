+++
title = "Troubleshoot licensing issues"

[menu.licensing]
title = "Troubleshooting"
identifier = "licensing/troubleshoot"
parent = "licensing"
weight = 20
+++

Refer to the following sections for details on troubleshooting licensing issues.

## License isn't entitled to use Infra

Each license key is associated with one or more Chef products.
This error occurs when a license key that's set with Chef Infra Client isn't entitled to use Infra Client.

To troubleshoot:`

- Run the `chef-client --license-list` command to view the products your key is entitled to.
- If Chef Infra isn't listed, set a license key that's entitled to Chef Infra.

See the [Chef licensing documentation](/license) for more information on setting appropriate entitlements.

## Unable to connect to the licensing server

Chef Infra requires communication with the Chef licensing service or a user-deployed [Chef Local License Service](https://docs.chef.io/licensing/local_license_service/) to validate the license key.

If it can't connect, check the following possible causes:

- **Network connectivity**: Verify that the machine running Chef Infra has proper network connectivity and can reach the Chef licensing service or the Chef Local License Service. Ensure that firewalls and network settings aren't blocking access.
- **Service availability**: If you're using a user-deployed Chef Local License Service, confirm that it's properly configured and operational. Any misconfigurations in the local license service can lead to connection issues.
- **URL configuration**: If using a Chef Local License Service, confirm that the server URL is correctly configured:
  - If it's configured with the `CHEF_LICENSE_SERVER` environment variable, verify the URL.
  - If it's configured using the `--chef-license-server` CLI option, reset the URL with the same option.
- **Logs and debugging**: Use the `--log-level` debug option in Chef Infra to check the detailed logs. Check the URL that Chef Infra is attempting to connect to for troubleshooting clues.

## Invalid file format version

Chef licensing data is stored in the `$HOME/.chef/licenses.yaml` file. This error may indicate an unsupported or invalid file format version in the `licenses.yaml` file.

To resolve this issue:

- Restore the `licenses.yaml` file to its original state or ensure it has the latest supported file format version.

  The original state of the `licenses.yaml` file is:

  ```yaml
  ---
  :file_format_version: 4.0.0
  :licenses: []
  :license_server_url: https://services.chef.io/licensing
  ```

## License file contents are corrupted

Corruption of the `$HOME/.chef/licenses.yaml` file (where Chef licensing data is stored) can result in errors.

To troubleshoot:

- Restore the contents of the `licenses.yaml` file to the original state to correct any corruption:

  ```yaml
  ---
  :file_format_version: 4.0.0
  :licenses: []
  :license_server_url: https://services.chef.io/licensing
  ```
