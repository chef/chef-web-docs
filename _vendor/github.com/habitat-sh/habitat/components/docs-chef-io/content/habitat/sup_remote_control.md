+++
title = "Control Supervisors Remotely"
description = "Controlling Supervisors Remotely"

[menu]
  [menu.habitat]
    title = "Remote Control"
    identifier = "habitat/supervisors/sup-remote-control"
    parent = "habitat/supervisors"
    weight = 120

+++

[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/sup_remote_control.md)

Since the 0.56.0 Supervisor release, it is possible to command and control one or more Supervisors from a remote location. Before this, the only way to interact with a Supervisor was by taking action directly on machine on which the Supervisor was running. While that is still an option (and is indeed the default behavior), remote command and control opens up more possibilities for using and managing Chef Habitat.

Here, we'll discuss how this is implemented, how it can be enabled in your Chef Habitat deployments, and how it can be used.

## Remote Command and Control Overview

The Chef Habitat Supervisor uses a defined TCP protocol for all interactions; the `hab` CLI tool is the client for this protocol, and the Supervisor is the server. Interactions are authenticated using a shared secret.

Previously, in order to run `core/redis` on a Supervisor running on (say), `hab1.mycompany.com`, you would have to have direct access to the machine (as well as root privileges) in order to load the service, which might look like this:

```
ssh hab1.mycompany.com
sudo hab svc load core/redis
```

Now, using the remote control capabilities of the Supervisor, this could be accomplished from a workstation or bastion host with an invocation that could be as simple as this:

```
hab svc load core/redis --remote-sup=hab1.mycompany.com:9632
```

No direct host access is necessary, and multiple Supervisors can be controlled from one central location.

### Remote Control is Optional

Operating Chef Habitat Supervisors remotely is purely optional; you must take positive action to enable this behavior. If you prefer, you can continue to manage Supervisors through on-the-box direct action, as before, and likely without any changes to your current procedures. Read on for further details about how to enable this ability, and how local interaction continues to operate through a new implementation.

## Managing Shared Supervisor Secrets

Authentication between client (`hab` CLI) and server (Supervisor) is achieved using a shared secret. The `hab` CLI receives its secret from a configuration file (`~/.hab/config/cli.toml`) or from an environment variable (`HAB_CTL_SECRET`). The Supervisor reads its secret from its `CTL_SECRET` file, located at `/hab/sup/default/CTL_SECRET`. When the value used by `hab` matches the one used by the Supervisor, the requested command is carried out.

### Create a Secret

Shared secrets are created in one of two ways.

First, when a Supervisor starts up, will create a new secret in `/hab/sup/default/CTL_SECRET` automatically if one does not already exist. This is helpful for transparently upgrading older Supervisors and continuing to allow local interactions.

Second, and most recommended, users can generate a new secret using `hab sup secret generate`:

```
hab sup secret generate
VKca6ezRD0lfuwvhgeQLPSD0RMwE/ZYX5nYfGi2x0R1mXNh4QZSpa50H2deB85HoV/Ik48orF4p0/7MuVNPwNA==
```

This generates a new secret, printing it to standard output. Using the provisioner or configuration management tool of your choice, you can then use this value to create your own `/hab/sup/default/CTL_SECRET` file, ensuring that your Supervisor(s) are using a pre-determined key, instead of each making their own.

If you have a pre-existing fleet of Supervisors which have already been started up with their own individually-generated secrets, you will likely want to overwrite their existing `CTL_SECRET` files with one that has a key of your own creation.

If you are using a raw container-based deployment (i.e., not a managed platform like Kubernetes), you will want to mount an appropriate `CTL_SECRET` file into the container.

### Configure the Hab Cli with Your Secret

Once you have a secret, you can add it to your local `hab` configuration file, preferably by running `hab cli setup` and following the interactive prompts. Alternatively, you can export it into your environment:

```
export HAB_CTL_SECRET="VKca6ezRD0lfuwvhgeQLPSD0RMwE/ZYX5nYfGi2x0R1mXNh4QZSpa50H2deB85HoV/Ik48orF4p0/7MuVNPwNA=="
```

