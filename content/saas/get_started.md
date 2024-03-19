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

This getting started guide will walk through the necessary setup and configuration for Chef SaaS to connect and begin to utilize the solution.

## Prerequisites

1. A System to install Chef Workstation

    * Supported [Platforms and System Requirements](https://docs.chef.io/workstation/install_workstation/)

1. Chef SaaS Starter Kit (Provided by Progress Chef)

    * SaaS Environment URL

    * SaaS Credentials

    * Pivotal PEM file for the initial setup of the environment (this PEM is only temporary and will be replaced in a later step)

## Connect to Chef SaaS

Connect to the URL provided by Progress Chef and log in with the admin account credentials to ensure that the environment is ready to be configured.

## Add an Infra Server in Chef SaaS Web UI

Connected to the Chef SaaS Automate Web User Interface, following these steps to add the Infra Server to the environment.

1. Select Infrastructure in the top navigation.

1. Select Chef Infra Servers in the left-hand navigation.

1. Click Add Chef Infra Server

1. Enter the following fields:

    * Provide a unique Name for the Chef Infra Server.

    * Ensure that the Type selected is FQDN.

    * Enter the FQDN by copying the same URL used to connect to the Automate Web User Interface. (Example: mycompany-demo.saas.chef.io)

      IMAGE

1. Select Add Chef Infra Server.

## Download Chef Workstation

Download the Chef Workstation from the [Chef Downloads](https://downloads.chef.io/tools/workstation) page.

## Install Chef Workstation

To install the Chef Workstation, go through our extended [Instal Chef Workstation](https://docs.chef.io/workstation/install_workstation/) page.

## Setup Chef Workstation

### Setup Chef Repo

If you’re setting up Chef for the very first time in your organization, then you will need a Chef Infra repository for saving your cookbooks and other work. The chef-repo is a directory on your workstation that stores everything you need to define your infrastructure with Chef Infra:

* Cookbooks (including recipes, attributes, custom resources, libraries, and templates)

* Data bags

* Policyfiles

Use the chef generate repo command to create your Chef Infra repository. For example, to create a repository called chef-repo:

```sh
chef generate repo chef-repo
```

### Setup Chef Credentials file

To continue configuring Workstation with Chef SaaS, a credentials file must be created.  This file will be updated with new credentials that are created later in the setup.

1. On the workstation run: knife configure init

1. This will prompt you with several questions:

    * Enter the Chef Server URL provided in the Starter Kit (Example: mycompany-demo.saas.chef.io)

    * For the existing username or clientname for the API, enter pivotal which is the Super User account provided in the Starter Kit.

1. Ensure that the pivotal.pem file provided in the Starter Kit is copied to the ~/.chef directory before running any additional commands with Knife.

The credentials file that gets created in the ~/.chef directory should look similar to this:

IMAGE

### Create Organization in CLI

A Chef Organization must be added to the Infra Server and act as a top-level entity for role-based access control. Use the knife org create command to create your Chef Organization. For example, to create an Organization called myorg:

```sh
Knife org create myorg “My New Organization”
```

The private key for the organization’s validator client is returned.

### Create a User in CLI

A new user must be created which will be associated with the new Chef Organization and will be leveraged in the credentials file. Use the knife user create command to create your new user account. For example, to create a User named chefadmin:

```sh
knife user create chefadmin --first-name Chef --last-name Admin --email chefadmin@mycompany.com –password securepassword -f chefadmin.pem
```

Ensure the new chefadmin.pem file that is created with this command is copied to the ~/.chef directory before updating the credentials file later in this document.

### Add New User to Organization in CLI

Now that the Organization and User are created, the two must be associated together. Use the knife org user command to add the user to an organization. For example, to add the User named chefadmin to the Organization called myorg:

```sh
knife org user add myorg chefadmin
```

### Update the Credentials file to use a new account

The credentials file under the ~/.chef directory on the Chef Workstation must be updated to reflect the new Organization, User, and PEM file.

1. Navigate to ~/.chef

1. Modify the credentials file
    * Change the client_name to the new account that was created (Example: chefadmin)

    * Change the client_key to the new PEM file that was created (Example: [home/admin/.chef/chefadmin.pem](https://mycompany-demo.saas.chef.io/organizations/myorg))

    * Change the chef_server_url to include the new Organization (Example: [https://mycompany-demo.saas.chef.io/organizations/myorg](https://mycompany-demo.saas.chef.io/organizations/myorg))

    * Save and Quit

      IMAGE

### Create Organization in Web User Interface

The following steps will add the Organization in the Chef SaaS Web User Interface to allow for visualization of Cookbooks, Data Bags, Nodes, Policyfiles, etc. Connect to the URL provided by Progress Chef and log in with the admin account credentials.

1. Select Infrastructure in the top navigation.

1. Select Chef Infra Servers in the left-hand navigation.

1. Select the Infra Server that was created earlier.

1. Click Add Chef Organization.

    * Provide the Name of the Organization that was created earlier in the CLI. (Example: myorg)

    * For Admin User, enter the new account that was created earlier (Example: chefadmin)

    * For Admin Key, paste the contents of the new PEM file that was created along with the account (Example: chefadmin.pem)

    * Click Add Chef Organization

IMAGE

### Run Knife SSL Check

Chef SaaS leverages public certificates to ensure a secure connection to the service. It is always best to run an SSL check on the Workstation to verify that the certificate is trusted to eliminate any connection issues.

1. Run the following command:  knife SSL check and ensure a successful message is displayed.

### Run Knife client list

Lastly, run a client list command to verify that a successful connection can be made to the new organization.

1. Run the following command: knife client list and ensure a validator entry is returned (Example: myorg-validator)
