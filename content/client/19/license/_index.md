+++
title = "Apply a license in Chef Infra Client"
linkTitle = "Apply a license"

[menu.licensing]
title = "Apply a license"
identifier = "licensing/apply"
parent = "licensing"
weight = 11
+++

This document outlines the licensing requirements and enforcement policies for Chef Infra Client 19.

Depending on the distribution you download and install, you may have to add a license key to run Chef Infra Client.
You must also [accept the Chef End User License Agreement (Chef EULA)](#accept-the-end-user-license-agreement) when you first run Chef Infra Client 19.

## Licensing requirements

Chef Infra Client 19 has different licensing requirements depending on the distribution you download.

### No license enforcement

Chef Infra Client doesn't require a license to run if you download an official distribution.

This includes:

- Downloading Infra Client from the customer portal.
- Installing the Infra Client Habitat package.
- Installing Infra Client using the migration tool or native installer.

### License required

You need a license key to run Chef Infra Client when you:

- Download it from unofficial sources (public Ruby gem).
- Use runtime installations and workflows.

## Add a license

Chef Infra Client has three ways to set a license:

- with an environment variable
- with a command line option
- with the command line interactive dialog

After setting a license key, Chef Infra Client validates it with Progress Chef's licensing service.

### Environment variable

- You can set the license key adding the `CHEF_LICENSE_KEY` environment variable:

  ```sh
  export CHEF_LICENSE_KEY=<LICENSE_KEY>
  ```

### Command line option

- You can set the license key using the `--chef-license-key` CLI option:

  ```sh
  chef-client --chef-license-key=<LICENSE_KEY>
  ```

### Interactive license dialog

If you run a `chef-client` command and a license key isn't already set, Chef Infra Client starts an interactive licensing dialog.

To set a license key with the CLI interactive dialog, follow these steps:

1. Verify the version of Chef Infra Client you have installed:

    ```sh
    chef-client --version
    ```

    It should return version 19.0.54 or greater for Infra Client RC 1.

1. Run `chef-client` in local mode and why-run mode:

    ```sh
    chef-client --local-mode --why-run
    ```

    Local mode runs Chef Infra Client on your local machine as if it were running against Chef Infra Server. why-run mode shows you what Chef Infra Client would configure if a Chef Infra Client run occurs.

1. At the first prompt, select **I already have a license ID**.

    ```text
    Please choose one of the options below (Press ↑/↓ arrow to move and Enter to select)
    ‣ I already have a license ID
      I don't have a license ID and would like to generate a new license ID
      Skip
    ```

1. Enter your license key at the second prompt.

    ```text
    Please enter your license ID:  <LICENSE_KEY>
    ✔ [Success] License validated successfully.
    ```

    After entering the license key, Chef Infra Client verifies your license and the run completes.

## Accept the End User License Agreement

When you first run Chef Infra Client 19, you must accept the End User License Agreement (EULA).

Chef Infra Client accepts a license using a command line option, environment variable, or config file.

### Options

Chef Infra Client accepts the following license acceptance options:

`accept`
: Accept the license and attempts to persist a marker file locally. Persisting these marker files means future invocations don't require accepting the license again.

`accept-silent`
: Similar to `accept`, but no messaging is sent to STDOUT.

`accept-no-persist`
: Similar to `accept-silent`, but no marker file is persisted. Future invocation will require accepting the license again.

### Command line option

Accept the Chef License with a command line invocation.

```sh
chef-client --chef-license <LICENSE_OPTION>
```

### Environment variable

Accept the Chef License by setting an environment variable. For example:

```sh
export CHEF_LICENSE="<LICENSE_OPTION>"
chef-client OPTION VALUE
```

### Config file

You can accept the Chef License with the Chef Infra Client or Knife config files.

On a workstation, you can set this in the [`~/.chef/config.rb` or `~/.chef/knife.rb` files](https://docs.chef.io/workstation/config_rb/), and on a node you can set this in the [`/etc/chef/client.rb`]({{< relref "/install/config_rb_client" >}}) file.

```ruby
chef_license "<LICENSE_OPTION>"
```
