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

Commercial support for platforms is part of paid maintenance contracts with Chef Software Inc. Support contracts allow you to open tickets and receive service level agreement (SLA) assistance from our support desk. Commercially supported platforms are extensively tested as part of Chef's development and release process. Commercial support generally follows the lifecycle of the underlying operating system vendor.

Commercial support is limited to the platforms listed in the "Commercial Support" tables--platforms not listed in these tables are unsupported.

### Community Support

Community support for platforms means that members of the Chef community have contributed to these platforms and Chef does not actively work to maintain this functionality. Chef does not explicitly test community supported platforms as part of the development and release process.

Many of these platforms are forks, clones, or otherwise derivative of platforms that Chef commercially supports. Continued functionality for these platforms is likely, but not guaranteed. Unsupported platforms may have missing or non-operative functionality. As always, we welcome community contributions from anyone looking to expand community support for platforms in Chef products.

## Platforms

The sections below list the platforms that Chef Software Inc. supports.

### Chef Infra Client

#### Commercial Support

The following table lists the commercially-supported platforms and versions for Chef Infra Client:

<table>
<colgroup>
<col style="width: 30%" />
<col style="width: 35%" />
<col style="width: 35%" />
</colgroup>
<thead>
<tr class="header">
<th>Platform</th>
<th>Architecture</th>
<th>Version</th>
</tr>
</thead>
<tbody>
<tr>
<td>AIX</td>
<td><code>powerpc</code></td>
<td><code>7.1</code> (TL5 SP2 or higher, recommended), <code>7.2</code></td>
</tr>
<tr>
<td>Amazon Linux</td>
<td><code>x86_64</code>, <code>aarch64</code></td>
<td>2.x</td>
</tr>
<tr>
<td>CentOS</td>
<td><code>x86_64</code>, <code>ppc64le</code> (7.x only), <code>ppc64</code> (7.x only), <code>aarch64</code> (7.x / 8.x only)</td>
<td><code>6.x</code>, <code>7.x</code>, <code>8.x</code></td>
</tr>
<tr>
<td>Debian</td>
<td><code>x86_64</code><code>aarch64</code> (10.x/11.x only)</td>
<td><code>9</code>, <code>10</code>, <code>11</code></td>
</tr>
<tr>
<td>FreeBSD</td>
<td><code>amd64</code></td>
<td><code>11.x</code>, <code>12.x</code></td>
</tr>
<tr>
<td>macOS</td>
<td><code>x86_64</code>, <code>aarch64 (M1 processors)</code></td>
<td><code>10.14</code>, <code>10.15</code>, <code>11.x</code>, <code>12.x</code></td>
</tr>
<tr>
<td>Oracle Enterprise Linux</td>
<td><code>x86_64</code><code>aarch64</code> (7.x / 8.x only)</td>
<td><code>6.x</code>, <code>7.x</code>, <code>8.x</code></td>
</tr>
<tr>
<td>Red Hat Enterprise Linux</td>
<td><code>x86_64</code>, <code>ppc64le</code> (7.x only), <code>ppc64</code> (7.x only), <code>aarch64</code> (7.x / 8.x only)</td>
<td><code>6.x</code>, <code>7.x</code>, <code>8.x</code></td>
</tr>
<tr>
<td>Solaris</td>
<td><code>sparc</code>, <code>i86pc</code></td>
<td><code>11.4</code></td>
</tr>
<tr>
<td>SUSE Enterprise Linux Server</td>
<td><code>x86_64</code>, <code>aarch64</code> (15.x only)</td>
<td><code>12</code>, <code>15</code></td>
</tr>
<tr>
<td>Ubuntu (LTS releases)</td>
<td><code>x86_64</code>,<code>aarch64</code></td>
<td><code>18.04</code>, <code>20.04</code></td>
</tr>
<tr>
<td>Microsoft Windows</td>
<td><code>x86</code>, <code>x64</code></td>
<td><code>8.1</code>, <code>2012</code>, <code>2012 R2</code>, <code>2016</code>, <code>10 (all channels except "insider" builds)</code>, <code>2019 (Long-term servicing channel (LTSC), both Desktop Experience and Server Core)</code><code>11</code>, <code>2022</code></td>
</tr>
</tbody>
</table>

