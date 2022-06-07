+++
title = "Enrolling the devices"
draft = false

[menu]
  [menu.desktop]
    title = "Enrollment"
    identifier = "desktop/zero_touch/windows/index.md Enrolling the devices"
    parent = "desktop/zero_touch/windows"
    weight = 10
+++

{{< note >}}
The application management documentation for Chef Desktop is under active development.
Check back for upcoming enhancements and improvements.
{{< /note >}}

Chef Software's Desktop pattern and tools expands familiar device management systems with extensive application and configuration capabilities that are designed to scale with automation.

Chef Desktop provides a cookbook with YAML settings that covers the most common (and some less common) device configuration needs. Of course, we continue to support and improve our classic Ruby cookbook customizations for when you need to go beyond the ordinary. The Chef Desktop pattern sets you up to manage applications with a CDN, so even when one thousand devices in your fleet means managing ten thousand applications, your Windows and macOS users can still access them through a unified catalog. Chef Desktop uses Chef Software's leading tools, providing observability, compliance reporting, and an audit trail as part of the process.

This guide covers automating the Chef Desktop pattern to manage your macOS and Windows devices.

## Configuration Overview

A work triangle is in play in Chef Desktop. The first leg is the Chef Infra Server with Chef Automate that holds and applies configurations to your nodes. The second leg is a Developer node running Chef Workstation from which you create and define the policies and settings that the Chef Infra Server metes out. The third leg of the triangle is the list of nodes to which the various polices and settings are applied.

The automation process follows these steps:

1. A node, such as a laptop or desktop, boots up the very first time and checks in with either Apple Business Manager (ABM) or Azure.
1. ABM or Azure reports the device as managed and redirects it to Microsoft Intune for management.
1. Microsoft Intune captures and provisions the device in the time between a user selecting **next** on the sign in screen and the desktop opening.

This guide helps you:

- Build out your Azure Instance
- Build a InstallApplications package to bootstrap macOS
- Build and deploy Munki to deploy apps to the macOS devices
- Write the PowerShell scripts needed to bootstrap Windows
- Build and deploy Gorilla to deploy apps to Windows devices

## Prerequisites

This guide assumes you have completed the previous steps:

1. [Install Chef Components]({{< relref "/desktop/install.md">}})
2. [Chef Desktop Cookbook Development Environment]({{< relref "desktop-cookbook.md" >}})
3. [The Chef Desktop Development Pattern]({{< relref "infrastructure_overview.md">}})

### Required Software

Integrating Chef Desktop with Microsoft Intune and Windows Autopilot software and subscriptions as well as specific software for macOS and Windows systems.

The solution in this guide requires:

