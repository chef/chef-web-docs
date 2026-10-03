+++
title = "Knife supermarket compatibility"
draft = false
+++

Marketplace currently supports only unauthenticated, read-only `knife supermarket` commands for consuming public cookbooks.
Write operations, including `knife supermarket upload`, aren't supported against Marketplace.
If you configure Marketplace as the Supermarket site, unsupported write commands such as `knife supermarket upload` fail.
To publish or upload cookbooks using Knife, continue to use `supermarket.chef.io`.
The supported read-only command syntax is the same as it is for Chef Supermarket, and no Marketplace credentials are required.

To configure Marketplace for supported read-only `knife supermarket` commands, add the following setting to your `knife.rb` file:

```ruby
knife[:supermarket_site] = "https://marketplace.chef.io"
```

After you configure `knife[:supermarket_site]`, use your existing supported read-only cookbook-consumption commands without changing their syntax.
You can also use Marketplace for a single supported read-only command with the `--supermarket-site https://marketplace.chef.io` option, without changing `knife.rb`.

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
