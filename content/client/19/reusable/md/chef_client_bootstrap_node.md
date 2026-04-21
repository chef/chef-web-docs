A node is any physical, virtual, or cloud device that Chef Infra Client configures and maintains.
Bootstrapping installs Chef Infra Client on a target system and sets up the node to communicate with Chef Infra Server.
You can bootstrap a node in two ways:

- Run the `knife bootstrap` command from a workstation.
- Perform an unattended install to bootstrap from the node itself, without requiring SSH or WinRM connectivity.
