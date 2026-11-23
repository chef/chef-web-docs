+++
title = "kitchen.yml"
draft = false

[menu]
  [menu.workstation_26_2]
    title = "kitchen.yml"
    identifier = "workstation_26_2/tools/test_kitchen/config_yml_kitchen.md kitchen.yml"
    parent = "workstation_26_2/tools/test_kitchen"
    weight = 30
+++
<!-- markdownlint-disable-file MD033 -->

Use [Test Kitchen](https://kitchen.ci/) to automatically test cookbook
data across any combination of platforms and test suites:

- Defined in a `kitchen.yml` file
- Uses a driver plugin architecture
- Supports cookbook testing across many cloud providers and virtualization technologies
- Supports all common testing frameworks that are used by the Ruby community
- Uses a comprehensive set of base images provided by [Bento](https://github.com/chef/bento)

{{< readfile file="content/workstation/26.2/reusable/md/test_kitchen_yml.md" >}}

{{< note >}}

This topic details functionality that's packaged with Chef Workstation.
See <https://kitchen.ci/docs/getting-started/introduction/> for more information
about Test Kitchen.

{{< /note >}}

## Syntax

{{< readfile file="content/workstation/26.2/reusable/md/test_kitchen_yml_syntax.md" >}}

## Provisioner settings

<!-- markdownlint-disable MD006 MD007 -->

Test Kitchen can configure the chef-zero provisioner with the following
Chef-specific settings:

`attributes`
: Chef attributes for use in the suite

`chef_client_path`
: Chef Infra Client provisioner only.

`chef_metadata_url`
: **This will be deprecated in a future version.**

`chef_omnibus_install_options`
: Use to specify the package to be installed. Possible values: `-P chef` (for Chef Infra Client) and `-P chef-workstation` (for Chef Infra Client that's packaged as part of Chef Workstation). Use `-n` to specify the nightly build. For example: `-P chef-workstation` or `-n -P chef-workstation`. **This will be deprecated in a future version.** See the `product_name`, `product_version`, and `channel` settings instead.

`chef_omnibus_root`
: Default value: `/etc/opt` for UNIX and Linux, `$env:systemdrive\\opscode\\chef` on Windows.

`chef_omnibus_url`
: The URL of an `install.sh` script that will install Chef Infra Client on the machine under test.

  - Commercial downloads install script: `https://chefdownload-commercial.chef.io/install.sh?license_id=<LICENSE_ID>`
  - Community downloads install script: `https://chefdownload-community.chef.io/install.sh`

  For the commercial endpoint, replace `<LICENSE_ID>` with your Progress Chef License ID. You can find your license ID on [Chef Downloads](https://www.chef.io/downloads). For more information, see this [support article](https://community.progress.com/s/article/How-Do-I-Find-My-License-Key-Needed-For-Chef-Product-Downloads).

`chef_solo_path`
: chef-solo provisioner only.

`chef_zero_host`
: Chef Infra Client provisioner only.

`chef_zero_port`
: Chef Infra Client provisioner only. The port on which chef-zero is to listen.

`client_rb`
: Chef Infra Client provisioner only. A list of `client.rb` file settings. For example:

  ```yaml
  client_rb:
    log_level: :warn
  ```

`clients_path`
: The relative path to the directory in which client data is located. This data must be defined as JSON.

`cookbook_files_glob`
: A file glob (pattern) that matches files considered to be part of the cookbook. (Typically, this value doesn't need to be modified from the default.)

`data_path`
: Use to specify the path from which non-cookbook files are copied to a Kitchen instance.

`data_bags_path`
: The relative path to a directory in which data bags and data bag items are defined. This data must be structured as if it were in the chef-repo.

`deprecations_as_errors`
: Set to `true` to treat deprecation warning messages as error messages.

`driver`
: Use to specify a driver for a platform. This will override the default driver.

`enforce_idempotency`
: Use with `multiple_converge` > 1. Set to `true` to force test-kitchen to fail if last converge has any updated resources.

`encrypted_data_bag_secret_key_path`
: The path to an RSA key file that's used to decrypt encrypted data bag items.

`environments_path`
: The relative path to the directory in which environment data is located. This data must be defined as JSON.

`http_proxy`
: The proxy server for HTTP connections.

`https_proxy`
: The proxy server for HTTPS connections.

`no_proxy`
: The comma-separated exception list of host patterns to exclude from using in proxy connections.

`install_msi_url`
: An alternate URL of a Windows MSI package that will install Chef Infra Client on the machine under test. **This will be deprecated in a future version.** Use the `download_url` setting instead.

`json_attributes`
: Chef Infra Client provisioner only.

`log_file`
:

`multiple_converge`
: Number of times to converge the node. Defaults to 1.

`nodes_path`
: The relative path to the directory in which node data is located. This data must be defined as JSON.

`require_chef_omnibus`
: Use to install the latest version of Chef Infra Client on a node. Set to `true` to install the latest version, `false` to not install Chef Infra Client (assumes the box already has it installed), or a version specifier like `15.3.12` to install a particular version, or simply `15` to install the latest 15.x package. When set to `true` or a version number, the `chef_omnibus_url` may be used to specify the URL of the `install.sh` that installs the specified version of Chef Infra Client. Default value: `true`. **This will be deprecated in a future version.** See the `product_version` and `install_strategy` settings.

`roles_path`
: The relative path to the directory in which role data is located. This data must be defined as JSON.

`root_path`
: The directory in which Kitchen will stage all content on the target node. This directory should be large enough to store all the content and must be writable. (Typically, this value doesn't need to be modified from the default value.) Default value: `/tmp/kitchen`.

`ruby_bindir`
: Chef Infra Client provisioner only.

`run_list`
:

`solo_rb`
: chef-solo provisioner only.

`retry_on_exit_code`
: Takes an array of exit codes to indicate that kitchen should retry the converge command. Default value: `[35, 213]`.

`max_retries`
: Number of times to retry the converge before passing along the failed status. Default value: 1.

`wait_for_retry`
: Number of seconds to wait between converge attempts. Default value: 30.

These settings may be added to the `provisioner` section of the
`kitchen.yml` file when the provisioner is chef-zero or chef-solo.

<!-- markdownlint-enable MD006 MD007 -->

### New provisioner settings

`product_name`
: `chef` or `chef-workstation`. This setting must be specified to use the new settings. Using this setting overrides Test Kitchen's default behavior based on the `require_chef_omnibus` setting.

  Replaces: `chef_omnibus_install_options`

`product_version`
: Product version number. Supports partial version numbers.

  Default value: `latest`

  Replaces: `require_chef_omnibus`

`channel`
: Artifact repository name. `stable`, `current` or `unstable`.

  Default value: `stable`

  Replaces: `chef_omnibus_install_options`

`install_strategy`
: Product install strategy. `once` (Don't install if any product installation detected), `always` or `skip`.

  Default value: `once`

  Replaces: `require_chef_omnibus`

`download_url`
: Direct package URL. Supports all platforms.

  Replaces: `install_msi_url`

`checksum`
: Optional setting when using `download_url`. Validates SHA256 checksum after download.

`platform`
: Override platform.

  Default value: auto detected

`platform_version`
: Override platform version.

  Default value: auto detected

`architecture`
: Override platform architecture.

  Default value: auto detected

`always_update_cookbooks`
: Updates the `policyfile.lock.json` when changes are made to the cookbook. Supports `true` or `false`.

  Default value: auto detected

## Transport Settings

Kitchen can configure a transport with the following settings for either
`ssh` or `winrm` transports:

`connection_retries`
: Maximum number of times to retry after a failed connection attempt. Default value: 5.

`connection_retry_sleep`
: Number of seconds to wait before attempting to reconnect after a failed connection.

`max_wait_until_ready`
: Maximum number of attempts to determine if the test instance is ready to accept commands. Default value: 600.

`password`
: The password used for authenticating to the test instance.

`port`
: Port used to connect to the test instance. Default value: `22` for `ssh` transport, `5985` for `winrm` with `http`, and `5986` for `winrm` with `https`.

`username`
: Username used to authenticate to the test instance. Default value: `administrator` for `winrm` transport and `root` for `ssh` transport. Some drivers may override this default.

These settings may be added to the `transport` section of the
`kitchen.yml` file when the transport is SSH:

`compression`
: Whether to use compression. Default value: `false`.

`compression_level`
: Default value: 6 when `compression` is `true`.

`connection_timeout`
: Default value: 15.

`keepalive`
: Default value: `true`.

`keepalive_interval`
: Default value: 60.

`max_ssh_sessions`
: Maximum number of parallel ssh sessions.

`ssh_key`
: Path to an ssh key identity file.

These settings may be added to the `transport` section of the
`kitchen.yml` file when the transport is WinRM:

`elevated`
: When `true`, all commands execute with a scheduled task. This may eliminate access denied errors related to double hop authentication, Windows updates, and MSI installations. Default value: `false`.

`elevated_password`
: Password for the identity running the scheduled task. Can be `null` for service accounts. Default value: `password`.

`elevated_username`
: Identity that the task runs under. Can be set to service accounts such as `System`. Default value: `username`.

`rdp_port`
: Port for `rdp` connections with `kitchen login` commands. Default value: 3389.

`winrm_transport`
: Transport type for [WinRM](https://github.com/WinRb/WinRM). Default value: `negotiate`. Acceptable values: `ssl` and `plaintext`.

### Work with proxies

{{< readfile file="content/workstation/26.2/reusable/md/test_kitchen_yml_syntax_proxy.md" >}}

## Chef Infra Client settings

A `kitchen.yml` file may define Chef Infra Client-specific settings, such
as whether to require the Chef installer or the URL from which Chef
Infra Client is downloaded, or to override settings in the client.rb
file:

```yaml
provisioner:
  name: chef_zero *or* chef_solo
  require_chef_omnibus: true
  chef_omnibus_url: https://www.chef.io/chef/install.sh

...

suites:
  - name: config
    run_list:
    ...
    attributes:
      chef_client:
        load_gems:
          chef-handler-updated-resources:
            require_name: "chef/handler/updated_resources"
        config:
          log_level: ":debug"
          ssl_verify_mode: ":verify_peer"
          start_handlers: [{class: "SimpleReport::UpdatedResources", arguments: []}]
          report_handlers: [{class: "SimpleReport::UpdatedResources", arguments: []}]
          exception_handlers: [{class: "SimpleReport::UpdatedResources", arguments: []}]
      ohai:
        disabled_plugins: ["passwd"]
```

where:

- `require_chef_omnibus` ensures that the Chef installer installs Chef Infra Client on all platform instances. You can also set it to `latest` to use the newest version of Chef Infra Client for that platform when testing cookbooks.
- `chef_omnibus_url` specifies the URL from which Chef Infra Client is downloaded.
- The `attributes` for the `config` test suite contain specific `client.rb` settings for this test suite.

## Driver Settings

Driver-specific configuration settings may be required. Use a block
similar to:

```yaml
driver:
  name: driver_name
  optional_settings: values
```

Specific `optional_settings: values` may be specified.

### Bento

{{< readfile file="content/workstation/26.2/reusable/md/bento.md" >}}

### Drivers

{{< readfile file="content/workstation/26.2/reusable/md/test_kitchen_drivers.md" >}}

### kitchen-vagrant

{{< readfile file="content/workstation/26.2/reusable/md/test_kitchen_driver_vagrant.md" >}}

{{< readfile file="content/workstation/26.2/reusable/md/test_kitchen_driver_vagrant_settings.md" >}}

{{< readfile file="content/workstation/26.2/reusable/md/test_kitchen_driver_vagrant_config.md" >}}

## Examples

The following examples show actual `kitchen.yml` files used in
Chef-maintained cookbooks.

### Chef, Chef Workstation

The following example shows the provisioner settings needed to install
Chef Workstation, and then use the version of Chef that's embedded in
Chef Workstation to converge the node.

To install the latest version of Chef Workstation:

```yaml
provisioner:
  ...
  chef_omnibus_install_options: -P chef-workstation
  chef_omnibus_root: /opt/chef-workstation
```

and to install a specific version of Chef Workstation:

```yaml
provisioner:
  ...
  chef_omnibus_install_options: -P chef-workstation
  chef_omnibus_root: /opt/chef-workstation
  require_chef_omnibus: 0.9
```

### Windows platform

The following example shows platform settings for the Windows
platform:

```yaml
platforms:
  - name: eval-win2012r2-standard
    os_type: windows
    transport:
      name: winrm
      elevated: true
```

If `name` begins with `win`, the `os_type` defaults to `windows`.
The `winrm` transport is the default on Windows operating systems.
When `elevated` is `true`, Windows commands run with a scheduled task to emulate a local user.

### Chef Infra Client cookbook

The following `kitchen.yml` file is part of the `chef-client` cookbook and
ensures Chef Infra Client is configured correctly.

```yaml
driver:
  name: vagrant

provisioner:
  name: chef_zero

platforms:
  - name: centos-8
  - name: fedora-latest
  - name: ubuntu-1804
  - name: ubuntu-2004

suites:

- name: service_init
  run_list:
  - recipe[minitest-handler]
  - recipe[chef-client::config]
  - recipe[chef-client_test::service_init]
  - recipe[chef-client::init_service]
  attributes: {}

- name: service_runit
  run_list:
  - recipe[minitest-handler]
  - recipe[runit]
  - recipe[chef-client_test::service_runit]
  - recipe[chef-client::runit_service]
  attributes: {}

- name: service_upstart
  run_list:
  - recipe[minitest-handler]
  - recipe[chef-client_test::service_upstart]
  - recipe[chef-client::upstart_service]
  excludes: ["centos-5.9"]
  attributes: {}

- name: cron
  run_list:
  - recipe[minitest-handler]
  - recipe[chef-client::cron]
  attributes: {}

- name: delete_validation
  run_list:
  - recipe[chef-client::delete_validation]
  attributes: {}
```

### chef-splunk Cookbook

The following `kitchen.yml` file is part of the `chef-splunk` cookbook and
helps ensure that Splunk client and server installations are correct.

```yaml
driver:
  name: vagrant
  customize:
    memory: 1024

provisioner:
  name: chef_zero

platforms:
  - name: ubuntu-18.04
  - name: ubuntu-20.04
  - name: centos-7
  - name: centos-8

suites:
  - name: client
    run_list:
      - recipe[chef-splunk::default]
      - recipe[test::default]
    attributes:
      dev_mode: true
      splunk:
        accept_license: true

  - name: server
    run_list:
      - recipe[chef-splunk::default]
    attributes:
      dev_mode: true
      splunk:
        is_server: true
        accept_license: true
        ssl_options:
          enable_ssl: true
```

### yum Cookbook

The following `kitchen.yml` file is part of the `yum` cookbook:

```yaml
driver:
  name: vagrant

provisioner:
  name: chef_zero

platforms:
  - name: centos-7
  - name: centos-8
  - name: fedora-latest

suites:
  - name: default
    run_list:
      - recipe[yum::default]
      - recipe[yum_test::test_repo]
```

### Platform Attributes

The following `kitchen.yml` file sets up a simple tiered configuration of
Chef Infra Server, including two front-end servers, a single
back-end server, and two add-ons (Chef Push Jobs and Chef management
console). The `platforms` block uses an `attributes` section to define
Chef Infra Server attributes that are used by all three test suites:

```yaml
driver:
  name: vagrant

provisioner:
  name: chef_zero

platforms:
  - name: ubuntu-18.04
    attributes:
      chef-server:
        api_fqdn: backend.chef-server.com
        backend:
          fqdn: backend.chef-server.com
          ipaddress: 123.456.789.0
        frontends:
          frontend1.chef-server.com: 123.456.789.0
          frontend2.chef-server.com: 123.456.789.0
        urls:
          private_chef: http://123.456.789.0/path/to/private-chef_11.1.4-1_amd64.deb
          manage: http://123.456.789.0/path/to/opscode-manage_1.3.1-1_amd64.deb
          push_jobs: http://123.456.789.0/path/to/opscode-push-jobs-server_1.1.1-1_amd64.deb

suites:
  - name: frontend1
    driver:
      vm_hostname: frontend1.chef-server.com
      network:
      - ["private_network", {ip: "123.456.789.0"}]
      customize:
        memory: 2048
        cpus: 2
    run_list:
      - recipe[chef-server::configfile]
      - recipe[chef-server::ntp]
      - recipe[chef-server::server]
      - recipe[chef-server::frontend]
  - name: frontend2
    driver:
      vm_hostname: frontend2.chef-server.com
      network:
      - ["private_network", {ip: "123.456.789.0"}]
      customize:
        memory: 2048
        cpus: 2
    run_list:
      - recipe[chef-server::configfile]
      - recipe[chef-server::ntp]
      - recipe[chef-server::server]
      - recipe[chef-server::frontend]
  - name: backend
    driver:
      vm_hostname: backend.chef-server.com
      network:
      - ["private_network", {ip: "123.456.789.0"}]
      customize:
        memory: 8192
        cpus: 4
    run_list:
      - recipe[chef-server::configfile]
      - recipe[chef-server::ntp]
      - recipe[chef-server::server]
      - recipe[chef-server::backend]
```

### Kitchen Converge On System Reboot

Test-Kitchen can handle reboots (when initiated from Chef Infra Client)
by setting `retry_on_exit_code`, `max_retries` and `wait_for_retry`
attributes on the provisioner in `kitchen.yml` file as follows :

```yaml
provisioner:
   name: chef_zero
   retry_on_exit_code:
     - 35 # 35 is the exit code signaling that the node is rebooting
     - 1
   max_retries: 1
   client_rb:
     exit_status: :enabled # Opt-in to the standardized exit codes
     client_fork: false  # Forked instances don't return the real exit code
```

**One note on Linux nodes**: The shutdown command blocks (as opposed to the Windows variant which registers the reboot and returns right away), so once the timeout period passes, Chef Infra Client and the node are in a race to see who can exit/shutdown first---so, you may or may not get the exit code out of Linux instances. In that case, you can add `1` to the `retry_on_exit_code` array and that should catch both cases.

Please refer [YAML
documentation](https://symfony.com/doc/current/components/yaml/yaml_format.html#collections)
to set `retry_on_exit_code` attribute.
