+++
title = "Supported platforms"
draft = false
gh_repo = "chef-web-docs"

swiftype_search_products = ["automate", "client", "server", "habitat", "inspec", "workstation"]

[menu]
  [menu.overview]
    title = "Supported platforms"
    identifier = "overview/packages_&_platforms/platforms.md Platforms"
    parent = "overview/packages_&_platforms"
    weight = 20
+++

## Support definitions

### Certification tiers

**Validated & Supported**
: Platforms tested automatically as part of every CI/CD pipeline build. The full Chef test suite runs in both agent and agentless modes. Covered by paid maintenance contracts and eligible for 24/7 SLA support.

**Supported (Untested)**
: Platforms that are not part of the CI/CD pipeline. These platforms are fully supported and bugs will be addressed, but issues may surface that are not caught before release. Customers with active maintenance contracts are eligible for technical support.

**User Reported**
: Platforms reported as working by community members. Chef Engineering does not formally test these platforms as part of the development and release process. Support is provided on a best-effort basis and not all Chef resources may be compatible.

### Installer types

**Native**
: Chef is installed using the platform's native package manager — MSI on Windows, DEB on Debian/Ubuntu, RPM on RHEL/SUSE, PKG on macOS.

**Habitat**
: Chef is installed and run using [Chef Habitat](https://www.habitat.sh/) commands (`hab pkg install`) or by extracting a Habitat artifact (`.hart` or `.tar.gz`). Used for platforms where a native package is not available or where a self-contained runtime is preferred.

### Agent and agentless modes

**Agent** 
: Agent-based mode includes all software that runs directly on the managed node:

- Chef Infra Client
- Chef InSpec
- Chef Habitat supervisor
- Chef 360 skills running in agent mode, including Courier job execution and Node Management

**Agentless** 
: Agentless mode includes all software that manages a node remotely without an agent present on the node:

- Chef Infra Client agentless mode (formerly Target Mode) — connects via SSH (Linux) or WinRM/SSH (Windows)
- Chef InSpec (remote scanning)
- Chef 360 Courier agentless job execution

Chef software is supported on the operating systems (platforms) listed below.
To see which versions of our software we currently support, see the [Supported Versions](/versions/) page.

## Platforms

The sections below list the platforms that Chef Software supports.

### Chef Automate

#### Commercial support

Commercial support for the [Chef Automate](/automate/system_requirements/) is available for platforms that use:

- a Linux kernel version of 3.2 or greater
- `systemd` as the init system
- `useradd`
- `curl` or `wget`

### Chef Automate HA

#### Commercial support

See the [Chef Automate HA supported platforms](/automate/ha_on_premises_deployment_prerequisites/#software-requirements)
documentation for a list of supported platforms for Chef Automate HA.

### Chef Backend

#### Commercial support

The following table lists the commercially supported platforms for Chef Backend, which is the high-availability solution for Chef Infra Server.

| Platform | Version | Architecture |
| --- | --- | --- |
| CentOS | `6.x`, `7.x`, `8.x` | `x86_64` |
| Oracle Enterprise Linux | `7.x`, `8.x` | `x86_64` |
| Red Hat Enterprise Linux | `6.x`, `7.x`, `8.x` | `x86_64` |
| SUSE Linux Enterprise Server | `12.x` | `x86_64` |
| Ubuntu (LTS releases) | `16.04`, `18.04` | `x86_64` |

#### Derived platforms

| Platform | Version | Architecture | Parent platform |
| --- | --- | --- | --- |
| AlmaLinux | `8.x` | `x86_64` | CentOS |
| Rocky Linux | `8.x` | `x86_64` | CentOS |

### Chef Infra Client

See the [Chef Infra Client supported platforms](/client/19/install/platforms/) documentation for the full list of supported platforms, certification tiers, and installer types.

### Chef Infra Server

#### Commercial support

{{< readfile file="content/server/reusable/md/adopted_platforms_server.md" >}}

### Chef InSpec

See the [Chef InSpec documentation](/inspec/latest/).

### Chef Workstation

#### Commercial support

The following table lists the commercially supported platforms and versions for the Chef Workstation.

{{< foundation_tabs tabs-id="chef-workstation-commercial-support" >}}
  {{< foundation_tab active="true" panel-link="chef-workstation-commercial-support-v26" tab-text="Chef Workstation 26">}}
  {{< foundation_tab panel-link="chef-workstation-commercial-support-v25" tab-text="Chef Workstation 25" >}}
{{< /foundation_tabs >}}

{{< foundation_tabs_panels tabs-id="chef-workstation-commercial-support" >}}
{{< foundation_tabs_panel active="true" panel-id="chef-workstation-commercial-support-v26" >}}

- Linux (x86_64)
- Windows (x86_64)

{{< /foundation_tabs_panel >}}

{{< foundation_tabs_panel panel-id="chef-workstation-commercial-support-v25" >}}

| Platform                          | Version                                       | Architecture                |
|-----------------------------------| ----------------------------------------------| ----------------------------|
| Amazon Linux                      | 2.x                                           | x86_64                      |
| Amazon Linux                      | 2023                                          | x86_64, aarch64             |
| macOS                             | 13.x, 14.x                                    | aarch64                     |
| Debian                            | 10.x, 11.x                                    | x86_64                      |
| Red Hat Enterprise Linux / CentOS | 7.x, 8.x, 9.x                                | x86_64                      |
| Ubuntu                            | 18.04, 20.04, 22.04                           | x86_64                      |
| Windows                           | 10, 11, Server 2016, Server 2019, Server 2022 | x64                         |

{{< /foundation_tabs_panel >}}

{{< /foundation_tabs_panels >}}

#### Derived platforms

Chef Workstation 25 supports the following derived platforms and versions.

| Platform | Version | Architecture | Parent platform |
| --- | --- | --- | --- |
| AlmaLinux | `8.x` | `x86_64` | CentOS |
| Rocky Linux | `8.x` | `x86_64` | CentOS |

## Platform end-of-life policy

Chef's products on particular platforms and versions reach end-of-life on the same date as the vendor EOL milestone for that operating system.
Because different vendors use different terminology, the following table clarifies when Chef products are end-of-life according to those vendors' terms.

| Platform | Vendor End-of-Life |
| --- | --- |
| Amazon Linux | End of Life |
| Apple macOS | Apple supports the last three macOS releases. Apple doesn't officially publish EOL dates. |
| Debian | End of maintenance updates |
| Enterprise Linux (covers Red Hat Enterprise Linux, CentOS) | End of Production 3 |
| FreeBSD | End of Life |
| IBM AIX | IBM End of Support Date |
| Windows | End of Extended Support |
| Oracle Enterprise Linux | Premier Support Ends |
| Oracle Solaris | Premier Support Ends |
| SUSE Linux Enterprise Server | General Support Ends |
| Ubuntu Linux | End of maintenance updates |

At Chef's option, additional support may be provided to customers beyond
the vendor end-of-life in the above table. As such, the following table
indicates upcoming product end-of-life dates for particular platforms.
On the Chef end-of-life date, Chef discontinues building software for
that platform and version.

| Platform and Version | Vendor End-of-Life Date | Chef End-of-Life Date |
| --- | --- | --- |
| Amazon Linux 201X | Dec 31st, 2020 | Dec 31st, 2020 |
| Amazon Linux 2 | Jun 30, 2025 | Jun 30, 2025 |
| Amazon Linux 2023 | Mar 15, 2028 | Mar 15, 2028 |
| Apple macOS 11 | Sep 26, 2023 | Sep 26, 2023 |
| Apple macOS 12 | Sep 16, 2024 | No current planned EOL date |
| CentOS 6 | Nov 30, 2020 | Nov 30, 2020 |
| CentOS 7 | Jun 30, 2024 | Jun 30, 2024 |
| CentOS 8 | Dec 31, 2021 | Dec 31, 2021 |
| Debian 7 (Wheezy) | May 31st, 2018 | May 31st, 2018 |
| Debian 8 (Jessie) | June 6th, 2020 | June 6th, 2020 |
| Debian 9 (Stretch) | June 30th, 2022 | June 30th, 2022 |
| Debian 10 (Buster) | June 30th, 2024 | June 30th, 2024 |
| Debian 11 (Bullseye) | June 30th, 2026 | June 30th, 2026 |
| FreeBSD 10-STABLE | October 31, 2018 | October 31, 2018 |
| FreeBSD 11-STABLE | September 30, 2021 | September 30, 2021 |
| IBM AIX 7.1 | Apr 30, 2023 | Apr 30, 2023  |
| IBM AIX 7.2 | No current planned EOL date | No current planned EOL date |
| IBM AIX 7.3 | Nov 30, 2026 | Nov 30, 2026 |
| Oracle Enterprise Linux 5 | June 30, 2017 | December 31, 2017 |
| Oracle Enterprise Linux 6 | March 31, 2021 | March 31, 2021 |
| Oracle Enterprise Linux 7 | December 1, 2024 | December 1, 2024 |
| Oracle Enterprise Linux 8 | July 1, 2029 | July 1, 2029 |
| Oracle Solaris 11.3 | January 30, 2021 | No current planned EOL date |
| Oracle Solaris 11.4 | November 31, 2031 | November 31, 2031 |
| Red Hat Enterprise Linux 5 | April 30, 2017 | December 31, 2017 |
| Red Hat Enterprise Linux 6 | November 30, 2020 | November 30, 2020 |
| Red Hat Enterprise Linux 7 | June 30, 2024 | June 30, 2024 |
| Red Hat Enterprise Linux 8 | May 31, 2029 | May 31, 2029 |
| Red Hat Enterprise Linux 9 | May 31, 2032 | May 31, 2032 |
| SUSE Linux Enterprise Server 11 | March 31, 2019 | March 31, 2019 |
| SUSE Linux Enterprise Server 12 | October 31, 2024 | October 31, 2024 |
| Ubuntu Linux 12.04 LTS | April 30, 2017 | April 30, 2017 |
| Ubuntu Linux 14.04 LTS | April 30, 2019 | April 30, 2019 |
| Ubuntu Linux 16.04 LTS | April 30, 2021 | April 30, 2021 |
| Ubuntu Linux 18.04 LTS | May 31, 2023 | May 31, 2023 |
| Ubuntu Linux 20.04 LTS | Apr 02, 2025 | Apr 02, 2025 |
| Ubuntu Linux 22.04 LTS | Apr 01, 2027 | Apr 01, 2027 |
| Windows Server 2008 (SP2)/R2 (SP1) | January 13, 2015 | January 14, 2020 |
| Windows Server 2012/2012 R2 | October 10, 2023 | October 10, 2023 |
| Windows Server 2016 | November 11, 2027 | November 11, 2027 |
| Windows Server 2019 | October 10, 2028 | October 10, 2028 |
