+++
title = "Setting up Munki and AutoPkg for Application Management"
draft = false

[menu]
  [menu.desktop]
    title = "Application Management"
    identifier = "desktop/zero_touch/macOS/application_management.md Setting up Munki and AutoPkg for Application Management"
    parent = "desktop/zero_touch/macOS"
    weight = 10
+++

One of the great things about an automated management setup like this is being
able to actively manage the applications that show up on user's desktops. To handle
that on macOS we use Munki. Our initial goal is to push a couple of required
applications out to our users.

Munki will handle managed installations and uninstallations.
Munki also provides a ready-made application that offers users
unmanaged applications that they can download if they choose.

### Create a CDN to hold the content

To get started, follow [these instructions](https://docs.microsoft.com/azure/cdn/cdn-create-a-storage-account-with-cdn)
for setting up an empty Azure CDN or [these instructions](https://github.com/grahamgilbert/terraform-aws-munki-repo)
for setting up an empty AWS CDN. This empty CDN will host all the application content
that will be deployed for both macOS and Windows devices. However, each OS type
requires a slightly different directory and file structure.

### Create containers in your Storage account

Create a container in the storage account to hold the content for users.
For macOS, all the content, either managed or unmanaged, goes here.

1. Go to your storage account
1. Navigate to Blob Storage -> Containers.
1. Create a container labeled Munki
1. Set the access level to 'Container'

Next, create the basic directory structure in each container that
the app clients expect to see. In the Gorilla container, create folders to match
this structure. We're going to build the files that go in the folders just below.
Build the top level folders for both clients, the child folders are indicated to
give you a reference of how the whole thing looks over time as applications are
added.

Build out a folder structure that looks like this:

```yaml
[Munki web root]
├── catalogs
│   ├── *.yaml
├── manifests
│   ├── *.yaml
├── icons
│   ├── *.ico
├── pkgsinfo
│   ├── *.*
└── pkgs
    ├── *.pkg
```

### Create a Catalog and Manifest for your Clients

These steps demonstrate installing Firefox and VS Code on clients to give you an
idea of how to deploy an application on each OS type.

#### Munki Setup

With [Munki](https://github.com/munki/munki), the configuration files are in XML and editing them directly
can produce errors so we recommend using command line tools.

1. Install the Munki tools locally

   [Download](https://github.com/munki/munki/releases) the whole Munki package to the macOS machine and install it.

1. Setup a local File Share on the macOS machine

   Setup a local file share on the macOS machine. Use the tools below to populate it
   with the settings and configuration you need. Follow this [document](https://github.com/munki/munki/wiki/Demonstration-Setup) to setup a local
   repo, use Server Explorer to sync it to Azure - go to "Building a "server" repository"

1. Configure Munki

   Run this command to configure Munki. The repo path must match the one you created
   above. Note that the path must have 3 slashes in it, e.g. "file:///".

   ```bash
   munkiimport --configure
   ```

1. Now import the pkg files. When you import the first package the catalog will build automatically.

   ```bash
   munkiimport - firefox
   munkiimport - VSCode
   ```

1. Next, run the following Autopkg commands to get all the Munki tools pulled in
   for the nodes (laptops) to use

   ```bash
   autopkg repo-add recipes
   autopkg run -k MUNKI_REPO=/Users/Shared/Munki_repo Munkitools4.Munki
   ```

1. After that, run `makecatalogs` to pull the Munki updates in:

   ```bash
   makecatalogs
   ```

1. Finally, run `manifestutil` too create the manifest and pull your apps under
   managed installs. If you run into issues with the tool, use the MunkiAdmin GUI.
   It makes it much easier to see what's going on with the configuration files.

   ```bash
   /usr/local/Munki/manifestutil
   Entering interactive mode... (type "help" for commands)
   > new-manifest site_default
   > add-catalog my_catalog --manifest site_default
   Added testing to catalogs of manifest site_default.
   > add-pkg Firefox --manifest site_default
   Added Firefox to section managed_installs of manifest site_default.
   > add-pkg VSCode --manifest site_default
   Added VSCode to section managed_installs of manifest site_default.
   > add-pkg Munkitools_admin --manifest site_default
   Added Munkitools_admin to section managed_installs of manifest site_default.
   ...
   > exit
   ```

Now you can use Storage Explorer to move the entire thing into your Azure Blob Storage

#### Example Munki Catalog

Below is a section of a Munki catalog. You can manually edit the details if you
need to, but we strongly encourage you to use the tools above to reduce the
chances of introducing an error.

```xml
<plist version="1.0">
    <array>
        <dict>
            <key>autoremove</key>
            <false/>
            <key>catalogs</key>
            <array>
              <string>mycatalog</string>
            </array>
            <key>display_name</key>
            <string>VSCode</string>
            <key>installed_size</key>
            <integer>1285143</integer>
            <key>installer_item_hash</key>
            <string>
              b9a5b90ff2b0bb733a9b719fe2afea5d5dc02875dc96b969a9fcf8b9de9214a6
            </string>
            <key>installer_item_location</key>
            <string>VSCode.pkg</string>
            <key>installer_item_size</key>
            <integer>513821</integer>
            <key>minimum_os_version</key>
            <string>10.5.0</string>
            <key>name</key>
            <string>VSCode</string>
            <key>receipts</key>
            <array>
                <dict>
                    <key>installed_size</key>
                    <integer>1285143</integer>
                    <key>packageid</key>
                    <string>com.microsoft.visual-studio</string>
                    <key>version</key>
                    <string>8.5.2</string>
                </dict>
            </array>
            <key>unattended_install</key>
            <true/>
            <key>uninstall_method</key>
            <string>removepackages</string>
            <key>uninstallable</key>
            <true/>
            <key>version</key>
            <string>1.45.1</string>
            </dict>
```

#### Example Munki Manifest

Notice that the format for the manifest is similar to what Gorilla uses:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
        <key>catalogs</key>
        <array>
                <string>my_catalog</string>
        </array>
        <key>included_manifests</key>
        <array>
        </array>
        <key>managed_installs</key>
        <array>
                <string>munkitools_app</string>
                <string>munkitools_app_usage</string>
                <string>munkitools_core</string>
                <string>munkitools_launchd</string>
                <string>Firefox</string>
                <string>VSCode</string>
        </array>
        <key>managed_uninstalls</key>
        <array>
        </array>
        <key>managed_updates</key>
        <array>
        </array>
        <key>optional_installs</key>
        <array>
        </array>
</dict>
</plist>
```

Now that the catalog and manifest are ready, test this out from a
macOS node by running the following commands from a terminal window.

Run the first command from the macOS client to verify that the correct configuration
got to that node and then run the second command to actually install the managed applications.

```bash
sudo /usr/local/munki/managedsoftwareupdate --show-config

sudo /usr/local/munki/managedsoftwareupdate
```

## Final Checklist

You are almost ready to start the process. Please ensure that you have completed the following steps:

- [ ] You have setup Apple Business Manager
- [ ] You have imported the serial number for at least one of your macOS machine
- [ ] You have configured your MDM server in Apple Business Manager to accept your devices
- [ ] You have setup and configured the MDM to accept devices from Apple Business Manager
  - [ ] You have all your certificates in place
  - [ ] You have built and uploaded the InstallApplications package and imported it into the MDM
- [ ] If you are going to use Munki, is the S3 bucket correctly configured for it?

## Bootstrapping the first Node

If all goes according to plan, the first node should be ready to restart,
pull down all the packages and/or scripts, load Chef Infra Client, and do the
first client run.
