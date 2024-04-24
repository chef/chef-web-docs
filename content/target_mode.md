+++
title = "Target Mode"
draft = false
gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Target Mode"
    identifier = "chef_infra/features/Target Mode"
    parent = "chef_infra/features"
    weight = 80
+++

Target Mode was first released in Chef 15. It allows for the execution of Chef resources on remote systems without the need to install Chef Infra Client on those systems. This enables easy management of the desired state of remote systems, edge devices, and cloud targets without the need of installing a client or an agent on them.

Target mode eliminates the need for specific platform support by allowing the management of any system, target, or device's desired state without the need of a native client. Devices can be managed with compatible native resources or through custom resources. Once a target mode compatible recipe has been written it will allow the remote management of that node from any server, workstation, container or pipeline. Essentially, target mode is compatible with systems regardless of whether they have native Chef Infra Client builds.

The host connects via unified interface of [transport interface (train)](https://github.com/inspec/train) to any agent using one of the train protocols and ensures that the agent or target system is in desired state and is manageable from the host system.
