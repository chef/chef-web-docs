+++
title = "Keys"
description = "Chef Habitat Security"

[menu]
  [menu.habitat]
    title = "Keys"
    identifier = "habitat/reference/keys"
    parent = "habitat/reference"

+++
[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/keys.md)

Chef Habitat has strong cryptography built into Chef Habitat Builder, the Supervisor, and the `hab` CLI commands. This means there are several different kinds of keys.

## Origin Key Pairs

Every Chef Habitat artifact belongs to an [origin]({{< relref "pkg_ids" >}}) and is cryptographically signed with that origin's private key. Chef Habitat requires the private key for producing artifacts and requires the public key for verification of artifacts before installation. If it is present on Builder, Chef Habitat will automatically download the public key for an origin when necessary.

Origin key cryptography is asymmetric: it has a public key that you can distribute freely, and a private key that you should keep safe.

Chef Habitat uses the public origin key to verify the integrity of downloaded artifacts before installing them.
Chef Habitat will only install artifacts for which it has the public origin key.

You can provide a public origin key to Chef Habitat by pointing it to a Builder site that has the origin key with the `--url` argument to `hab pkg install` or using the `hab origin key import` command.
Use `hab origin key upload` to upload origin keys to Builder.
Use `hab origin key download` to download your origin keys from Builder to your environment.
Use `hab origin key import` to read the key from a standard input stream or local file:

```bash
hab origin key import <enter or paste key>
hab origin key import < <PATH_TO_KEY>
curl <URL_THAT_RETURNS_KEY> | hab origin key import
```

See the [hab origin key]({{< relref "habitat_cli/#hab-origin-key" >}}) command documentation for more information about working with origin keys from the command line.

## User and Service Group Keys

User and service group keys are used to set up trust relationships between these two entities. Service groups can be set up to reject communication (e.g. applying new configuration via `hab config apply`) from untrusted users.

By default, service groups will trust *any* communication, so for a production deployment of Chef Habitat, setting up these relationships is essential.

User and service group keys also utilize asymmetric cryptography. To apply configuration changes to service groups when running in this mode, a user uses their own private key to encrypt configuration information for a service group, using that service group's public key. The service group then uses its private key to decrypt the configuration information, and the user's public key to verify.

## Ring Encryption Key

A Supervisor network can be optionally set up to encrypt *all* supervisor-to-supervisor communication.
This requires the use of a symmetric, pre-shared key.
