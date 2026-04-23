+++
title = "Chef Infra Agentless Mode example"

[menu.client_18]
title = "Agentless Mode example"
identifier = "features/agentless/example"
parent = "features/agentless"
weight = 20
+++

This document provides a simplified, end-to-end guide to configure and run
Chef Infra Client 19 RC3 in Agentless (Target Mode) using Habitat (`hab`)
for managing remote systems.

## Prerequisites

- [Chef Infra Client is installed](/install/)
- Your `HAB_AUTH_TOKEN` is exported
- a valid Progress Chef license key

## Create a target credentials file

Create a target credentials file (`~/.chef/target_credentials`) that defines connection settings for each node.

For example:

```toml
['TARGET_NODE_1']
host = '<IP_ADDRESS_OR_FQDN>'
user = '<USERNAME>'
sudo = true
key_files = '~/.ssh/key-pair.pem'

['TARGET_NODE_2']
host = '<IP_ADDRESS_OR_FQDN>'
user = 'root'
password = '<PASSWORD>'
```

For more information, see the [target credentials file documentation](/client/18/features/agentless/).

## Create the test recipe

<!-- markdownlint-disable MD051 -->

On the host, create a test recipe file (`~/.chef/apply.rb`) with the test resources below.

{{< foundation_tabs tabs-id="test-agentless-mode-recipe" >}}
  {{< foundation_tab active="true" panel-link="apply-recipe" tab-text="Test recipe">}}
  {{< foundation_tab panel-link="apply-safe-recipe" tab-text="Safe test recipe" >}}
{{< /foundation_tabs >}}

{{< foundation_tabs_panels tabs-id="test-agentless-mode-recipe" >}}
{{< foundation_tabs_panel active="true" panel-id="apply-recipe" >}}

This recipe:

- creates the `/tmp/chef-repo` directory
- executes `echo` to confirm connectivity
- sets `/etc/crontab` ownership and permissions. This requires root privileges.

**WARNING:** Changing `/etc/crontab` permissions can affect cron system behavior.
For a safer alternative, run the [safe test recipe](#apply-safe-recipe).

```ruby
# ~/.chef/apply.rb
# Simple test recipe for Chef Target Mode (Agentless).

directory '/tmp/chef-repo' do
  action :create
end

execute 'test_echo' do
  # Use single quotes inside echo to avoid shell quoting issues
  command "echo 'Target Mode Connected Successfully..!!'"
end

file '/etc/crontab' do
  mode '0600'
  owner 'root'
  group 'root'
  # Note: This resource only enforces ownership/permissions, not content.
end
```

{{< /foundation_tabs_panel >}}

{{< foundation_tabs_panel panel-id="apply-safe-recipe" >}}

This alternate `apply.rb` that avoids touching system files.

This recipe:

- creates the `/tmp/chef-repo` directory
- executes `echo` and saves the output to a text file
- sets ownership and permissions in a temp file.

```ruby
# ~/.chef/apply.rb

directory '/tmp/chef-repo' do
  action :create
end

execute 'test_echo' do
  command "echo 'Target Mode Connected Successfully..!!' > /tmp/target_mode_test.txt"
  creates '/tmp/target_mode_test.txt'
end

file '/tmp/target_mode_marker' do
  content "Target Mode ran at #{Time.now}\n"
  mode '0644'
  owner 'root'
  group 'root'
end
```

{{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}

<!-- markdownlint-enable MD051 -->

## Run the recipe in Agentless Mode

From your `.chef` directory, execute the recipe withe Chef Infra Client:

```sh
cd ~/.chef
chef-client -z -t <TARGET_NODE> apply.rb
```

Replace `<TARGET_NODE>` with the target name defined in the `target_credentials` file. For example, `TARGET_NODE_1`.

Chef Infra Client executes the `apply.rb` recipe in local mode (`chef-client -z`) against the remote target (`-t <TARGET_NODE>`) over SSH using the credentials defined in `~/.chef/target_credentials`.

## Verify the output

A successful Infra Client run returns something like this:

```sh
Starting Chef Infra Client, version 19.x.x
[Target Mode] Connecting to target: Ubuntu (192.168.0.251)
Converging 3 resources
Recipe: /root/.chef/apply.rb
  * directory[/tmp/chef-repo] action create (up to date)
  * execute[test_echo] action run
    - execute echo 'Target Mode Connected Successfully..!!'
  * file[/etc/crontab] action create (up to date)
Running handlers:
Running handlers complete
Infra Phase complete, 0/3 resources updated in 12 seconds
```

You can SSH into the remote target from the host and get details about the directory and file permissions. For example:

```sh
# on host, to confirm through ssh example:
ssh -i ~/.ssh/key-pair.pem ubuntu@192.168.0.251 'ls -ld /tmp/chef-repo && echo "crontab perms:" && stat -c "%a %U %G" /etc/crontab'
```

## Troubleshooting

- `SSH authentication failed`

  Verify `host`, `user`, and `key_files` properties in the target credentials file, and verify key permissions and network availability.

- `Target not found`

  The name in `-t <TARGET>` must exactly match a target defined in the `target_credentials` file.

- `Permission denied (sudo)`

  For a non-root user, set `sudo = true` in the target credentials file, or use `user = 'root'`.

- `Recipe file not found`

  Use absolute path to `apply.rb` or run command from the directory containing `apply.rb`.
