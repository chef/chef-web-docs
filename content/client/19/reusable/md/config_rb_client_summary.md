The `client.rb` file configures Chef Infra Client on a node and it has the following characteristics:

- Chef Infra Client loads this file every time the `chef-client` executable runs.
- The default location is `C:\chef\client.rb` on Windows and `/etc/chef/client.rb` on all other systems.
- You can override the default location using the `--config` command line option.
- This file isn't created by default.
