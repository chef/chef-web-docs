Ohai is a tool for collecting system configuration data, which it then provides to Chef Infra Client to use in cookbooks. Chef Infra Client runs Ohai at the start of every Chef Infra run to determine system state. The attributes that Ohai collects are called `automatic attributes`. Chef Infra Client uses these attributes to ensure that nodes are in the desired state after each configuration run.

The types of attributes Ohai collects include but aren't limited to:

- Operating System
- Network
- Memory
- Disk
- CPU
- Kernel
- Host names
- Fully qualified domain names
- Virtualization
- Cloud provider metadata

Ohai includes required and optional plugins to detect common configuration information. Ohai has a plugin model and language to write [custom plugins](/ohai_custom/) to collect additional system state information.
