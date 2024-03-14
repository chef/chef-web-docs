+++
title = "Platforms"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/platforms.html", "/supported_platforms.html"]
product = ["automate", "client", "server", "habitat", "inspec", "workstation"]

[menu]
  [menu.overview]
    title = "Platforms"
    identifier = "overview/packages_&_platforms/platforms.md Platforms"
    parent = "overview/packages_&_platforms"
    weight = 20
+++

Chef software is supported on the operating systems (platforms)
listed below. To see which versions of our software we currently
support, see the [Supported Versions](/versions/) page.

## Support

We offer two levels of support for platforms (operating systems), [Commercial Support]({{< relref "#commercial-support">}}) and [Community Support]({{< relref "#community-support" >}}).

### Commercial Support

Commercial support for platforms is part of paid maintenance contracts with Chef Software. Support contracts allow you to open tickets and receive service level agreement (SLA) assistance from our support desk. Commercially supported platforms are extensively tested as part of Chef's development and release process. Commercial support follows the lifecycle of the underlying operating system vendor.

Commercial support is limited to the platforms listed in the "Commercial Support" tables--platforms not listed in these tables are unsupported.

### Community Support

Community support for platforms means that members of the Chef community have contributed to these platforms and Chef doesn't actively work to maintain this functionality. Chef doesn't explicitly test community supported platforms as part of the development and release process.

Many of these platforms are forks, clones, or otherwise derivative of platforms that Chef commercially supports. Continued functionality for these platforms is likely, but not guaranteed. Unsupported platforms may have missing or non-operative functionality. As always, we welcome community contributions from anyone looking to expand community support for platforms in Chef products.

### Support for Derived Platforms

Chef doesn't explicitly test or provide builds for derived distributions other than those in our supported platform list. However, if the derived distribution is a direct rebuild of the originating distribution and hasn't diverged in functionality or packaged dependencies, Chef will support our customers through our normal channels.

## Platforms

The sections below list the platforms that Chef Software supports.

### Chef Automate

#### Commercial Support

Commercial support for the [Chef Automate](/automate/system_requirements/) is available for platforms that use:

- a Linux kernel version of 3.2 or greater
- `systemd` as the init system
- `useradd`
- `curl` or `wget`

### Chef Automate HA

#### Commercial Support

