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

Progress Chef software is supported on the operating systems (platforms)
listed below. To see which versions of our software we currently
support, see the [Supported versions](/versions/) page.

## Support definitions

Refer to the following sections for definitions of the certification tiers, installer types, and agent and agentless modes.

### Certification tiers

**Validated and supported**
: These platforms are fully tested on every release. These platforms run through the complete Chef automated test suite in Continuous Integration/Continuous Delivery (CI/CD) prior to each release.

**Supported (untested)**
: These platforms are fully supported, but not tested in our CI/CD pipelines. Chef supports these platforms and will address any reported bugs.

**User-reported**
: These platforms are validated by users. Support is provided on a best-effort basis.

**Commercial support**
: Commercial support for platforms is part of paid maintenance contracts with Progress Chef Software. Support contracts allow you to open tickets and receive service level agreement (SLA) assistance from our support desk. Commercially supported platforms are extensively tested as part of Chef's development and release process. Commercial support follows the lifecycle of the underlying operating system vendor.

  Commercial support is limited to the platforms listed in the "Commercial Support" tables--platforms not listed in these tables are unsupported.

**Community support**
: Community support for platforms means that members of the Chef community have contributed to these platforms and Chef doesn't actively work to maintain this functionality. Chef doesn't explicitly test community supported platforms as part of the development and release process.

  Many of these platforms are forks, clones, or otherwise derivative of platforms that Chef commercially supports. Continued functionality for these platforms is likely, but not guaranteed. Unsupported platforms may have missing or non-operative functionality. As always, we welcome community contributions from anyone looking to expand community support for platforms in Chef products.

**Derived platforms support**
: Chef doesn't explicitly test or provide builds for derived distributions other than those in our supported platform list. However, if the derived distribution is a direct rebuild of the originating distribution and hasn't diverged in functionality or packaged dependencies, Chef will support our customers through our normal channels.

### Installer types

**Native**
: Chef is installed using the platform's native package manager - (Microsoft Installer (MSI)) on Windows, Debian package (DEB) on Debian/Ubuntu, RPM Package Manager (RPM) on Red Hat Enterprise Linux (RHEL)/SUSE, or PKG (macOS installer package).

