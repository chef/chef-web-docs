+++
title = "Create an origin"

[menu]
  [menu.habitat]
    title = "Create an origin"
    identifier = "habitat/on-prem-builder/origins/create"
    parent = "habitat/on-prem-builder/origins"
    weight = 20
+++

You can create origins in a private Habitat Builder deployment using either the Habitat Builder UI or the `hab` CLI.
[Chef's public Habitat Builder](https://bldr.habitat.sh) doesn't support creating new origins.

## Create an origin in Chef Habitat Builder

To create an origin in your Chef Habitat Builder deployment, follow these steps:

1. In Habitat Builder, select **My Origins** in the left navigation menu.

1. On the **My Origins** page, select **Create origin** to open the **Create New Origin** form.

1. Enter a unique name for your origin. Chef Habitat requires origin names to be unique. Examples of origin names include team names, user names, or abstract concepts.

1. Choose a default privacy setting for new packages. You can override this setting when uploading individual packages from the CLI or by connecting a plan file that declares a package as private.

   The difference between public and private packages is:

   - Public packages are visible to and usable by anyone.
   - Private packages are visible to and usable only by users with origin membership.

1. Select **Save and Continue**.

   Habitat Builder performs the following actions:

   - Creates your origin.
   - Creates an [origin key pair](../origin_keys).
   - Redirects you to the origin page.

   ![Origin successfully created](/images/habitat/create-origin-done.png)

## Create an origin with the Chef Habitat CLI

Before you create an origin, make sure your [workstation is configured](../../install/workstation) to connect to your private Habitat Builder deployment.

To create an origin with the `hab` CLI, use the [`hab origin create`](/habitat/habitat_cli/#hab-origin-create) command. For example:

- ```bash
  hab origin create <ORIGIN>
  ```

This command creates an origin on the Chef Habitat Builder site.

To create a key pair for your origin, see the [origin keys](../origin_keys) documentation.