See the [Chef Automate HA supported platforms](/automate/ha_on_premises_deployment_prerequisites/#software-requirements)
documentation for a list of supported platforms for Chef Automate HA.

### Chef Backend

#### Commercial Support

The following table lists the commercially supported platforms for Chef Backend, which is the high-availability solution for Chef Infra Server.

| Platform | Architecture | Version |
| --- | --- | --- |
| CentOS | `x86_64` | `6.x`, `7.x`, `8.x` |
| Oracle Enterprise Linux | `x86_64` | `7.x`, `8.x` |
| Red Hat Enterprise Linux | `x86_64` | `6.x`, `7.x`, `8.x` |
| SUSE Linux Enterprise Server | `x86_64` | `12.x` |
| Ubuntu (LTS releases) | `x86_64` | `16.04`, `18.04` |

#### Derived platforms

The following table lists supported derived platforms and versions for Chef Infra Server.

See our policy on [support for derived platforms](#support-for-derived-platforms) for more information.

| Platform | Architecture | Version | Parent platform |
| --- | --- | --- | --- |
| AlmaLinux | `x86_64` | `8.x` | CentOS |
| Rocky Linux | `x86_64` | `8.x` | CentOS |

### Chef Infra Client

#### Commercial Support

The following table lists the commercially supported platforms and versions for Chef Infra Client.

| Platform | Architecture | Version |
| --- | --- | --- |
| AIX | `powerpc` | `7.1` (TL5 SP2 or higher, recommended), `7.2`, `7.3` |
| Amazon Linux | `x86_64`, `aarch64` | `2.x`, `2023` |
| CentOS | `x86_64`, `ppc64le`, `ppc64`, `aarch64` | `7.x` |
| Debian | `x86_64`, `aarch64` | `10`, `11` |
| FreeBSD | `amd64` | `12.x` |
| macOS | `x86_64`, `aarch64` (M1 processors) | `12.x` |
| Oracle Enterprise Linux | `x86_64`, `aarch64` | `7.x`, `8.x` |
| Red Hat Enterprise Linux | `x86_64`, `ppc64le` (7.x only), `ppc64` (7.x only), `aarch64`, `s390x` (7.x / 8.x only) | `7.x`, `8.x`, `9.x` |
| Rocky Linux | `x86_64`, `aarch64` | `8.x`, `9.x` |
| Solaris | `sparc`, `i86pc` | `11.3` (16.17.4 and later only), `11.4`  |
| SUSE Linux Enterprise Server | `x86_64`, `aarch64` (15.x only), `s390x` | `12`, `15` |
| Ubuntu (LTS releases) | `x86_64`,`aarch64` | `16.04`, `18.04`, `20.04`, `22.04` |
| Windows | `x86`, `x64` | `2012`, `2012 R2`, `2016`, `10` (all channels except "insider" builds), `2019` (Long-term servicing channel (LTSC), both Desktop Experience and Server Core), `11`, `2022` |

#### Derived platforms

The following table lists supported derived platforms and versions for Chef Infra Client.

See our policy on [support for derived platforms](#support-for-derived-platforms) for more information.

| Platform | Architecture | Version | Parent platform |
| --- | --- | --- | --- |
| AlmaLinux | `x86_64`, `aarch64` | `8.x` | CentOS |

#### Community Support

The following platforms are supported only using the community.

| Platform | Architecture | Version |
| --- | --- | --- |
| Alibaba Cloud Linux | `x86_64` | 2.x |
| Arch Linux | `x86_64` | current version |
| Arista EOS | `x86_64` | current non-EOL releases |
| CentOS Stream | `x86_64`, `aarch64` | current non-EOL releases |
| Clear Linux | `x86_64` | current non-EOL releases |
| Cumulus Linux | `x86_64` | current non-EOL releases |
| Fedora | `x86_64`, `aarch64` | current non-EOL releases |
| Kali Linux | `x86_64` | current non-EOL releases |
| Linux Mint | `x86_64` | current non-EOL releases |
| OpenIndiana Hipster | `x86_64` | current non-EOL releases |
| openSUSE | `x86_64`, `aarch64` | `15.x` |
| Pop!_OS | `x86_64` | current non-EOL releases |
| Raspberry Pi OS | `aarch64` | current non-EOL releases |
| SmartOS | `x86_64` | current non-EOL releases |
| SUSE Linux Enterprise Desktop | `x86_64`, `aarch64` (15.x only) | `12.x`, `15.x` |
| Ubuntu | `x86_64`, `aarch64` | Current non-LTS releases |
| Virtuozzo | `x86_64` | Current non-LTS releases |
| Windows | `x64` | `Windows Server, Semi-annual channel (SAC) (Server Core only)` |
| XCP-ng | `x86_64` | 8.x |

### Chef Infra Server

#### Commercial Support

{{< readfile file="content/server/reusable/md/adopted_platforms_server.md" >}}

### Chef InSpec

#### Commercial Support

The following table lists the commercially supported platforms and versions for Chef InSpec.

{{< readfile file="content/inspec/reusable/md/support_commercial_platforms.md" >}}

#### Derived platforms

The following table lists supported derived platforms and versions for Chef InSpec.

See our policy on [support for derived platforms](#support-for-derived-platforms) for more information.

{{< readfile file="content/inspec/reusable/md/support_derived_platforms.md" >}}

### Chef Manage

#### Commercial Support

The following table lists the commercially supported platforms for Chef Manage.

| Platform | Architecture | Version |
| --- | --- | --- |
| CentOS | `x86_64` | `7.x` |
| Oracle Enterprise Linux | `x86_64` | `7.x`, `8.x` |
| Red Hat Enterprise Linux | `x86_64` | `7.x`, `8.x` |
| Ubuntu (LTS releases) | `x86_64` | `16.04`, `18.04`, `20.04` |

#### Derived platforms

The following table lists supported derived platforms and versions for Chef Manage.

See our policy on [support for derived platforms](#support-for-derived-platforms) for more information.

| Platform | Architecture | Version | Parent platform |
| --- | --- | --- | --- |
| AlmaLinux | `x86_64` | `8.x` | CentOS |
| Rocky Linux | `x86_64` | `8.x` | CentOS |

### Chef Workstation

#### Commercial Support

The following table lists the commercially supported platforms and versions for the Chef Workstation.

{{< readfile file = "content/workstation/reusable/md/workstation_supported_platforms.md" >}}

#### Derived platforms

The following table lists supported derived platforms and versions for Chef Workstation.

See our policy on [support for derived platforms](#support-for-derived-platforms) for more information.

{{< readfile file = "content/workstation/reusable/md/workstation_supported_derived_platforms.md" >}}

## Platform End-of-Life Policy

Chef's products on particular platforms and versions reach end-of-life on the same date as the vendor EOL milestone for that operating systems.
Because different vendors use different terminology, the following table clarifies when Chef products are end-of-life according to those vendors' terms.

| Platform | Vendor End-of-Life |
| --- | --- |
| Amazon Linux | End of Life |
| Apple macOS | Apple supports the last three macOS releases, for example: 10.15, 11.x, and 12.x. Apple doesn't officially publish EOL dates. |
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
| Apple macOS 12 | No current planned EOL date | No current planned EOL date |
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