Note that your `hab` configuration file only keeps a single "secret" entry, and exporting a single secret into your environment does effectively the same thing. An assumption of this arrangement is that all Supervisors you wish to interact with have the same shared secret; if you wish to control a set of Supervisors that do not all use the same shared secret, you will need to manage the mapping of secret-to-supervisor yourself, which might look something like this:

```
HAB_CTL_SECRET=${secret_for_supervisor_1} hab svc load ... --remote-sup=${address_of_supervisor_1}
HAB_CTL_SECRET=${secret_for_supervisor_2} hab svc load ... --remote-sup=${address_of_supervisor_2}
# etc.
```

## Configuring Supervisors for Remote Command and Control

As stated earlier, the Supervisor reads its secret from its `/hab/sup/default/CTL_SECRET` file, the contents of which you can control using `hab sup secret generate` and your chosen provisioner / deployment tooling. This ensures that the shared secret is in place, but one more step must be taken to fully enable the feature.

By default, the Supervisor's "control gateway" listens on the `127.0.0.1` interface for incoming commands. This means that it can only receive commands from the same machine, and not from remote clients. If you wish to control a Supervisor remotely, you'll have to start the Supervisor setting its `--listen-ctl` option to an appropriate interface and port (9632 is the default control gateway port):

```
hab sup run --listen-ctl=0.0.0.0:9632
```

This Supervisor would now be able to be controlled via any network interface (provided the request used the appropriate shared secret, of course). As always, be sure to use the appropriate interface values for your specific situation (e.g., pass an internal network-facing interface rather than a publicly-exposed interface).

## Targeting a Remote Supervisor

Throughout this documentation are numerous examples of interacting with a Supervisor; commands like `hab svc load`, `hab svc start`, `hab svc stop`, etc. all generate requests using the Supervisor's defined interaction protocol. They all operate over TCP, even in the default case of interacting with a Supervisor on the same host.

In order to target a remote Supervisor, you must have the appropriate shared secret available, as described above (either in the environment or in the `hab` CLI configuration file), and you must also specify the specific Supervisor using the `--remote-sup` option. The value for this option should correspond to the value of `--listen-ctl` the Supervisor was started with; it is the address and port at which the Supervisor's control gateway may be reached. All Supervisor interaction commands accept a `--remote-sup` option for such targeting.

## Local Supervisor Interactions

Without specifying `--remote-sup`, the `hab` CLI will always try to connect to a Supervisor running on the current host. It must still use the correct shared secret, however. As a last resort, if no secret is found in either a configuration file or an environment variable, the `hab` CLI will attempt to read one from `/hab/sup/default/CTL_SECRET`. In this way, it will use the same secret that the local Supervisor is using, enabling the request to proceed.

## Protocol Versioning and `hab` Versions

Before the 0.56.0 release of Chef Habitat, the interaction between `hab` and the Supervisor was not formally defined, and relied on making changes to files on disk. As a result, it was often possible to continue interacting with a newer Supervisor using an older version of the `hab` CLI. This was particularly noticeable when the Supervisor was configured to automatically update itself; the Supervisor would continue upgrading over time, while the `hab` CLI binary remained at whatever version it was when it was originally installed, because each of the two executable were distributed in separate packages.

For the near term, `hab` and the Supervisor are still distributed separately, as `core/hab` and `core/hab-sup`, respectively. To interact with 0.56.0 or later Supervisors, users will need to use an 0.56.0 or later `hab` binary, even if they wish to continue interacting with their Supervisors only locally. This may require a manual upgrade for the `hab` binary, which can be done by running `hab pkg install core/hab -b -f`. In the near future, we hope to consolidate all of Chef Habitat's functionality into a single package (if not a single binary), which will make it easier to manage going forward.

The interaction protocol is defined using Google's [Protocol Buffers](https://developers.google.com/protocol-buffers/); it is our explicit goal that all future changes to the protocol will happen in a backward-compatible way.
