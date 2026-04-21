The `knife bootstrap` command is a common way to install Chef Infra Client on a node.
The default for this approach assumes that a node can access the Chef website to download the Chef Infra Client package.

The Chef Infra Client installer detects the version of the operating system, then installs the appropriate version of Chef Infra Client and all of its dependencies using a single command.
Dependencies include an embedded version of Ruby, OpenSSL, parsers, libraries, and command line utilities.

The Chef Infra Client installer puts everything into a unique directory (`/opt/chef/`) so that Chef Infra Client doesn't interfere with other applications running on the target machine.
After installation, Chef Infra Client requires a few more configuration steps before it can perform its first run on a node.
