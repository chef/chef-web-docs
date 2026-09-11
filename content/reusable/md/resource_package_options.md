The RubyGems package provider attempts to use the RubyGems API to
install gems without starting a new process, whenever possible. A gems
command to install starts under the following conditions:

- When a `gem_binary` property is specified (as a hash, a string, or
    by a .gemrc file), Chef Infra Client runs that command to
    examine its environment settings and then again to install the gem.
- When install options are specified as a string, Chef Infra Client
    starts a gems command with those options when installing the gem.
- When Chef Infra Client invokes an external gem command, it resolves
    that command through `PATH` rather than automatically using the current
    RubyGems environment. As part of `enforce_default_paths`, Chef Infra Client
    adds the `bin` directories to the `PATH`. This ensures that the gem installs
    into Chef Infra Client's embedded RubyGems environment, even when another Ruby
    installation is present on the system.
