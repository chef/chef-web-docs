The RubyGems package provider attempts to use the RubyGems API to
install gems without starting a new process, whenever possible. A gems
command to install starts under the following conditions:

- When a `gem_binary` property is specified (as a hash, a string, or
    by a .gemrc file), Chef Infra Client runs that command to
    examine its environment settings and then again to install the gem.
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
