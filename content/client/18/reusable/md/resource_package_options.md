The RubyGems package provider attempts to use the RubyGems API to
install gems without starting a new process, whenever possible. A gems install
command starts under the following conditions:

- When the `gem_binary` property is specified, Chef Infra Client shells out
  to that binary (with `gem env` or `gem list --remote`) to inspect the target
  Ruby's gem environment, then shells out to it again to run the install.
  **Note**: `gem_binary` can't be combined with a Hash value for `options`,
  this raises an error.
- When install options are specified as a string, Chef Infra Client
    starts a gems command with those options when installing the gem.
- When no `gem_binary` is specified and Chef Infra Client is running from
    an omnibus install (its own embedded Ruby), the `gem_package` resource
    searches the `PATH` for a `gem` command instead of using Chef Infra
    Client's own embedded RubyGems installation. The embedded Ruby is
    dedicated to running Chef Infra Client itself, so `gem_package` installs
    into a separate, general-purpose Ruby environment found on the `PATH`.
    This doesn't apply to the `chef_gem` resource, which always installs into
    Chef Infra Client's own embedded RubyGems environment.
