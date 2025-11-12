+++
title = "Habitat origin settings"

[menu]
  [menu.habitat]
    title = "Origin settings"
    identifier = "habitat/builder/on-prem/origins/settings"
    parent = "habitat/builder/on-prem/origins"
    weight = 40
+++

The **Settings** tab for an origin lets you view and manage default package settings and origin secrets.

Every origin member can view the origin's settings, but only origin administrators and owners can add, update, or delete settings.

| Settings actions | Read-only | Member | Maintainer | Administrator | Owner |
|------------------|-----------|--------|------------|---------------|-------|
| View settings    | Y         | Y      | Y          | Y             | Y     |
| Add/update/delete settings | N | N | N | Y | Y |
| View secrets     | N         | N      | Y          | Y             | Y     |
| Add/update/delete secrets | N | N | N | Y | Y |

![The administrator or owner's view of the origin settings tab with a public default package setting and a saved origin secret](/habitat/builder/on_prem/origin-secrets.png)

## Default package settings

The **Default Package Settings** define the default visibility of a package's build artifacts (`.hart` files) in an origin:

- **Public packages** are visible in search results and can be used by any Chef Habitat Builder user.
- **Private packages** don't appear in search results and are available only to users with origin membership.

Packages can have different visibility settings from the origin to which they belong.

To change the origin's default visibility settings, select the origin in Habitat Builder, go to **Settings**, and select either **Public artifacts** or **Private artifacts**.

## Origin secrets

Origin secrets let you encrypt and store secrets as environment variables. These secrets are useful for plans that require access to protected resources at build time, such as private source-code repositories or cloud storage providers.

Origin secrets are retained by the origin and are available for any of that origin's packages. The secrets in your local environment are encrypted with an origin encryption key. Only Chef Habitat Builder can read encrypted origin secrets.

Every origin member can view an origin's secrets, but only origin administrators and owners can add, update, or delete them. You can find **Origin Secrets** at the bottom of the **Settings** tab (Builder > Origin > Settings > Origin Secrets).

### Manage origin secrets with the Chef Habitat CLI

You can view the list of origin secrets and delete them in Chef Habitat Builder.
However, the primary way to interact with origin secrets is through the Chef Habitat CLI.

#### List secrets

To list all secrets in an origin, run:

```bash
hab origin secret list --origin <ORIGIN>
```

#### Set origin secrets as environment variables

Add your origin secrets as environment variables in your local environment:

```bash
export HAB_ORIGIN=<ORIGIN>
export HAB_AUTH_TOKEN=<TOKEN>
hab origin secret list
```

#### Save an origin secret

To save an origin secret, give the secret a name and a key value:

```bash
hab origin secret upload AWS_ACCESS_KEY_ID <KEY_ID>
hab origin secret upload AWS_SECRET_ACCESS_KEY <SECRET_ACCESS_KEY>
```

The output should look similar to this:

```bash
$ hab origin secret upload AWS_ACCESS_KEY_ID 1234567890EXAMPLE
↓ Downloading latest public encryption key
    79 B / 79 B | [========================================] 100.00 % 120.23 KB/s
☑ Cached habicat-20200123456789.pub
☛ Encrypting value for key AWS_ACCESS_KEY_ID.
✓ Encrypted AWS_ACCESS_KEY_ID=[REDACTED].
↑ Uploading secret for key AWS_ACCESS_KEY_ID.
✓ Uploaded secret for AWS_ACCESS_KEY_ID.
```

#### Delete an origin secret

To delete an origin secret, run:

```bash
hab origin secret delete AWS_ACCESS_KEY_ID
hab origin secret delete AWS_SECRET_ACCESS_KEY
```

## More information

- See [Using origin secrets in plans](/habitat/plan_writing/#buildtime-workflow) for guidance on using origin secrets.
- See the [`hab origin secret`](/habitat/habitat_cli/#hab-origin-secret) CLI documentation for more information on these commands.
