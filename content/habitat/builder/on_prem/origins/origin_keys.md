+++
title = "Habitat origin keys"

[menu]
  [menu.habitat]
    title = "Origin keys"
    identifier = "habitat/builder/on-prem/origins/keys"
    parent = "habitat/builder/on-prem/origins"
    weight = 30
+++

When you create an origin, Chef Habitat On-prem Builder automatically generates _origin keys_.
Origin key cryptography is asymmetric: it has a public origin key that you can distribute freely, and a private origin key that you should distribute only to users belonging to the origin.

Chef Habitat uses origin keys in the following ways:

- When you build an artifact in your local environment, Chef Habitat signs the artifact with a public key.
- When you upload an artifact to Chef Habitat On-prem Builder, Chef Habitat verifies that the artifact was signed with its public key.
- When you install an artifact on a Chef Habitat Supervisor, Chef Habitat uses the public origin key to authorize the artifact's installation; Chef Habitat only installs artifacts for which it has the public origin key.
- When you download an artifact to your local environment, Chef Habitat uses the public origin key to verify the artifact's integrity before it starts the installation.

## Prerequisites

- [Download and installed the Chef Habitat CLI](/habitat/install_habitat/).
- [Create a Chef Habitat On-prem Builder account](/habitat/builder_account/).
- [Generate a personal access token](/habitat/builder_profile/#create-a-personal-access-token).
- [Create an origin with `hab origin create` or join an origin by invitation](../create_an_origin).

## Key access

All Chef Habitat On-prem Builder users with access to the origin can view the origin public key revisions in the origin key tab (**Builder** > **Origin** > **Keys**) and download the origin public key, but only origin members with the administrator or owner roles can view or download the origin private key, or change the origin key pair.

| Keys Actions | Read-Only | Member | Maintainer | Administrator | Owner |
|---------|-------|-------|-------|-------|-------|
| View keys | Y | Y | Y | Y | Y |
| Add/Update/Delete keys | N | N | N | Y | Y |

## Key filename format

Chef Habitat On-prem Builder origin keys use the following format:

- Public key: `<ORIGIN>-<DATETIME>.pub`
- Private key or signing key: `<ORIGIN>-<DATETIME>.sig.key`

For example, in:

```shell
testorigin-20190416223046.pub
testorigin-20190416223046.sig.key
```

- `testorigin` is the origin's name.
- `20190416223046` is the date and time of the key's creation, which was 2019-04-16 22:30:46.
- `.pub` is the file extension for the public key.
- `.sig.key` is the file extension for the private key, which is also called a signing key.

## Get origin keys

When you create an origin, Chef Habitat On-prem Builder automatically generates an origin key pair and saves both keys. To view an origin's keys on Chef Habitat On-prem Builder, navigate to the origin and select **Keys**.
Anyone can view and download an origin's public keys, but only origin owners and administrators can view or download an origin private key, or change the origin key pair.

![Viewing your origin keys](/habitat/builder/on_prem/origin-keys.png)

### Download origin keys

To download your private or public origin key, select {{< icons class="material-symbols-outlined icon-filled" icon="download_2" >}} **Download this key** under the **Actions** heading.

### Upload origin keys

To upload a public or private origin key in Chef Habitat On-prem Builder, select either **Upload a private key** or **Upload a public key** and paste your key into the dialog box that appears.

## Manage origin keys with the CLI

Run Chef Habitat CLI commands from your local environment or from within the Chef Habitat Studio.

For more information, see the [`hab origin key` CLI documentation](/habitat/habitat_cli/#hab-origin-key).

### Find your local origin keys

Chef Habitat stores your public and private origin keys at `~/.hab/cache/keys` on Linux systems, `C:\hab\cache\keys` on Windows, and at `/hab/cache/keys` inside of the Chef Habitat Studio environment.

#### Find your origin keys in your local environment

On Windows:

```PowerShell
Get-ChildItem C:\hab\cache\keys
```

On Linux or macOS:

```bash
ls -la ~/.hab/cache/keys
```

#### Find your existing origin keys from inside of the Chef Habitat Studio

On Windows:

```powershell
Get-ChildItem C:\hab\cache\keys
```

On Linux or macOS:

```bash
ls -la /hab/cache/keys
```

### Generate origin keys with the CLI

When you create an origin in Chef Habitat On-prem Builder, Builder automatically generates an origin key pair.

The Chef Habitat CLI creates origin key pairs through two different commands, for two different uses:

- Use [`hab setup`](/habitat/hab_setup/) to generate your first origin key pair as part of setting up the `hab` CLI.
- Use the `hab origin key generate` command to create an key pair for an origin created with the `hab origin create` command

To create an origin key with the `hab` CLI, run the [`hab origin key generate` command](/habitat/habitat_cli/#hab-origin-key-generate):

```shell
hab origin key generate <ORIGIN>
```

### Download origin keys with the CLI

To download your public origin key using the command line, use [`hab origin key download` command](/habitat/habitat_cli/#hab-origin-key-download):

```shell
hab origin key download <ORIGIN>
```

### Upload origin keys with the CLI

Creating an origin with the `hab origin create` command registers the origin on Chef Habitat On-prem Builder without creating an origin key pair. The `hab origin key generate` command creates the key pair and saves them in your local environment, but it doesn't upload either origin key to Chef Habitat On-prem Builder.

- Only origin members with the administrator and owner roles can upload new keys to an origin.
- Habitat On-prem Builder requires the public origin key to upload artifacts for that origin, so you'll need to upload it.
- Habitat On-prem Builder requires the private origin key to enable new artifact builds from packages with plans linked to that origin.

Upload origin keys with the [`hab origin key upload` command](/habitat/habitat_cli/#hab-origin-key-upload):

```shell
hab origin key upload <ORIGIN>
```

Upload the origin private key:

```shell
hab origin key upload --secret <ORIGIN>
```

Upload both origin keys at the same time:

```shell
hab origin key upload  --secfile <PATH_TO_PRIVATE_KEY> --pubfile <PATH_TO_PUBLIC_KEY>
```

### Import origin keys with the CLI

Use [`hab origin key import`](/habitat/habitat_cli/#hab-origin-key-import) to read the key from a standard input stream into Chef Habitat On-prem Builder:

```shell
hab origin key import <KEY_STRING>
hab origin key import <PATH_TO_KEY>
curl <URL_THAT_RETURNS_KEY> | hab origin key import
```

#### Troubleshoot origin key import

On a macOS, you may encounter an upload failure.
Follow these steps to remediate this failure:

- Check that your `HAB_AUTH_TOKEN` environment variable is properly set and initialized.
- Add your `SSL_CERT_FILE` to the environment variables in your interactive shell configuration file, such as your `.bashrc`. For example:

  ```bash
  export SSL_CERT_FILE=/usr/local/etc/openssl/cert.pem
  ```

  After you've added this variable to your shell configuration, reinitialize the shell configuration. For example:

  ```bash
  source ~/.bashrc
  ```
