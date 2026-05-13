You can use multiple configuration files by putting them in `.d` configuration directories,
for example `/etc/chef/client.d`.

To use a `.d` directory, create a directory with the same name as the configuration file but replace the `.rb` suffix with `.d`.

The default locations for `.d` directories in Chef Infra are:

- For Chef Infra Client, use `/etc/chef/client.d`.
- For Chef development tooling such as knife, use `~/.chef/config.d`.
- For Chef Solo, use `/etc/chef/solo.d`.

The standard `.rb` configuration file and all configuration `.rb` files in the `.d` directory are merged as one file.
For example, knife would load and merge the following files:

- `~/.chef/config.rb`
- `~/.chef/config.d/company_settings.rb`
- `~/.chef/config.d/ec2_configuration.rb`

Non-`.rb` files in a `.d` directory are ignored, for example `old_settings.rb.bak`.

{{< note >}}

If you have the same setting in multiple configuration files, ensure that it has the same value in all files.

{{< /note >}}