[Microsoft Azure](https://azure.microsoft.com)
: If you do not already have one, sign up for an [Azure account](https://azure.microsoft.com)

[Microsoft Intune](https://www.microsoft.com/microsoft-365/enterprise-mobility-security/microsoft-intune)
: Microsoft Intune is a cloud-based service that you will use to capture and push configuration to devices.

[Windows Autopilot](https://docs.microsoft.com/windows/deployment/windows-autopilot/windows-autopilot)
: Windows Autopilot simplifies the IT-side of managing Windows devices.

#### macOS

[Apple Enterprise Developer Account](https://developer.apple.com/programs/enterprise/)
: This program allows for macOS devices to be auto-assigned to an MDM service, which then provisions the devices for you. The Apple Developer Enterprise Program is a program that supports large organizations in developing and deploying proprietary, internal-use apps to their employees. You may find mentions of Apple Device Enrollment Program (DEP) elsewhere, which is the predecessor to ABM and used interchangeably with ABM.

[AutoPkg](https://github.com/autopkg/autopkg)
: AutoPkg is an automation framework for macOS software packaging and distribution, oriented towards the tasks one would perform manually to prepare third-party software for mass deployment to managed clients.

[Munki](https://www.munki.org/munki/)
: Munki is an [open source project](https://github.com/munki/munki) from Walt Disney Animation Studios. It is a set of tools for managing applications on macOS computers.

[MunkiAdmin](https://github.com/hjuutilainen/munkiadmin/releases/)
: MunkiAdmin is a graphical user interface (GUI) for managing munki repositories

[Storage Explorer](https://azure.microsoft.com/features/storage-explorer/)
: Storage Explorer is a free tool from Microsoft for managing your Azure cloud storage resources.

#### Windows

[Gorilla](https://github.com/autopkg/autopkg/releases)
: Gorilla is an [open source project](https://github.com/1dustindavis/gorilla). It is a set of tools for managing applications on Windows computers.

[Storage Explorer](https://azure.microsoft.com/features/storage-explorer/)
: Storage Explorer is a free tool from Microsoft for managing your Azure cloud storage resources.

## Setup Azure

### Configure Microsoft Intune and Active Directory

First, read about [setting up Microsoft Intune](https://docs.microsoft.com/mem/intune/fundamentals/setup-steps)

You will want to spend a bit of time going through that document to get your Microsoft Intune and Azure Active Directory instances configured.

### Register Devices in Azure

The fastest and best way to set up a macOS device is by never physically touching it.

In this case, you will sign on to Apple Business Manager and use the article above to set up Azure as the MDM which receives the laptops and other devices you wish to manage.

#### Windows Options

First, read about [getting started with Windows Autopilot](https://docs.microsoft.com/en-us/mem/intune/enrollment/enrollment-autopilot)

For Windows devices, Azure acts as both the enrollment service and the MDM at the same time. Also, current iterations of Windows 10 will bootstrap from Azure when the correct settings from a laptop are captured.

##### Dynamic Device Management

Use dynamic device groups to capture both macOS and Windows devices and automatically assign profiles and configuration policies. Dynamic device groups are essential for macOS devices and Windows-kiosk style devices, because all devices in the groups are assigned the correct policies.

[Create an Autopilot Dynamic Device Group](https://docs.microsoft.com/en-us/mem/autopilot/enrollment-autopilot#create-an-autopilot-device-group)

##### Dynamic User Management

But what happens if you want more flexibility to manage the users instead of devices? This approach creates a user group that applies the same policies to individuals. That way, if a user logs onto a different system their account is still managed correctly.

[Create a Dynamic User Group](https://docs.microsoft.com/en-us/azure/active-directory/users-groups-roles/groups-dynamic-membership)

#### OS X Options

[OSX Auto Enrollment](https://docs.microsoft.com/en-us/mem/intune/enrollment/device-enrollment-program-enroll-ios)

This article walks you through the configuration of Windows Autopilot and Microsoft Intune to ingest macOS devices as they boot the first time.

### Create Device Groups

You will need to create two device groups for macOS devices and two for Windows (a total of four device groups). You will use the first device group to apply the initial enrollment profile. The second device group is for applying, updating, and removing packages, scripts, etc. on the devices.

### Create Enrollment/Deployment Profiles

Now that you have your systems listed in Azure, we need to get them under an enrollment or deployment profile. This initial configuration of the device will bring it under management.

First, read about [getting started with Microsoft Intune](https://docs.microsoft.com/mem/intune/enrollment/enrollment-autopilot)

### Configuration Scripts

For Windows devices, develop your PowerShell configuration scripts to create and populate the `validation.pem` file and the `client.rb` file in the `c:\chef` directory. You will also want to install the Chef Infra Client.

### Registering the Devices with Chef Infra Server

The `knife` command-line tool provides an interface for interacting with a Chef Infra Server from a local workstation. You'll use two `knife` commands from your developer workstation to the Chef Infra Server. The first command creates the node on the Chef Infra Server, and the second assigns a Chef policy to that node.

```powershell
# knife node policy set SERIAL_NUMBER_OR_FQDN 'NODE_GROUP' 'POLICYFILE'

knife node create S90T7HK2
Created node [S90T7HK2]
knife node policy set S90T7HK2 'Windows_Node_Policy_Group' 'ChefDesktop'
Successfully set the policy on node S90T7HK2
```

### Re-Registering the Devices with Chef Infra Server

During testing--and in any other time that you change the contents of a device--you may need to re-register it. Follow these steps to re-register a device:

```powershell
# Chef Infra Server distinguishes between a Node object and a Client object
knife node delete S90T7HK2
Deleted node [S90T7HK2]
knife client delete S90T7HK2
Deleted client [S90T7HK2]
knife node create S90T7HK2
Created node [S90T7HK2]
knife node policy set S90T7HK2 'Windows_Node_Policy_Group' 'desktop-config'
Successfully set the policy on node S90T7HK2
```