#### Community Support

The following platforms are supported only via the community:

<table>
<colgroup>
<col style="width: 30%" />
<col style="width: 35%" />
<col style="width: 35%" />
</colgroup>
<thead>
<tr class="header">
<th>Platform</th>
<th>Architecture</th>
<th>Version</th>
</tr>
</thead>
<tbody>
<tr>
<td>AlmaLinux</td>
<td><code>x86_64</code>, <code>aarch64</code></td>
<td><code>8.x</code></td>
</tr>
<tr>
<td>Alibaba Cloud Linux</td>
<td><code>x86_64</code></td>
<td>2.x</td>
</tr>
<tr>
<td>Arch Linux</td>
<td><code>x86_64</code></td>
<td>current version</td>
</tr>
<tr>
<td>Arista EOS</td>
<td><code>x86_64</code></td>
<td>current non-EOL releases</td>
</tr>
<tr>
<td>CentOS Stream</td>
<td><code>x86_64</code>, <code>aarch64</code></td>
<td>current non-EOL releases</td>
</tr>
<tr>
<td>Clear Linux</td>
<td><code>x86_64</code></td>
<td>current non-EOL releases</td>
</tr>
<tr>
<td>Cumulus Linux</td>
<td><code>x86_64</code></td>
<td>current non-EOL releases</td>
</tr>
<tr>
<td>Fedora</td>
<td><code>x86_64</code>, <code>aarch64</code></td>
<td>current non-EOL releases</td>
</tr>
<tr>
<td>Kali Linux</td>
<td><code>x86_64</code></td>
<td>current non-EOL releases</td>
</tr>
<tr>
<td>Linux Mint</td>
<td><code>x86_64</code></td>
<td>current non-EOL releases</td>
</tr>
<tr>
<td>OpenIndiana Hipster</td>
<td><code>x86_64</code></td>
<td>current non-EOL releases</td>
</tr>
<tr>
<td>openSUSE</td>
<td><code>x86_64</code>, <code>aarch64</code></td>
<td><code>15.x</code></td>
</tr>
<tr>
<td>Pop!_OS</td>
<td><code>x86_64</code></td>
<td>current non-EOL releases</td>
</tr>
<tr>
<td>Raspberry Pi OS</td>
<td><code>aarch64</code></td>
<td>current non-EOL releases</td>
</tr>
<tr>
<td>Rocky Linux</td>
<td><code>x86_64</code>, <code>aarch64</code></td>
<td>8.x</td>
</tr>
<tr>
<td>SmartOS</td>
<td><code>x86_64</code></td>
<td>current non-EOL releases</td>
</tr>
<tr>
<td>SUSE Linux Enterprise Desktop</td>
<td><code>x86_64</code>, <code>aarch64</code> (15.x only)</td>
<td><code>12.x</code>, <code>15.x</code></td>
</tr>
<tr>
<td>Ubuntu</td>
<td><code>x86_64</code>, <code>aarch64</code></td>
<td>Current non-LTS releases</td>
</tr>
<td>Virtuozzo</td>
<td><code>x86_64</code></td>
<td>Current non-LTS releases</td>
</tr>
<tr>
<td>Windows</td>
<td><code>x64</code></td>
<td><code>Windows Server, Semi-annual channel (SAC) (Server Core only)</code></td>
</tr>
<tr>
<td>XCP-ng</td>
<td><code>x86_64</code></td>
<td>8.x</td>
</tr>
</tbody>
</table>

### Chef Workstation

#### Commercial Support

The following table lists the commercially-supported platforms and
versions for the Chef Workstation:

<table>
<colgroup>
<col style="width: 30%" />
<col style="width: 35%" />
<col style="width: 35%" />
</colgroup>
<thead>
<tr class="header">
<th>Platform</th>
<th>Architecture</th>
<th>Version</th>
</tr>
</thead>
<tbody>
<tr>
<td>Amazon Linux</td>
<td><code>x86_64</code></td>
<td><code>2.x</code></td>
</tr>
<tr>
<td>macOS</td>
<td><code>x86_64</code></td>
<td><code>10.14</code>, <code>10.15</code>, <code>11.x</code></td>
</tr>
<tr>
<td>Debian</td>
<td><code>x86_64</code></td>
<td><code>9.x</code>, <code>10.x</code></td>
</tr>
<tr>
<td>Red Hat Enterprise Linux</td>
<td><code>x86_64</code></td>
<td><code>7.x</code>, <code>8.x</code></td>
</tr>
<tr>
<td>Ubuntu</td>
<td><code>x86_64</code>,<code>aarch64</code></td>
<td><code>18.04</code>, <code>20.04</code></td>
</tr>
<tr>
<td>Microsoft Windows</td>
<td><code>x64</code></td>
<td><code>8.1</code>, <code>2012</code>, <code>2012 R2</code>, <code>2016</code>, <code>10 (all channels except "insider" builds)</code>, <code>2019 (Long-term servicing channel (LTSC), Desktop Experience only)</code></td>
</tr>
</tbody>
</table>

### Chef InSpec

#### Commercial Support

The following table lists the commercially-supported platforms and versions for Chef InSpec:

<table>
<colgroup>
<col style="width: 30%" />
<col style="width: 35%" />
<col style="width: 35%" />
</colgroup>
<thead>
<tr class="header">
<th>Platform</th>
<th>Architecture</th>
<th>Version</th>
</tr>
</thead>
<tbody>
<tr>
<td>Amazon Linux</td>
<td><code>x86_64</code>, <code>aarch64</code></td>
<td><code>2.x</code></td>
</tr>
<tr>
<td>Debian</td>
<td><code>x86_64</code><code>aarch64</code> (10.x only)</td>
<td><code>9.x</code>, <code>10.x</code></td>
</tr>
<tr>
<td>macOS</td>
<td><code>x86_64</code>, <code>aarch64 (M1 processors)</code></td>
<td><code>10.14</code>, <code>10.15</code>, <code>11.x</code>, <code>12.x</code></td>
</tr>
<tr>
<td>Oracle Enterprise Linux</td>
<td><code>x86_64</code><code>aarch64</code> (7.x / 8.x only)</td>
<td><code>6.x</code>, <code>7.x</code>, <code>8.x</code></td>
</tr>
<tr>
<td>Red Hat Enterprise Linux</td>
<td><code>x86_64</code>, <code>aarch64</code> (7.x and 8.x only)</td>
<td><code>6.x</code>, <code>7.x</code>, <code>8.x</code></td>
</tr>
<tr>
<td>SUSE Enterprise Linux Server</td>
<td><code>x86_64</code>, <code>aarch64</code> (15.x only)</td>
<td><code>12.x</code>, <code>15.x</code></td>
</tr>
<tr>
<td>Ubuntu</td>
<td><code>x86_64</code></td>
<td><code>18.04</code>, <code>20.04</code></td>
</tr>
<tr>
<td>Microsoft Windows</td>
<td><code>x86_64</code></td>
<td><code>8.1</code>, <code>2012</code>, <code>2012 R2</code>, <code>2016</code>, <code>10 (all channels except "insider" builds)</code>, <code>2019</code></td>
</tr>
</tbody>
</table>

Chef InSpec Target Mode (`inspec --target`) may be functional on
additional platforms, versions, and architectures but are not validated
by Chef Software, Inc.

### Chef Infra Server

#### Commercial Support

{{% adopted_platforms_server %}}

### Chef Automate Server

#### Commercial Support

Commercial support for the [Chef Automate 2
Server](/automate/system_requirements/) is available
for platforms that use:

- a Linux kernel version of 3.2 or greater
- `systemd` as the init system
- `useradd`
- `curl` or `wget`

### Chef Backend

#### Commercial Support

The following table lists the commercially-supported platforms for Chef Backend, which is the high-availability solution for Chef Infra Server:

<table>
<colgroup>
<col style="width: 30%" />
<col style="width: 35%" />
<col style="width: 35%" />
</colgroup>
<thead>
<tr class="header">
<th>Platform</th>
<th>Architecture</th>
<th>Version</th>
</tr>
</thead>
<tbody>
<tr>
<td>CentOS</td>
<td><code>x86_64</code></td>
<td><code>6.x</code>, <code>7.x</code>, <code>8.x</code></td>
</tr>
<tr>
<td>Oracle Enterprise Linux</td>
<td><code>x86_64</code></td>
<td><code>6.x</code>, <code>7.x</code>, <code>8.x</code></td>
</tr>
<tr>
<td>Red Hat Enterprise Linux</td>
<td><code>x86_64</code></td>
<td><code>6.x</code>, <code>7.x</code>, <code>8.x</code></td>
</tr>
<tr>
<td>SUSE Linux Enterprise Server</td>
<td><code>x86_64</code></td>
<td><code>12.x</code></td>
</tr>
<tr>
<td>Ubuntu (LTS releases)</td>
<td><code>x86_64</code></td>
<td><code>18.04</code></td>
</tr>
</tbody>
</table>

### Chef Manage

#### Commercial Support

The following table lists the commercially-supported platforms for Chef Manage:

<table>
<colgroup>
<col style="width: 30%" />
<col style="width: 35%" />
<col style="width: 35%" />
</colgroup>
<thead>
<tr class="header">
<th>Platform</th>
<th>Architecture</th>
<th>Version</th>
</tr>
</thead>
<tbody>
<tr>
<td>CentOS</td>
<td><code>x86_64</code></td>
<td><code>6.x</code>, <code>7.x</code>, <code>8.x</code></td>
</tr>
<tr>
<td>Oracle Enterprise Linux</td>
<td><code>x86_64</code></td>
<td><code>6.x</code>, <code>7.x</code>, <code>8.x</code></td>
</tr>
<tr>
<td>Red Hat Enterprise Linux</td>
<td><code>x86_64</code></td>
<td><code>6.x</code>, <code>7.x</code>, <code>8.x</code></td>
</tr>
<tr>
<td>Ubuntu (LTS releases)</td>
<td><code>x86_64</code></td>
<td><code>18.04</code></td>
</tr>
</tbody>
</table>

## Platform End-of-Life Policy

Chef's products on particular platforms and versions generally reach
end-of-life on the same date as the vendor EOL milestone for that
operating systems. Because different vendors use different terminology,
the following table clarifies when Chef products are end-of-life
according to those vendors' terms:

<table>
<colgroup>
<col style="width: 74%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr class="header">
<th>Platform</th>
<th>Vendor End-of-Life</th>
</tr>
</thead>
<tbody>
<tr>
<td>Amazon Linux</td>
<td>End of Life</td>
</tr>
<tr>
<td>Apple macOS</td>
<td>Apple generally supports the last three macOS releases, for example: 10.14, 10.15, and 11.x. Apple does not officially publish EOL dates.</td>
</tr>
<tr>
<td>Debian</td>
<td>End of maintenance updates</td>
</tr>
<tr>
<td>Enterprise Linux (covers Red Hat Enterprise Linux, CentOS)</td>
<td>End of Production 3</td>
</tr>
<tr>
<td>FreeBSD</td>
<td>End of Life</td>
</tr>
<tr>
<td>IBM AIX</td>
<td>IBM End of Support Date</td>
</tr>
<tr>
<td>Microsoft Windows</td>
<td>End of Extended Support</td>
</tr>
<tr>
<td>Oracle Enterprise Linux</td>
<td>Premier Support Ends</td>
</tr>
<tr>
<td>Oracle Solaris</td>
<td>Premier Support Ends</td>
</tr>
<tr>
<td>SUSE Linux Enterprise Server</td>
<td>General Support Ends</td>
</tr>
<tr>
<td>Ubuntu Linux</td>
<td>End of maintenance updates</td>
</tr>
</tbody>
</table>