**Habitat**
: Chef is installed and run using [Chef Habitat](https://www.habitat.sh/) commands (`hab pkg install`) or by extracting a Habitat artifact (`.hart` or `.tar.gz`). Used for platforms where a native package isn't available or where a self-contained runtime is preferred.

### Agent and agentless modes

**Agent-based mode**
: Agent-based mode includes all software that runs directly on the managed node:

- Chef Infra Client
- Chef InSpec
- Chef Habitat supervisor
- Chef 360 Platform skills running in agent mode, including Courier job execution and Node Management

**Agentless mode**
: Agentless mode includes all software that manages a node remotely without an agent present on the node:

- Chef Infra Client agentless mode (formerly Target Mode)—connects using SSH (Linux) or WinRM/SSH (Windows)
- Chef InSpec (remote scanning)
- Chef 360 Courier agentless job execution

Chef software is supported on the operating systems (platforms) listed below.
To check which versions of our software we currently support, refer to the [Supported Versions](/versions/) page.

## Platforms

The sections below list the platforms that Chef Software supports.

### Chef Automate

#### Standalone

{{< readfile file="content/reusable/md/supported_platforms/automate.md" >}}

For more information, see the [Chef Automate system requirements](/automate/system_requirements/)

#### Chef Automate HA

{{< readfile file="content/reusable/md/supported_platforms/automate_ha.md" >}}

For more information, see the [Chef Automate HA system requirements](/automate/ha_on_premises_deployment_prerequisites/#software-requirements).

### Chef Habitat

{{< foundation_tabs tabs-id="chef-habitat-support" >}}
  {{< foundation_tab active="true" panel-link="chef-habitat-support-2_1" tab-text="Chef Habitat 2.1">}}
  {{< foundation_tab panel-link="chef-habitat-support-2_0" tab-text="Chef Habitat 2.0" >}}
  {{< foundation_tab panel-link="chef-habitat-support-1_6" tab-text="Chef Habitat 1.6" >}}
{{< /foundation_tabs >}}

{{< foundation_tabs_panels tabs-id="chef-habitat-support" >}}

{{< foundation_tabs_panel active="true" panel-id="chef-habitat-support-2_1" >}}
{{< readfile file="content/reusable/md/supported_platforms/chef_habitat_2_1.md" >}}
{{< /foundation_tabs_panel >}}

{{< foundation_tabs_panel panel-id="chef-habitat-support-2_0" >}}
{{< readfile file="content/reusable/md/supported_platforms/chef_habitat_2_0.md" >}}
{{< /foundation_tabs_panel >}}

{{< foundation_tabs_panel panel-id="chef-habitat-support-1_6" >}}
{{< readfile file="content/reusable/md/supported_platforms/chef_habitat_1_6.md" >}}
{{< /foundation_tabs_panel >}}

{{< /foundation_tabs_panels >}}

### Chef Infra Client

{{< foundation_tabs tabs-id="chef-infra-client-support" >}}
  {{< foundation_tab active="true" panel-link="chef-infra-client-support-19" tab-text="Chef Infra Client 19">}}
  {{< foundation_tab panel-link="chef-infra-client-support-18" tab-text="Chef Infra Client 18" >}}
{{< /foundation_tabs >}}

{{< foundation_tabs_panels tabs-id="chef-infra-client-support" >}}

{{< foundation_tabs_panel active="true" panel-id="chef-infra-client-support-19" >}}
{{< readfile file="content/reusable/md/supported_platforms/chef_infra_client_19.md" >}}
{{< /foundation_tabs_panel >}}

{{< foundation_tabs_panel panel-id="chef-infra-client-support-18" >}}
{{< readfile file="content/reusable/md/supported_platforms/chef_infra_client_18.md" >}}
{{< /foundation_tabs_panel >}}

{{< /foundation_tabs_panels >}}

### Chef Infra Server

{{< readfile file="content/server/reusable/md/adopted_platforms_server.md" >}}

### Chef InSpec

{{< foundation_tabs tabs-id="chef-inspec-support" >}}
  {{< foundation_tab active="true" panel-link="chef-inspec-support-7-2" tab-text="Chef InSpec 7.2">}}
  {{< foundation_tab panel-link="chef-inspec-support-7-1" tab-text="Chef InSpec 7.1" >}}
  {{< foundation_tab panel-link="chef-inspec-support-7-0" tab-text="Chef InSpec 7.0" >}}
  {{< foundation_tab panel-link="chef-inspec-support-6-8" tab-text="Chef InSpec 6.8" >}}
  {{< foundation_tab panel-link="chef-inspec-support-5-24" tab-text="Chef InSpec 5.24" >}}
  {{< foundation_tab panel-link="chef-inspec-support-5-23" tab-text="Chef InSpec 5.23" >}}
{{< /foundation_tabs >}}

{{< foundation_tabs_panels tabs-id="chef-inspec-support" >}}
{{< foundation_tabs_panel active="true" panel-id="chef-inspec-support-7-2" >}}
{{< readfile file="content/reusable/md/supported_platforms/chef_inspec_7_2.md" >}}
{{< /foundation_tabs_panel >}}

{{< foundation_tabs_panel panel-id="chef-inspec-support-7-1" >}}
{{< readfile file="content/reusable/md/supported_platforms/chef_inspec_7_1.md" >}}
{{< /foundation_tabs_panel >}}

{{< foundation_tabs_panel panel-id="chef-inspec-support-7-0" >}}
{{< readfile file="content/reusable/md/supported_platforms/chef_inspec_7_0.md" >}}
{{< /foundation_tabs_panel >}}

{{< foundation_tabs_panel panel-id="chef-inspec-support-6-8" >}}
{{< readfile file="content/reusable/md/supported_platforms/chef_inspec_6_8.md" >}}
{{< /foundation_tabs_panel >}}

{{< foundation_tabs_panel panel-id="chef-inspec-support-5-24" >}}
{{< readfile file="content/reusable/md/supported_platforms/chef_inspec_5_24.md" >}}
{{< /foundation_tabs_panel >}}

{{< foundation_tabs_panel panel-id="chef-inspec-support-5-23" >}}
{{< readfile file="content/reusable/md/supported_platforms/chef_inspec_5_23.md" >}}
{{< /foundation_tabs_panel >}}

{{< /foundation_tabs_panels >}}

### Chef Workstation

{{< foundation_tabs tabs-id="chef-workstation-support" >}}
  {{< foundation_tab active="true" panel-link="chef-workstation-support-26-1" tab-text="Chef Workstation 26.1">}}
  {{< foundation_tab panel-link="chef-workstation-support-26-0" tab-text="Chef Workstation 26.0">}}
  {{< foundation_tab panel-link="chef-workstation-support-25" tab-text="Chef Workstation 25.x" >}}
{{< /foundation_tabs >}}

{{< foundation_tabs_panels tabs-id="chef-workstation-support" >}}

{{< foundation_tabs_panel active="true" panel-id="chef-workstation-support-26-1" >}}
{{< readfile file="content/reusable/md/supported_platforms/chef_workstation_26_1.md" >}}
{{< /foundation_tabs_panel >}}

{{< foundation_tabs_panel panel-id="chef-workstation-support-26-0" >}}
{{< readfile file="content/reusable/md/supported_platforms/chef_workstation_26_0.md" >}}
{{< /foundation_tabs_panel >}}

{{< foundation_tabs_panel panel-id="chef-workstation-support-25" >}}
{{< readfile file="content/reusable/md/supported_platforms/chef_workstation_25.md" >}}
{{< /foundation_tabs_panel >}}

{{< /foundation_tabs_panels >}}

## Platform end-of-life policy

Chef's products on particular platforms and versions reach end-of-life on the same date as the vendor EOL milestone for that operating system.
Because different vendors use different terminology, the following table clarifies when Chef products are end-of-life according to those vendors' terms.

| Platform                                                   | Vendor End-of-Life                                                                        |
| ---------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| Amazon Linux                                               | End of Life                                                                               |
| Apple macOS                                                | Apple supports the last three macOS releases. Apple doesn't officially publish EOL dates. |
| Debian                                                     | End of maintenance updates                                                                |
| Enterprise Linux (covers Red Hat Enterprise Linux, CentOS) | End of Production 3                                                                       |
| FreeBSD                                                    | End of Life                                                                               |
| IBM AIX                                                    | IBM End of Support Date                                                                   |
| Windows                                                    | End of Extended Support                                                                   |
| Oracle Enterprise Linux                                    | Premier Support Ends                                                                      |
| Oracle Solaris                                             | Premier Support Ends                                                                      |
| SUSE Linux Enterprise Server                               | General Support Ends                                                                      |
| Ubuntu Linux                                               | End of maintenance updates                                                                |

At Chef's option, additional support may be provided to customers beyond
the vendor end-of-life in the above table. As such, the following table
indicates upcoming product end-of-life dates for particular platforms.
On the Chef end-of-life date, Chef discontinues building software for
that platform and version.

| Platform and Version       | Vendor End-of-Life Date     | Chef End-of-Life Date       |
| -------------------------- | --------------------------- | --------------------------- |
| Amazon Linux 2023          | Mar 15, 2028                | Mar 15, 2028                |
| IBM AIX 7.2                | No current planned EOL date | No current planned EOL date |
| IBM AIX 7.3                | Nov 30, 2026                | Nov 30, 2026                |
| Oracle Enterprise Linux 8  | Jul 1, 2029                 | Jul 1, 2029                 |
| Oracle Solaris 11.4        | Nov 31, 2031                | Nov 31, 2031                |
| Red Hat Enterprise Linux 8 | May 31, 2029                | May 31, 2029                |
| Red Hat Enterprise Linux 9 | May 31, 2032                | May 31, 2032                |
| Ubuntu Linux 22.04 LTS     | Apr 1, 2027                 | Apr 1, 2027                 |
| Windows Server 2016        | Nov 11, 2027                | Nov 11, 2027                |
| Windows Server 2019        | Oct 10, 2028                | Oct 10, 2028                |
