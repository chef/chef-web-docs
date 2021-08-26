+++
title = "Set up Automate Server"
draft = false

[menu]
  [menu.desktop]
    title = "Automate Server"
    identifier = "desktop/install/automate_server.md Set up Automate Server"
    parent = "desktop/install"
    weight = 20
+++

We recommend starting with a clean installation of Chef Automate, Chef Infra Server, and Chef Desktop. Combining existing Chef Automate nodes with new Chef Desktop leads to significant confusion, because the servers do not distinguish between the types of nodes that they mange.

For the purposes of this demonstration, we recommend installing Chef Automate and Chef Infra Server together on the same host. Talk to your account representative to decide if you should follow a different deployment pattern in production.

{{<note>}}
Proceed with the instructions provided in the following sections after you have logged in to the server where you want to install and set up Automate.
{{</note>}}

## Prepare the System

In your clean Linux environment, update and install the system packages:

```bash
apt-get -qq update
apt-get install -y --no-install-recommends
apt-get clean
```

The Chef Automate installation requires the following settings:

```bash
sysctl -w vm.max_map_count=262144
sysctl -w vm.dirty_expire_centisecs=20000
```

## Download Automate and install with Desktop dashboard

Download the Chef Automate CLI:

```bash
curl https://packages.chef.io/files/current/latest/chef-automate-cli/chef-automate_linux_amd64.zip | gunzip - > chef-automate
chmod +x chef-automate
```

Deploy the packages with the following command:

```bash
sudo chef-automate deploy --product automate --product infra-server --product desktop --accept-terms-and-mlsa
```

*You will need the host names and user information later in this guide. They are located them in the `automate-credentials.toml`.*

## Configure the Infra server

You need run these commands as an administrator or use `sudo` before each command.

***Note**: You will need information from both of these commands. Copy them from your command line to a file. Store the file securely.*

```powershell
chef-server-ctl user-create USER_NAME FIRST_NAME LAST_NAME EMAIL 'PASSWORD' --filename USER_NAME.pem
```

Create an organization:

```powershell
chef-server-ctl org-create SHORT_NAME 'FULL_ORGANIZATION_NAME' --association_user USER_NAME --filename ORGANIZATION-validator.pem
```

Transfer the generated user and validator keys to your workstation and put them in the `.chef` directory. If you already logged out of the server, you can read the next section on key management to find instructions on how to transfer them to your local workstation.

## Key Management

"Key management" is a software term that means "Safely and securely getting the right credentials from remote and local computers into the right directories--usually, but not always, on your local computer--in order to use software to run commands between computers".

We recommend using a secure copy protocol (SCP) to move the public key and configuration file from the Chef Infra Server to the `.chef` directory on your workstation.

- macOS workstations should have the `scp` command,
- Windows workstations will need to install [WinSCP](https://winscp.net/eng/index.php) or another similar tool.

  - The public key is `ORGANIZATION-validator.pem`
  - The configuration file is `config.toml`

*This step is the reason that you copied output of the above commands to files.* To manage your keys and credentials, you need to know:

- The host name (also called a FQDN) or ip of the Chef Infra Server
- The user name on the Chef Infra Server
- The password on the Chef Infra Server

### Transfer Keys on Windows Workstations

1. Install WinSCP
1. Open the program using the icon on your workstation desktop.
1. Select **SCP** as the file protocol
1. Set port **22**
1. Fill in the host name, the user name, and the password that you created on your Chef Infra Server.

### Transfer Keys on macOS Workstations

macOS systems come with `scp` installed. Download the key and configuration files:

```bash
scp user_name@chef-automate.test:/remote/ORGANIZATION-validator.pem ~/.chef
scp user_name@chef-automate.test:/remote/config.toml ~/.chef
```

### More Information on SCP

[SCP for macOS](https://linuxize.com/post/how-to-use-scp-command-to-securely-transfer-files/)
: SCP is used to move files between your workstation to a remote computer. It uses ssh for data transfer. `scp` asks for passwords or passphrases if needed for authentication.

[WinSCP for Windows](https://winscp.net/index.php)
: WinSCP is an open source application for Windows used to move files between your workstation and a remote computer. WinSCP offers scripting and basic file manager functionality. The download page has many junk buttons, make sure you select **Download WinSPC**.

[SCP on Azure](https://docs.microsoft.com/azure/virtual-machines/linux/copy-files-to-linux-vm-using-scp)
: SCP on Azure is used to move files from your workstation up to an Azure Linux VM, or from an Azure Linux VM down to your workstation.

- Next: [Chef Desktop Cookbook Development Environment]({{< relref "cookbook_repository.md" >}})
- Last: [Chef Desktop Requirements]({{< relref "requirements.md" >}})
