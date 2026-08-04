+++
title = "Supported platforms"
draft = false

[menu]
  [menu.client_19]
    title = "Supported platforms"
    identifier = "overview/chef_infra_client_platforms.md Supported Platforms"
    parent = "overview"
    weight = 30
+++

This page lists the operating system platforms supported by Chef Infra Client 19.

## Support definitions

### Certification tiers

**Validated & Supported**
: Platforms tested automatically as part of every CI/CD pipeline build. The full Chef test suite runs in both agent and agentless modes. Covered by paid maintenance contracts and eligible for 24/7 SLA support.

**Supported (Untested)**
: Platforms that aren't part of the CI/CD pipeline. These platforms are fully supported and bugs will be addressed, but issues may surface that aren't caught before release. Customers with active maintenance contracts are eligible for technical support.

**User Reported**
: Platforms reported as working by community members. Chef Engineering doesn't formally test these platforms as part of the development and release process. Support is provided on a best-effort basis and not all Chef resources may be compatible.

### Installer types

**Native**
: Chef is installed using the platform's native package manager—MSI on Windows, DEB on Debian/Ubuntu, RPM on RHEL/SUSE, PKG on macOS.

**Habitat**
: Chef is installed and run using [Chef Habitat](https://www.habitat.sh/) commands (`hab pkg install`) or by extracting a Habitat artifact (`.hart` or `.tar.gz`). Used for platforms where a native package isn't available or where a self-contained runtime is preferred.

### Agent and agentless modes

**Agent**
: Agent-based mode includes all software that runs directly on the managed node:

- Chef Infra Client
- Chef InSpec
- Chef Habitat supervisor
- Chef 360 skills running in agent mode, including Courier job execution and Node Management

**Agentless**
: Agentless mode includes all software that manages a node remotely without an agent present on the node:

- Chef Infra Client agentless mode (formerly Target Mode)—connects using SSH (Linux) or WinRM/SSH (Windows)
- Chef InSpec (remote scanning)
- Chef 360 Courier agentless job execution

## RHEL / Enterprise Linux family

| Platform | Architecture | Version | Tier | Agent | Agentless | Installer |
| --- | --- | --- | --- | --- | --- | --- |
| Red Hat Enterprise Linux | `x86_64`, `aarch64` | `7.x`, `8.x`, `9.x`, `10.x` | Validated & Supported | Yes | Yes | Native, Habitat |
| Red Hat Enterprise Linux | `s390x`, `ppc64le`, `ppc64` | `7.x`, `8.x` | Validated & Supported | No | Yes | Habitat |
| CentOS | `x86_64`, `aarch64` | `7.x` | Validated & Supported | Yes | Yes | Native, Habitat |
| CentOS | `ppc64le`, `ppc64` | `7.x` | Validated & Supported | No | Yes | Habitat |
| Oracle Enterprise Linux | `x86_64`, `aarch64` | `7.x`, `8.x` | Validated & Supported | Yes | Yes | Native, Habitat |
| Amazon Linux | `x86_64`, `aarch64` | `2.x`, `2023` | Validated & Supported | Yes | Yes | Native, Habitat |
| Rocky Linux | `x86_64`, `aarch64` | `8.x`, `9.x` | Supported (Untested) | Yes | Yes | Habitat |
| AlmaLinux | `x86_64`, `aarch64` | `8.x`, `9.x`, `10.x` | Supported (Untested) | Yes | Yes | Habitat |
| CentOS Stream | `x86_64`, `aarch64` | current non-EOL releases | User Reported | Yes | Yes | Habitat |
| Fedora | `x86_64`, `aarch64` | current non-EOL releases | User Reported | Yes | Yes | Habitat |

## Debian / Ubuntu family

| Platform | Architecture | Version | Tier | Agent | Agentless | Installer |
| --- | --- | --- | --- | --- | --- | --- |
| Debian | `x86_64`, `aarch64` | `10`, `11` | Validated & Supported | Yes | Yes | Native, Habitat |
| Ubuntu (LTS releases) | `x86_64`, `aarch64` | `18.04`, `20.04`, `22.04`, `24.04` | Validated & Supported | Yes | Yes | Native, Habitat |
| Kali Linux | `x86_64` | current non-EOL releases | User Reported | Yes | Yes | Habitat |
| Linux Mint | `x86_64` | current non-EOL releases | User Reported | Yes | Yes | Habitat |
| Pop!_OS | `x86_64` | current non-EOL releases | User Reported | Yes | Yes | Habitat |
| Raspberry Pi OS | `aarch64` | current non-EOL releases | User Reported | Yes | Yes | Habitat |
| Ubuntu (non-LTS) | `x86_64`, `aarch64` | current non-LTS releases | User Reported | Yes | Yes | Habitat |

## SUSE family

| Platform | Architecture | Version | Tier | Agent | Agentless | Installer |
| --- | --- | --- | --- | --- | --- | --- |
| SUSE Linux Enterprise Server | `x86_64`, `aarch64` | `12`, `15` | Validated & Supported | Yes | Yes | Native, Habitat |
| SUSE Linux Enterprise Server | `s390x` | `12`, `15` | Validated & Supported | No | Yes | Habitat |
| openSUSE | `x86_64`, `aarch64` | `15.x` | User Reported | Yes | Yes | Habitat |
| SUSE Linux Enterprise Desktop | `x86_64`, `aarch64` | `12.x`, `15.x` | User Reported | Yes | Yes | Habitat |

## Windows

| Platform | Architecture | Version | Tier | Agent | Agentless | Installer |
| --- | --- | --- | --- | --- | --- | --- |
| Windows | `x86_64` | `10`, `11`, Server `2016`, `2019` (LTSC), `2022`, `2025` | Validated & Supported | Yes | Yes | Native (MSI) |
| Windows Server, Semi-annual channel (SAC) | `x64` | Server Core only | User Reported | Yes | Yes | Habitat |

## macOS

| Platform | Architecture | Version | Tier | Agent | Agentless | Installer |
| --- | --- | --- | --- | --- | --- | --- |
| macOS | `aarch64` | `13.x`, `14.x` | Validated & Supported | Yes | Yes | Native |

## IBM AIX

| Platform | Architecture | Version | Tier | Agent | Agentless | Installer |
| --- | --- | --- | --- | --- | --- | --- |
| IBM AIX | `powerpc` | `7.1` (TL5 SP2 or higher), `7.2`, `7.3` | Validated & Supported | No | Yes | Habitat |

## Oracle Solaris

| Platform | Architecture | Version | Tier | Agent | Agentless | Installer |
| --- | --- | --- | --- | --- | --- | --- |
| Oracle Solaris | `i86pc` | `11.3` (16.17.4 and later only), `11.4` | Validated & Supported | Yes | Yes | Habitat |
| Oracle Solaris | `sparc` | `11.3` (16.17.4 and later only), `11.4` | Validated & Supported | No | Yes | Habitat |

## FreeBSD

| Platform | Architecture | Version | Tier | Agent | Agentless | Installer |
| --- | --- | --- | --- | --- | --- | --- |
| FreeBSD | `amd64` | `13.x` | Validated & Supported | Yes | Yes | Habitat |

## Specialized and network Linux

| Platform | Architecture | Version | Tier | Agent | Agentless | Installer |
| --- | --- | --- | --- | --- | --- | --- |
| Arista EOS | `x86_64` | current non-EOL releases | User Reported | Yes | Yes | Habitat |
| Cumulus Linux | `x86_64` | current non-EOL releases | User Reported | Yes | Yes | Habitat |
| XCP-ng | `x86_64` | `8.x` | User Reported | Yes | Yes | Habitat |

## Other community platforms

| Platform | Architecture | Version | Tier | Agent | Agentless | Installer |
| --- | --- | --- | --- | --- | --- | --- |
| Alibaba Cloud Linux | `x86_64` | `2.x` | User Reported | Yes | Yes | Habitat |
| Arch Linux | `x86_64` | current version | User Reported | Yes | Yes | Habitat |
| Clear Linux | `x86_64` | current non-EOL releases | User Reported | Yes | Yes | Habitat |
| OpenIndiana Hipster | `x86_64` | current non-EOL releases | User Reported | Yes | Yes | Habitat |
| SmartOS | `x86_64` | current non-EOL releases | User Reported | Yes | Yes | Habitat |
| Virtuozzo | `x86_64` | current non-LTS releases | User Reported | Yes | Yes | Habitat |
