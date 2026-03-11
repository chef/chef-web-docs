+++
title = "Setting up Gorilla for Application Management"
draft = false

[menu]
  [menu.desktop]
    title = "Application Management"
    identifier = "desktop/zero_touch/windows/application_management.md Setting up Gorilla for Application Management"
    parent = "desktop/zero_touch/windows"
    weight = 10
+++

{{< note >}}
The application management documentation for Chef Desktop is under active development.
Check back for upcoming enhancements and improvements.
{{< /note >}}

One of the great things about an automated management setup like this is the ability to actively manage the applications that show up on users' desktops. To handle applications on macOS, we use Munki. To handle applications for Windows, we use Gorilla. Our initial goal is to push a couple of required Apps out to our users.

The two apps will handle both managed installations and managed uninstallations. Also, Munki for macOS provides a ready-made application can display to users and offer them unmanaged apps. For Windows users, we will publish unmanaged apps via the private Microsoft Store.

### Create a CDN

To get started, follow this document to set up an Azure Content Delivery Network (CDN). After setting up, you will have an empty CDN. Use this empty CDN to host all the App content we want to deploy for both our Macs and Windows devices. We will need to set up slightly different directory and file structures for each OS type.

[Create an Azure CDN](https://docs.microsoft.com/azure/cdn/cdn-create-a-storage-account-with-cdn)

### Create Containers in your Storage Account

Now, create two containers in your storage account to hold the content for our users. For macOS devices, all content we want them to have - either 'managed' (we push it to them) or 'unmanaged' (users can download if they wish) goes here. For Windows users, only the managed content goes in the corresponding bucket and we will use the App Store to make things we license available to them.

1. Go to your storage account
1. Navigate to Blob Storage > Containers
1. Create 2 containers with one labeled "Munki" and the other labeled "Gorilla"
1. Set their access level to 'Container'

The next step is to create the basic directory structure in each container that the app clients expect to see. In the Gorilla container, create folders to match this structure. We are going to build the files that go in the folders just below. Just build the top level folders for both clients, the child folders are indicated in the example below to give you a reference of how the file structure will look over time as apps are added.

```shell
[Gorilla web root]
├── manifests
│   ├── *.yaml
├── catalogs
│   ├── *.yaml
└── packages
    ├── Firefox
    ├── Chrome
    ├── *.nupkg
    ├── *.msi
    ├── *.exe
    └── *.ps1
```

Now for your Munki container, build out a folder structure that looks like this:

```shell
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

## macOS (Munki) Catalog and Manifest

Spend some time thinking about and planning what you ultimately want to put into your manifests and catalogs that your users can access. For simplicity, we will demonstrate installing Firefox and VS Code on clients to give you an idea of how to deploy for each OS type.

### Install Munki

We are going to take a different approach with Munki because the configuration files are in XML and editing them directly can be fraught with peril so we are going to rely on using command line tools for the most part.

Get started by reviewing the [Munki documentation](https://github.com/munki/munki).

Next, [download Munki](https://github.com/munki/munki/releases) to your macOS and install it.

#### Set up a local File Share on your Mac

We are going to set up a local file share on your Mac. We will use the tools below to populate it with the settings and configuration we need. Follow this doc to set up a local repo, we will use Server Explorer to sync it to Azure - go to "Building a "server" repository"

For guidance, follow the [Munki setup demonstration](https://github.com/munki/munki/wiki/Demonstration-Setup).

### Configure Munki

Run this command to configure Munki. The repo path must match the one you created just above. Note that the path must have 3 slashes in it `file:///`

```bash
munkiimport --configure
```

Now you can import pkg files. When you import the first package, the catalog gets built for you automatically.

```bash
munkiimport - firefox
munkiimport - VSCode
```

Next, run the following `autopkg` commands to get all the Munki tools pulled in for the nodes (laptops) to use.`

```bash
autopkg repo-add recipes
autopkg run -k MUNKI_REPO=/Users/Shared/munki_repo munkitools4.munki
```

After that, run `makecatalogs` to pull the Munki updates in.

```bash
makecatalogs
```

Finally, run `manifestutil` to create the manifest and pull your apps under managed installs. If you run into issues with the tool, you can flip over to the MunkiAdmin GUI. The MunkiAdmin GUI makes it much easier to see what is going on with the configuration files.

```bash
/usr/local/munki/manifestutil
Entering interactive mode... (type "help" for commands)
> new-manifest site_default
> add-catalog my_catalog --manifest site_default
Added testing to catalogs of manifest site_default.
> add-pkg Firefox --manifest site_default
Added Firefox to section managed_installs of manifest site_default.
> add-pkg VSCode --manifest site_default
Added VSCode to section managed_installs of manifest site_default.
> add-pkg munkitools_admin --manifest site_default
Added munkitools_admin to section managed_installs of manifest site_default.
...
> exit
```

Now you can use Storage Explorer to move the entire thing into your Azure Blob Storage.

#### Example Munki Catalog

Below is a section of a Munki catalog. You CAN edit the details if needed, but using the tools above is strongly encouraged to reduce the probability of introducing an error.

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

Notice that the format for the Munki manifest is similar to what Gorilla uses:

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

You can also [use AWS for your CDN](https://github.com/grahamgilbert/terraform-aws-munki-repo).

Once you have your catalog and manifest ready, you can test this out from a macOS node by running the following commands from a terminal window. Run the first command from your macOS client to verify that the correct configuration got to that node and then run the second command to actually install the managed applications

```bash
sudo /usr/local/munki/managedsoftwareupdate --show-config

sudo /usr/local/munki/managedsoftwareupdate
```

## Windows (Gorilla) Catalog and Manifest

Spend some time thinking about and planning what you ultimately want to put into your manifests and catalogs that your users can access. For simplicity, we will demonstrate installing Firefox and VS Code on clients to give you an idea of how to deploy for each OS type.

### How Gorilla Operates

Save the `config.yaml` file to the `/files` directory of your Chef Desktop cookbook. Configuring the app resource in the Windows recipe file deploys the `config.yaml` setting to your Windows 10 desktops.  The next time Gorilla checks in with your CDN, it pull down the manifest, parses the applications and catalog listings for loading, and finally loads the applications by first loading the catalog(s) and then attempting to load the apps from the catalog(s). To see this in action, use `gorilla -d` from the command line to get the debug output.

[Gorilla Documentation](https://github.com/1dustindavis/gorilla)

#### Sample Gorilla catalog.yaml

```yaml
---
Chocolatey:
  display_name: Chocolatey
  check:
    file:
      - path: C:\ProgramData\chocolatey\choco.exe
        version: 0.10.15
  installer:
    hash: 0C1282378641E03564844D04881209AA946D7D2475049BE32B3151BD68F2758F
    location: packages/chocolatey/chocolatey_installer-1.0.ps1
    type: ps1
  version: 1.0

ChocolateyCoreExtension:
  dependencies:
    - Chocolatey
  display_name: Chocolatey Core Extension
  check:
    file:
      - path: C:\ProgramData\chocolatey\extensions\chocolatey-core\chocolatey-core.psm1
        hash: 376E6EDA567DDDD6AA70CFC9EC5380CE0EB1383BE83C2FBDC87F6FC79252E4E8
  installer:
    hash: 5ECEF3B776508CEBC4B52E9AC7F04D213C2045A6765F12E17545A5FBE2F41928
    location: packages/chocolatey/extensions/core/chocolatey-core.extension.1.3.5.1.nupkg
    type: nupkg
  version: 1.3.5.1

FireFox:
  display_name: Firefox
  check:
    file:
      - path: C:\Program Files\Mozilla Firefox\firefox.exe
        version: 75.0
  installer:
    hash: FF029F6E59D9D92D3AC5F8E837C973B641B3400980624D3A830DCFE55D4C71FC
    location: packages/firefox/Firefox Setup 75.0.exe
    arguments:
      - /S
      - /INI=c:\gorilla\cache\install.ini
    type: exe
  version: 75.0

VSCode:
  display_name: VSCode
  check:
    file:
      - path: C:\Program Files\Microsoft VS Code\Code.exe
        version: 1.45.1
  installer:
    location: packages/vscode/VSCodeSetup-x64-1.45.1.exe
    hash: E9E107CF53F8F06688C881E4616BD9A8553D012A657389399827E0EC2155633C
    arguments:
     - /VERYSILENT
     - /MERGETASKS=!runcode
    type: exe
  uninstaller:
    location: packages/vscode/VSCodeSetup-x64-1.45.1.exe
    hash: E9E107CF53F8F06688C881E4616BD9A8553D012A657389399827E0EC2155633C
    type: exe
  version: 1.45.1
```

#### Sample Gorilla Manifest.yaml

```yaml
---
name: my_manifest
managed_installs:
  - Chocolatey
  - ChocolateyCoreExtension
  - VSCode
  - Firefox

managed_uninstalls:

managed_updates:

included_manifests:

catalogs:
 - my_catalog
```

#### Sample Gorilla config.yaml file

```yaml
---
url: https://<your_cdn_name>.blob.core.windows.net/gorilla/
manifest: my_manifest
catalogs:
  - my_catalog
app_data_path: C:/gorilla/cache
```

### Configuring Apps in a Private Store for Windows

We talked about a second way to get apps to your users in Windows. That method involves you licensing apps and then letting your users have them through your Private Microsoft Store. Follow the directions here to make that work for you.

[Set up a Private Store in Azure](https://docs.microsoft.com/en-us/microsoft-store/distribute-apps-from-your-private-store)

## Final Checklist

You are almost ready to start the process. Please ensure that you have completed the following steps:

- [ ] You have set up Apple Business Manager
- [ ] You have imported the serial number for at least one of your macOS devices
- [ ] You have configured your MDM in Apple Business Manager to accept your devices
- [ ] You have set up and configured the MDM to accept devices from Apple Business Manager
  - [ ] You have all your certificates in place
  - [ ] You have built and uploaded the InstallApplications package and imported it into the MDM
- [ ] If you are going to use Munki, confirm if the S3 bucket is correctly configured for it.

If all goes according to plan, then you should be ready to reset/restart your first node, have it pull down all the packages and/or scripts, load Chef Infra Client, and do the first client run.

- Next: [Zero Touch Deployment with MicroMDM for macOS]({{< relref "../macOS/_index.md" >}})
