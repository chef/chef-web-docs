+++
title = "Chef SaaS Overview"
draft = false

[cascade]
  product = ["saas"]

[menu]
  [menu.saas]
    title = "Overview"
    identifier = "chef_infra/Overview"
    parent = "chef_saas"
    weight = 10
+++

This guide is a quick start for Chef SaaS.

## Quick Start for Automate SAAS

Steps to start your Automate SaaS journey is given below:

{{< note >}} Prerequisites: Workstation setup already installed. {{< /note >}}

1. Once you have the credentials, verify it by logging in to the environment through the Automate user interface.

1. Once you have logged in, test the `admin` user and connect their Workstation to SaaS.

If you do not have a workstation setup, follow the steps given below:

1. [Install](https://downloads.chef.io/tools/workstation) Chef Workstation.

1. You will receive an e-mail in your provided mail id. The e-mail contains the server information. Use the server information to create your connection to Automate SaaS.

1. Once you are connected, start connecting the nodes to Automate SaaS.

## Workstation Test

To start with the Workstation Test, go through the [Getting Started](https://docs.chef.io/workstation/getting_started/) section of Workstation.

### Configure Your User Credentials File

Your `.chef` directory contains a credentials file for communicating with the **Chef Infra Server**. You can generate the `.chef` file by running Knife Configure or by following the prompts.

The knife configure command requires the following values:

* **Chef Server URL:** The full URL to your Chef Infra Server including the `org`.
* **Client Name:** The client name of the Server Administrator created for you.

Your Chef administrator should provide the following information:

```sh
current_dir = File.dirname(__FILE__)
log_level                :info
log_location         	STDOUT
node_name            	"hshefu"
client_key           	"#{current_dir}/hshefu.pem"
chef_server_url      	https://api.chef.io/organizations/4thcafe-web-team
cookbook_path            ["#{current_dir}/../cookbooks"]
```

Use the `chef_server_url` and `node_name` values from the file when running knife configure.

## Verify Client-to-Server Communication

To verify that the Chef Workstation can connect to the Chef Infra Server:

Run the following command on the command line:

### Knife Client List

### Workstation Setup

1. To set up the workstation on your instance follow these steps:

    * Install the latest version of Chef Workstation on the Ubuntu system. Install the version using the command shown below:

    ```sh
    wget https://packages.chef.io/files/stable/chef-workstation/21.2.524/ubuntu/20.04/chef-workstation_21.2.524-1_amd64.deb
    ```

    * For Deb packaging run the following command:

    ```sh
    dpkg -i chef-workstation_21.2.524-1_amd64.deb
    ```

    * Verify installation by running the following command:

    ```sh
    chef -v
    ```

    For additional information refer to the [Install Workstation](https://docs.chef.io/workstation/install_workstation/) page.

    * Generate `chef-repo` using the following command:

    ```sh
    chef generate repo chef-repo
    ```

    For additional information refer to the [Getting Started](https://docs.chef.io/workstation/getting_started/) page of Workstation.

    * Paste the `pem` file of user inside `/root/.chef/<pem_file_of_user>`.

    * Paste the `pem` file of node you want to bootstrap inside `/root/.ssh/<pem_file_of_node>`.

    * Edit credentials file using the following command:

    ```sh
    vi /root/.chef/credentials
    ```

    Provide the name of the user created in **chef_server**, the correct path of `pem` file of the user, and the chef server URL and organization name.

    ```sh
    [default]
    client_name = "<name_of_user>"
    client_key = "/root/.chef/<pem_file_of_user>"
    chef_server_url = "https://demo-server.saas.chef.io/organizations/<name_of_organization>/"
    ```

    * Run bootstrap command using the following command:

    ```sh
    knife bootstrap <Public_ip> -i ~/<pem_file_of_node> -U ubuntu -N <name_of_node> --sudo
    ```

* **Public IP**: Public IP is the IP address of node which we are bootstrapping.

* **pem_file_of_node**: `pem` file of node which we have saved at `/root/.ssh/<pem_file_of_node>`.

* **name_of_node**: You can provide any name to your node.
