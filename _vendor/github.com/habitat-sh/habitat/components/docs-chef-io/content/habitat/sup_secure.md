+++
title = "Securing Supervisor Networks"
description = "Securing Supervisor Networks"

[menu]
  [menu.habitat]
    title = "Securing Networks"
    identifier = "habitat/supervisors/using-encryption"
    parent = "habitat/supervisors"
    weight = 80

+++

[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/sup_secure.md)

By default, a Supervisor runs unsecured. It communicates with other Supervisors in cleartext, and it allows any user to apply new configuration without authentication. While this is beneficial for demonstrating the concepts of Chef Habitat, users will want to provide external security on production deployments of Chef Habitat Supervisor networks.

There are several types of security measures:

* Wire encryption of inter-Supervisor traffic
* Trust relationships between supervisors and users

## Wire Encryption

Supervisors running in a ring can be configured to encrypt all traffic between them. This is accomplished by generating a _ring key_, which is a symmetric shared secret placed into the Supervisor environment prior to starting it.

### Generating a Ring Key

1. Generate a ring key using the `hab` command-line tool. This can be done on your workstation. The generated key has the `.sym.key` extension, indicating that it is a symmetric pre-shared key, and is stored in the `$HOME/.hab/cache/keys` directory.

    ```bash
    $ hab ring key generate <RING>
    ```

2. Copy the key file to the environment where the Supervisor will run, into the `/hab/cache/keys` directory. Ensure that it has the appropriate permissions so only the Supervisor can read it.
3. Start the Supervisor with the `-r` or `--ring` parameter, specifying the name of the ring key to use.

    ```bash
    $ hab sup run --ring <RING>
    $ hab svc load <ORIGIN>/<NAME>
    ```

4. The Supervisor becomes part of the named ring `<RING>` and uses the key for network encryption. Other supervisors that now attempt to connect to it without presenting the correct ring key will be rejected.
5. It is also possible to set the environment variable `HAB_RING_KEY` to the contents of the ring key; for example:

    ```bash
    $ env HAB_RING_KEY=$(cat /hab/cache/keys/ring-key-file) hab sup run
    $ hab svc load <ORIGIN>/<NAME>
    ```

## Service Group Encryption

Supervisors in a service group can be configured to require key-based authorization prior to allowing configuration changes. In this scenario, the Supervisor in a named service group starts up with a key for that group bound to an _organization_. This allows for multiple service groups with the same name in different organizations.

As explained in the [security overview]({{< relref "sup_crypto" >}}), this process also requires the generation of a user key for every user making configuration updates to the Supervisor network.

### Generating Service Group Keys

1. Generate a service group key using the `hab` command-line tool. This can be done on your workstation. Because asymmetric encryption is being used, two files will be generated: a file with a `.box.key` extension, which is the service group's private key, and a file with a `.pub` extension, which is the service group's public key.

    ```bash
    $ hab svc key generate service-group-name.example <ORG>
    ```

2. This generated a service group key for the service group `service-group-name.example` in the organization `<ORG>`. Copy the `.box.key` private key to the environment where the Supervisor will run into the `/hab/cache/keys` directory. Ensure that it has the appropriate permissions so that only the Supervisor can read it.
3. Start the Supervisor, specifying both the service group and organization that it belongs to:

    ```bash
    $ hab sup run --org <ORG> --group service-group-name.example
    $ hab svc load <ORIGIN>/<NAME>
    ```

4. Only users whose public keys that the Supervisor already has in its cache will be allowed to reconfigure this service group. If you need to generate a user key pair, see the next section.

### Generating User Keys

The user key is used to encrypt configuration data targeted for a particular service group.

1. Generate a user key using the `hab` command-line tool. This can be done on your workstation. Because asymmetric encryption is being used, two files will be generated: a file with a `.box.key` extension, which is the user's private key, and a file with a `.pub` extension, which is the user's public key.
2. Distribute the user's public key to any Supervisor that needs it, into the `/hab/cache/keys` directory. The user will be able to reconfigure that Supervisor, provided they encrypted the configuration update using the service group's public key.

## Apply Configuration Changes

The `hab config apply` and `hab file upload` commands will work as usual when user/service group trust relationships are set up in this way.

If a running Supervisor cannot decrypt a secret due to a missing key, it will retry with exponential backoff starting with a one-second interval. This allows an administrator to provide the Supervisor with the key to resume normal operations, without taking down the Supervisor.

## Identifying Key Types

To aid the user in the visual identification of the many varieties of keys in use by Chef Habitat, a key itself is in cleartext and contains a header on the first line indicating what kind of key it is. The file extension and, in some situations, the format of the file name, provide additional guidance to the user in identifying the type of key.

`YYYYMMDDRRRRRR` denotes the creation time and release identifier of that key.

| Key Type | Header | Filename Format |
|----------|--------|-----------------|
| Private origin signing key | SIG-SEC-1 | originname-YYYYMMDDRRRRRR.sig.key |
| Public origin signing key | SIG-PUB-1 | originname-YYYYMMDDRRRRRR.pub.key |
| Ring wire encryption key | SYM-SEC-1 | ringname-YYYYMMDDRRRRRR.sym.key |
| Private service group key | BOX-SEC-1 | service-group.env@org-YYYYMMDDRRRRRR.box.key |
| Public service group key | BOX-PUB-1 | service-group.env@org-YYYYMMDDRRRRRR.pub |
| Private user key | BOX-SEC-1 | username-YYYYMMDDRRRRRR.box.key |
| Public user key | BOX-PUB-1 | username-YYYYMMDDRRRRRR.pub |

Keys that contain `SEC` in their header should be guarded carefully. Keys that contain `PUB` in their header can be distributed freely with no risk of information compromise.