At Chef's option, additional support may be provided to customers beyond
the vendor end-of-life in the above table. As such, the following table
indicates upcoming product end-of-life dates for particular platforms.
On the Chef end-of-life date, Chef discontinues building software for
that platform and version.

<table>
<colgroup>
<col style="width: 54%" />
<col style="width: 22%" />
<col style="width: 22%" />
</colgroup>
<thead>
<tr class="header">
<th>Platform and Version</th>
<th>Vendor End-of-Life Date</th>
<th>Chef End-of-Life Date</th>
</tr>
</thead>
<tbody>
<tr>
<td>Amazon Linux 201X</td>
<td>Dec 31st, 2020</td>
<td>Dec 31st, 2020</td>
</tr>
<tr>
<td>Apple macOS 10.13</td>
<td>Nov 13th, 2020</td>
<td>Nov 13th, 2020</td>
</tr>
<tr>
<td>Debian 7 (Wheezy)</td>
<td>May 31st, 2018</td>
<td>May 31st, 2018</td>
</tr>
<tr>
<td>Debian 8 (Jessie)</td>
<td>June 6th, 2020</td>
<td>June 6th, 2020</td>
</tr>
<tr>
<td>Enterprise Linux 5 (covers Red Hat Enterprise Linux, CentOS)</td>
<td>April 30, 2017</td>
<td>December 31, 2017</td>
</tr>
<tr>
<td>Enterprise Linux 6 (covers Red Hat Enterprise Linux, CentOS)</td>
<td>November 30, 2020</td>
<td>November 30, 2020</td>
</tr>
<tr>
<td>FreeBSD 10-STABLE</td>
<td>October 31, 2018</td>
<td>October 31, 2018</td>
</tr>
<tr>
<td>FreeBSD 11-STABLE</td>
<td>September 30, 2021</td>
<td>September 30, 2021</td>
</tr>
<tr>
<td>IBM AIX 6.1</td>
<td>April 30, 2017</td>
<td>December 31, 2017</td>
</tr>
<tr>
<td>Microsoft Windows Server 2008 (SP2)/R2 (SP1)</td>
<td>January 13, 2015</td>
<td>January 14, 2020</td>
</tr>
<tr>
<td>Microsoft Windows Server 2012/2012 R2</td>
<td>October 10, 2023</td>
<td>October 10, 2023</td>
</tr>
<tr>
<td>Microsoft Windows Server 2016</td>
<td>November 11, 2027</td>
<td>November 11, 2027</td>
</tr>
<tr>
<td>Microsoft Windows Server 2019</td>
<td>October 10, 2028</td>
<td>October 10, 2028</td>
</tr>
<tr>
<td>Oracle Enterprise Linux 5</td>
<td>June 30, 2017</td>
<td>December 31, 2017</td>
</tr>
<tr>
<td>Oracle Enterprise Linux 6</td>
<td>March 31, 2021</td>
<td>March 31, 2021</td>
</tr>
<tr>
<td>Oracle Solaris 10</td>
<td>January 30, 2018</td>
<td>January 30, 2018</td>
</tr>
<tr>
<td>Oracle Solaris 11.3</td>
<td>January 30, 2021</td>
<td>January 30, 2021</td>
</tr>
<tr>
<td>SUSE Linux Enterprise Server 11</td>
<td>March 31, 2019</td>
<td>March 31, 2019</td>
</tr>
<tr>
<td>SUSE Linux Enterprise Server 12</td>
<td>October 31, 2024</td>
<td>October 31, 2024</td>
</tr>
<tr>
<td>Ubuntu Linux 12.04 LTS</td>
<td>April 30, 2017</td>
<td>April 30, 2017</td>
</tr>
<tr>
<td>Ubuntu Linux 14.04 LTS</td>
<td>April 30, 2019</td>
<td>April 30, 2019</td>
</tr>
<tr>
<td>Ubuntu Linux 16.04 LTS</td>
<td>April 30, 2021</td>
<td>April 30, 2021</td>
</tr>
</tbody>
</table>
