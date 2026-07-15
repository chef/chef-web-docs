+++
title = "Set up Chef Workstation"
draft = false

[menu]
  [menu.workstation_26_1]
    title = "Set up"
    identifier = "workstation_26_1/setup.md Set Up Chef Workstation"
    weight = 10
+++

This guide walks you through the four parts to set up Chef Workstation on your computer.

- [Set up your chef-repo](#set-up-your-chef-repo) for storing your cookbooks
- [Set up Chef Credentials](#set-up-chef-credentials)
- [Verify Client-to-Server Communication](#verify-client-to-server-communication)

## Prerequisites

- [Chef Workstation installed]({{< relref "install.md" >}})
- A running instance of Chef Infra Server.
- the `CLIENT.PEM` file supplied by your Chef administrator.

## Set up your Chef repo

If you're setting up Chef for the very first time **in your organization**, then you will need a Chef Infra repository for saving your cookbooks and other work.

The chef-repo is a directory on your workstation that stores everything
you need to define your infrastructure with Chef Infra:

- Cookbooks (including recipes, attributes, custom resources, libraries, and templates)
- Data bags
- Policyfiles

The chef-repo directory should be synchronized with a version control
system, such as git. All of the data in the chef-repo should be treated
like source code.

You'll use the `chef` and `knife` commands to upload data to the Chef
Infra Server from the chef-repo directory. Once uploaded, Chef Infra
Client uses that data to manage the nodes registered with the Chef Infra
Server and to ensure that it applies the right cookbooks, policyfiles,
and settings to the right nodes in the right order.

Use the [chef generate repo]({{< relref "ctl_chef.md#chef-generate-repo" >}}) command to create your Chef Infra repository. For example, to create a repository called `chef-repo`:

```bash
chef generate repo chef-repo
```

## Set up Chef credentials

The first time you run Chef Workstation, it creates a `.chef` directory in your user directory. The `.chef` directory is where you store your Chef Workstation configuration and client keys.

If you're setting up Chef Workstation **as a Chef Infra Server administrator**, manage users with the [Chef Infra Server CLI](/server/ctl_chef_server/#user-management). When you create a new user, Chef Infra Server generates a user-specific RSA client key that you must share securely with that user.

If you're setting up Chef Workstation **as a Chef user**, you need a client private key that your server administrator creates for you on Chef Infra Server. The client private key is an RSA private key in `.pem` format.

### Configure your user credentials

Your `.chef` directory contains a `credentials` file used by Knife to communicate with Chef Infra Server.

#### Prerequisites

To configure Knife to communicate with Chef Infra Server, you need the following values:

- `chef_server_url`: the full URL to your Chef Infra Server including the organization
- `node_name`: the client name your server administrator created for you

Your Chef administrator provides this information.

Use the `chef_server_url` and `node_name` values from this file when running `knife configure`.

#### Configure Knife automatically

To configure Knife to connect to Chef Infra Server:

```sh
knife configure
```

This command prompts you for your Chef Infra Server credentials and creates the necessary configuration files.

#### Configure Knife manually

To manually configure Knife to connect to Chef Infra Server:

1. Create the `~/.chef/credentials` file:

   ```sh
   mkdir -p ~/.chef
   touch ~/.chef/credentials
   ```

1. Add your Chef Infra Server credentials to the `~/.chef/credentials` file:

   ```toml
   [default]
   chef_server_url = "https://chef-server.example.com/organizations/org-name"
   client_name = "username"
   client_key = "~/.chef/certificate_file.pem"
   ```

   Replace the following:

   - `https://chef-server.example.com/organizations/org-name`: Your Chef Infra Server URL and organization name
   - `username`: Your Chef Infra Server username
   - `~/.chef/certificate_file.pem`: Path to your client certificate file

### Set up your client private key

All communication between Chef Workstation and Chef Infra Server is authenticated using an RSA public/private key pair. This pair is generated on Chef Infra Server and the private key must be copied to your local Chef Workstation installation for communication to function.

Your Chef administrator will provide you with your `client.pem` file. Copy this file to the `~/.chef` directory.

On macOS and Linux systems, this looks something like:

```bash
cp ~/Downloads/USERNAME.pem ~/.chef/
```

On Windows systems this, looks something like this:

```powershell
Copy-Item -Path C:\Users\MY_NAME\Downloads\USERNAME.pem -Destination C:\Users\MY_NAME\.chef\
```

## Verify client-to-server communication

To verify that Chef Workstation can connect to Chef Infra Server:

Run the following command on the command line:

```bash
knife client list
```

Which returns a list of clients similar to:

```bash
chef_machine
registered_node
```

### Fetch self-signed certificates

If your Chef Infra Server deployment is configured to use a self-signed certificate, download the Chef Infra Server TLS/SSL certificate and save it locally in `.chef/trusted_certs`:

1. Fetch the Chef Infra Server SSL certificates:

   ```sh
   knife ssl fetch
   ```

1. Verify the certificates:

   ```sh
   knife ssl check
   ```

Chef Infra verifies the security of all requests made to Chef Infra Server from tools like knife and Chef Infra Client. The certificate generated during the installation of Chef Infra Server is self-signed, meaning no certificate authority (CA) has signed it. You must download this certificate to every machine from which knife or Chef Infra Client will make requests to Chef Infra Server.

For more information about how knife and Chef Infra Client use SSL certificates generated by Chef Infra Server, see [Chef Infra Client's SSL certificates documentation](/client/latest/security/chef_client_security/#ssl-certificates).

## Next step

- [Add a Chef license](license)

## More information

- [Knife setup documentation](/workstation/26.1/tools/knife/knife_setup/)
- [Knife `config.rb` documentation](/workstation/26.1/tools/knife/config_rb)
- [`knife ssl fetch` documentation](/workstation/26.1/tools/knife/knife_ssl_fetch/)
- [`knife ssl check` documentation](/workstation/26.1/tools/knife/knife_ssl_check/)
