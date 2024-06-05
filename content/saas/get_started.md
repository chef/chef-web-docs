+++
title = "Get Started with Chef SaaS"
draft = false
[menu]
  [menu.saas]
    title = "Get Started"
    identifier = "chef_infra/Get Started with Chef SaaS"
    parent = "chef_saas"
    weight = 20
+++

This guide shows you how to set up and configure Chef SaaS.

## Prerequisites

Before you start working with Chef SaaS, have a quick look at the following prerequisites:

* A System to install Chef Workstation.
  * Supported [Platforms and System Requirements](/workstation/install_workstation/).

* Chef SaaS Starter Kit (Provided by Progress Chef).
  * SaaS Environment URL.
  * SaaS Credentials.
  * Pivotal PEM file for the initial setup of the environment (the PEM is temporary, so replace it later).

## Add Chef Infra Server in Chef SaaS

Connected to the Chef SaaS Automate Web User Interface, follow these steps to add the Chef Infra Server to the environment.

1. Select Infrastructure in the top navigation.
1. Select Chef Infra Servers in the left-hand navigation.
1. Select **Add Chef Infra Server**.
1. Enter the following fields:
    * Provide a unique Name for the Chef Infra Server.
    * Ensure that the Type selected is FQDN.
    * Enter the FQDN by copying the same URL used to connect to the Chef SaaS. (Example: saas-example.com)

      {{< figure src="/images/automate/add-chef-server-popup-menu-with-error.png" width="500" alt="Add Chef Server Form">}}

1. Select **Add Chef Infra Server**.

## Configure Chef Workstation

### Set up the Chef Credentials file

Create a credentials file to continue configuring Workstation with Chef SaaS. You can update the new credentials created later in the setup.

1. On the workstation, run: `knife configure init`.
1. This prompts you with several questions:
    * Enter the Chef Infra Server URL provided in the Starter Kit (Example: `company-example.com.chef.io`)
    * For the existing API **username** or **client_name**, enter the Super User account provided in the Starter Kit.
1. Copy the `pivotal.pem` file in the Starter Kit to the `~/.chef` directory before running additional commands with Knife.

The credentials file that gets created in the `~/.chef` directory looks like as shown in the following code snippet:

```ruby
[default]
client_name         - 'pivotal'
client_key          = '/home/admin/.chef/pivotal.pem'
chef_server_url     - 'https://saas-example.com' //Sample URL
```

### Create Organization in CLI

Add the organization to the Chef Infra Server and act as a top-level entity for role-based access control. Use the [knife org create](/workstation/knife_org/) command to create your organization. For example, create an Organization:

```sh
Knife org create <ORGANIZATION_NAME> <ORGANIZATION_FULL_NAME>
```

In the above snippet, replace:

* `<ORGANIZATION_NAME>` with user\'s organization name.
* `<ORGANIZATION_FULL_NAME>` with the organization's full name.

The above code returns the private key for the organization's validator client.

### Create a User in CLI

Create a new user associated with the new organization and leverage in the credentials file. Create your new account using the [knife user create](/workstation/knife_user/) command. For example, to create a User named:

```sh
knife user create <USERNAME> <DISPLAY_NAME> <FIRST_NAME> <LAST_NAME> <EMAIL_Address> <PASSWORD> <FILE_NAME>.pem
```

In the above snippet, replace:

* `<USERNAME>` with the user's username.
* `<FIRST_NAME>` with the user's first name.
* `<LAST_NAME>` with the user's last name.
* `<EMAIL_ADDRESS>` with the user's e-mail id.
* `<PASSWORD>` with the user's password.
* `<FILE_NAME>` with the name of the file.

Copy the new `<FILE_NAME>.pem` file created with this command to the `~/.chef` directory before updating the credentials file later in this document.

### Add new User to Organization in CLI

Associate the created Organization and User to each other. Use the [knife org user](/workstation/knife_org/) command to add the user to an organization. For example, to add the User to the Organization:

```sh
knife org user add <ORGANIZATION_NAME> <USERNAME>
```

In the above code, replace:

* \<ORGANIZATION_NAME\> with user's organization name.
* \<USERNAME\> with the user's username.

### Update the credentials file to use a new account

Update the credentials file under the `~/.chef` directory on the Workstation to reflect the new **Organization**, **User**, and **PEM** file.

1. Open the credentials file in the `~/.chef` directory. Modify the following values:
    * `client_name` to the new account created.
    * `client_key` to the new **PEM** file that was created.
    * `chef_server_url` to include the new **Organization**.

    Following is an example of the credentials in the `~/.chef` directory:

    ```ruby
    [default]
    client_name         - 'CLIENT_NAME'
    client_key          = '/home/admin/.chef/<USER_NAME>.pem'
    chef_server_url     - 'https://saas-example.com'
    ```

### Create Organization in Web User Interface

The following steps add the Organization to the Chef SaaS Web User Interface, allowing visualization of Cookbooks, Data Bags, Nodes, Policyfiles, etc. Connect to the URL provided by Progress Chef and log in with the admin account credentials.

1. Select **Infrastructure** in the top navigation.
1. Select **Chef Infra Servers** in the left-hand navigation.
1. Select the **Infra Server** created previously.
1. Select **Add Chef Organization**.
    * Provide the Name of the Organization created earlier in the CLI (Example: `<ORGANIZATION_NAME>`).
    * For Admin User, enter the new account created previously (Example: `<USER_NAME>`).
    * For Admin Key, paste the contents of the new PEM file created previously along with the account (Example: `<USER_NAME>.pem`).
    * Select **Add Chef Organization**.

{{< figure src="/images/automate/add-chef-organization-popup-menu.png" width="500" alt="Add Chef Organization Form">}}

### Verify SSL configuration

Chef SaaS leverages public certificates to ensure a secure connection to the service. To eliminate connection issues, it is always best to run an SSL check on the Workstation to verify that the certificate is trusted.

* To verify the connection with the new organization, run the following command:

```cd
knife ssl checks
```

### Verify Client Connection

Lastly, run a client list command to verify a successful connection to the new organization.

* Run the following command: `knife client list`. It returns a list of registered clients.
