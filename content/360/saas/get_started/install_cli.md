+++
title = "Install CLIs and register your workstation"

draft = false

[menu.cloud]
title = "Install CLIs"
identifier = "chef_cloud/360/get_started/cli"
parent = "chef_cloud/360/get_started"
weight = 40
+++

This page documents how to download and install the Chef 360 Platform CLIs and register your workstation with your Chef 360 SaaS deployment.

## Prerequisites

- [Chef 360 SaaS configured]({{< relref "set_up" >}}).
- `/usr/local/bin` is present in the PATH environment variable.

## Install CLIs

{{< readfile file="content/360/saas/reusable_text/md/clis_install_saas.md" >}}

## Install and configure the bash-completion package

{{< readfile file="content/360/saas/reusable_text/md/install_bash_completion.md" >}}

## Add your license

{{< readfile file="content/360/saas/reusable_text/md/clis_add_license.md" >}}

## Verify profiles

{{< readfile file="content/360/saas/reusable_text/md/clis_verify_profiles.md" >}}

## Assign the Node Manager and Courier Operator roles

The `node-manager` and `courier-operator` roles allow you to manage nodes, manage skills on nodes, and run Chef Courier jobs.

Before you begin, ensure you have:

- Your user ID. Use the `user-account identity get-self-user` subcommand to get your user ID.
- The name of a profile with the org-admin role.

Follow this step to give your user account the `node-manager` and `courier-operator` roles:

- Assign the `node-manager` role and `courier-operator` role using the `user-account user assign-role` subcommand:

  ```sh
  chef-platform-auth-cli user-account user assign-role --body '{"name": "node-manager", "roleId": "6e7df273-928b-41ec-b6f6-e3f5138a6f9e"}' --userId <USER_ID> --profile <ORG_ADMIN_PROFILE_NAME>
  ```

  ```sh
  chef-platform-auth-cli user-account user assign-role --body '{"name": "courier-operator", "roleId": "ac12c3a6-95f7-429d-b3fc-584ce1cf74de"}' --userId <USER_ID> --profile <ORG_ADMIN_PROFILE_NAME>
  ```

  Replace:

  - `<USER_ID>` with your user ID.
  - `<ORG_ADMIN_PROFILE_NAME>` with your profile that has the org-admin role.

## Create profiles for the Node Manager and Courier Operator roles

Create a profile _for each role_ that you added to your user account in the previous step.

To create a profile, follow these steps:

1. Create a profile using the `register-device` subcommand that associates your workstation with a specific tenant, organization, and role:

    ```sh
    chef-platform-auth-cli register-device --device-name <WORKSTATION_NAME> --profile-name <PROFILE_NAME> --url <TENANT_URL>
    ```

    {{< note >}}

    If you've configured Chef 360 SaaS with a system-generated or custom certificate in the API/UI settings, use the following CLI arguments:

    - If you don't have the root certificate authority, use the `--insecure` flag. This flag skips certificate validation.
    - If have the root certificate authority present, use the `--cafile <ABSOLUTE_PATH_TO_ROOT_CA_FILE>` flag.

    {{< /note >}}

    Replace:

    - `<WORKSTATION_NAME>` with a name for the workstation.
    - `<PROFILE_NAME>` with a profile name for the role that this profile will use. For example, add the `courier-operator` profile name for the `courier-operator` role.
    - `<TENANT_URL>` with the tenant URL, for example `https://chef360.example.com:31000`.

    The CLI responds with an authorization code that includes a link to log into Chef 360 SaaS.

    ```sh
    Device Id :  ac:de:48:00:11:22-admin-chef-courier-cli
    Device Name : <DEVICE_NAME>
    OAuth Code : <AUTHORIZATION_CODE>

    Please log in and authorise the the device by using the link below:
    https://chef360.example.com/platform/user-accounts/v1/identity/device/ac:de:48:00:11:22-admin-chef-courier-cli/authorise?oauthCode=<AUTHORIZATION_CODE>&appType=chef-courier-cli&deviceName=<WORKSTATION>

    Is the device authorised? (y or n)
    ```

    Paste the link into your browser and log in.
    The CLI waits for the device registration process to finish in the browser.

1. Open a browser, navigate to the link returned by the CLI, and log in if you haven't already.

1. Select the organization and role you would like to link to this profile and select **Submit**.

    {{< figure src="/images/360/select-role.png" width="500px" alt="Chef 360 SaaS organization and role selection screen." >}}

1. On the **Device Authorization** screen, Chef 360 SaaS shows your OAuth code and you can select an expiration date for your session.

   Chef 360 SaaS automatically refreshes your access token up to this expiration date.

   After entering this information, select **Authorize**.

    {{< figure src="/images/360/setting-expiry-token.png" alt="Chef 360 SaaS device authorization screen with OAuth token and expiration date." width="500px">}}

1. Return to your terminal and enter `y` to continue.

    The CLI displays your device profile and your workstation is authorized to access Chef 360 SaaS services.

    ```sh
    Is the device authorised? (y or n)
    > y
    Profile:

    [tenant-org-role]
    DeviceId = "ac:de:48:00:11:22-admin-chef-courier-cli"
    Url = "https://demo.chef360.io/"
    OrgName = "Demo Organization"
    RoleName = "org-admin"
    AccessKey = "FIT3SXM...TCYK4V05Y"
    SecretKey = "Cwaygh4FqE2sT...rX4wBu0hp9IE9YpzoGuX"

    Device registered successfully
    ```

1. Optional: Test your connection by getting the role associated with your user account:

    ```sh
    chef-platform-auth-cli user-account self get-role --profile <PROFILE_NAME>
    ```

    Replace `<PROFILE_NAME>` with the name of your profile.

1. Optional: Set your new profile as the default profile.

    The Chef 360 Platform CLIs use a default profile automatically in any command that accepts the `--profile` argument.
    If you don't set a default profile, you will have to specify it in each command with `--profile <PROFILE_NAME>`.

    Set a default profile:

    ```sh
    chef-platform-auth-cli set-default-profile <PROFILE_NAME>
    ```

    Replace `<PROFILE_NAME>` with the name of the default profile.

1. Repeat this procedure so that you have separate profiles for the Node Manager and Courier Operator roles.

## Additional information

- [Chef 360 CLI reference documentation](https://docs.chef.io/360/1.2/reference/cli/)

## Next step

- [Register the Node Management agent]({{< relref "register_node_agent.md" >}}).
