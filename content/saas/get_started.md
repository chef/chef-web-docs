+++
title = "Get Started with Chef SaaS"
draft = false
[menu]
  [menu.cloud]
    title = "Get Started"
    identifier = "chef_cloud/saas/Get Started with Chef SaaS"
    parent = "chef_cloud/saas"
    weight = 20
+++

This guide explains how to set up and configure Chef SaaS. For details on how to migrate from AWS OpsWorks, refer to the following page: [AWS OpsWorks migration](/saas/opsworks_migration/).

## Prerequisites

Chef SaaS has the following prerequisites:

- You must have a system with [Chef Workstation installed](/workstation/install_workstation/).

- Chef SaaS Starter Kit (provided by Progress Chef):
  - SaaS Environment URL
  - SaaS Credentials
  - Pivotal PEM file for the initial setup of the environment. This PEM file is temporary and is replaced later.

## Add Chef Infra Server in Chef SaaS

Follow these steps in Chef SaaS to add a Chef Infra Server:

1. Select **Infrastructure** in the top navigation.
1. Select **Chef Infra Servers** in the navigation on the left.
1. Select **Add Chef Infra Server**.
1. Fill out the fields as follows:
    - Provide a unique name for the Chef Infra Server.
    - Enter the FQDN by copying the same URL used to connect to Chef SaaS, for example: `saas.example.com`.

      {{< figure src="/images/saas/add-chef-server-popup-menu.png" width="500" alt="Enter Chef Infra Server name and FQDN in the Add Chef Infra Server dialog.">}}

1. Select **Add Chef Infra Server**.

## Configure Chef Workstation

For details on configuring Chef Workstation, refer to the following sections.

1. Create a Chef credentials file on your local workstation:

    ```sh
    knife configure init
    ```

    This prompts you with several questions:

    - Enter the Chef Infra Server URL provided in the Starter Kit, for example: `saas.example.com`.
    - For the existing API **username** or **client_name**, enter the superuser account provided in the Chef SaaS Starter Kit.

    This creates a credentials file in the `~/.chef` directory with contents similar to the following:

    ```ruby
    [default]
    client_name         - 'pivotal'
    client_key          = '/home/admin/.chef/pivotal.pem'
    chef_server_url     - 'https://saas.example.com'
    ```

1. Copy the `pivotal.pem` file from the Chef SaaS Starter Kit to the `~/.chef` directory.

   This gives you the proper credentials to connect to Chef SaaS in the following steps.

1. Create an organization using the [`knife org create`](/workstation/knife_org/) command. This organization acts as a top-level entity for role-based access control.

    ```sh
    knife org create <ORGANIZATION_NAME> "<ORGANIZATION_FULL_NAME>"
    ```

    Replace:

    - `<ORGANIZATION_NAME>` with the user's organization name.
    - `<ORGANIZATION_FULL_NAME>` with the organization's full name.

    This returns a private key for the organization's validator client.

1. Create a new user associated with the new organization and use the credentials file:

    ```sh
    knife user create <USERNAME> --email <EMAIL> --password <PASSWORD>
    ```

    Replace:

    - `<USERNAME>` with the user's username.
    - `<EMAIL>` with the user's e-mail address.
    - `<PASSWORD>` with the user's password.

    Copy the new `<FILE_NAME>.pem` file created with this command to the `~/.chef` directory before updating the credentials file later in this document.

1. Add the new user to the organization using the [`knife org user`](/workstation/knife_org/) command:

    ```sh
    knife org user add <ORGANIZATION_NAME> <USERNAME>
    ```

    In the above code, replace:

    - `<ORGANIZATION_NAME>` with user's organization name.
    - `<USERNAME>` with the user's username.

1. Open the credentials file in the `~/.chef` directory and update the following values:

    - `client_name` to the new account created.
    - `client_key` to the new PEM file that was created.
    - `chef_server_url` to include the new organization.

    An example of the credentials in the `~/.chef` directory is as follows:

    ```ruby
    [default]
    client_name         - 'CLIENT_NAME'
    client_key          = '/home/admin/.chef/<USER_NAME>.pem'
    chef_server_url     - 'https://saas-example.com'
    ```

## Configure Chef Saas

The following steps add the organization to Chef SaaS. Connect to the URL provided by Progress Chef and log in with the admin account credentials:

1. Select **Infrastructure** in the top navigation.
1. Select **Chef Infra Servers** in the navigation on the left.
1. Select the **Chef Infra Server** created previously.
1. Select **Add Chef Organization** and:
    - Provide the **Name** of the organization created using knife.
    - For **Admin User**, enter the new account created using knife.
    - For **Admin Key**, paste the contents of the new PEM file created with the user account.
    - Select **Add Chef Organization**.

    {{< figure src="/images/automate/add-chef-organization-popup-menu.png" width="350" alt="Add Chef Organization Form">}}

### Verify the SSL configuration

Chef SaaS uses public certificates to ensure a secure connection to the service. To eliminate connection issues, verify the SSL connection and the certificate.

- Verify the connection with the new organization:

    ```cd
    knife ssl check
    ```

### Verify the client connection

- Finally, verify a successful connection to the new organization:

  ```sh
  knife client list
  ```

  This returns a list of Infra Client nodes and workstations that are registered with a Chef Infra Server.
