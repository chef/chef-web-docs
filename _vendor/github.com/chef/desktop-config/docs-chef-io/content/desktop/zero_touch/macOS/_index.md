+++
title = "Enrolling the devices"
draft = false

[menu]
  [menu.desktop]
    title = "Enrollment"
    identifier = "desktop/zero_touch/macos/index.md Enrolling the devices"
    parent = "desktop/zero_touch/macos"
    weight = 10
+++


{{< note >}}
The application management documentation for Chef Desktop is under active development.
Check back for upcoming enhancements and improvements.
{{< /note >}}

## Introduction

The Chef Desktop management pattern allows you to manage all your macOS devices using a MicroMDM server for a fully automated experience.

If you have not done so, read [The Chef Desktop Development Pattern]({{< relref "infrastructure_overview.md" >}}) to familiarize yourself with some of the basic steps for getting started. We will repeat a number of those steps here.

## Overview

This document describes how to set up the following things:

- Install Chef Infra Server and Chef Automate
- Build your local repo and test Chef Desktop
- Build the InstallApplications package.
- Build the MDM server
- Build and deploy Munki to deploy apps to the laptops

## Setting up the MDM

We need a Mobile Device Management (MDM) service to capture macOS machines as they boot, and to securely connect and push applications and configuration settings to them. In this document we use MicroMDM, but there are others on the market like VMware Airwatch, SimpleMDM, and others.

Your configuration and setup may begin like this:

1. Stand up a new Linux instance in Azure or AWS and ensure that you use SSH keys
   for authentication rather than passwords.

1. Once the instance is running, upgrade the installed packages:

   ```powershell
   sudo apt-get update && sudo apt-get upgrade -y
   sudo reboot
   ```

1. Create a micromdm directory on the drive.

1. Clone MicroMDM from Github:

   ```powershell
   curl -L https://github.com/micromdm/micromdm/releases/download/v1.6.0/micromdm_v1.6.0.zip
   ```

1. Open a terminal window on the Linux box.

   ```powershell
   sudo apt-get install unzip
   unzip micromdm_v1.6.0.zip
   cd /micromdm/build/linux
   ./mdmctl config set -name <some name> -api-token <password> -server-url https://somefqdn
   ```

   Where:

   `-name`
   : is the label you choose to identify your MicroMDM server

   `-api-token`
   : is a password you will use to connect to your server to configure it

   `-server-url`
   : is the publicly accessible IP or FQDN of your created server

1. Start the MDM and note the password you use. You will need this password with `mdmctl` to configure the server.

   ```powershell
   sudo ./micromdm serve -server-url https://somefqdn/ -api-key <password>
   ```

1. There are three important certificates on your MDM server:

   - A TLS capable certificate that allows you to connect to your MDM server via port 443.
   - An APNS certificate, which is a Push certificate, that allows your MDM server to talk to your macOS clients.
   - A DEP certificate that allows your MDM server to talk to deploy.apple.com
     and accept incoming boot requests from Apple's servers.

### Securing the MDM

Read this [guide](https://github.com/micromdm/micromdm/blob/main/docs/user-guide/quickstart.md) which describes the steps necessary to create both the DEP and APNS certificates
that you need for your MicroMDM server.

## Initial App Deployment to a Node

`InstallApplication` is a stage in the Apple setup process that occurs between the time the display shows up for the user and when the user reaches the desktop for the first time.

[InstallApplications](https://github.com/macadmins/installapplications) (plural) is a corresponding application that will install applications or settings during that stage of configuration.

1. Start by loading these apps on your macOS machines:

   - The current release of Chef Infra Client
   - DepNotify

     [Depnotify](https://gitlab.com/Mactroll/DEPNotify) is an open source tool that tells users how much more time their macOS machine needs to install applications before they can starting using it.

   - Caffeinate

     [Caffeinate](https://ss64.com/osx/caffeinate.html) keeps the desktop active so that the screensaver does not turn on during installation. The screensaver will turn off network connections and break the setup if it activates.

   - [Chef Bootstrap](/install_bootstrap/)

     The last thing we pull down is a python script to configure the `chef/client.rb` file and run `chef-client` the first time to configure the laptop to its desired state and keep it in that state.

1. Install the latest version of [InstallApplications](https://github.com/macadmins/installapplications).

1. Modify the LaunchDaemon plist to look like the [first example](#example-munki-catalog) below. Notice that we updated the JSONUrl and a couple of the identity sections. Also notice that we enabled some of the commands needed to properly populate DepNotify so it displays useful information to the user.

1. Modify the build-info.json file on the identity line to correctly reference your developer certificate. Read the [InstallApplications documentation](https://github.com/erikng/installapplications/wiki/Packaging) for information about the type of accounts that Apple requires to install packages.

1. Use `munkipkg` to create the actual pkg file. See the [munkipkg documentation](https://github.com/munki/munki-pkg) for instructions.

1. Upload the compiled package to your MDM server.

1. Issue the following commands on your MDM:

   ```shell
   ~/mdm/build/linux/mdmctl apply app -pkg ~/Desktop/mdmvid/InstallApplications.pkg -sign "Developer ID Installer: groob (myid)" -upload

   [WARNING] package signing only implemented on macOS. An unsigned macOS package will not install with MDM.
   ```

1. In the example above, the developer ID should match the one you specify in the `build-info` file below.

## Signing Your Apps

Sign and/or notarize everything that the MDM server touches.
