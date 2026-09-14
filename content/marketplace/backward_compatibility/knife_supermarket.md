+++
title = "Knife supermarket compatibility"
draft = false
+++

Marketplace supports all unauthenticated, read-only `knife supermarket` commands.
The command syntax is the same as it is for Chef Supermarket, and no Marketplace credentials are required.

Configure Marketplace for all `knife supermarket` commands by adding the following setting to your `knife.rb` file:

```ruby
knife[:supermarket_site] = "https://marketplace.chef.io"
```

After you configure `knife[:supermarket_site]`, use your existing `knife supermarket` commands without any further changes.
You can also apply Marketplace to a single command with the `--supermarket-site https://marketplace.chef.io` option, without changing `knife.rb`.

| Command | Marketplace example | Purpose |
|---|---|---|
| `knife supermarket download <cookbook-name>` | `knife supermarket download <cookbook-name> --supermarket-site https://marketplace.chef.io` | Download a cookbook archive. |
| `knife supermarket install <cookbook-name>` | `knife supermarket install <cookbook-name> --supermarket-site https://marketplace.chef.io` | Install a cookbook into a local Git workflow. |
| `knife supermarket list` | `knife supermarket list --supermarket-site https://marketplace.chef.io` | List available cookbooks. |
| `knife supermarket search <search-query>` | `knife supermarket search <search-query> --supermarket-site https://marketplace.chef.io` | Search available cookbooks. |
| `knife supermarket show <cookbook-name>` | `knife supermarket show <cookbook-name> --supermarket-site https://marketplace.chef.io` | Show cookbook details. |

## Related information

- [Backward compatibility](/marketplace/backward_compatibility/)
- [knife supermarket](/workstation/latest/tools/knife/knife_supermarket/)
- [Configure knife](/workstation/latest/tools/knife/config_rb/)
- [Chef Supermarket](/supermarket/)
