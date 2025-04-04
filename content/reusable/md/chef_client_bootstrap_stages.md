The following diagram shows the stages of the bootstrap operation,
and the list below the diagram describes each of those stages in greater detail.

![image](/images/chef_bootstrap.png)

When you run `knife bootstrap` on a node for the first time, Chef Workstation, Infra Client, and Infra Server handle the following tasks:

1. **Run `knife bootstrap`**

   Run the [`knife bootstrap`](/workstation/knife_bootstrap/) subcommand from a workstation. Include the hostname, IP address, or FQDN of the target node as part of this command. Knife establishes an SSH or WinRM connection with the target system and runs the bootstrap script.

    By default, the first Chef Infra Client run has an empty run list. You can add a [run list](/run_lists/) to the initial bootstrap operation using the [`--run-list`](/workstation/knife_bootstrap/#node-options) option.

1. **Get the install script**

    A shell script gets the most recent version of the [Chef Infra Client install script](/chef_install_script/) (`install.sh` or `install.ps1`) from Chef.

1. **Get the Chef Infra Client package**

    The install script gathers system-specific information, determines the correct package for Chef Infra Client, and downloads that package from Chef's downloads API.

1. **Install Chef Infra Client**

    Chef Infra Client is installed on the target node using a system native package (.rpm, .msi, etc).

1. **Start a Chef Infra Client run**

    When you first run `knife bootstrap`, Chef Workstation creates a `first-boot.json` file with some initial settings.

    On UNIX and Linux-based machines, the second shell script executes the `chef-client` binary with the `first-boot.json` file on the node.

    On Windows machines, the batch file that's derived from the `windows-chef-client-msi.erb` bootstrap template executes the `chef-client` binary with the `first-boot.json` file on the node.

1. **Complete the Chef Infra Client run**

    The Chef Infra Client run proceeds using HTTPS (port 443) and registers the node with Chef Infra Server.
