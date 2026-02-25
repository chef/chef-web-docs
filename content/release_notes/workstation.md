+++
title = "Chef Workstation release notes"
draft = false
product = ["workstation"]
linkTitle = "Chef Workstation"
summary = "Chef Workstation release notes"

[menu]
  [menu.release_notes]
    title = "Chef Workstation"
    identifier = "release_notes/release_notes.md Chef Workstation"
    parent = "release_notes"
    weight = 110
+++

<!-- markdownlint-disable-file -->
<!-- cSpell:disable  -->
<!-- vale off -->

## Chef Workstation 25.12.1102

Release Date: December 15, 2025.

### Component Updates

#### Test Kitchen

- Updated Test Kitchen to v3.9.1.

#### Knife

- Updated Knife from v18.8.13 to v18.8.68 to address code scanning alerts.

#### chef-cli

- Updated chef-cli from v5.6.21 to v5.6.23 to to address code scanning alerts

### Security

- Updated cURL from v8.14.1 to v8.16.0 to resolve the following CVE:

  - [CVE-2025-10148](https://curl.se/docs/CVE-2025-10148.html)

- Updated OpenSSL from v3.2.4 to v3.2.6 to resolve the following CVE:

  - [CVE-2025-9230](https://openssl-library.org/news/vulnerabilities/#CVE-2025-9230)
  - [CVE-2025-9231](https://openssl-library.org/news/vulnerabilities/#CVE-2025-9231)
  - [CVE-2025-9232](https://openssl-library.org/news/vulnerabilities/#CVE-2025-9232)

- Updated libxml2 from v2.13.8 to v2.14.4 to resolve the following CVE:

  - [CVE-2025-6021](https://www.cvedetails.com/cve/CVE-2025-6021/)

- Updated git-windows from v2.47.0 to v2.48.1 to resolve the following CVE:

  - [CVE-2025-0725](https://curl.se/docs/CVE-2025-0725.html)

- Updated REXML to v3.4.4 to address [CVE-2025-58767](https://github.com/advisories/GHSA-c2f4-jgmc-q2r5)
- Updated google-protobuf to v3.25.5 to address [CVE-2024-7254](https://github.com/advisories/GHSA-735f-pc8j-v9w8)
- Updated rack to v3.2.4 to address [CVE-2025-61919](https://github.com/rack/rack/security/advisories/GHSA-6xw4-3v39-52mm)
- Updated net-imap to v0.2.5 to address [CVE-2025-43857](https://github.com/advisories/GHSA-j3g3-5qv5-52mj)
- Updated resolv to v0.2.3 to address [CVE-2025-24294](https://github.com/advisories/GHSA-xh69-987w-hrp8)
- Updated golang.org/x/text (
[Go](https://github.com/advisories?query=ecosystem%3Ago)
) to v 0.3.8 to address [CVE-2022-32149](https://github.com/advisories/GHSA-69ch-w2m2-3vjp)
- Updated [golang.org/spf13/cobra](https://github.com/spf13/cobra) from v1.10.1 to v1.10.2.
- Updated [golang.org/x/sys](https://github.com/golang/sys) from v0.28.0 to v0.38.0.
- Updated the chef-zero Ruby gem to v15.0.26.
- Updated the activesupport Ruby gem to v7.0.10.
- Updated the kitchen-vagrant Ruby gem to v2.2.0.
- Updated the license_scout Ruby gem to 1.4.1.
- Updated the uri Ruby gem to 1.0.4.

### Bug Fixes

- Updated Test Kitchen to v3.9.1 to resolve a Windows convergence issue introduced in v3.9.0. The issue prevented Chef configuration files (client.rb, dna.json, and cookbooks) from being detected on the guest system.

### Packaging

We no longer build packages for:

- macOS 12 x86-64
- macOS 12 ARM64

## Chef Workstation 25.9.1094

Release Date: September 30, 2025.

### New features

- Updated Test Kitchen to 3.9.0. This adds support for using SSH transport on Windows platforms.

### Component updates

- Updated Chef Infra Client to v18.8.11. See the [Chef Infra Client release notes](https://docs.chef.io/release_notes_client/#18.8.11) for a full list of improvements and features.
- Updated Chef InSpec to v5.22.95. See the [InSpec release notes](https://docs.chef.io/release_notes_inspec/#5.22.95) for more information.
- Updated Knife to v18.8.13.
- Updated Test Kitchen to v3.9.0.
- Updated chef-vault from 4.1.23 to 4.2.5
- Updated knife-tidy from 2.1.6 to 2.3.2
- Updated kitchen-vagrant from 2.0.1 to 2.1.2
- Updated kitchen-dokken from 2.20.7 to 2.20.8
- Updated kitchen-ec2 from 3.19.0 to 3.20.0

### Security updates

- Updated ruby and ruby-msys2-devkit from 3.1.6 to 3.1.7

- Updated Go from 1.23.9 to 1.23.12 to resolve the following CVE:
  - [CVE-2025-0913](https://www.cvedetails.com/cve/CVE-2025-0913/)

- Updated git from 2.39.3 to 2.43.7 to resolve the following CVE:
  - [CVE-2025-48384](https://www.cvedetails.com/cve/CVE-2025-48384/)

- Updated cURL from 8.12.1 to 8.14.1 to resolve the following CVEs:
  - [CVE-2025-5025](https://www.cvedetails.com/cve/CVE-2025-5025/)
  - [CVE-2025-4947](https://www.cvedetails.com/cve/CVE-2025-4947/)

- Updated libxml2 from 2.12.10 to 2.13.8 to resolve the following CVEs:
  - [CVE-2025-32415](https://www.cvedetails.com/cve/CVE-2025-32415/)
  - [CVE-2025-32414](https://www.cvedetails.com/cve/CVE-2025-32414/)

- Updated libarchive from 3.7.9 to 3.8.1 to resolve the following CVEs:
  - [CVE-2025-5914](https://www.cvedetails.com/cve/CVE-2025-5914/)
  - [CVE-2025-5915](https://www.cvedetails.com/cve/CVE-2025-5915/)
  - [CVE-2025-5916](https://www.cvedetails.com/cve/CVE-2025-5916/)
  - [CVE-2025-5917](https://www.cvedetails.com/cve/CVE-2025-5917/)
  - [CVE-2025-5918](https://www.cvedetails.com/cve/CVE-2025-5918/)

- Updated Berkshelf from 8.0.22 to 8.1.6 to address code scanning and dependabot alerts.

### Packaging

We now build Windows packages for:

- Windows 2019

We no longer build packages for:

- Windows 8
- Windows Server 2012
- Windows Server 2012 R2.

## Chef Workstation 25.5.1084

Release Date: May 27, 2025.

### Components

#### Chef Infra Client

- Updated Chef Infra Client to v18.7.10. See the [Chef Infra Client release notes](https://docs.chef.io/release_notes_client/) for a full list of improvements and features.

#### InSpec

- Updated Chef InSpec to v5.22.80. See the [InSpec release notes](https://docs.chef.io/release_notes_inspec/#5.22.80) for more information.

#### Knife

- Updated Knife to v18.7.9.

#### Test Kitchen

- Updated Test Kitchen to v3.7.0.

### Security

- Updated OpenSSL from v3.0.15 to v3.2.4 while maintaining FIPS algorithm support from v3.0.9.
- Updated cURL from v8.4.0 to v8.12.1 to resolve the following CVE:

  - [CVE-2025-0725](https://www.cvedetails.com/cve/CVE-2025-0725/)
  - [CVE-2024-9681](https://www.cvedetails.com/cve/CVE-2024-9681/)
  - [CVE-2023-46219](https://www.cvedetails.com/cve/CVE-2023-46219/)
  - [CVE-2023-46218](https://www.cvedetails.com/cve/CVE-2023-46218/)

- Updated libxml2 from v2.12.7 to v2.12.10 to resolve the following CVE:

  - [CVE-2025-27113](https://www.cvedetails.com/cve/CVE-2025-27113/)
  - [CVE-2025-24928](https://www.cvedetails.com/cve/CVE-2025-24928/)
  - [CVE-2024-56171](https://www.cvedetails.com/cve/CVE-2024-56171/)
  - [CVE-2024-40896](https://www.cvedetails.com/cve/CVE-2024-40896/)

- Updated libxslt from v1.1.39 to v1.1.43 to resolve the following CVE:

  - [CVE-2024-55549](https://nvd.nist.gov/vuln/detail/CVE-2024-55549)
  - [CVE-2025-24855](https://nvd.nist.gov/vuln/detail/cve-2025-24855)

- Updated libarchive from v3.7.5 to v3.7.9 to resolve the following CVE:

  - [CVE-2024-48615](https://www.cvedetails.com/cve/CVE-2024-48615/)

- Updated REXML to v3.4.1 to address [CVE-2024-49761](https://nvd.nist.gov/vuln/detail/CVE-2024-49761)
- Updated Go from v1.22.5 to v1.23.9 as support for the 1.22 series is nearing end-of-life.

We updated several components to address critical security issues identified through Dependabot and GitHub code scanning alerts:

- Berkshelf was updated from v8.0.9 to v8.0.22.
- Chef CLI was updated from v5.6.16 to v5.6.21.
- Ohai was updated from v18.1.18 to v18.2.6.
- Fauxhai was updated from v9.3.16 to v9.3.26.
- Chef Vault was updated from v4.1.11 to v4.1.23.

### Bug Fixes

- Fixed a bootstrap failure on Windows caused by an incorrect URL in Knife.
- Resolved unexpected kitchen doctor errors appearing during kitchen test runs.
- Fixed knife-vsphere failures caused by licensing changes introduced in Chef Infra Client 19.
- Resolved Windows pipeline failures in the chef-vault repository during verification steps.

### Packaging

- We no longer build packages for macOS 11 Big Sur.
- We now build packages for macOS 13 and 14 on aarch64.

## Chef Workstation 25.2.1075

Release Date: 5 February, 2025.

### Components

#### Knife

Important Notice: Upcoming Omnitruck API Deprecation

We updated Knife from v18.6.2 to v18.6.13. This release introduces a warning message when running `knife bootstrap` that notifies users about the upcoming Omnitruck API deprecation.

To ensure uninterrupted downloads and remove this warning:

- For connected environments: Activate your Chef license and Knife automatically uses the new download APIs.
- For air-gapped environments: Set up a local Chef licensing service and configure the `CHEF_LICENSE_SERVER` environment variable to point to its URL. For more information, see the [Chef Local License Service documentation](https://docs.chef.io/licensing/local_license_service/install/).

Activating your Chef license ensures a smooth transition to the new download mechanism before the Omnitruck API is deprecated.

#### Chef Habitat

- Updated Chef Habitat from v1.6.1041 to v1.6.1243. See the [Habitat release notes](https://docs.chef.io/release_notes_habitat/#1.6.1243) for more information.

### Improvements

- To improve security and mitigate vulnerabilities, we replaced `Kernel.open` with `File.open` and `IO.read` with `File.read`.

### Security

Updated expat from v2.5.0 to v2.6.4 to resolve the following CVEs:

- [CVE-2023-52425](https://www.cvedetails.com/cve/CVE-2023-52425/)
- [CVE-2023-52426](https://www.cvedetails.com/cve/CVE-2023-52426/)
- [CVE-2024-45492](https://www.cvedetails.com/cve/CVE-2024-45492/)

## Chef Workstation 24.12.1073

Release Date: 18 December, 2024.

### Components

- Updated Chef Infra Client from v18.5.0 to v18.6.2 and Knife from v18.5.0 to v18.6.2. See the [Chef Infra Client release notes](https://docs.chef.io/release_notes_client/#18.6.2) for a full list of improvements and features.
- Updated Chef InSpec from v5.22.55 to v5.22.65. See the [InSpec release notes](https://docs.chef.io/release_notes_inspec/#5.22.65) for more information.
- Updated kitchen-dokken to v2.20.7.

### Improvements

- Updated the chef-cli gem from v5.6.14 to v5.6.16 so users can connect to JFrog Artifactory with an access token. ([#239](https://github.com/chef/chef-cli/pull/239))

#### Licensing

These changes prepare users for new license requirements in Chef Infra Client 19. ([#14669](https://github.com/chef/chef/pull/14669))

The knife bootstrap command now validates your license key and downloads from [Chef's new download APIs](https://docs.chef.io/download). If you don't have a license, Knife falls back to the older Omnitruck API and returns a warning to add a license.

We added the following commands to manage licenses with Knife:

- `knife license`
- `knife license list`
- `knife license add`

See the Chef [licensing documentation](https://docs.chef.io/licensing/) and [download API documentation](https://docs.chef.io/download) for more information.

### Security

- Updated OpenSSL from v3.0.12 to v3.0.15 to resolve the following CVEs:

  - [CVE-2024-5535](https://www.cvedetails.com/cve/CVE-2024-5535/)
  - [CVE-2024-6119](https://www.cvedetails.com/cve/CVE-2024-6119/)
  - [CVE-2024-4741](https://www.cvedetails.com/cve/CVE-2024-4741/)

- Updated libxml2 from v2.12.5 to v2.12.7 to resolve the following CVE:

  - [CVE-2024-34459](https://www.cvedetails.com/cve/CVE-2024-34459/)

- Updated libarchive from v3.7.4 to v3.7.5 to resolve the following CVEs:

  - [CVE-2024-37407](https://www.cvedetails.com/cve/CVE-2024-37407/)
  - [CVE-2024-48957](https://www.cvedetails.com/cve/CVE-2024-48957/)
  - [CVE-2024-48958](https://www.cvedetails.com/cve/CVE-2024-48958/)

- Updated git-windows from v2.41.0 to v2.47.0 to resolve the following CVE:

  - [CVE-2023-38545](https://nvd.nist.gov/vuln/detail/cve-2023-38545)

- Updated ruby and ruby-msys2-devkit from v3.1.2 to v3.1.6 to resolve the following CVE:

  - [CVE-2023-38545](https://nvd.nist.gov/vuln/detail/cve-2023-38545)

- Updated RDoc to v6.4.1.1 to resolve the following CVE:

  - [CVE-2024-27281](https://nvd.nist.gov/vuln/detail/cve-2024-27281)

## Chef Workstation 24.8.1068

### Bug Fixes

- Calls to chef_vault_item in Test Kitchen now converge correctly.

### Components

- Updated Chef Infra Client from v18.4.12 to v18.5.0 and Knife from v18.4.2 to v18.5.0.
  See the [Chef Infra Client release notes](https://docs.chef.io/release_notes_client/#18.5.0) for a full list of improvements and features.

- Updated Chef InSpec from v5.22.50 to v5.22.55. See the [InSpec release notes](https://docs.chef.io/release_notes_inspec/#5.22.55) for more information.
- Updated the following Test Kitchen drivers:

  - Updated kitchen-azurerm to v1.13.1.
  - Updated kitchen-digitalocean to v0.16.1.
  - Updated kitchen-dokken to v2.20.6.
  - Updated kitchen-ec2 to v3.19.0.
  - Updated kitchen-google to v2.6.1.
  - Updated kitchen-hyperv to v0.10.1.
  - Updated kitchen-openstack to v6.2.1.
  - Updated kitchen-vra to v3.3.3.
  - Updated kitchen-vagrant to v2.0.1.

### Security

- Updated libarchive from 3.6.2 to 3.7.4 to resolve the following CVE:

  - [CVE-2024-37407](https://www.cvedetails.com/cve/CVE-2024-37407/)

- Updated Go from 1.21.5 to 1.22.5 to resolve the following CVEs:

  - [CVE-2024-24790](https://www.cvedetails.com/cve/CVE-2024-24790/)
  - [CVE-2024-24791](https://www.cvedetails.com/cve/CVE-2024-24791/)

## Chef Workstation 24.6.1066

### Improvements

- Added the Ruby implementation of c_rehash script to Chef Workstation. In the past, we've included c_rehash as a Perl script, but we stopped including Perl with Chef Workstation. ([#3234](https://github.com/chef/chef-workstation/pull/3234))

### Bug Fixes

- Fixed an error where the Chef Workstation App remains open in the tray icon after it's uninstalled on macOS.

### Components

#### Chef InSpec

- Updated Chef InSpec from 5.22.40 to 5.22.50. See the [InSpec release notes](https://docs.chef.io/release_notes_inspec/#5.22.50) for more information.

#### Chef Habitat

- Updated the Chef Habitat CLI from 1.6.652 to 1.6.1041. See the [Chef Habitat release notes](https://docs.chef.io/release_notes_habitat/) for a full list of improvements and features.

## Chef Workstation 24.4.1064

### Improvements

- Added support for FIPS in OpenSSL v3.

### Bug Fixes

- Fixed an issue with the Chef Workstation tray icon.

### Security

#### Libxml2

Updated the libxml2 to v2.12.5 to address the following CVE:

- [CVE-2024-25062](https://www.cvedetails.com/cve/CVE-2024-25062/)

### Components

#### Chef Infra Client

Updated Chef Infra Client to v18.4.12. See the [Chef Infra Client release notes](https://docs.chef.io/release_notes_client/) for a full list of improvements and features.

#### Fauxhai

Updated fauxhai-chef to v9.3.16. See the [fauxhai changelogs](https://github.com/chef/fauxhai/blob/main/CHANGELOG.md#v9316-2024-03-27) for more information.

#### kitchen-dokken

Updated kitchen-dokken to v2.20.4.

#### kitchen-google

Updated kitchen-google to v2.6.0, which replaces the google-api-client Ruby gem with google-apis-compute-v1.

#### kitchen-vagrant

Updated kitchen-vagrant to v2.0.0. See the [changelogs](https://github.com/test-kitchen/kitchen-vagrant/blob/main/CHANGELOG.md#200-2024-02-14) for more information.

#### knife-ec2

Updated knife-ec2 to v2.1.6, which adds support for the gp3 and io2 volume types.

## Chef Workstation 24.2.1058

### Packaging

#### Amazon Linux 2023 packages

We now produce Amazon Linux 2023 packages for Chef Workstation for x86_64 and AArch64 architectures.

**Note**: Chef Habitat isn't bundled with Chef Workstation for Amazon Linux 2023 AArch64 architectures.

### Components

#### InSpec

Updated Chef InSpec from 5.22.36 to 5.22.40. See the [InSpec release notes](https://docs.chef.io/release_notes_inspec/#5.22.40) for more information.

#### Cookstyle

Updated Cookstyle to [v7.32.7](https://github.com/chef/cookstyle/tree/v7.32.7).

### Security

#### Go

Updated Go from 1.21.3 to 1.21.5, which resolves the following CVEs:

- [CVE-2023-45285](https://www.cvedetails.com/cve/CVE-2023-45285/)
- [CVE-2023-45283](https://www.cvedetails.com/cve/CVE-2023-45283/)

#### zlib

Updated zlib from 1.3 to 1.3.1, which resolves the following CVEs:

- [CVE-2023-45853](https://www.cvedetails.com/cve/CVE-2023-45853/)

#### OpenSSL

Updated OpenSSL from 3.0.11 to 3.0.12, which resolves the following CVEs:

- [CVE-2023-5363](https://www.cvedetails.com/cve/CVE-2023-5363/)

## Chef Workstation 23.12.1055

### Improvements

- Replaced the previous Chef Workstation logo and icons with the new Progress Chef logo and updated the copyright date.
- Improved performance of `chef` CLI commands when using multiple cookbooks stored in Git repositories. Thanks [adsr](https://github.com/adsr)! ([#223](https://github.com/chef/chef-cli/pull/223))

### Components

#### Chef Infra Client

Updated Chef Infra Client from 18.2.7 to 18.3.0. See the [Chef Infra Client release notes](https://docs.chef.io/release_notes_client/) for a full list of improvements and features.

#### Chef InSpec

Updated Chef InSpec from 5.22.3 to 5.22.36. This update overhauls the `inspec check` and `inspec export` commands to improve security and addresses [CVE-2023-42658](https://www.cvedetails.com/cve/CVE-2023-42658/).

See the [InSpec release notes](https://docs.chef.io/release_notes_inspec/) for more information.

#### knife-vshpere

Updated knife-vsphere to [v5.2.0](https://github.com/chef/knife-vsphere/blob/main/CHANGELOG.md#v520-2023-11-06) to fix [CVE-2019-17383](https://github.com/advisories/GHSA-49pj-69vf-c689)

#### Berkshelf

Updated Berkshelf to 8.0.9 which resolves an issue where `berks install` fails due to a cert already being in the hash table.

#### Test Kitchen

Updated Test Kitchen to [v3.6.0](https://github.com/test-kitchen/test-kitchen/releases/tag/v3.6.0).

Updated the following Test Kitchen drivers:

- Updated kitchen-azurerm to [v1.13.0](https://github.com/test-kitchen/kitchen-azurerm/pull/264), which adds support for configurable VM prefix.
- Updated kitchen-digitalocean to [v0.16.0](https://github.com/test-kitchen/kitchen-digitalocean/blob/main/CHANGELOG.md#0160-2023-11-27), which exposes api_url of droplet_kit client as an environment variable. Thanks [biox](https://github.com/biox)!
- Updated kitchen-dokken to [v2.20.3](https://github.com/test-kitchen/kitchen-dokken/blob/main/CHANGELOG.md#2203-2023-11-28)
- Updated kitchen-google to [v2.5.0](https://github.com/test-kitchen/kitchen-google/blob/main/CHANGELOG.md#250-2023-11-28), which adds support for guest accelerator(s) configuration. Thanks [estedev](https://github.com/estedev)!
- Updated kitchen-hyperv to [v0.10.0](https://github.com/test-kitchen/kitchen-hyperv/blob/main/CHANGELOG.md#0100-2023-11-27).
- Updated kitchen-vra to [v3.3.2](https://github.com/test-kitchen/kitchen-vra/pull/66), which adds support for unique naming configuration for the deployments. Thanks [Rupesh0688](https://github.com/Rupesh0688)!

### Bug Fixes

- Fixed an issue with bundling the win32-security gem on Windows.
- Fixed an installation issue with the ruby-shadow gem.
- Fixed an error when installing Chef Workstation on D drive.

### Security

#### Go

Updated Go from 1.19.5 to 1.21.3.

#### OpenSSL

Updated OpenSSL to 3.0.11.

#### Git

Updated Git from 2.34.1 to 2.39.3, which resolves the following CVEs:

- [CVE-2023-29007](https://www.cvedetails.com/cve/CVE-2023-29007/)
- [CVE-2023-25652](https://www.cvedetails.com/cve/CVE-2023-25652/)
- [CVE-2023-23946](https://www.cvedetails.com/cve/CVE-2023-23946/)
- [CVE-2022-41953](https://www.cvedetails.com/cve/CVE-2022-41953/)
- [CVE-2022-41903](https://www.cvedetails.com/cve/CVE-2022-41903/)
- [CVE-2022-39260](https://www.cvedetails.com/cve/CVE-2022-39260/)
- [CVE-2022-24975](https://www.cvedetails.com/cve/CVE-2022-24975/)
- [CVE-2022-24765](https://www.cvedetails.com/cve/CVE-2022-24765/)
- [CVE-2022-23521](https://www.cvedetails.com/cve/CVE-2022-23521/)
- [CVE-2023-38545](https://www.cvedetails.com/cve/CVE-2023-38545/)

#### curl

Updated curl from 7.85.0 to 8.4.0 to resolve the following CVEs:

- [CVE-2022-32221](https://www.cvedetails.com/cve/CVE-2022-32221/)
- [CVE-2022-42915](https://www.cvedetails.com/cve/CVE-2022-42915/)
- [CVE-2022-42916](https://www.cvedetails.com/cve/CVE-2022-42916/)
- [CVE-2022-43551](https://www.cvedetails.com/cve/CVE-2022-43551/)
- [CVE-2023-23914](https://www.cvedetails.com/cve/CVE-2023-23914/)
- [CVE-2023-27533](https://www.cvedetails.com/cve/CVE-2023-27533/)
- [CVE-2023-27534](https://www.cvedetails.com/cve/CVE-2023-27534/)
- [CVE-2023-28319](https://www.cvedetails.com/cve/CVE-2023-28319/)
- [CVE-2023-38039](https://www.cvedetails.com/cve/CVE-2023-38039/)

#### libarchieve

Updated libarchieve from 3.5.2 to 3.6.2 to resolve the following CVE:

- [CVE-2022-36227](https://www.cvedetails.com/cve/CVE-2022-36227/)

#### libxml2

Updated libxml2 from 2.9.13 to 2.10.4 to resolve the following CVEs:

- [CVE-2022-40303](https://www.cvedetails.com/cve/CVE-2022-40303/)
- [CVE-2022-40304](https://www.cvedetails.com/cve/CVE-2022-40304/)

#### ncurses

Updated ncureses from 6.3 to 5.6 to resolve the following CVEs:

- [CVE-2023-29491](https://www.cvedetails.com/cve/CVE-2023-29491/)
- [CVE-2022-29458](https://www.cvedetails.com/cve/CVE-2022-29458/)

#### zlib

Updated zlib from 1.2.11 to 1.3 to resolve the following CVEs:

- [CVE-2023-45853](https://www.cvedetails.com/cve/CVE-2023-45853/)
- [CVE-2022-37434](https://www.cvedetails.com/cve/CVE-2022-37434/)
- [CVE-2018-25032](https://www.cvedetails.com/cve/CVE-2018-25032/)

## Chef Workstation 23.7.1042

### Updated Components

#### Chef InSpec

Updated Chef InSpec from 5.21.29 to 5.22.3. See the [Chef InSpec release notes](https://docs.chef.io/release_notes_inspec/) for a full list of improvements and features.

### Bug Fixes

- Updated the `chef` CLI to fix an issue where cookbook generator converge fails when run from the same parent directory as a new cookbook
- Updated Berkshelf to fix an issue where invalid Cookbook dependency versions were allowed to be uploaded using `berks upload`.

## Chef Workstation 23.5.1040

### Platform support

- Added support for RHEL 9. ([#3108](https://github.com/chef/chef-workstation/pull/3108))

### Bug Fixes

- Fixed an issue where `chef env` would not correctly handle the `-chef-license` flag. ([#3097](https://github.com/chef/chef-workstation/pull/3097))
- Updated the chef-apply gem from 0.9.4 to 0.9.6 to fix an issue loading YAML files. ([#3113](https://github.com/chef/chef-workstation/pull/3113/))
- Updated the `chef-cli` gem from 5.6.8 to 5.6.11 to address warnings that would appear when `chef shell-init` is run. ([#3109](https://github.com/chef/chef-workstation/pull/3109))

#### Test-Kitchen

- Updated the kitchen-azurerm gem from 1.10.5 to 1.12 to fix an issue when running `kitchen create` after using Azure CLI to log in using the Kitchen AzureRM Driver. ([#3100](https://github.com/chef/chef-workstation/pull/3100/))

## Chef Workstation 23.5.1039

This release doesn't have any release notes.

## Chef Workstation 23.4.1032

### Updated Components

#### Chef Infra Client

Updated Chef Infra Client from 18.0.185 to 18.2.7. See the [Chef Infra Client release notes](https://docs.chef.io/release_notes_client/) for a full list of improvements and features.

#### Chef InSpec

Updated Chef InSpec from 5.18.14 to 5.21.29. See the [Chef InSpec release notes](https://docs.chef.io/release_notes_inspec/) for a full list of improvements and features.

### Bug Fixes & Updates

- Fixed errors that occur when `knife ssl fetch` or `knife ssl check` is run.
- Updated cookstyle to fix an issue where `cron.deny` gets flagged as false positive.

## Chef Workstation 23.3.1030

### Updated Components

#### Chef Habitat CLI

Updated the Chef Habitat CLI from 1.6.521 to 1.6.652. See the [Chef Habitat release notes](https://docs.chef.io/release_notes_habitat/) for a full list of improvements and features.

#### Chef Workstation App

We removed the experimental dashboard that allows you to manage cookbooks on Windows and macOS from the Chef Workstation App.

### Bug Fixes & Updates

- Updated `chef-vault` to support the `client_key_contents` attribute. Thanks [Tyrael](https://github.com/Tyrael)!
- Updated `kitchen-vagrant` to correctly prune older bento boxes in use.
- Updated `kitchen-vagrant` to append `-arm64` to the bento box name automatically when run on this architecture.

## Chef Workstation 23.2.1028

### Updated Components

#### Chef Infra Client

Updated Chef Infra Client from 17.10.0 to 18.0.185, which comes with Ruby 3.1. See the [Chef Infra Client release notes](https://docs.chef.io/release_notes_client/) for a full list of improvements and features.

#### Chef InSpec

Updated Chef InSpec from 4.56.20 to 5.18.14. See the [Chef InSpec release notes](https://docs.chef.io/release_notes_inspec/) for a full list of improvements and features.

### Bug Fixes & Updates

- We fixed an error when opening the Chef Workstation App on macOS Ventura that states that "Chef Workstation App.app is damaged and can't be opened".

### Platform Packages

- We're no longer producing Debian 9 packages as Debian 9 is now end-of-life.

#### Test-Kitchen

- Updated `kitchen-dokken` to support a new `platform:` attribute. Thanks [nrocco](https://github.com/nrocco)!
- Updated `kitchen-dokken` to fix an issue where `kitchen login` fails if Docker is absent. Thanks [jmauro](https://github.com/jmauro)!
- Updated `kitchen-vra` to fix issues with catalog lookup using `catalog_name` and to deprecate the outdated `subtenant_id` attribute.

## Chef Workstation 22.12.1024

### New Features

#### Preview Feature

- The Chef Workstation App on Windows and macOS now includes a dashboard to help manage cookbooks. You can access the dashboard from the system tray menu.

### Bug Fixes & Updates

- Chef Workstation now supports Ubuntu 18, 20, and 22.
- Support for Ubuntu 16 is deprecated.
- The `chef export` command now works with Chef repositories located in deeply-nested directories on Windows.

#### Test-Kitchen

- Test-Kitchen is updated to fetch relevant data and run fallback/cleanup actions on test failure. Thanks [brycekahle](https://github.com/brycekahle)!
- Test-Kitchen is updated to support `net-scp` 4.0 & `net-ssh` 7.0. Thanks [tas50](https://github.com/tas50)!
- Updated `kitchen-dokken` plugin to support `systemd` based containers. Thanks [drehammond](https://github.com/drewhammond)!
- Updated `kitchen-ec2` to support MacOS M1 & M2 EC2 instances. Thanks [tecracer-theinen](https://github.com/tecracer-theinen)!
- Updated `kitchen-vagrant` to specify an optional provider in the configuration for use in auto-update and auto-prune commands.
- Updated `kitchen-vra` to align with the use of the `domain` attribute in lieu of the older `tenant` attribute.

## Chef Workstation 22.10.1013

### Improvements

Updated Test Kitchen to allow pattern-based [platform exclusions](https://github.com/test-kitchen/test-kitchen/pull/1828). Thanks [Annih](https://github.com/Annih)!

### Chef Habitat

Updated the Chef Habitat CLI to [1.6.521](https://docs.chef.io/release_notes_habitat/#1.6.521).

### Bug Fixes

The `chef report nodes` and `chef report cookbooks` subcommands now work with a FIPS-enabled Chef Infra Server when authentication based on Public-Key Cryptography Standards (PKCS) #8 is used.

#### Test Kitchen

- Fixed an [issue](https://github.com/test-kitchen/kitchen-vagrant/issues/476) with the `kitchen-vagrant` plugin that would create an incorrectly formatted `Vagrantfile`. Thanks [PowerKiKi](https://github.com/PowerKiKi)!
- Fixed an [issue](https://github.com/test-kitchen/kitchen-dokken/pull/262#issuecomment-1177232385) with the `kitchen-dokken` plugin so it will verify that the Docker `config.json` file exists before trying to parse credentials. Thanks [evandam](https://github.com/evandam)!

## Chef Workstation 22.7.1006

### Improvements

#### Test Kitchen

- `test-kitchen` has been updated to mask the sensitive data in debug logs.
- The `kitchen-dokken` plugin has been updated to read credentials from `config.json` when attempting to authenticate with the registry. Thanks [evandam](https://github.com/evandam)!

### Bug Fixes

- `knife-tidy` has been updated to address an issue where the `--keep-versions` flag would not account for node data. Thanks [ecottom](https://github.com/ecottom)!

### Backward Incompatibilities

- The reference to the default user gem path is now updated from `~/.chefdk` to `~/.chef`. This is made to avoid gem loading issues in MacOS. The backward incompatibility, if any, is relevant to a prior ChefDK installation (which is EOL) and not related to Chef Workstation installation.

## Chef Workstation 22.6.973

### Improvements

- Chef Workstation now includes `knife-vrealize`. This plugin is updated to work with VMware vRealize Automation (vRA) v8.

#### Test Kitchen Updates

- Updated the `kitchen-ec2` plugin to include support for configuring IMDSv2. Thanks [bdwyertech](https://github.com/bdwyertech)!
- The state of readiness of a newly created Windows instance is now detected much faster by the `kitchen-ec2` plugin. Thanks [jakauppila](https://github.com/jakauppila)!
- Added support for waivers in the `kitchen-inspec` plugin.
- `kitchen-vcenter` plugin now lets you specify multiple network interfaces while creating a VM from a template. Earlier, only one network interface could be specified.

### Bug Fixes

- Fixed an [issue](https://github.com/berkshelf/berkshelf/issues/1857) in Berkshelf where the `berks package` command returns incorrect file paths. Thanks [inopinatus](https://github.com/inopinatus)!
- Fixed an [issue](https://github.com/chef/cookbook-omnifetch/issues/35) in `cookbook-omnifetch` so that cached cookbooks can be used for ChefSpec testing. Thanks [karmix](https://github.com/karmix)!
- Fixed an issue in the `kitchen-vra` plugin which restores the ability to specify vRA users that aren't part of the default domain.
- Fixed an issue in the `kitchen-vra` plugin which will allow non-administrator vRA users to execute kitchen tests. Thanks [oshvarts](https://github.com/oshvarts)!

## Chef Workstation 22.5.923

### Improvements

- Updated the `berkshelf` gem to support Ruby 3.1.

### Bug Fixes

#### Test Kitchen Updates

- Updated the `kitchen-azurerm` plugin so that failures related to the `zone` parameter no longer appear. Thanks [@jasonwbarnett](https://github.com/jasonwbarnett)!

## Chef Workstation 22.4.861

### Improvements

- `train-winrm` added the option to allow SSL connection with certificates. In this case, the password isn't required.
- `chef env` now runs faster on all OSes, especially on Windows.
- `knife supermarket` commands are now additionally available to execute as `chef supermarket`. This is a preview feature.

#### Chef Infra Client 17.10.0

Updated Chef Infra Client from 17.9.52 to 17.10.0. See the [Chef Infra Client release notes](https://docs.chef.io/release_notes_client/#17.10.0) for a complete list of new features and updates.

#### Test Kitchen Updates

- `kitchen-vcenter` now supports adding a new network interface to the VM being cloned.
- `kitchen-vcenter` now works on Windows platforms.
- `kitchen-azurerm` introduces a new parameter `store_deployment_credentials_in_state` that defaults to `true`. Thanks [@jasonwbarnett](https://github.com/jasonwbarnett)!

#### Chef InSpec 4.56.19

Updated Chef InSpec 4.52.9 to 4.56.19. See the [Chef InSpec release notes](https://docs.chef.io/release_notes_inspec/#5.10.5) for a complete list of new features and updates.

### Bug Fixes

- The parameter `default_chef_server_http_client` is now set when used with CookbookOmnifetch. Thanks [@karmix](https://github.com/karmix)!
- `kitchen-azurerm` has temporarily disabled support for specifying a VM availability zone. This allows `kitchen create` to run successfully when the availability zone isn't configured.

## Chef Workstation 22.2.807

### Improvements

#### Cookstyle 7.32

Cookstyle has been updated from 7.31.7 to 7.32.

- A new `Chef/Deprecations/FoodcriticFile` cop detects the legacy `.foodcritic` configuration file used by Foodcritic
- The `Chef/Deprecations/Delivery` cop has been rewritten to avoid false positives due to caching. Thanks [@karmix](https://github.com/karmix)!

### Bug Fixes

- Failures running ChefSpec when using Policyfiles have been resolved

## Chef Workstation 22.2.802

### New Features

#### New Generators for Compliance Phase

We introduced support for Compliance Phase in the `chef generate` command. You can now create an InSpec `profile`, an `input` file, or a `waiver` file using the `chef generate profile`, `chef generate input`, or `chef generate waiver` commands. These files are created in the `compliance` subfolder within the cookbook folder of your repo.

#### Kitchen.ci Drivers Documentation

Updated the documentation for test-kitchen plugins in the [kitchen.ci](https://kitchen.ci/docs/drivers/) website. Users no longer need to look up driver documentation for separate plugins in GitHub.

### Improvements

#### Test Kitchen Updates

- kitchen-vra no longer requires the version property
- kitchen-azurerm now lets you define the zone of the VM. Thanks for this improvement [@pkazi](https://github.com/pkazi)!

#### Chef Infra Client 17.9.52

We updated Chef Infra Client from 17.9.26 to 17.9.52. See the [Chef Infra Client release notes](https://docs.chef.io/release_notes_client/#17.9.52) for a complete list of new features and updates.

#### Cookstyle 7.31.7

We updated Cookstyle from 7.31.1 to 7.31.7. This release updates the underlying RuboCop engine used by Cookstyle to 1.25.1, fixes a number of bugs, and improves issue detection in the `Chef/Modernize/CronDFileOrTemplate` cop. Thanks for these improvements [@yacn](https://github.com/yacn)!

#### Chef CLI Updates

- The `chef push` command now supports `--profile` option

### Bug Fixes

- Chef InSpec no longer fails when using VMware Transport.
- The `chef report cookbooks` command now correctly processes options such as `-p`.
- Resolved failures when using cookbooks defined in a Policyfile with ChefSpec.

## Chef Workstation 22.1.778

### New Features

#### VMware vRealize Automation Test Kitchen Support

Chef Workstation now includes the updated `kitchen-vra` plugin to support VMware's vRealize Automation 8.0. See the [Test Kitchen kitchen-vra documentation](https://kitchen.ci/docs/drivers/vra/) for more information on using this new plugin in vRealize Automation environments.

#### chef-run AIX Support

We updated the `chef-run` command for ad-hoc execution of Chef Infra Client on remote systems to support running on AIX systems. chef-run can now remotely manage Linux, macOS, Windows, Solaris, and AIX systems.

### Improvements

#### Chef Infra Client 17.9.26

We updated Chef Infra Client from 17.9.18 to 17.9.26. This update includes a fix for failures when running the homebrew_tap resource that was introduced in 17.9.18. See the [Chef Infra Client release notes](https://docs.chef.io/release_notes_client/) for a complete list of new features and updates.

#### Cookstyle 7.31.1

We updated Cookstyle from 7.26.1 to 7.31.1. This new release includes the latest RuboCop engine for improved cookbook issue detection and also includes several new and updated Chef Infra cops:

- The new `Chef/Security/SshPrivateKey` cop detects plain text private key content used within cookbooks that should be stored securely.
- The new `Chef/Correctness/InvalidNotificationResource` cop detects incorrect syntax in resource notifications.
- The new `Chef/Correctness/InvalidCookbookName` cop detects cookbook names which contain a period.
- The new `Chef/Deprecations/Delivery` cop detects the use of Chef Delivery / Workflow.
- `Chef/Deprecated/CookbookDependsOnPoise` now detects the usage of the `poise-hoist` cookbook.
- `Chef/RedundantCode/UseCreateIfMissing` now examines the `path` property in resources to detect more problematic resources.
- `Chef/RedundantCode/UseCreateIfMissing` now examines non-string values to detect more problematic resources.
- `Chef/Deprecations/DeprecatedChefSpecPlatform` now detects additional legacy platform versions in ChefSpec tests.

#### Updated Platforms for ChefSpec Tests

We've updated the Fauxhai project, which provides mock platform data for use in ChefSpecs. This new release has the following platform updates:

Added support for:

- macOS `12`
- Almalinux `8`
- Rocky Linux `8`

Deprecated support for:

- FreeBSD `11.2`
- macOS `11.0` and replaced it with `11`

#### curl 7.81

We updated the version of the curl command-line tool bundled with Chef Workstation from 7.80 to 7.81. This new release includes a large number of bug fixes. See the [curl 7.81 changelog](https://curl.se/changes.html#7_81_0) for more information.

### Backward Incompatibilities

#### Delivery CLI Removal

We removed the Delivery CLI tool from Chef Workstation as part of the December 31, 2020 end-of-life for Chef Workflow and Chef Delivery. Running this command will now show a warning and exit. We updated the `chef cookbook generate` commands so they no longer generate Workflow or Delivery content. We also added a new Cookstyle cop `Chef/Deprecations/Delivery` to detect cookbooks shipping with a `.delivery/project.toml` config.

### Packaging

#### Native Apple M1 Packages

We now produce macOS packages for Chef Workstation macOS for Intel and M1 (ARM) architectures. The new M1 packages eliminate the need for Apple's Rosetta framework when using Chef Workstation. We've also seen significant performance improvements with 28% faster knife command runtime on MacBook Air systems.

## Chef Workstation 22.1.745

### Performance

#### Improved Knife Performance

Improved the Knife command performance with optimizations to plugin loading. Windows users and users on non-SSD disks will see the most significant performance improvements from this update.

### Updated Components

#### Chef Infra Client 17.9.18

Updated Chef Infra Client from 17.8.25 to 17.9.18 with improvements to YUM support in the `package` resource, improved detection of VMware hypervisors, and supports for HashiCorp Vault Approle authentication in the `secrets` helper. See the [Chef Infra Client release notes](https://docs.chef.io/release_notes_client/) for a complete list of new features and updates.

#### Chef InSpec 4.52.9

Chef InSpec has been updated from 4.50.3 to 4.52.9 with many important fixes and improvements.

##### New Features

- Added remote target support for Alpine Linux.
- Added a CLI option for executing profiles from private Supermarkets.
- Added the ability to specify a proxy as a parameter in the `http` resource.
- Added a CLI option to set an SSH configuration file path for SSH transport.
- Added support for TLS 1.3 to the `ssl` resource.

##### Bug Fixes

- Fixed an edge case in the `service` resource where InSpec may falsely detect services as enabled on FreeBSD if that service is the suffix of another enabled service.
- Fixed the `ibmdb2_session` resource so that it now correctly accepts queries with clauses.
- Fixed the `oracledb_session` resource to properly handle nil in the query output.
- Fixed the `packages` resource to list only installed packages on Alpine Linux correctly.

#### Cookstyle 7.26.1

Updated Cookstyle from 7.25.10 to 7.26.1. This new version includes an updated RuboCop engine with improvements for code linting. New `Style/FileRead` and `Style/FileWrite` cops are also enabled to simplify file read/write code in libraries and resources.

#### Kitchen-ec2 3.12

Updated the Test Kitchen kitchen-ec2 plugin from 3.11.1 to 3.12.0. This new release allows you to define multiple tags in the `subnet_filter` configuration and ensures the system is properly terminated if there is a failure during the instance creation. Thanks for these improvements [@jakauppila](https://github.com/jakauppila)!

## Chef Workstation 21.12.720

### Bug Fixes

- The knife boostrap command's `--max-wait` no longer fails when connecting over WinRM

### Updated Components

#### InSpec 4.50.3

Chef InSpec has been updated from 4.49.0 to 4.50.3 which adds Windows support to the http resource.

#### Chef Infra Client 17.8.25

Chef Infra Client has been updated from 17.7.29 to 17.8.25. This new release includes Compliance Phase improvements along with a large number of resource improvements and fixes. See the [Chef Infra Client 17.8.25 Release Notes](https://docs.chef.io/release_notes_client/?v=17.8.25) for complete details on what's new in this version.

#### Chef Vault 4.1.5

Chef Vault has been updated to 4.1.5 to resolve issues where no results would be shown with the chef-vault` CLI.

#### Cookstyle 7.25.10

Cookstyle has been updated from 7.25.9 to 7.25.10. This new release updates the RuboCop engine used by Cookstyle to resolve a number of false positives and improve detection and autocorrection.

#### Test Kitchen

Test Kitchen has been updated from 3.1.1 to 3.2.2 and kitchen-ec2, kitchen-vagrant, kitchen-vcenter, and kitchen-dokken.

##### Bug Fixes

- Resolved failures using the `multiple_converge` config option when testing Windows systems. Thanks for this fix [@tecracer-theinen](https://github.com/tecracer-theinen)!
- Resolved failures cloning a VM without a network interface in the kitchen-vcenter driver. Thanks for this fix [@tecracer-theinen](https://github.com/tecracer-theinen)!
- Resolved output formatting issues when running the `kitchen diagnose` command.
- Resolved deprecation warnings in the kitchen-aws driver.

##### New Features

- Support for testing cookbooks that use the `compliance` directory introduced in Chef Infra Client 17.5.
- Added support for private Docker registries in the kitchen-dokken driver.
- Adds the ability to set `use_cached_chef_client` in the kitchen-vagrant driver to enable caching of Chef Infra Client packages on vagrant boxes not produced by Chef. Thanks for this improvement [@gaelik](https://github.com/gaelik)!

#### Chef CLI

The Chef CLI has seen significant performance improvements.

### Packaging

#### macOS 10.14 Package Removal

With the release of macOS 12, our N-2 macOS release policy now includes macOS 12, 11, and 10.15. macOS 10.14 packages will no longer be produced.

### Security

#### Ruby 3.0.3

Ruby has been updated from 3.0.2 to 3.0.3 to resolve the following CVEs:

- CVE-2021-41817
- CVE-2021-41816
- CVE-2021-41819

## Chef Workstation 21.11.679

### Improvements

#### Chef Infra Client 17.7.29

Chef Infra Client has been updated from 17.6.18 to 17.7.29 with improved secrets manager support for Azure Key Vault, improvements to agentless Chef Infra Client runs with Target Mode, and multiple updated resources. See the [Chef Infra Client 17.7.22 Release Notes](https://docs.chef.io/release_notes_client/?v=17.7.22) and [Chef Infra Client 17.7.29 Release Notes](https://docs.chef.io/release_notes_client/?v=17.7.29) for more details.

#### Chef InSpec 4.49.0

Chef InSpec has been updated from 4.46.13 to 4.49.0 with the following updates:

##### New Features

- Added support for testing Cassandra DB configurations and CQL commands.
- Added the CLI option `--filter-waived-controls` to increase execution speed when using waivers.
- Integrated `inspec check` with Cookstyle.

##### Bug Fixes

- Resolved case sensitivity issue for Windows `users` and `group` resources.
- Fixed the **oracledb_session** resource when invoking a query using OS user and DB role.
- Additional **oracledb_session** resource fixes.

#### Test Kitchen

Test Kitchen has been updated from 3.1.0 to 3.1.1 with improved progress logging in the `ssh` transport. Thanks [@karmix](https://github.com/karmix)!

#### Kitchen Dokken

The Test Kitchen plugin `kitchen-dokken` now includes colored output in the terminal to distinguish between multiple nodes converging at the same time and also includes improved support for Docker on Windows.

#### Kitchen EC2

The Test Kitchen plugin `kitchen-ec2` has been updated with better platform support and error handling:

- Test Kitchen no longer waits 300 seconds during `kitchen destroy` if the AWS instance was destroyed outside of Test Kitchen.
- Supports using vendor images of Windows 2022
- Supports using vendor images of Debian 10 or later

#### knife acl

The `knife acl` command now supports setting acls on `cookbook_artifacts` objects on the Chef Infra Server.

#### Habitat 1.6.420

Habitat has been updated from 1.6.351 to 1.6.420 with many behind-the-scenes updates.

#### Cookstyle 7.25.9

Cookstyle has been updated from 7.25.6 to 7.25.9 with many improvements to its code linting engine.

## Chef Workstation 21.10.640

### Updated Components

#### Chef Infra Client 17.6.18

Chef Infra Client has been updated from 17.4.38 to 17.6.18. This new release supports shipping InSpec profiles directly in cookbooks with a new `compliance` directory in cookbooks. It also adds support to the `secrets` helper for fetching secrets from HashiCorp Vault as well as Akeyless Vault. For a complete list of everything new in this release see the [Chef Infra Client Release Notes](https://docs.chef.io/release_notes_client/).

#### InSpec 4.46.13

Chef InSpec has been updated from 4.41.20 to 4.46.13 with the following enhancements:

- Added `rocky` and `almalinux` Linux distributions to `service` resource.
- Added the ability to handle files without headers in the `csv` resource.
- Added the option to establish a connection using a UNIX socket in the `postgres_session` resource.
- Fixed the --tags filter for dependent profiles.
- Fixed the --controls filter for dependent profiles.
- Fixed the `opa_cli` and `opa_api` resources so they're able to verify an empty result.

#### Cookstyle 7.25.6

Cookstyle has been updated from 7.24.1 to 7.25.6. This new release includes an updated RuboCop engine to resolve edge cases and adds the `Chef/Correctness/MetadataMissingVersion` cop to detect cookbooks that don't have a version defined in the `metadata.rb` file.

#### chef-vault

Chef Vault has been updated to allow uploading secrets that include a newline character (`\n`).

#### Test Kitchen

##### WinRM Certificate Authentication

Test Kitchen now supports certificate authentication with the WinRM transport. New WinRM transport configuration options `client_cert` and `client_key` control the certificate authentication behavior. See the [WinRM Transport Documentation](https://kitchen.ci/docs/transports/winrm/) for more information on this transport and these new configuration options. Thanks for adding this new capability [@gholtiii](https://github.com/gholtiii)!

##### Kitchen DigitalOcean

The Kitchen Digital Ocean driver now supports Debian 11 DigitalOcean droplets. Thanks for this new capability [@cedricverhaeghe](https://github.com/cedricverhaeghe)!

##### Kitchen vCenter

The Kitchen vCenter drive now supports passing `guestinfo` data to the test instances. Thanks for this new capability [@jasonwbarnett](https://github.com/jasonwbarnett)!

### Security

#### OpenSSL 1.0.2zb

OpenSSL has been updated from 1.0.2za to 1.0.2zb to resolve issues with Let's Encrypt certificates.

#### cacerts

The cacerts bundle has been updated to the 2021-09-30 release which removes older expired root certificates and adds the following new root certificates:

- AC RAIZ FNMT-RCM SERVIDORES SEGUROS
- GlobalSign Root R46
- GlobalSign Root E46
- GLOBALTRUST 2020
- ANF Secure Server Root CA
- Certum EC-384 CA
- Certum Trusted Root CA

### Packaging

Chef Workstation packages are now produced for the following operating systems:

- Windows 11
- Windows 2022
- macOS 12
- Debian 11
- Ubuntu 16.04 (no longer EOL)

## Chef Workstation 21.9.613

### Updated Components

#### Chef Infra Client 17.4

Chef Infra Client has been updated from 17.3.48 to 17.4.38. This new release includes a large number of improvements to the Infra Client Compliance Phase, simplifies fetching secrets with the `secrets` helper, and improves a large number of built-in resources. For a complete list of everything new in this release, see the [Chef Infra Client 17.4 Release Notes](https://docs.chef.io/release_notes_client/#whats-new-in-174)

#### InSpec 4.41.20

Chef InSpec has been updated from 4.38.9 to 4.41.20 with the following enhancements:

- Updated the git fetcher to handle profiles that have a default git branch that isn't `master`.
- Added support for Alibaba Cloud Linux 3 to the Chef InSpec service resource.
- Replaced the WMI command-line (WMIC) utility in the Chef InSpec security_identifier resource with Common Information Model (CIM) cmdlets as the WMIC utility will be deprecated soon.
- Adjusted the exit code to Normal when attempting to install a plugin that's already installed.
- Added new Open Policy Agent resources opa_cli and opa_api.
- Added new mongodb_session resource.
- The mssql_session resource now allows named connections by no longer forcing a port.
- The PostgreSQL resources (postgres_session, postgres_conf, postgres_hba_conf, and postgres_ident_conf) now work with Windows.
- Fixed a bug where the year in an expiration date was misinterpreted in waiver files.
- Fixed range-based filtering in filter tables.
- Fixed an issue in the Chef InSpec apache_conf resource when the ServerRoot isn't specified in the Apache configuration file.
- Fixed an issue when testing files with `chef exec` where the `--insecure` flag doesn't bypass SSL verification when downloading profiles over HTTPS.
- Fixed the `inspec --chef-license=accept` invocation to only show the license acceptance message and not show the InSpec CLI help command output.
- Fixed an error in the Chef InSpec postgres_session resource where the resource couldn't connect to a database.
- Fixed an error in the Chef InSpec apache_conf resource where it would overwrite any Apache configurations from the main Apache configuration file with configurations from any included configuration files.
- Fixed an error where the Chef InSpec `security_policy` resource returned a comma-separated string of local groups (rather than SIDs) instead of an array.
- Fixed a regression related to processing tags in certain formats using the `--tags` CLI option.

#### Knife

Knife has been updated to 17.4.47 to resolve an error running `knife client create`. Thanks for this fix [@jasonwbarnett](https://github.com/jasonwbarnett)!

#### chef-run

The chef-run command for ad-hoc execution of Chef Infra Client on remote systems has been updated to support running on Solaris systems. chef-run can now remotely manage Linux, macOS, Windows, and Solaris systems, with AIX support coming soon!

#### Cookstyle 7.24.1

Cookstyle has been updated from 7.15.4 to 7.24.1 with an updated RuboCop engine for improved performance as well as 18 new autocorrecting Chef Infra Cops:

- Chef/Correctness/MetadataMalformedDepends
- Chef/Correctness/PowershellFileExists
- Chef/Deprecations/DependsOnChefNginxCookbook
- Chef/Deprecations/DependsOnChefReportingCookbook
- Chef/Deprecations/DependsOnOmnibusUpdaterCookbook
- Chef/Deprecations/DeprecatedSudoActions
- Chef/Modernize/ClassEvalActionClass
- Chef/Modernize/DependsOnChefVaultCookbook
- Chef/Modernize/DependsOnChocolateyCookbooks
- Chef/Modernize/DependsOnKernelModuleCookbook
- Chef/Modernize/DependsOnLocaleCookbook
- Chef/Modernize/DependsOnOpensslCookbook
- Chef/Modernize/DependsOnTimezoneLwrpCookbook
- Chef/Modernize/DependsOnWindowsFirewallCookbook
- Chef/Modernize/UnnecessaryDependsChef15
- Chef/Modernize/UseChefLanguageCloudHelpers
- Chef/Modernize/UseChefLanguageEnvHelpers
- Chef/Modernize/UseChefLanguageSystemdHelper

#### Test Kitchen

Several Test Kitchen drivers received important updates to improve their reliability on specific hypervisors and clouds.

##### VMware vCenter

The Test Kitchen driver for VMware VCenter has been updated to avoid targeting ESXi systems in maintenance mode and to provide better errors when resources aren't found or the client lacks permissions on the cluster. Thanks for these improvements [@tecracer-theinen](https://github.com/tecracer-theinen)!

##### Microsoft Hyper-V

The Test Kitchen driver for Microsoft Hyper-V received updates to allow specifying remote Hyper-V hosts. See the [driver documentation](https://github.com/test-kitchen/kitchen-hyperv#using-remote-hyper-v-servers) for more details on specifying remote hosts. Thanks for this new feature [@tecracer-theinen](https://github.com/tecracer-theinen)!

##### HashiCorp Vagrant

The Test Kitchen driver for HashiCorp Vagrant has been updated to allow specifying existing VM disk images. Thanks for the initial pull request for this work [@stissot](https://github.com/stissot)!

##### Microsoft Azure

The Test Kitchen driver for Microsoft Azure has been updated to allow creating Virtual Machines with a maximum volume size of up to 2048GB. Thanks for this improvement [@jasonwbarnett](https://github.com/jasonwbarnett)!

### Security

#### OpenSSL 1.1.1l/1.0.2za

Updated OpenSSL to 1.1.1l on macOS and 1.0.2za on all other platforms to resolve the following CVEs:

- [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712)
- [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711)

#### libarchive 3.5.2

Updated the libarchive library that powers the archive_file resource from 3.5.1 to 3.5.2 to resolve security vulnerabilities in libarchive's handling of symbolic links.

### Improvements

The Chef Workstation CLI command `chef -v` has been optimised to fetch the component version details faster across all platforms.

## Chef Workstation 21.9.612

### Updated Components

#### Chef Infra Client 17.4

Chef Infra Client has been updated from 17.3.48 to 17.4.38. This new release includes a large number of improvements to the Infra Client Compliance Phase, simplifies fetching secrets with the `secrets` helper, and improves a large number of built-in resources. For a complete list of everything new in this release, see the [Chef Infra Client 17.4 Release Notes](https://docs.chef.io/release_notes_client/#whats-new-in-174)

#### InSpec 4.41.20

Chef InSpec has been updated from 4.38.9 to 4.41.20 with the following enhancements:

- Updated the git fetcher to handle profiles that have a default git branch that isn't `master`.
- Added support for Alibaba Cloud Linux 3 to the Chef InSpec service resource.
- Replaced the WMI command-line (WMIC) utility in the Chef InSpec security_identifier resource with Common Information Model (CIM) cmdlets as the WMIC utility will be deprecated soon.
- Adjusted the exit code to Normal when attempting to install a plugin that's already installed.
- Added new Open Policy Agent resources opa_cli and opa_api.
- Added new mongodb_session resource.
- The mssql_session resource now allows named connections by no longer forcing a port.
- The PostgreSQL resources (postgres_session, postgres_conf, postgres_hba_conf, and postgres_ident_conf) now work with Windows.
- Fixed a bug where the year in an expiration date was misinterpreted in waiver files.
- Fixed range-based filtering in filter tables.
- Fixed an issue in the Chef InSpec apache_conf resource when the ServerRoot isn't specified in the Apache configuration file.
- Fixed an issue when testing files with `chef exec` where the `--insecure` flag doesn't bypass SSL verification when downloading profiles over HTTPS.
- Fixed the `inspec --chef-license=accept` invocation to only show the license acceptance message and not show the InSpec CLI help command output.
- Fixed an error in the Chef InSpec postgres_session resource where the resource couldn't connect to a database.
- Fixed an error in the Chef InSpec apache_conf resource where it would overwrite any Apache configurations from the main Apache configuration file with configurations from any included configuration files.
- Fixed an error where the Chef InSpec `security_policy` resource returned a comma-separated string of local groups (rather than SIDs) instead of an array.
- Fixed a regression related to processing tags in certain formats using the `--tags` CLI option.

#### Knife

Knife has been updated to 17.4.47 to resolve an error running `knife client create`. Thanks for this fix [@jasonwbarnett](https://github.com/jasonwbarnett)!

#### chef-run

The chef-run command for ad-hoc execution of Chef Infra Client on remote systems has been updated to support running on Solaris systems. chef-run can now remotely manage Linux, macOS, Windows, and Solaris systems, with AIX support coming soon!

#### Cookstyle 7.24.1

Cookstyle has been updated from 7.15.4 to 7.24.1 with an updated RuboCop engine for improved performance as well as 18 new autocorrecting Chef Infra Cops:

- Chef/Correctness/MetadataMalformedDepends
- Chef/Correctness/PowershellFileExists
- Chef/Deprecations/DependsOnChefNginxCookbook
- Chef/Deprecations/DependsOnChefReportingCookbook
- Chef/Deprecations/DependsOnOmnibusUpdaterCookbook
- Chef/Deprecations/DeprecatedSudoActions
- Chef/Modernize/ClassEvalActionClass
- Chef/Modernize/DependsOnChefVaultCookbook
- Chef/Modernize/DependsOnChocolateyCookbooks
- Chef/Modernize/DependsOnKernelModuleCookbook
- Chef/Modernize/DependsOnLocaleCookbook
- Chef/Modernize/DependsOnOpensslCookbook
- Chef/Modernize/DependsOnTimezoneLwrpCookbook
- Chef/Modernize/DependsOnWindowsFirewallCookbook
- Chef/Modernize/UnnecessaryDependsChef15
- Chef/Modernize/UseChefLanguageCloudHelpers
- Chef/Modernize/UseChefLanguageEnvHelpers
- Chef/Modernize/UseChefLanguageSystemdHelper

#### Test Kitchen

Several Test Kitchen drivers received important updates to improve their reliability on specific hypervisors and clouds.

##### VMware vCenter

The Test Kitchen driver for VMware VCenter has been updated to avoid targeting ESXi systems in maintenance mode and to provide better errors when resources aren't found or the client lacks permissions on the cluster. Thanks for these improvements [@tecracer-theinen](https://github.com/tecracer-theinen)!

##### Microsoft Hyper-V

The Test Kitchen driver for Microsoft Hyper-V received updates to allow specifying remote Hyper-V hosts. See the [driver documentation](https://github.com/test-kitchen/kitchen-hyperv#using-remote-hyper-v-servers) for more details on specifying remote hosts. Thanks for this new feature [@tecracer-theinen](https://github.com/tecracer-theinen)!

##### HashiCorp Vagrant

The Test Kitchen driver for HashiCorp Vagrant has been updated to allow specifying existing VM disk images. Thanks for the initial pull request for this work [@stissot](https://github.com/stissot)!

##### Microsoft Azure

The Test Kitchen driver for Microsoft Azure has been updated to allow creating Virtual Machines with a maximum volume size of up to 2048GB. Thanks for this improvement [@jasonwbarnett](https://github.com/jasonwbarnett)!

### Security

#### OpenSSL 1.1.1l/1.0.2za

Updated OpenSSL to 1.1.1l on macOS and 1.0.2za on all other platforms to resolve the following CVEs:

- [CVE-2021-3712](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3712)
- [CVE-2021-3711](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3711)

#### libarchive 3.5.2

Updated the libarchive library that powers the archive_file resource from 3.5.1 to 3.5.2 to resolve security vulnerabilities in libarchive's handling of symbolic links.

### Improvements

The Chef Workstation CLI command `chef -v` has been optimised to fetch the component version details faster across all platforms.

## Chef Workstation 21.8.555

### Bug Fixes

- PowerShell DLLs for Chef Infra Client are now properly set up on Windows systems to prevent failures running Chef Infra Client.
- `knife bootstrap` now respects the `config_log_level` config when setting up `client.rb` configuration files on new Windows nodes.
- `knife bootstrap` with the `--use-sudo-password` no longer fails with a sudo error.
- `knife user create` now provides helpful error messages if the client can't be written to disk.
- `knife bootstrap` now properly supports the `~/.ssh/config` settings.
- Cookstyle no longer reports `Chef/Deprecations/ResourceWithoutUnifiedTrue` failures in custom resource partials.
- Cookstyle no longer reports `Chef/Deprecations/ResourceWithoutUnifiedTrue` failures when a custom resource file is empty.
- `chef generate cookbook` now generates cookbooks that require Chef Infra Client 16 or later.
- `chef generate cookbook` now generates example content referencing Chef Infra Client 17.

### Packaging

#### RHEL 8 Packages

We improved our RHEL 8 packages with additional RHEL 8 optimizations and EL8 in the filename.

## Chef Workstation 21.7.545

### Bug Fixes

#### Knife

- Resolved failures running `knife ssh` on hosts that require a PTY with a new `--pty` flag.
- Resolved `knife bootstrap` of Windows nodes from Chef Workstation on Linux/macOS incorrectly setting the file cache config.
- Resolved `knife bootstrap` of Linux nodes from Chef Workstation on macOS creating a `/Users` directory.

### Updated Components

#### InSpec 4.38.9

InSpec has been updated from 4.38.3 to 4.38.9:

##### New Features

- The mssql_session resource now allows named connections by no longer forcing a port.
- The PostgreSQL resources (postgres_session, postgres_conf, postgres_hba_conf, and postgres_ident_conf) now work with Windows.

##### Bug Fixes

- Fixed a bug where the year in an expiration date was misinterpreted in waiver files.

#### Chef Infra Client 17.3.48

Chef Infra Client has been updated from 17.2.29 to 17.3.48. This new release includes large improvements to Policyfiles, 9 new built-in resources, and initial support for fetching secrets from AWS Secrets Manager and Azure Key Vault. See the [17.3 release notes](https://docs.chef.io/release_notes_client/#whats-new-in-173) for more information.

#### Habitat 1.6.351

Habitat has been updated from 1.6.319 to 1.6.351 with updated internal libraries.

### Security

#### Addressable

We've updated the addressable gem from 2.7 to 2.8 to resolve [CVE-2021-32740](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-32740).

#### Ruby

We've upgraded Ruby from 3.0.1 to 3.0.2. This upgrade resolves bugs and also resolves the following CVEs:

- [CVE-2021-31810](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-31810)
- [CVE-2021-32066](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-32066)
- [CVE-2021-31799](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-31799)

#### curl

We've updated the bundled curl CLI from 7.76 to 7.77 to resolve the following CVEs:

- [CVE-2021-22901](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22901)
- [CVE-2021-22898](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22898)
- [CVE-2021-22897](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-22897)

## Chef Workstation 21.7.524

### Bug Fixes

- Resolved Ruby crashes that occurred intermittently when running `knife ssh` or `knife bootstrap`.

### New Features

#### Policyfile Improvements

##### Policyfile.rb metadata Helper

Policyfiles has a new `metadata` helper. This helper gets a local cookbook's `name` and `path` from the `metadata.rb` file instead of requiring them in the Policyfile.

Existing Policyfile:

```ruby
name "base" # cookbook name
run_list "base::default"
default_source :supermarket
cookbook "base", path: "." # cookbook path
```

Policyfile using the `metadata` helper:

```ruby
metadata # invokes the metadata helper
run_list "base::default"
default_source :supermarket
```

##### Defined Policy Groups in Exports

The `chef export` command now includes a new `--policy_group` flag that allows you to define a policy group (a set of hosts in a deployed unit) in the exported tarball.

#### Cookstyle 7.15.1

Cookstyle has been updated from 7.13 to 7.15.1 with additional cops and an updated RuboCop engine.

##### RuboCop 1.18.3

The RuboCop engine that powers Cookstyle has been updated to 1.18.3. This new release improves autocorrection and resolves a large number of detection errors.

##### New Cops

We added Chef InSpec-specific Cookstyle Cops to the `InSpec/Deprecations` department. These cops help with the migration from InSpec `attributes` to `inputs`. Watch for additional deprecation and correctness cops for InSpec in the future. You can also [request a new cop](https://github.com/chef/cookstyle/issues/new?assignees=&labels=Status%3A+Untriaged%2C+New+Cop+Proposal&template=NEW_COP_REQUEST.md) for Chef InSpec!

##### InSpec/Deprecations/AttributeDefault

The `Chef/Deprecations/AttributeDefault` cop detects Chef InSpec profiles that use the deprecated pattern of passing the `default` option to `attribute` or `input` helpers instead of passing it to the newer `value` option.

`Enabled by default`: True

`Autocorrects`: True

##### InSpec/Deprecations/AttributeHelper

The `Chef/Deprecations/AttributeHelper` cop detects Chef InSpec profiles that use the deprecated `attribute` helper instead of the `input` helper.

`Enabled by default`: True

`Autocorrects`: True

##### Chef/Deprecations/PolicyfileCommunitySource

The `Chef/Deprecations/PolicyfileCommunitySource` cop detects Policyfile.rb files that set a `default_source` of `:community`. This source is deprecated and is an alias to the `:supermarket` source, which should be used instead.

`Enabled by default`: True

`Autocorrects`: True

#### Test Kitchen Improvements

##### New default chef_infra Provisioner

We renamed the `chef_zero` Test Kitchen provisioner to `chef_infra`, making it clear that it's the preferred provisioner for testing Chef Infra cookbooks. This change is backward-compatible, so your existing `kitchen.yml` configurations will still work. We also changed Test Kitchen's default provisioned from `chef_solo` to `chef_infra`. Even if you leave the provisioner configuration unassigned, you will still get Chef Infra cookbook testing. To test with Chef Solo, you need to set the provisioner to `chef_solo` explicitly.

##### Berkshelf / Policyfiles Update Automatically

We changed Test Kitchen to automatically run `berks update` or `chef update` before testing, so you're always testing the latest cookbook code on your workstation. If you prefer to test an existing `Policyfile.lock` without updating it, add `always_update_cookbooks false` to the provisioner section of your `kitchen.yml` file.

##### Specifying Policy Groups

We added a new `policy_group` configuration that allows setting the policy group for testing a cookbook. Set this in the provisioner block or individual suites.

```yaml
suites:
  - name: default
    policy_group: production
    run_list:
      - recipe[base]
```

##### Attaching Elastic Network Interfaces in AWS

We added a new `elastic_network_interface_id` configuration option that allows you to specify the Elastic Network Interface ID attached to new AWS test instances.

```yaml
driver:
  name: ec2
  elastic_network_interface_id: eni-0545666738adeed14
```

#### Ubuntu FIPS Support

Chef Workstation Ubuntu packages are now FIPS enabled for all your FedRAMP needs.

## Chef Workstation 21.6.497

### Regression Fixes

- The Chef Workstation toolbar app now properly shows the installed version of Workstation.
- Resolves failures running Berkshelf, including failures running ChefSpec in GitHub actions when cookbooks use Berkshelf for depsolving. Thanks for these fixes [@ramereth](https://github.com/ramereth)!
- Resolved ChefSpec failures on Windows.

### Updated Components

#### Knife

Knife has been updated to 17.2.38 with support for Curve25519 SSH key exchange.

#### Test Kitchen

Test Kitchen has been updated to 2.12.0:

##### Bug Fixes

- Fixes failures running the `kitchen console` command which were caused by changes in Ruby's `pry` gem. Thanks for this fix [@jayaddison-collabora](https://github.com/jayaddison-collabora)!
- Test Kitchen will now continue to run even if an SSH connection fails in `lifecycle_hooks` and `skippable` is set to `true`. Thanks for this fix [@tarcinil](https://github.com/tarcinil)!

##### Slow Resource Report Support

Test Kitchen now supports Chef Infra Client 17.2's new slow resource report for displaying the slowest resources in a Chef Infra Client run. You can enable this report by setting the `slow_resource_report` configuration option in the `chef-zero` provisioner:

```
provisioner:
  name: chef_zero
  # set the configuration value to true to display the 10 slowest resources
  # or set it to the number of resources you'd like to display
  slow_resource_report true
```

#### Kitchen Dokken

The Kitchen Dokken driver for testing Chef Infa cookbooks in Docker containers has been updated to 2.13:

##### Bug Fixes

- Fixes execution failures on Windows. Thanks for this fix [@jakauppila](https://github.com/jakauppila)!
- Fixes failures when running on Podman instead of Docker. Thanks for this fix [@tomhughes](https://github.com/tomhughes)!

##### Slow Resource Report Support

Kitchen Dokken has also been updated to support Chef Infra Client 17.2's new slow resource report for displaying the slowest resources in a Chef Infra Client run. You can enable this report by setting the `slow_resource_report` configuration option in the `dokken` provisioner:

```
provisioner:
  name: dokken
  # set the configuration value to true to display the 10 slowest resources
  # or set it to the number of resources you'd like to display
  slow_resource_report true
```

#### Chef InSpec 4.37.30

Chef InSpec has been updated from 4.37.25 to 4.37.30 with the following bugfixes:

- Fixed the mysql_session resource to raise an exception if there is an error in a connection or query.
- Fixed the postgres_session resource to raise an exception if there is an error in a connection or query.

## Chef Workstation 21.6.479

### Bug Fixes

- Resolved errors from running various knife commands.

### Upgraded Components

#### Ruby 3.0

Ruby has been updated from 2.7.3 to 3.0.1. The Ruby 3.0 release includes improved performance and aligns Chef Workstation with the release of Ruby in Chef Infra Client 17 for maximum compatibility.

#### Chef Infra Client 17.2

Chef Infra Client has been updated from 17.1 to 17.2. This release includes a new `--slow-report` flag for displaying the slowest resources in a client run, improved allowlist/denylist functionality with Automate reporting, and many improved resources. See the [Chef Infra Client Release Notes](https://docs.chef.io/release_notes_client/#whats-new-in-172) for complete details

#### Chef InSpec 4.37.23

Chef InSpec has been updated from 4.37.20 to 4.37.23:

##### Improvements

- Updated the `inspec init plugin` command
  - The values of flags passed to the `inspec init plugin` command are now wrapped in double quotes instead of single quotes.
  - Template files are now ERB files.
  - The `activator` flag replaces the `hook` flag, which is now an alias.

##### Backward Incompatibilities

- Removed support for Chef Compliance Server and Chef Automate 1 from the `inspec automate` command, as both products are EOL.

#### Knife Azure

The knife-azure plugin has been updated from 3.0.6 to 4.0.0. This major release removes the legacy `knife azure` commands that were based on the Azure ASM API deprecated in 2018. `knife azurerm` commands will continue to function as they're based on the modern Azure ARM API.

#### Kitchen InSpec

The `kitchen-inspec` plugin has been updated to from 2.4.1 to 2.4.3, which adds a `forward_agent` option for connecting to the host using SSH Agent Forwarding.

### Security

#### Nokogiri

Nokogiri was updated to 1.11.7 to resolve [CVE-2020-26247](https://nvd.nist.gov/vuln/detail/CVE-2020-26247).

## Chef Workstation 21.6.467

### Bug Fixes

- Failures running `knife org user add` are resolved.
- Failures running `knife configure` are resolved.

## Chef Workstation 21.5.462

### Updated Tools

#### Chef Infra Client 17.1

Chef Infra Client has been updated from 17.0 to 17.1. This new release includes improvements to the Chef Infra Client Compliance Phase, Unified Mode improvements, and updates to many built-in resources. See the [Chef Infra Client 17.1 Release Notes](https://docs.chef.io/release_notes_client/#whats-new-in-171) for details on new functionality.

#### Chef InSpec 4.37.20

Chef InSpec has been updated from 4.36.4 to 4.37.20 with the following bug fixes and improvements:

##### Improvements

- Added support for `zfs_pool` and `zfs_dataset` resources on Linux.
- Improved `port` resource performance: adding more specific search while using `ss` command.
- A new `inspec automate` command replaces the `inspec compliance` command, which is now deprecated. This command also fully validates credentials before storing them to disk.

##### Bug Fixes

- The `file` resource `more_permissive_than` matcher returns nil instead of throwing an exception when the file doesn't exist.
- The `http` resource response body is now coerced into UTF-8.
- Fixed an error when using profile dependencies and require_controls.
- Fixed the windows_firewall_rule resource when it failed to validate more than one rule.
- Modified the windows_feature resource to indicate if a feature is enabled rather than just available.
- `inspec detect --no-color` returns color-free output

#### Chef Habitat 1.6.319

The Chef Habitat CLI has been updated from 1.6.288 to 1.6.319 with performance and stability improvements.

#### Chef CLI 5.1

The Chef CLI has been updated to 5.1. This new release includes a new `--yaml` flag for the `chef generate cookbook` command to generate example YAML Chef Infra cookbooks.

#### Knife 17.2

The Knife CLI has been updated from 17.0 to 17.2, which includes several fixes for failures running knife commands.

#### Cookstyle 7.13

Cookstyle has been updated from 7.10 to 7.13 with the following improvements:

- Cookstyle now targets Ruby 2.5 or later allowing Cookstyle to simplify some complex codebases to use new Ruby functionality.
- A new `Chef/Deprecations/HWRPWithoutUnifiedTrue` cop detects custom resources that don't set `unified_mode true`. These resources will produce deprecation warnings in Chef Infra Client 17.0 or later as the Unified Mode will become the default in Chef Infra Client 18 (April 2022). Setting `unified_mode true` in custom resources today allows you to ensure they will continue to function as expected in future Chef Infra Client releases.
- Fixed false positives in the `Chef/Modernize/WindowsRegistryUAC` resource.
- Improved how we exclude `vendor` and `files` directories so that Cookstyle can run in cookbooks contained in directories named `vendor` or `files`.
- Updated the RuboCop engine used by Cookstyle to 1.15 with a significant number of detection and autocorrection improvements.

### Security

#### TLS 1.3 Support on macOS

macOS builds of Chef Workstation now ship with OpenSSL 1.1.1, which enables TLS 1.3 communication with Chef services.

### Known Issues

Chef Workstation 21.5.420 introduced a regression causing failures when running some knife commands. We're currently working towards a fix for this issue which we hope to ship in the next release of Chef Workstation. If you encounter failures running knife commands, please install [Chef Workstation 21.4.365](https://downloads.chef.io/tools/workstation/stable?v=21.4.365)

## Chef Workstation 21.5.420

### Breaking Changes

#### Chef CLI

The `chef shell-init` CLI command checks for the Chef Workstation PATH variable before adding it, ensuring that it appears only once in your PATH.

We removed two legacy Chef Workflow (Delivery) commands in the chef-cli (Chef Workflow reached end-of-life status in December 2020):

- `chef generate cookbook --workflow` now warns that the `--workflow` flag is no longer supported and generates a Chef cookbook---without the Chef Workflow build-cookbook.
- `chef generate build-cookbook` now alerts that build-cookbook generation is no longer supported and exits with an error.

#### Knife Changes

##### Renamed knife opc org commands

We've rewritten our knife-opc plugin and merged it into the main knife codebase. As part of this rewrite, the `knife opc org` commands have been renamed to `knife org`, and several of the user commands have merged into the existing `knife user` commands.

##### Renamed Commands

- knife opc org create -> knife org create
- knife opc org delete -> knife org delete
- knife opc org edit -> knife org edit
- knife opc org list -> knife org list
- knife opc org show -> knife org show
- knife opc org user add -> knife org user add
- knife opc org user remove -> knife org user remove

##### User Commands Now in Knife User

- knife opc user create -> knife user create
- knife opc user delete -> knife user delete
- knife opc user edit -> knife user edit
- knife opc user list -> knife user list
- knife opc user password -> knife user password
- knife opc user show -> knife user show

##### Simplified knife user create syntax

The `knife user create` command previously required passing the user's display name, first name, last name, e-mail, and password in order as arguments. Only the e-mail and password values are actually required by Chef Infra Server, so we've simplified the syntax to allow passing just the required values. New flags have been introduced for each of the values and only the `--email` and `--password` flags are now required. The existing positional argument syntax will continue to work with a warning message, but will be removed in a future release.

#### Fauxhai updated to 9.0

The Fauxhai engine mocks Ohai data in ChefSpec tests. The 9.0 release removes all the deprecated Fauxhai definitions---the ones that warned you of their impending deprecation every time you used them this past year.

The Fauxhai community team removed platforms that:

- have reached end-of-life status and are no longer supported.
- have newer minor release versions available in Fauxhai.

The best practice for referencing platforms in ChefSpec tests is to use a platform's major version or no version at all, which lets Fauxhai automatically pick the latest version. This practice ensures that your specs will continue to run, even as new platforms are released and older ones are removed.

To automatically migrate ChefSpec tests to use newer platforms, use the [Chef/Deprecations/DeprecatedChefSpecPlatform](https://docs.chef.io/workstation/cookstyle/cops/chef_deprecations_deprecatedchefspecplatform/) Cookstyle cop. This cop will autocorrect many specs. Run it with:

```
cookstyle -a --only Chef/Deprecations/DeprecatedChefSpecPlatform
```

#### Fauxhai Platforms Removed

- AIX 6.1
- Amazon Linux 2015.03
- Amazon Linux 2015.09
- Amazon Linux 2016.03
- Amazon Linux 2016.09
- Amazon Linux 2017.03
- Amazon Linux 2017.09
- CentOS 5.11
- CentOS 6.9
- CentOS 7.5.1804
- CentOS 7.6.1810
- Debian 8.11
- Debian 9.8
- Debian 9.9
- Fedora 29
- Fedora 30
- FreeBSD  11.1
- Linux Mint 18.3
- macOS 10.13
- OpenSUSE 15.0
- OpenSUSE 15.1
- Oracle Linux 5.11
- Oracle Linux 6.9
- Red Hat Linux 5.11
- Red Hat Linux 6.9
- Red Hat Linux 7.4
- Red Hat Linux 7.5
- Red Hat Linux 7.6
- Suse Enterprise Linux 12.3
- Ubuntu 14.04
- Windows 20008 R2

### Improvements

#### Chef Infra Client 17

Chef Workstation now includes Chef Infra Client 17 with the new Compliance Phase and many other improvements. For a complete list of what's new, see the [Chef Infra Client 17.0 Release Notes](https://docs.chef.io/release_notes_client/#whats-new-in-170) and our [Chef Infra Client 17 Launch Webinar](https://www.youtube.com/watch?v=cj29Io6vrCI).

### Chef InSpec

Chef InSpec has been updated from 4.29.3 to 4.36.4 with the following improvements and bug fixes:

#### New Features

- Added the SELinux resource, which includes support for modules and booleans.
- Added the pattern input option for DSL and metadata inputs.
- Added the `members_array` property for group & groups resources.
- Train now reads the username and port from the `.ssh/config` file and will use these values if present.
- Added the new `--reporter-include-source` CLI option, which includes the source code of the controls in the output of the CLI reporter.
- Added ability to pass inputs to InSpec shell using input file and cli.
- Commands can now be set to timeout using the [command resource](https://docs.chef.io/inspec/resources/command/) or the [`--command timeout`](https://docs.chef.io/inspec/cli/) option in the CLI. Commands timeout by default after one hour.
- Added the [`--docker-url`](https://docs.chef.io/inspec/cli/) CLI option, which can be used to specify the URI to connect to the Docker Engine.
- Added support for targeting Linux and Windows containers running on Docker for Windows.

#### Bug Fixes

- Fix SSH Timeout PTY allocation. We fixed a bug that caused occasional failures in some command resources that use SSH transport and were mistakenly allocated a pseudoterminal (PTY) when setting a timeout. In some cases, the PTY changed how the resource was interpreted. This fix only uses PTY when explicitly requested.
- Fixed the group resource when a member doesn't exist.
- Hash inputs will now be loaded consistently and accessed as strings or symbols.

### Test Kitchen

#### Digital Ocean Driver Update

The `kitchen-digitalocean` driver update removes support for legacy platform values that no longer exist on Digital Ocean: `CoreOS`, `Ubuntu17`, `CentOS6` and it adds support for `RancherOS`. The Test Kitchen docs have a new [Digital Ocean getting started guide](https://kitchen.ci/docs/drivers/digitalocean/).

#### Amazon AWS Driver Update

The Amazon AWS `kitchen-ec2` driver update adds support for GP3 EBS volume types on instances and proper cleanup of EBS volumes on termination on RHEL-based platforms. Thanks for the GP3 fix [@bdwyertech](https://github.com/bdwyertech)!

#### Cookstyle updated to 7.10.1

This update improves offense detection and autocorrelation in Ruby code.

### Platform Support

Ubuntu 16.04 packages will no longer be produced for Chef Workstation as Ubuntu 16.04 became EOL at the end of April 2021.

### Security Updates

#### Ruby updated to 2.7.3

This Ruby version provides a large number of bug fixes and resolves the following CVEs:

- [CVE-2021-28966](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-28966)
- [CVE-2021-28966](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-28966)

#### git updated to 2.31.1

This update to the embedded git client in Chef Workstation resolves [CVE-2021-21300](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-21300)

## Chef Workstation 21.4.365

### macOS Support in chef-run

We've updated the `chef-run` command to allow resources to be executed against macOS nodes in addition to Linux and Windows nodes.

### Opt-In ChefSpec Specs

The `chef generate cookbook` will no longer generate ChefSpec tests by default. For many users ChefSpec tests add a minimal amount of quality assurance for their large level of complexity. We believe that users are overwhelmingly better off writing true integration tests with InSpec and Test Kitchen, as these tests are far more likely to detect real-world failure conditions. If you'd like to continue to generate sample ChefSpecs, you can run `chef generate cookbook --specs MY_COOKBOOK_NAME`.

### Improved Kitchen Dokken Configs

The `chef generate cookbook --kitchen dokken` command will now generate a Kitchen Dokken config that runs the container in privileged mode by default. This is necessary for testing any cookbook which includes a systemd unit. Since most cookbooks tested with Kitchen Dokken manage services this will make it easier to switch to Kitchen Dokken for quick test cycles.

### Autocompletion in fish Shell

We've updated the code snippet generated by the `chef shell-init fish` command to generate proper auto-complete commands for the fish shell. If you previously added the code generated by this command to your `~/.config/fish/config.fish` config file, you'll want to update that content with the new code. This will give you autocompletion helpers for all the `chef` sub-commands.

### Packaging Improvements

- Failures running Habitat on macOS systems have been resolved.
- On Linux and macOS systems symlinks are now created for `chef-zero`, `mixlib-install`, and `fauxhai` making Chef Workstation more functional for users that don't want to use the Chef Workstation Ruby installation as their system-wide Ruby installation.

## Chef Workstation 21.3.346

### Bug Fixes

- We resolved a failure running our embedded `curl` on macOS systems. Thanks for reporting this [@kmf](https://github.com/kmf).
- We updated the `chef-run` command to allow using symbols in resources defined on the command-line.
- We resolved frozen string errors that could occur in Test Kitchen. Thanks for the help with this [@tbugfinder](https://github.com/tbugfinder).
- [@signe](https://github.com/signe) fixed fetching the validation key from AWS S3 with `knife ec2`.

### Improvements

#### kitchen-dokken

We've improved how the Test Kitchen `dokken` driver handles Docker registries other than DockerHub. You should now be able to configure DockerHub mirrors without any requests being made to DockerHub. Thanks [@jaymzh](https://github.com/jaymzh)! We've also updated the `docker-api` gem to 2.1.0. The `docker-api` gem powers the dokken driver and this update adds support for running dokken against [Podman](https://podman.io/).

#### kitchen-azurerm

The Test Kitchen `azurerm` driver has been updated to use unique instance names by default to avoid conflicts. Systems will now be named `tk-RANDOMVALUE` instead of just `vm`. Thanks [@jasonwbarnett](https://github.com/jasonwbarnett)!

#### Cookstyle

Cookstyle has been updated from 7.8 to 7.9. This release includes an updated RuboCop engine with improved detection and autocorrection capabilities.

#### Chef Infra Client

Chef Infra Client has been updated to 16.11, with minor bug fixes. See the [Chef Infra Client Release Notes](https://docs.chef.io/release_notes_client/) for more details.

#### Chef InSpec

Chef InSpec has been updated from 4.26.13 to 4.29.3.

##### New Features

- The JSON metadata pass-through configuration has been moved from the Automate reporter to the JSON Reporter
- Added the option to filter out empty profiles from reports.
- Exposed the `conf_path`, `content`, and `params` properties to the `auditd_conf` resource.
- Added the ability to specify `--user` when connecting to docker containers.

##### Bug Fixes

- Fixed the `crontab` resource when passing a username to AIX.
- Stopped a backtrace from occurring when using `cmp` to compare `nil` with a non-existing file.
- The apt resource now correctly fetches all package repositories using the `-name` flag in an environment where ZSH is the user's default shell.
- The `--controls` option in `inspec exec` now correctly filters the controls by name.
- Updates how InSpec profiles are created with GCP or AWS providers so they use `inputs` instead of `attributes`.
- `inspec exec` will now fetch profiles via Git regardless of the name of the default branch.

### Security

#### Git

The embedded `git` client in Workstation has been updated to 2.30.2 to resolve [CVE-2021-21300](https://nvd.nist.gov/vuln/detail/CVE-2021-21300).

## Chef Workstation 21.2.303

### Improved Upgrade Behavior

Chef Workstation packages on Linux will now upgrade existing ChefDK installations. This matches the existing behavior on Windows and macOS systems.

### Improved Git Client

The embedded git client in Chef Workstation has been updated to 2.30.1. This new release includes improvements to `git diff` functionality as well as a large number of bug fixes.

### InSpec

InSpec has been updated to 4.26.13 with two bug fixes:

- Fixed skip_control to work on deeply nested profiles.
- The ssh_config and sshd_config resources now correctly use the first value when a setting is repeated.

### Test Kitchen

Several Test Kitchen plugins have been updated to improve the overall testing experience:

#### AzureRM

The `azurerm` Test Kitchen driver has been updated to improve backwards compatibility in the `public_ip_sku` configuration option with previous driver release.

#### InSpec

A regression in the Test Kitchen `inspec` has been resolved, which would cause failures when setting custom reporters.

#### Dokken

The Test Kitchen `dokken` driver/provisioner has been updated with a new `docker_registry` configuration option for specifying a Docker Registry other than DockerHub.

Example:

```yaml
driver:
  docker_registry: docker.sample.com
```

Note: The Docker Registry must container the `dokken` images for the platforms you want to test, the `chef` image, as well as the `centos` image that's used as part of the driver setup.

### Smaller Package Size

In order to further reduce the Chef Workstation installation size, we've removed the `yard` package from Chef Workstation. This package was never documented as being included in Chef Workstation and isn't required for any Chef product workflows.

## Chef Workstation 21.2.292

### Bug Fixes

We resolved two regressions in the 21.2.278 release of Chef Workstation:

- A failure in `mixlib-archive` when running `berks install`
- Failures using the `azurerm` provider in Test Kitchen

### Chef Infra Client

Chef Infra Client has been updated to 16.10.17. This release resolves two bugs:

- Fixed the `mount` resource for network mounts using the root level as the device. Thanks [@ramereth](https://github.com/ramereth)!
- Resolved a Compliance Phase failure with profile names using the `@` symbol.

### Test Kitchen

Several Test Kitchen plugins have been updated to improve the overall Test Kitchen experience:

#### Improved Windows Reliability

Windows detection for Chef Infra Client installations is now more reliable.

#### InSpec Plugin Configuration

A new `plugin_config` config option has been added to the `inspec` verifier for passing configs to InSpec plugins. Thanks for this improvement [@tecracer-theinen](http://github.com/tecracer-theinen)!

Example plugin config in a `kitchen.yml`:

```yaml
verifier:
  name: inspec
  plugin_config:
    example_plugin_name:
      example_setting: "Example value"
```

#### Azure Storage Account Types

The `storage_account_type` config option in the `azurerm` plugin is now honored. This allows you to set `storage_account_type: Standard_LRS` to use non-SSD disks in Azure. Thanks for this fix [@reasland](https://github.com/reasland) and [@Dreweasland](https://github.com/Dreweasland)!

#### Cloud-Init With OpenStack

The `openstack` Test Kitchen driver now includes a new `cloud_config` config option that allows you to pass config options to `cloud-init` for setting up systems before Chef Infra Client runs. Thanks for this improvement [@JimScadden](http://github.com/JimScadden)!

An example of setting the hostname at provision time:

```yaml
driver_config:
  cloud_config:
    hostname: my-hostname
```

### Cookstyle

Cookstyle has been updated to provide links to our new Cookstyle cop documentation on [docs.chef.io](https://docs.chef.io/).

### Security

OpenSSL has been upgraded to 1.0.2y to resolve the following CVEs:

- [CVE-2021-23841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23841)
- [CVE-2021-23839](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23839)
- [CVE-2021-23840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23840)

### Platform Updates

With the release of macOS 11 we will no longer produce packages for macOS 10.13 systems. See our [Platform End-of-Life Policy](https://docs.chef.io/platforms/#platform-end-of-life-policy) for details on the platform lifecycle.

## Chef Workstation 21.2.278

### Performance Improvements

We've improved the performance of many of the included command-line tools in Chef Workstation along with the performance of the Chef Workstation menubar application.

### Test Kitchen

The Kitchen vCenter driver has been updated to prevent failures while running on Windows hosts.

The Kitchen Azure driver now includes support for setting the public IP SKU with a new `public_ip_sku` driver configuration option thanks to [@simonjefford](https://github.com/simonjefford)! For example:

```yaml

platforms:
  - name: ubuntu-1804
    driver:
      image_urn: Canonical:UbuntuServer:18.04.4-LTS:latest
      vnet_id: /subscriptions/b6e7eee9-YOUR-GUID-HERE-03ab624df016/resourceGroups/pendrica-infrastructure/providers/Microsoft.Network/virtualNetworks/pendrica-arm-vnet
      subnet_id: subnet-10.1.0
      public_ip: true
      public_ip_sku: Standard
```

To learn more about this configuration option, see the [Azure Public IP Documentation](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-public-ip-address-upgrade?tabs=option-upgrade-powershell%2Coption-migrate-powershell).

### Chef-CLI

You can now rename the generator directory after generation without breaking generator usage.

### Berkshelf

Several potential race conditions in Berkshelf have been resolved. This may improve the reliability of testing multiple instances in Test Kitchen when Berkshelf is used for cookbook dependency resolution.

### Cookstyle

Cookstyle has been updated with the latest RuboCop engine for improved code issue detection and correction. Additionally, RuboCop's `Lint/ErbNewArguments` cop has been enabled to detect deprecated usage of the ERB class in libraries.

## Chef Workstation 21.2.259

#### Chef Infra Client 16.10

Chef Workstation now ships with Chef Infra Client 16.10. This new release includes expanded AWS Metadata support including IMDSv2 support, Alma Linux support, and resource updates. See the [Chef Infra Client 16.10 Release Notes](https://docs.chef.io/release_notes_client/#whats-new-in-1610) for more details on everything new in this release.

#### Policyfiles Improvements

We've improved how Policyfiles are handled in the `chef` command. Now running `chef install` when a `Policyfile.lock` isn't present will generate the lock file and install the cookbooks instead of producing an error. This mirrors the behavior of `bundle install` and other dependency management tools. We think this will make it easier to manage Chef Infra cookbooks in CI pipelines where a lock may or may not be generated yet. Thanks for reporting this issue [@coderanger](https://github.com/coderanger)!

We've also resolved a failure that would occur when testing cookbooks that use Policyfiles in ChefSpec. Thanks for reporting this issue [@ElfoLiNk](https://github.com/ElfoLiNk)!

#### Knife Bootstrapping Without Sudo

The `knife boostrap` command now supports elevating privileges on systems without `sudo` by using the `su` command instead. Use the new `--su-user` and `--su-password` flags to specify credentials for `su`.

#### Alma Linux Support

Chef Infra Client and Chef Workstation now support [Alma Linux](https://almalinux.org/), a new open-source RHEL fork produced by the CloudLinux team.

Chef Infra Client 16.10 and later now maps the `alma-linux` `platform` to the `rhel` `platform_family` value.

In Chef Workstation, we've also added support for testing cookbooks on Alma Linux with new [Alma Linux 8 Vagrant Images](https://app.vagrantup.com/bento/boxes/almalinux-8) for use in Test Kitchen on VirtualBox, Parallels, and VMware. You can use these images today in Test Kitchen by specifying this new box in your config as follows:

```yaml
platforms:
  - name: almalinux-8
```

#### Kitchen vCenter Windows Improvements

When using Test Kitchen's `vcenter` driver, you can now specify `administrator_password` to set the password on a Windows test instance's `Administrator` account. Thanks for this enhancement [@lomeroe](https://github.com/lomeroe)!

#### Updated Cookstyle

Cookstyle has been updated from 7.5 to 7.7. This new release includes an updated RuboCop engine for improved detection and autocorrection. It also enables RuboCop's `Lint/DeprecatedConstants` cop to detect deprecated `TRUE`, `FALSE`, and `NIL` constant values.

#### Amazon Linux 2 Packages

We now produce Chef Workstation packages for Amazon Linux 2. You can find these packages from [Chef Downloads](https://www.chef.io/downloads).

#### Security

We've updated the version of `curl` packaged with Chef Workstation to 7.75 to resolve the following curl CVEs:

- [CVE-2020-8286](https://nvd.nist.gov/vuln/detail/CVE-2020-8286)
- [CVE-2020-8285](https://nvd.nist.gov/vuln/detail/CVE-2020-8285)
- [CVE-2020-8284](https://nvd.nist.gov/vuln/detail/CVE-2020-8284)

## Chef Workstation 21.1.247

### Chef Infra Client

Chef Infra Client has been updated from 16.9.20 to 16.9.32.

- Resolved orphaned PowerShell processes when using Compliance Remediation content.
- Resolved failures from running `chef-client` on some Windows systems.
- Compliance Phase: Improved detection of the `audit` cookbook when it's used for compliance reporting.
- chef-shell: Added support for loading configs in `client.d` directories - Thanks [@jaymzh](https://github.com/jaymzh)!

### Chef InSpec

Chef InSpec has been updated from 4.24.32 to 4.26.14.

##### New Features

- You can now directly refer to settings in the `nginx_conf` resource using the `its` syntax. Thanks [@rgeissert](https://github.com/rgeissert)!
- You can now specify the shell type for WinRM connections using the `--winrm-shell-type` option. Thanks [@catriona1](https://github.com/catriona1)!
- Plugin settings can now be set programmatically. Thanks [@tecracer-theinen](https:/github.com/tecracer-theinen)!
- OpenSSH Client on Windows can now be tested with the ssh_config and sshd_config resources. Thanks [@rgeissert](https://github.com/rgeissert)!
- The `--reporter-message-truncation` option now also truncates the `code_desc` field, preventing failures when sending large reports to Automate.

##### Bug Fixes

- Updated the `oracledb_session` to use more general invocation options. Thanks [@pacopal](https://github.com/pacopal)!
- Fixed an error with the `http` resource in Chef Infra Client by including `faraday_middleware` in the gemspec.
- Fixed an incompatibility between `parslet` and `toml` in Chef Infra Client.
- Improved programmatic plugin configuration.

### Test Kitchen

Test Kitchen has been updated from 2.9 to 2.10.

#### Uploading Files In the Provisioner

Test Kitchen now allows you to upload files from your workstation to the test node within the provisioner. The new `uploads` config accepts a hash mapping local files to files on the remote test node. Thanks for this new feature [@tecracer-theinen](https://github.com/tecracer-theinen)!

##### Uploading a config file before running Chef Infra Client

```yaml
provisioner:
  name: chef_zero
  uploads:
    "foo.cfg": "/etc/foo.cfg"
```

#### Includes/Excludes Filters in Lifecycle Hooks

You can now exclude or include platforms from running in a lifecycle hook. This is particularly useful when running commands like `apt-get update` which can only be run on certain systems. Thanks for this new feature [@jasonwbarnett](https://github.com/jasonwbarnett)!

##### Excluding apt-get update on RHEL

```yaml
lifecycle:
  pre_converge:
    - remote: |
        "apt-get update"
      exclude:
        - rhel-7
        - rhel-8
```

#### Bug Fixes

- Resolved `uninitialized constant Kitchen::Loader::YAML::Psych` error - [@dwmarshall](https://github.com/dwmarshall)

### Kitchen Inspec Verifier

The kitchen-inspec verifier plugin has been updated from 2.2.2 to 2.3.0. This new release improves performance by setting the `backend_cache` config to `true` by default.

### Chef CLI

The Chef CLI has been updated to allow `chef generate` to properly create files in subdirectories.

## Chef Workstation 21.1.233

This release of Chef Workstation includes a small number of bug fixes and improvements from the previous 21.1.222 release.

### Chef Infra Client

Chef Infra Client has been updated from 16.9.16 to 16.9.20, which resolves issues from installing packages on newer FreeBSD releases and resolves errors from using the audit cookbook for compliance scans.

### Chef InSpec

Chef InSpec has been updated from 4.24.26 to 4.24.32, which reduces the size of some report data to avoid failures from pushing reports larger than 4MB to Chef Automate.

### kitchen-google

The kitchen-google plugin has been updated to use the latest version of Google's SDK with better support for newer services.

### knife-ec2

The knife-ec2 plugin has been updated to resolve an error where an EBS volume would be created when using the `ephemeral` option instead of attaching an ephemeral volume, and to resolve failures when bootstrapping Windows nodes if a password has not been provided. Thanks for reporting these issues [@DoctorOgg](https://github.com/DoctorOgg) and [@jerseyfoxcom](https://github.com/jerseyfoxcom)!

## Chef Workstation 21.1.222

### Updated Components

#### Knife

Chef Infra Client has been updated to 16.9 with the following improvements to the `knife` command:

- The `knife bootstrap` command now properly formats the `trusted_certs_dir` configuration value on Windows hosts. Thanks for this fix [@axelrtgs](https://github.com/axelrtgs)!
- The `knife bootstrap` command now only specifies the ssh option `-o IdentitiesOnly=yes` if keys are present. Thanks for this fix [@drbrain](https://github.com/drbrain)!
- The `knife status` command with the `-F json` flag no longer fails if cloud nodes have no public IP.

#### Chef InSpec

Chef InSpec has been updated from 4.24.8 to 4.24.26. This release includes several behind-the-scenes updates as well as a few useful resource updates:

- The `parse_config` resource now accepts `[` and `]` characters, which allows access to settings that contain dots. Thanks [@rgeissert](https://github.com/rgeissert)! ([#5252](https://github.com/inspec/inspec/pull/5252))
- The `mssql_session` resource expands its platform support to include macOS and Linux since the `sqlcmd` utility is now available on those platforms. Thanks [@kclinden](https://github.com/kclinden)! ([#5366](https://github.com/inspec/inspec/pull/5366))

#### Upgrade Lab

The `chef report` command in the Chef Upgrade Lab has been updated to work with the latest releases of Cookstyle.

#### Cookstyle

Cookstyle has been updated from 7.3 to 7.5. This new release updates the RuboCop engine that powers Cookstyle in order to improve detection and autocorrect of Ruby code. The new release also offers several improvements to existing Chef Infra cops:

- The `Chef/RedundantCode/UnnecessaryNameProperty` has been improved to detect additional cases where an unnecessary name property is defined in a resource.
- Trailing whitespace in files is once again detected by enabling the renamed `Layout/TrailingEmptyLines` cop. Thanks for reporting this issue [@mvangoor](https://github.com/mvangoor)!
- The `Chef/Deprecations/DeprecatedChefSpecPlatform` cop has been updated to detect newly deprecated platforms in Fauxhai when used in ChefSpec tests.

#### ChefSpec

Missing dependency errors running ChefSpec tests have been resolved. Thanks for the report [@y0y0z](https://github.com/y0y0z)!

#### Test Kitchen

Test Kitchen has been updated from 2.8.0 to 2.9.0. This new release improves connecting to Windows hosts over WinRM from Linux systems. Connections are now made using `xfreerdp` to avoid CredSSP error messages that previously occurred. If you're currently using the previous `rdesktop` solution, you'll need to install `xfreerdp`. This solution works out of the box without configuration, making it easier to test Windows guests on Linux hosts. Thanks [@ramereth](https://github.com/ramereth)!

#### knife-ec2

The knife-ec2 plugin for Amazon EC2 has been updated from 2.1.0 to 2.1.1 to properly report the instance name when running `knife ec2 server list`. Thanks for reporting this issue [@isaitgirl](https://github.com/isaitgirl)!

#### Fauxhai

Fauxhai was updated from 8.6 to 8.7. Fauxhai provides mock Ohai system configuration data for use in ChefSpec unit tests. This release marked several legacy OS datasets as deprecated. The mocked data for these platforms will be removed from Fauxhai in the April 2021 release:

- openSUSE 15.1
- Redhat 7.6
- CentOS 7.6
- Linux Mint 18.3
- All Amazon Linux 201X releases except 2018.03

To detect and update ChefSpec tests using this legacy data, run Cookstyle against your cookbooks.

### Backward Incompatibilities

The Chef Push Client and knife-push plugin are no longer included in Chef Workstation. Chef Push Jobs became EOL on Dec 31, 2020.

## Chef Workstation 20.12.205

### Chef Infra Client 16.8.14

Chef Infra Client has been updated to 16.8.14 with many improvements to built-in resources, as well as the following improvements to the `knife` CLI:

- `knife bootstrap` with the `--forward-agent` no longer results in an error. Thanks for fixing this [@drbrain](https://github.com/drbrain)!
- `knife bootstrap` no longer sets the SSH option `-o IdentitiesOnly` when no keys are specified. Thanks for fixing this [@drbrain](https://github.com/drbrain)!
- `knife ssh` with the `--no-host-key-verify` option no longer shows a deprecation warning. Thanks for reporting this issue [@bipinbachhao-lilly](https://github.com/bipinbachhao-lilly)!
- `knife ssh` with the `--ssh-password` option no longer results in an error. Thanks for reporting this issue [@evandam](https://github.com/evandam)!
- `knife ssh` with the `--sudo` flag will no longer silently fail. Thanks for fixing this [@rveznaver](https://github.com/rveznaver)!

### Chef InSpec

Chef InSpec has been updated to 4.24.8 including the following improvements:

- An unset `HOME` environment variable won't cause execution failures
- You can use wildcards in `platform-name` and `release` in InSpec profiles. Thanks for this improvement [@yarick](https://github.com/yarick)!
- The `WMI` resource now returns an array to support returning multiple WMI objects
- The `package` resource on Windows properly escapes package names. Thanks for this improvement [@ramereth](https://github.com/ramereth)!
- The `grub_conf` resource succeeds even if without a `menuentry` in the grub config
- Loaded plugins won't try to re-load themselves

### Cookstyle

Cookstyle has been updated to 7.3.11, which includes an updated RuboCop, two additional Chef Infra cops, and a large number of improvements to existing cops.

See the [Cookstyle 7.3.11 Release Notes](https://github.com/chef/cookstyle/blob/master/RELEASE_NOTES.md#cookstyle-73) for details.

### Kitchen-dokken

Kitchen Dokken has been updated to 2.11.2 to resolve failures from creating containers during the Test Kitchen converge. Thanks for reporting this issue [@emeshuris](https://github.com/emeshuris)!

### Chef Workstation App

We've improved the Chef Workstation menu bar app to make getting started with Chef Infra easier:

- We added links to the Chef Documentation and Learn Chef sites on the app menu bar, making it easier to find documentation for Chef products.
- Our Release Notes are on the Chef Documentation site, making them easier to find and read.
- The first time it launches, Chef Workstation creates the `.chef` directory with a sample `credential` file in your home directory (if you don't already have them), making the set-up process one step easier.

## Chef Workstation 20.12.187

### Breaking Changes

#### Foodcritic Removal

Foodcritic was deprecated in September 2019 and we're removing it in this release. In its place, Chef Workstation comes with Cookstyle, which has over 200 Chef Infra-specific rules. Foodcritic commands now result in an error message directing users to Cookstyle.

See our [Goodbye, Foodcritic](https://blog.chef.io/goodbye-foodcritic/) blog post for more details.

#### Stove Removal

We've removed the Stove binary, which was included in Chef Workstation, but not added to the default path. We added Stove's functionality of pruning files from artifacts uploaded to Supermarket (such as test files) to the `knife supermarket share` command. You no longer need `stove` to upload trimmed artifacts to Supermarket.

#### Red Hat 6 EOL

Red Hat 6 / CentOS 6 entered end-of-life on November 30th, 2020. We've removed platform support for RHEL 6 from our build matrix and will no longer publish packages. If you require Chef Workstation on a RHEL platform you'll need to upgrade to Red Hat or CentOS 7/8.

See Red Hat's [6.0 End of Maintenance Phase FAQ page](https://access.redhat.com/articles/4665701) for more information.

### Windows Bootstrap Improvements

We've improved the `knife bootstrap` experience for Windows. Windows hosts now respect the `knife bootstrap` `--secret` flag and sets up nodes correctly to use encrypted data bags. Thanks for reporting this issue [@AMC-7](https://github.com/AMC-7)! Additionally, we now force connections to use TLS 1.2 during the bootstrap procedure, which prevents failures on Windows 2012-2016. Thanks for this improvement [@TimothyTitan](https://github.com/TimothyTitan)!

### Updated Components

#### Chef Infra Client

Chef Infra Client was updated from 16.6 to 16.7. This new release includes significant performance improvements to Windows resources as well as extensive bug fixes throughout the codebase.

#### Habitat

Habitat was updated from 1.6.56 to 1.6.181, which includes a large number of studio and supervisor improvements.

#### git

The bundled git client was updated from 2.28 to 2.29.2. See the [git 2.29.0 release notes](https://raw.githubusercontent.com/git/git/master/Documentation/RelNotes/2.29.0.txt) for the most significant new functionality introduced in this release.

#### Test Kitchen

Test Kitchen was updated from 2.7.2 to 2.8.0. This release improves how we execute commands on Windows hosts in order to avoid failures executing commands that are too long for the windows command line. Thanks for this fix [@ramereth](https://github.com/ramereth)!

#### Kitchen Google

The Kitchen Google driver for Test Kitchen was updated from 2.0.3 to 2.1.0. This release adds a new `network_ip` config for an IPv4 internal IP address to assign to the instance. The driver automatically assigns an unused internal IP to an unconfigured `network_ip`. Thanks [@eReGeBe](https://github.com/eReGeBe) for this new feature!

#### Fauxhai

Fauxhai was updated from 8.4 to 8.6. Fauxhai provides mock Ohai system configuration data for use in ChefSpec unit tests. This release adds AIX 7.2 and macOS 11.0 platform data and deprecated the macOS 10.13 data.

## Chef Workstation 20.11.180

### Improvements

#### fauxhai

The `fauxhai` library is updated from 8.3.1 to 8.4.0 and includes new support for CentOS 7.8, RedHat 7.8, and openSUSE 15.2, as well as updates to existing platform data for Chef Infra Client 16.6.

#### Cookstyle

The Cookstyle linting tool has been updated from 6.21.1 to 7.2.1, with new cops and a new cop naming format.

##### New Cop Naming Format

Cookstyle now ships with the RuboCop 1.x engine. This new release of RuboCop has enabled us to improve the naming scheme for Cookstyle cops. Previously all Cookstyle cops started with `Chef` and then included the description of what the department actually did such as `ChefDeprecations`, which was for deprecation cops. Cop names are now three parts instead of two, so `ChefDeprecations/SomeCop` becomes `Chef/Deprecations/SomeCop`. Why the change? Using this format makes it much easier to enable just the Chef specific cops in Cookstyle without having to list each individual department. Now you can run `cookstyle --only Chef` to see just Chef Infra related cops without the additional few hundred Ruby specific cops provided by RuboCop. Cookstyle will automatically migrate any comments to the new department names, but anything in your .rubocop.yml will need to be updated manually.

**New Name Mapping**

- ChefCorrectness -> Chef/Correctness
- ChefDeprecations -> Chef/Deprecations
- ChefEffortless -> Chef/Effortless
- ChefModernize -> Chef/Modernize
- RedundantCode -> Chef/RedundantCode
- ChefSharing -> Chef/Sharing
- ChefStyle -> Chef/Style

##### New Cops

##### Style/CollectionCompact

The `Style/CollectionCompact` cop detects code that removes `nil` values from Hashes or Arrays using a Ruby block when this can be done with the `compact` method instead.

`Examples:`

Overly complex nil removals:

```ruby
array.reject { |e| e.nil? }
array.select { |e| !e.nil? }
```

Simpler nil removal:

```ruby
array.compact
```

##### Chef/Deprecations/FoodcriticTesting

The `Chef/Deprecations/FoodcriticTesting` cop detects cookbooks with a Gemfile that requires Foodcritic or any code, such as a Rakefile/Guardfile, that requires the Foodcritic gem. Foodcritic is no longer supported and has been significantly eclipsed in functionality by Cookstyle. Any existing Rakefile or Guardfile tests for Foodcritic should be updated to use Cookstyle instead.

`Enabled by default`: True

`Autocorrects`: False

##### Chef/Deprecations/LibrarianChefSpec

The `Chef/Deprecations/LibrarianChefSpec` cop detects ChefSpec tests that require the legacy `chefspec/librarian` library. Librarian Chef is no longer supported and users should migrate to Berkshelf or Policyfiles.

`Enabled by default`: True

`Autocorrects`: True

#### Chef InSpec

Chef InSpec is updated from 4.23.11 to 4.23.15. A bug fix included ensuring that waiver expiration data is always populated.

#### chef-vault

We've updated the release of `chef-vault` to 4.1. Chef Vault 4.1 properly handles escape strings in secrets and greatly improves performance for users with large numbers of secrets. Thanks for the performance work [@Annih](https://github.com/Annih)!

#### Kitchen Vagrant

The `kitchen-vagrant` plugin is updated from version 1.7.1 to 1.7.2 with a bug fix to no longer stop with an error when updating a Vagrant box that has not yet been downloaded.

#### Kitchen vCenter

The `kitchen-vcenter` plugin is updated from version 2.8.2 to 2.9.0, which includes support for Windows guest customization and improved support for nested datacenters.

## Chef Workstation 20.10.168

### Security Updates

Ruby has been updated to 2.7.2, which includes a fix for [CVE-2020-25613](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25613).

### Improvements

Install times on Windows systems are now 2.5x faster.

#### Chef Workstation Powershell Shortcut

We removed the administrator requirement from the PowerShell shortcut added to the Desktop on install. Users who desire this existing functionality should right-click and `Run as administrator` on this shortcut.

#### Chef Infra Client

Chef Infra Client has been updated from 16.5.77 to 16.6.14. This release adds support for Microsoft's `pwsh` (commonly known as PowerShell Core) in addition to its previous support for `PowerShell`. The [powershell_script](https://docs.chef.io/resources/powershell_script/) resource includes a new `interpreter` property that accepts either `powershell` or `pwsh`, the `powershell_out` and `powershell_exec` custom resource helpers have been updated with a new argument that accepts either `:pwsh` or `:powershell`, and the `powershell_exec` helper now supports the 32-bit version of Windows.

This release also improves the Target Mode feature by converting the majority of Ohai plugins to run remotely, adds a new [chef_client_config](https://docs.chef.io/resources/chef_client_config/) resource, and fixes various bugs.

#### Cookstyle

Cookstyle has been updated from 6.19.5 to 6.21.1. This release includes an updated RuboCop engine, improves scan times, fixes various bugs, and adds 3 new cops:

##### Lint/RedundantSafeNavigation

The `Lint/RedundantSafeNavigation` cop detects redundant save navigation operators in order to simplify code. For example `attrs&.respond_to?(:[])` can be simplified to just `attrs.respond_to?(:[])` because `respond_to?` won't error even if `attrs` isn't defined.

##### ChefCorrectness/OctalModeAsString

The `ChefCorrectness/OctalModeAsString` cop detects mode properties that incorrectly use a string to represent an octal value. We highly recommend using strings that contain a base 10 mode value, but even if you want to use octal values, they can't be passed as strings.

##### ChefDeprecations/UseYamlDump

The `ChefDeprecations/UseYamlDump` cop detects cookbooks that use the .to_yaml method. Chef Infra Client 16.5 introduced performance enhancements to Ruby library loading and due to the underlying implementation of Ruby's `.to_yaml` method, it doesn't automatically load the YAML library. We recommend using `YAML.dump()` instead, which is functionally equivalent, and also properly loads the YAML library.

#### Kitchen EC2

The `kitchen-ec2` gem has been updated from 3.7.2 to 3.8.0. This release allows multiple IP addresses to be specified when creating a security group and fixes a bug when creating spot instances.

#### Kitchen Dokken

The `kitchen-dokken` gem has been updated from 2.11.0 to 2.11.1 This release improves how kitchen-dokken determines if containers are available for connections.

#### knife-ec2

The `knife-ec2` plugin has been updated from 2.0.4 to 2.0.6. This release fixes an error that would occur when using the `--server-connect-attribute private_ip_address` flag.

## Chef Workstation 20.9.158

### Security Updates

#### OpenSSL 1.0.2w

OpenSSL has been updated to 1.0.2w, which includes a fix for [CVE-2020-1968](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2020-1968).

#### False Positive `chef.exe` Malware Detection

Recently we received reports that `chef.exe` was triggering users' anti-virus software. We confirmed that we're shipping the latest security patches that we can and aren't shipping malware to users. This is a false positive and we submitted a report as such to Microsoft. They corrected their security definitions and are no longer marking `chef.exe` as malware. If you get errors trying to run the `chef` command in PowerShell or have issues starting the Chef Workstation shell shortcut, most likely Windows Defender already quarantined your `chef.exe` executable. You can either un-quarantine that file or reinstall Chef Workstation to fix this issue.

We also submitted a false positive report to McAfee, but have yet to hear back from them.

### Improvements

#### Chef Infra Client

Chef Infra Client has been updated from 16.4.41 to 16.5.77. This release includes two new resources, updates to 10 existing resources, and the following CLI improvements:

- The client license acceptance logic has been improved to provide helpful error messages when an incorrect value is passed and to accept license values in any text case.
- A new `chef-client` process exit code of 43 has been added to signal that an invalid configuration was specified. Thanks [@NaomiReeves](https://github.com/NaomiReeves)!
- The `knife vault` commands now output properly formatted text when using `-f json` or `-f yaml` formatters.
- The `knife ssh` command no longer hangs when connecting to Windows nodes over SSH.
- The `knife config` commands have been renamed to make them shorter and table output has been improved:
  - `knife config get-profile` -> `knife config use`
  - `knife config use-profile [NAME]` -> `knife config use [NAME]`
  - `knife config list-profiles` -> `knife config list`
  - `knife config get` -> `knife config show`

#### Cookstyle

Cookstyle has been updated from 6.16.10 to 6.19.5. This release includes eight new Chef Infra cops and twelve new Ruby cops to help you identify deprecations and invalid code in your cookbooks. It also includes several performance and memory usage improvements to speed up Cookstyle scans.

#### Chef InSpec

InSpec has been updated from 4.22.22 to 4.23.11. This release includes a `--no-diff` CLI option to suppress diff output for textual tests, a `--sort_results_by` CLI option to sort control output, and implements a sensitive mechanism to hide sensitive output.

#### knife-opc

The `knife-opc` plugin has been updated from 0.4.6 to 0.4.7. This release includes a new `--all-info` flag for use with the `knife opc user list` command. This flag provides additional details on each listed user:

```
antima_gupta:
  display_name: Antima Gupta
  email:        agupta@example.com
  first_name:   Antima
  last_name:    Gupta
pivotal:
  display_name: Chef Server Superuser
  email:        root@localhost.localdomain
  first_name:   Chef
  last_name:    Server
```

#### kitchen-azurerm

The `kitchen-azurerm` plugin has been updated from 1.2.0 to 1.4.0. This release includes multiple bug fixes, as well as a new `use_fqdn_hostname` config option that forces using the instance's FQDN for all communication.

#### kitchen-dokken

The `kitchen-dokken` plugin has been updated from 2.10.0 to 2.11.0. This release works with newer Docker API releases and resolves Ruby 2.7 compatibility warnings.

#### kitchen-ec2

The `kitchen-ec2` plugin has been updated from 3.7.1 to 3.7.2. This release now avoids beta releases of Red Hat when searching for AMIs to converge.

#### kitchen-inspec

The `kitchen-inspec` plugin has been updated from 2.0.0 to 2.2.1. This release includes the ability to disable input caching in InSpec, as well as a fix for using the `junit` reporter under Test Kitchen.

#### kitchen-vcenter

The `kitchen-vcenter` gem has been updated from 2.7.12 to 2.8.2. This release includes the ability to enable IP customization using DHCP, as well as minor performance improvements.

### Performance Improvements

We made updates to `kitchen-azurerm` and Chef Infra Client, various knife gems to autoload dependencies. This should reduce the startup time of these gems by not trying to load a gazillion files on program startup. If these performance improvements function well, we plan to continue rolling this autoloading pattern to more gems to continue performance improvements.

### Bug Fixes

#### Chef CLI

The `chef install` command will no longer fail if a `Policyfile.lock.json` file exists, but no `Policyfile.rb` exists.

#### Test Kitchen

Test Kitchen has been updated from 2.6.0 to 2.7.2. This release fixes a bug when trying to use concurrency. Some plugins didn't support concurrency and would raise an exception when run concurrently. Plugins now run concurrently by default, and known non-concurrent ones are being marked as such. In this case that plugin will run serially. For example, the InSpec verifier isn't concurrent. If used with the AWS driver (for example) the machines would be created in parallel but verified serially.

## Chef Workstation 20.9.136

### Improvements

#### FIPS support

Starting with this release, we added FIPS support for Chef Workstation. This includes support for all the Ruby-based tools, such as `knife`, `chef-client`, and `kitchen`, but doesn't include support for some of our newer tools, such as the Chef Workstation App and the Upgrade Lab flow.

#### Chef Infra Client

Chef Infra Client has been updated from 16.4.38 to 16.4.41. This release:

- Resolves an error that would prevent ipaddress detection on Windows hosts
- Fixes failures running the knife configure command
- Refactors the `timezone` resource to properly load the existing timezone value in order to improve logging, and the data exposed to Chef Automate and handlers.

#### chef-run

`chef-run` has been updated to add support for YAML-based recipes introduced in Chef Infra Client 16. Users can specify a YAML recipe in the same way that they would normally specify a Ruby recipe, such as `chef run target chef_repo/recipes/my_recipe.yml`.

NOTE: We incorrectly said we released this feature in Chef Workstation 20.6.62, but the updated dependency wasn't pulled for that release. 

#### Chef Vault

Chef Vault has been updated from 4.0.6 to 4.0.11. This release raises a warning if the input of the vault admin is anything other than an array.

#### Cookstyle

Cookstyle has been updated from 6.15.5 to 6.16.10. This release makes Cookstyle 16% faster, while also improving detection in many existing Chef cops. The RuboCop engine that powers Cookstyle has been updated to 0.90 with improvements to greatly speed up autocorrection while consuming less memory. This release also fixes an issue where Cookstyle wasn't detecting invalid Ruby syntax.

#### Chef InSpec

Chef InSpec has been updated from 4.22.8 to 4.22.22. This release includes new `windows_firewall` and `windows_firewall_rule` resources, a `junit2` reporter, as well as numerous bug fixes and improvements.

#### Kitchen AzureRM

Kitchen AzureRM has been updated from 1.0.0 to 1.2.0. This release includes:

- Support for deletion or preservation of resource group tags with a new `destroy_explicit_resource_group_tags` config that defaults to `true`
- Default password generation increased to 25 characters to avoid failures on newer Windows releases
- Multiple README and documentation fixes. Thanks [@jasonwbarnett](https://github.com/jasonwbarnett)!

#### Kitchen vCenter

Kitchen vCenter has been updated from 2.7.9 to 2.7.12. This release allows storing the images created by Test Kitchen in nested folders. Thanks [@cattywampus](https://github.com/cattywampus)!

### Platform Packages

- We now produce macOS Big Sur (11.0) packages for Chef Workstation

## Chef Workstation 20.8.125

### Improvements

#### Chef Infra Client

Chef Infra Client has been updated from 16.3.45 to 16.4.38. This release resolves an issue with `knife bootstrap` that prevented bootstrapping Windows nodes from a non-Windows Workstation. It also updates 8 built-in resources.

#### Cookstyle

Cookstyle has been updated from 6.14.7 to 6.15.5. This updates the RuboCop engine to 0.89. This new release also enabled several new Ruby cops that were helpful in writing quality cookbooks and disabled several naming and code length cops that were not helpful when writing cookbooks.

#### Chef InSpec

InSpec has been updated from 4.22.1 to 4.22.8. This release adds a new `sensitive` parameter to MySQL and Postgres sessions that, when enabled, shows `REDACTED` in the command output. Thank you [@fzipi](https://github.com/fzipi)!

#### kitchen-vagrant

kitchen-vagrant has been updated from 1.6.1 to 1.7.0. This release adds new `box_auto_update` and `box_auto_prune` options to pull newer Vagrant base boxes. Thank you [@Stromweld](https://github.com/Stromweld)!

#### markdownlint

markdownlint (`mdl`) has been updated from 0.9.0 to 0.10.0. This release updates Dockerfile to work with modern markdownlint, updates the minimum version of kramdown, and updates the minimum version of RuboCop to consume security fixes.

#### Fauxhai

Fauxhai has been updated to 8.3.1 providing updated mocked Ohai platform data for use with ChefSpec. This release adds Debian 9.12 data, updates all Ubuntu releases to the latest patch releases, and updates CentOS 8 to be the 8.2 release. This release also deprecates several of the older platform versions so you may start to see additional platform deprecation warnings when running ChefSpec. To avoid these deprecations in the future make sure to specify just the major version of the platform when writing ChefSpec. For example, use Debian "10" instead of "10.3" to always use the latest version of Debian 10 data.

#### Chef Vault

Chef Vault has been updated to 4.0.6 to resolve errors when running some `knife vault` commands.

### Security

#### CA Root Certificates

The included `cacerts` bundle in Chef Workstation has been updated to the 7-22-2020 release. This new release removes 4 legacy root certificates and adds 4 additional root certificates.

#### Reduced Dependencies

We've audited the included dependencies that we ship with Chef Workstation to reduce the 3rd party code we ship. We've removed many of the embedded binaries that shipped with the package in the past, but were not directly used. We've also reduced the feature set built into many of the libraries that we depend on, and removed several Ruby gem dependencies that were no longer necessary. This reduces the future potential for CVEs in the product and reduces package size at the same time.

### Bug Fixes

#### Chef Workstation App

Chef Workstation App has been updated to fix a bug where dialog boxes would incorrectly pop up when the app started before internet connectivity was available causing the update check to fail. This no longer results in a dialog box and the update check will run after internet connectivity has been restored.

## Chef Workstation 20.8.111

### Improvements

#### .chef Home Directory

The first time you execute the `chef` command, it checks for the presence of the `~/.chef` directory. If it doesn't exist, `chef` creates it. Some tools included in Chef Workstation raise an error if that directory doesn't exist, so we're attempting to add more safeguards to ensure that it does.

#### Habitat Version Reporting

`chef -v` output has been updated to display the included Habitat version. We also updated the Chef Workstation App to include the Habitat version on the 'About' page.

#### Chef Infra Client

Chef Infra Client has been updated from 16.2.73 to 16.3.45.

We took a hard look at many of the terms we've historically used throughout the Chef Infra Client configuration sub-system and came to the realization that we weren't living up to the words of our [Community Code of Conduct](https://community.chef.io/code-of-conduct/). From the code of conduct: "Be careful in the words that you choose. Be kind to others. Practice empathy". Terms such as blacklist and sanity don't meet that bar so we've chosen to rename these configuration options:

- `automatic_attribute_blacklist` -> `blocked_automatic_attributes`
- `default_attribute_blacklist` -> `blocked_default_attributes`
- `normal_attribute_blacklist` -> `blocked_normal_attributes`
- `override_attribute_blacklist` -> `blocked_override_attributes`
- `automatic_attribute_whitelist` -> `allowed_automatic_attributes`
- `default_attribute_whitelist` -> `allowed_default_attributes`
- `normal_attribute_whitelist` -> `allowed_normal_attributes`
- `override_attribute_whitelist` -> `allowed_override_attributes`
- `enforce_path_sanity` -> `enforce_default_paths`

Existing configuration options will continue to function for now, but will raise a deprecation warning and will be removed entirely from a future release of Chef Infra Client.

This release includes the new `windows_firewall_profile` resource and updates eight existing resources. It also includes improvements to `knife`. See the [release notes](https://docs.chef.io/release_notes/#whats-new-in-16338) for full details!

This update resolves failures from negotiating protocol versions with the Chef Infra Server. It also improves log output on Windows systems in the `hostname` resource and adds support to the `archive_file` resource for pzstd compressed files.

##### Knife Improvements

- Ctrl-C can now be used to exit knife even when being prompted for input.
- `knife bootstrap` will now properly error if attempting to bootstrap an AIX system using an account with an expired password.
- `knife profile` commands will no longer error if an invalid profile was previously set.
- The `-o` flag for `knife cookbook upload` can now be used on Windows systems.
- `knife ssh` now once again accepts legacy DSS host keys although we highly recommend upgrading to a more secure key algorithm if possible.
- Several changes were made to knife to that may prevent intermittent failures running cookbook commands

#### Cookstyle

Cookstyle has been updated from 6.12.6 to 6.14.7. This release includes seven new cops, including ones to modernize resource writing and clean up `macos_userdefaults` usage.

#### Chef InSpec

InSpec has been updated from 4.21.3 to 4.22.1. This release includes the following improvements:

- The `=` character is now allowed for command line inputs.
- `apt-cdrom` repositories are now skipped when parsing out the list of apt repositories.
- Faulty profiles are now reported instead of causing a crash.
- Errors are no longer logged to stdout with the `html2` reporter.
- macOS Big Sur is now correctly identified as macOS.

#### knife-opc

`knife-opc` has been updated from 0.4.4 to 0.4.6. This release fixes hydrate errors raised when running `knife opc user edit USERNAME`.

#### Test Kitchen

Test Kitchen has been updated from 2.5.3 to 2.5.4. This update rolls back a change we introduced around fixing `root_path` usage. We're going to take another stab at fixing this and will include that in the next version of Chef Workstation.

##### kitchen-vcenter

kitchen-vcenter has been updated from 2.7.0 to 2.7.8. This release adds the ability to customize the guest OS as well as supporting data centers stored in folders. It also updates the vSphere interface gem (`rbvmomi`) to the latest major release.

## Chef Workstation 20.7.96

This release doesn't have any release notes.

## Chef Workstation 20.7.81

### Improvements

#### Chef CLI

The Chef CLI's `chef generate cookbook` command has been updated to generate a more complete `chefignore` file.

#### ChefSpec

ChefSpec was updated from 9.1 to 9.2 which now supports cookbooks that include Ohai plugins in the 'ohai' directory. It also adds support for Chef 16's `after_resource`.

#### Cookstyle

Cookstyle has been updated from 6.7 to 6.9 with an updated RuboCop engine and additional Chef Infra cops.

##### RuboCop 0.86

RuboCop has been updated to 0.86 which includes several bug fixes to prevent false positives and includes new autocorrection capabilities.

##### Improvements for Chef Infra Client 16.2

Chef Infra Client 16.2 contains additional changes to the way that resource names are specified in order to avoid edge cases in resource naming. When setting the name of a custom resource, `provides` should now be used instead of `resource_name`. When writing cookbooks that support Chef Infra Client earlier than version 16, you'll want to use both `provides` and `resource_name` to support all releases.

To support these changes we've made several updates to existing cops. The `ChefDeprecations/ResourceUsesOnlyResourceName` cop has been updated to add `provides` in addition to `resoure_name` instead of replacing `resource_name` with `provides`. This change ensures that cookbooks will continue to function on versions of Chef Infra Client prior to version 16. The `ChefDeprecations/ResourceWithoutNameOrProvides` cop has also been renamed to `ChefDeprecations/HWRPWithoutProvides` and improves detection of resources without `provides`. Both cops now better validate the contents of existing `provides` calls.

#### InSpec

InSpec was updated from 4.19 to 4.21. This new release includes the following improvements:

- Certain substrings within a .toml file no longer cause unexpected crashes.
- Accurate InSpec CLI input parsing for numeric values and structured data, which were previously treated as strings. Numeric values are cast to an integer or float and YAML or JSON structures are converted to a hash or an array.
- Suppress deprecation warnings on `inspec exec` with the `--silence-deprecations` option.

#### knife bootstrap

The `knife bootstrap` command has been updated with several fixes and improvements

- knife bootstrap will now warn when bootstrapping a system using a validation key. Users should instead use validatorless bootstrapping with `knife bootstrap` which generates node and client keys using the client key of the user bootstrapping the node. This method is far more secure as an organization-wide validation key doesn't need to be distributed or rotated. Users can switch to validatorless bootstrapping by removing any `validation_key` entries in their config.rb (knife.rb) file.
- Resolved an error bootstrapping Linux nodes from Windows hosts
- Improved information messages during the bootstrap process
- Bootstrapping will now be done using a single SSH connection improving bootstrap times on high latency network connection.

#### Knife Tidy

Knife Tidy has been updated from 2.0.12 to 2.1.0 which adds support for a `--keep-versions` command line flag. Specifying this keeps a minimum number of versions of each cookbook and defaults to `0`.

#### net-ssh

`net-ssh` has been updated from 5.2.0 to 6.1.0 which includes the following updates:

- Support empty lines and comments in known_hosts.
- Add sha2-{256,512}<-etm@openssh.com> MAC algorithms.
- curve25519sha256 support.

#### Ohai

Ohai was updated from 16.1 to 16.2 which correctly identifies the new macOS Big Sur (11.0) beta as the platform `mac_os_x`.

### Platform Packages

- Debian 8 packages are no longer being produced as Debian 8 is now end-of-life.
- We now produce Windows 8 packages.

### Backward Incompatibilities

- gerkin and cucumber-core gems no longer ship by default with Chef Workstation.

## Chef Workstation 20.6.62

### Major Version Change

Starting with this release, Chef Workstation is switching to a date-based versioning scheme. The major number represents the year, the minor number represents the month, and the patch number represents the build number. For example, `20.6.111` would refer to the June 2020 release at build number 111.

We decided to switch to a date-based version because Chef Workstation is a collection of tools meant to be used by humans and not machines. Dates are easier to relate and reference, whereas SemVer makes it easier to convey API changes and backward-incompatible changes.

The Chef Workstation team introduced feature flags as a way of introducing new functionality or breaking changes alongside bundled tool updates. The Chef Workstation team will document feature flags in the release notes and Chef Workstation App tool.

This change gives us the ability to change human-centric tools more rapidly than strict adherence to SemVer allowed us to. We won't break major tool flows (except in the scope of a feature flag), but rather we want users to always stay up-to-date on the latest release and consume iterative updates to their tooling.

### Breaking Changes

#### chef-sugar removal

With the introduction of chef-utils in Chef Infra Client 15, we now ship nearly 100 of the most important helpers from chef-sugar directly in Chef Infra Client. Including these helpers is the right thing to do for users and makes them easier to maintain. Now that this functionality is included, users no longer need to install the chef-sugar gem or use the chef-sugar cookbook, so we removed them from Chef Workstation.

### Security Updates

#### OpenSSL

OpenSSL was updated from 1.0.2u to 1.0.2v with the following message:

> *) Implemented coordinate blinding for the generic implementations of both
binary and prime elliptic curves to avoid leaking bits of the scalar and,
potentially, bug attacks. A group of security researchers and
cryptographers from academia and industry, listed below, reported a
successful cache timing attack in OpenSSL 1.0.2u against specific prime and
binary curves whose order or field length is close to a word boundary. They
also provided the fix. This attack doesn't fit the OpenSSL threat model
and so no CVE is assigned, but a fix is implemented nonetheless.
[Diego F. Aranha, Akira Takahashi, Mehdi Tibouchi, Yuval Yarom]

#### Rake

Rake was updated from 12.3.2 to 13.0.1 to resolve [CVE-2020-8130](https://github.com/advisories/GHSA-jppv-gw3r-w3q8).

### Upgrade Lab

Chef Upgrade Lab is a new process guide for upgrading nodes from legacy Chef Infra Client 12 to current Chef Infra Client 16 using a powerful set of new tools.

#### Upgrade Lab Guide

The [Upgrade Lab Guide](https://docs.chef.io/workstation/upgrade_lab/) teaches users how to leverage the new tools in Chef Workstation to upgrade their older Chef Infra installations to the latest version. Users will learn how to query their existing infrastructure to identify a single node to upgrade, capture the state of that node to a local development workstation, iterate locally on cookbook changes to support the latest version of Chef Infra Client, deploy the updated cookbook to a new Chef Infra Server instance, and finally upgrade the installed version of Chef Infra Client on the node.

#### The new `report` command

Use the new `chef report` command to analyze a Chef Infra Server and quickly get insight into which nodes and cookbooks are best suited for upgrading. The `chef report nodes` command lists all nodes on the server and describes which cookbooks are used by each node. The `chef report cookbooks` command lists cookbooks and the nodes that consume them, and can even analyse the cookbooks using `cookstyle` to look for potential upgrade issues in the recipes!

#### The new `capture` command

`chef capture` is a powerful interactive CLI experience that analyzes a single node on the Chef Infra Server, then helps you locate the cookbooks it consumes, downloads the node data, and even creates a local Test Kitchen configuration. This enables you to start upgrading your cookbooks while running Chef Infra Client in a local virtual machine for rapid development.

#### VSCode Integration

As you iterate on your cookbooks, you can make your changes directly in Visual Studio Code assisted by the Chef Infra Extension. It provides code completion and integration with cookstyle, including auto-correction of recipe code issues.

### Updated Components

#### Chef Infra Client 16

Chef Infra Client has been updated to Chef 16. This release adds tons of new features and improvements, including these highlights:

- Cookbook authors can now [write](https://docs.chef.io/release_notes/#yaml-recipes) simple recipes in YAML.
- New resources for setting the client to run on an interval using native system schedulers.
- New `windows_security_policy` and `windows_user_privlidge` resources.
- Resource partials allow you to define reusable portions of code that can be included in multiple custom resources.
- Built-in support for Chef Vault, so no need to depend on the `chef-vault` cookbook or gem.
- Improved performance on Windows systems.

See the [Chef Infra Client 16 Release Notes](https://docs.chef.io/release_notes/#whats-new-in-160) for details on all the great new features and improvements, as well as breaking changes.

#### Chef executables

`chef-run` and `chef` have been updated to add support for YAML-based recipes introduced in Chef Infra Client 16. Users can specify a YAML recipe in the same way that they would normally specify a ruby recipe (`chef run target chef_repo/recipes/my_recipe.yml`, `chef install`, etc.).

`chef generate cookbook` has also been updated to use the latest CentOS and Ubuntu releases in Test Kitchen and ChefSpec configuration files.

#### Cookstyle 6.7

Cookstyle has been updated from 6.3.4 to 6.7.3. This new release includes 8 new Chef Infra cookbook cops as well as an updated RuboCop engine, which includes a large number of autocorrection improvements and bug fixes. It also enables a `ChefModernize/FoodcriticComments`, encouraging users to migrate off Foodcritic and includes improved Chef Infra Client version documentation for each cop.

#### Chef InSpec

Chef InSpec has been updated from 4.18.111 to 4.19.0. This new release allows you to develop your own Chef InSpec Reporter plugin and determine how Chef InSpec will report result data. Additionally, the `inspec archive` command packs your profile into a `tar.gz` file that includes the profile in JSON form as the `inspec.json` file. Use this JSON file to programmatically examine the profile without needing to load it into Chef InSpec.

#### Kitchen Hyper-V

The Kitchen Hyper-V driver has updated from 0.5.3 to 0.5.4, which resolves failures from getting the default VM Switch if there were spaces in the name. Thanks [@kdoores](http://github.com/kdoores) for this improvement.

#### Kitchen DigitalOcean

The Kitchen DigitalOcean driver has updated from 0.10.6 to 0.11.0. This release adds slugs for Ubuntu 20.04 / RHEL 8 / Fedora 31 support, and adds support for VPCs. Thanks [@zmaupin](https://github.com/zmaupin), [@tolland](https://github.com/tolland), and [@gregf](https://github.com/gregf) for these improvements.

#### Ruby 2.7

Chef Workstation's Ruby installation has been updated from Ruby 2.6 to Ruby 2.7.1, which includes many features available for use in resources and libraries.

See <https://medium.com/rubyinside/whats-new-in-ruby-2-7-79c98b265502> for details on many of the new features.

### Windows 10

Our Windows 10 Chef Workstation packages now receive an additional layer of testing to ensure that they function as expected.

### Updates to Homebrew Cask

We moved Chef Workstation out of our custom tap and into the [core](https://github.com/Homebrew/homebrew-cask/pull/81618) Homebrew casks. If you use Homebrew to keep your Chef Workstation version updated, you will need to run the following:

```
brew update
brew cask reinstall chef-workstation
```

The `reinstall` command removes chef-workstation if it was installed from our custom tap (previously installed with `brew cask install chef/chef/chef-workstation`), and installs it from the list of core Homebrew casks.

## Chef Workstation 0.18.3

### New features

#### Kitchen OpenStack

Chef Workstation now ships with Kitchen OpenStack so you can test your Chef Infra cookbooks using instances in OpenStack clouds. See the [Kitchen Openstack GitHub repo](https://github.com/test-kitchen/kitchen-openstack) for usage information. Thanks [@ramereth](https://github.com/ramereth) for all the work getting this driver ready to ship in Workstation.

#### Ubuntu 20.04 Packages

Chef Workstation packages are now created for Ubuntu 20.04! See the Workstation Downloads Page for a complete list of platforms we produce packages for.

### Updated Components

#### Chef Infra Client 15.10

Chef Infra Client has been updated from 15.8 to 15.10 which includes improvements to resources, additional cookbook helpers, and critical bug fixes for bootstrapping nodes using `knife bootstrap` and SSHing to nodes with `ed25519` keys from Windows hosts. For a complete list of changes, see the [Chef Infra Client 15.10 release notes](https://docs.chef.io/release_notes/#whats-new-in-1510)

#### Cookstyle 6.3

Cookstyle has been updated from 5.22 to 6.3. This new release includes an updated RuboCop engine which includes a large number of autocorrection improvements and bug fixes, plus compatibility with Ruby 2.7. Cookstyle also ships with a large number of autocorrection improvements and 18 new Chef Infra cops. Included in the new cops are cops to get your cookbooks ready for Chef Infra Client 16.

Note: The updated RuboCop engine has renamed many of the out-of-the-box Ruby cops which may require updating cop names in your .rubocop.yml config. Additionally, this release will now fail Cookstyle runs if any of the `ChefDeprecations` department cops that shipped at the time of Cookstyle 5.22 alert. Any new cops we add will be added at the warning level until Cookstyle 7.0 ships. This gives you time to update your cookbooks using the latest Cookstyle releases without immediately failing CI builds.

#### Fauxhai 8.1

Fauxhai has been updated from 7.6 to 8.1. Fauxhai is the engine that provides ChefSpec with mocked Ohai data, allowing you to writes ChefSpecs for multiple platforms. This release updates all of the mocked Ohai data to be generated with Chef Infra Client 16. It also updates the list of platforms that are included in the mocked data. We've added new platforms and removed deprecated platforms that have generated warnings for the last year. To avoid deprecation warnings in your ChefSpecs in the future, you can avoid specifying the minor versions of releases and instead let ChefSpec choose the latest platform for you. For example, instead of specifying `platform: 'centos', version: '7.7.1908'` you can instead set `platform: 'centos'` or `platform: 'centos', version: '7'`.

##### New Platforms

- Ubuntu 20.04
- openSUSE 15.1
- Raspbian 10
- Fedora 31
- Redhat 7.7
- CentOS 7.7.1908

##### Removed Platforms

- Raspbian 8.0
- Debian 9.2 / 9.3 / 9.4 / 9.5 / 9.6
- Fedora 26/27/28
- FreeBSD 10.4
- macOS 10.11 / 10.12
- openSUSE 42.2 / 42.3
- CentOS 6.8 / 7.3.1611 / 7.4.1708
- Debian 7.11
- FreeBSD 10.4
- Oracle Linux 6.8 / 7.3 / 7.4
- Redhat 6.8 / 7.3
- SUSE 11.4 / 12.1 / 12.2
- Ubuntu 17.10

#### Chef InSpec 4.18.111

Chef InSpec has been updated from 4.18.100 to 4.18.108. This update includes the following fixes and improvements:

- Resolved a regression that prevented the `service` resource from working correctly on Windows. Thanks [@Axuba](https://github.com/Axuba)
- Implemented VMware and Hyper-V detection on Linux systems
- Implemented VMware, Hyper-V, Virtualbox, KVM and Xen detection on Windows systems
- Added helpers `virtual_system?` and `physical_system?`. Thanks [@tecracer-theinen](https://github.com/tecracer-theinen)

#### Chef CLI

The Chef CLI has been updated from 2.0 to 2.0.10. This fixes `chef update` to properly add cookbooks from `include_policies` to the PolicyFile lockfile. This release also supports new Chef Infra 16 YAML recipes in the `chef install` command.

#### Test Kitchen

Test Kitchen itself has been updated to from 2.4.0 to 2.5.0. This release includes support for Ohai plugins stored in the `ohai` directory of cookbooks and also resolves failures using the PowerShell provisioner. Thanks [@SAPDanJoe](https://github.com/SAPDanJoe) and [@alanghartJC](https://github.com/alanghartJC) for these improvements.

##### Kitchen AzureRM

The Kitchen AzureRM driver was updated from 0.15.1 to 1.0. This release fixes several failures from running the Kitchen Azurerm driver. It also includes support for Azure Marketplace plans and Managed Service Identity (MSI). Thanks [@jasonwbarnett](https://github.com/jasonwbarnett), [@zanecodes](https://github.com/zanecodes), [@albertvaka](https://github.com/albertvaka), and [@KSerrania](https://github.com/KSerrania) for these improvements.

##### Kitchen Hyper-V

The Kitchen Hyper-V driver has been updated from 0.5.3 to 0.5.4 which resolves failures from getting the default VM Switch if there were spaces in the name. Thanks [@kdoores](http://github.com/kdoores) for this improvement.

##### Kitchen DigitalOcean

The Kitchen DigitalOcean driver has been updated from 0.10.5 to 0.10.6. This release adds slugs for RHEL 8 / Fedora 31 support and updates the default instance memory size to 1GB. Thanks [@zmaupin](https://github.com/zmaupin) and [@tolland](https://github.com/tolland) for these improvements.

##### Kitchen EC2

The Kitchen EC2 driver has been updated from 3.3 to 3.5. This release lets the driver cleanly exit if the test instance was destroyed outside of the Test Kitchen run, either by automation or in the console. Test Kitchen will also now select the subnet with the most available IPs to better distribute systems across multiple Availability Zones. Thanks [@bdwyertech](http://github.com/bdwyertech) and [@kamaradclimber](http://github.com/kamaradclimber) for these improvements.

##### Kitchen InSpec

The Kitchen InSpec verifier has been updated to allow setting Chef InSpec plugins for use during the verification. This new functionality can be enabled by adding `load_plugins: true` to your InSpec verifier config. Thanks [@tecracer-theinen](https://github.com/tecracer-theinen) for this improvement.

##### Kitchen vCenter

The Kitchen vCenter driver has been updated from 2.6.4 to 2.7.0 which adds the ability to define transformations for VM IPs that are used in 1:1 NAT environments. This release also includes improved fallback for DC lookups to use methods that may work with less privileged users. Thanks [@tecracer-theinen](https://github.com/tecracer-theinen) and [@jasonwbarnett](https://github.com/jasonwbarnett) for these improvements.

##### Kitchen Dokken

The Kitchen Dokken driver has been updated from 2.8.1 to 2.9.0. This release adds a new provisioning configuration, `clean_dokken_sandbox`, that doesn't require cleaning the Chef Infra and Test Kitchen files between converges. This configuration will speed up repeatedly converging systems. This defaults to `true` which maintains the existing behavior. Thanks [@chrisUsick](https://github.com/chrisUsick)

#### Knife Plugins

##### Knife Tidy

Knife Tidy has been updated from 2.0.9 to 2.0.12 which provides compatibility with Chef Infra Client 15 and improves error handling in JSON parsing.

##### Knife Azure

Knife Azure was updated from 2.0.13 to 2.0.17 which resolves issues from loading plugin requirements.

##### Knife EC2

Knife EC2 has been updated from 1.0.32 to 1.0.36. This update resolves failures from bootstrapping nodes in classic EC2 and avoids attempting to bootstrap nodes using private DNS which may not be accessible from the node running the bootstrap command.

### Security Updates

#### Git

Git was updated from 2.24.1 to 2.26.2 to resolves the following CVEs:

- [CVE-2020-5260](https://www.ruby-lang.org/en/news/2020/03/31/heap-exposure-in-socket-cve-2020-5260/): Heap exposure vulnerability in the socket library
- [CVE-2020-11008](https://www.ruby-lang.org/en/news/2020/03/31/heap-exposure-in-socket-cve-2020-11008/): Heap exposure vulnerability in the socket library

#### libarchive

libarchive was updated from 3.4.0 to 3.4.2 to resolve the following CVEs:

- [CVE-2019-19221](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19221): archive_wstring_append_from_mbs in archive_string.c has an out-of-bounds read because of an incorrect mbrtowc or mbtowc call
- [CVE-2020-9308](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-9308): archive_read_support_format_rar5.c in libarchive before 3.4.2 attempts to unpack a RAR5 file with an invalid or corrupted header

#### Ruby

Ruby was updated from 2.6.5 to 2.6.6 to resolve the following CVEs:

- [CVE-2020-16255](https://www.ruby-lang.org/en/news/2020/03/19/json-dos-cve-2020-10663/): Unsafe Object Creation Vulnerability in JSON (Additional fix)
- [CVE-2020-10933](https://www.ruby-lang.org/en/news/2020/03/31/heap-exposure-in-socket-cve-2020-10933/): Heap exposure vulnerability in the socket library

## Chef Workstation 0.17.5

### Updated Components

#### Chef InSpec 4.18.100

Chef InSpec has been updated to 4.18.100 to fix the following bugs:

- We fixed a problem in which the sudo password would appear to be ignored even if provided.
- We resolved an issue in which profiles couldn't be fetched from an Automate server.
- The `release` property of the `platform` resource no longer breaks for Chef Habitat with Linux.

#### Test Kitchen 2.4.0

Test Kitchen has been updated to 2.4.0. This update will now pass the `CHEF_LICENSE` environmental variable, if it's set, from the host workstation to any created machines. The `CHEF_LICENSE` environmental variable is
used to accept the required EULA. Any environmental variables on the host machine that start with `TKENV_` will also be passed to created machines with that prefix removed.

The base verifier was updated to support a downloads configuration. This configuration will download files from the created machines to the host machine after running verification. It expects a hash from locations on the created machine to locations on the host machine:

```
downloads:
  "/tmp/kitchen/nodes": "./test/fixtures"
```

## Chef Workstation 0.16.33

### Updated Components

#### knife-ec2

knife-ec2 has been updated to 1.0.32 to fix a [regression](https://github.com/chef/knife-ec2/pull/640) in profile support. Using profiles with `knife ec2 server create` is working correctly again.

#### Markdown Lint

Markdown Lint has been updated to 0.9.0. This release adds support for nested code blocks as well as block quoted list items. Thank you [@jaymzh](https://github.com/jaymzh)!

### Reverted Components

#### Chef InSpec

Chef InSpec has been reverted to 4.18.51 to fix some escaped defects. We're currently working on a fix and will update to the latest version of Chef InSpec as soon as the fixes are released.

## Chef Workstation 0.16.32

### Updated Components

#### knife-ec2

knife-ec2 has been updated to 1.0.32 to fix a [regression](https://github.com/chef/knife-ec2/pull/640) in profile support. Using profiles with `knife ec2 server create` is working correctly again.

#### Markdown Lint

Markdown Lint has been updated to 0.9.0. This release adds support for nested code blocks as well as block quoted list items. Thank you [@jaymzh](https://github.com/jaymzh)!

### Reverted Components

#### Chef InSpec

Chef InSpec has been reverted to 4.18.51 to fix some escaped defects. We're currently working on a fix and will update to the latest version of Chef InSpec as soon as the fixes are released.

## Chef Workstation 0.16.31

### Improved Knife Performance

We've optimized knife to provide a huge performance increase. Knife commands are now more than 3x faster on Windows and more than 4.5x faster on macOS.

### Chef Workstation App Improvements

The Chef Workstation App now runs at boot and launches after installing Chef Workstation. We've also added a new preferences dialog on macOS that allows you to set Chef Workstation preferences without using the config file.

### Updated Components

#### Chef Infra Client 15.8.23

Chef Infra Client has been updated to 15.8.23 with updated resources, a new notify_group feature, and dozens of new helpers to make writing cookbooks easier than ever. Check the complete release notes for details on [docs.chef.io](https://docs.chef.io/release_notes.html#what-s-new-in-15-8)

#### Chef InSpec 4.18.85

Chef InSpec has been updated from 4.18.51 to 4.18.85. This release includes a large number of bug fixes in addition to some great resource enhancements:

- The service resource features new support for yocto-based Linux distributions. Thank you to [@michaellihs](https://github.com/michaellihs) for this addition!
- The package resource now includes support for FreeBSD. Thank you to [@fzipi](https://github.com/fzipi) for this work!
- We standardized the platform for the etc_hosts, virtualization, ini, and xml resources.
- The oracledb_session resource works again due to a missing quote fix.
- The groups resource on macOS no longer reports duplicates anymore.
command.exist? now conforms to POSIX standards. Thanks to [@PiQuer](https://github.com/PiQuer)!
- We changed the postfix_conf resource's supported platform to the broader unix. Thank you to [@fzipi](https://github.com/fzipi) for this fix!

#### Cookstyle 5.21.9

We updated Cookstyle from 5.20.0 to 5.21.9. This release adds 4 new Chef Infra cops and improves many existing cops:

##### ChefStyle/UnnecessaryOSCheck

The `ChefStyle/UnnecessaryOSCheck` cop checks cookbooks that use `node['os']` to check the operating system of a node, when they could instead use the `platform_family?()` helper. All values of `os` from Ohai match one-to-one with `platform_family` values, except for `linux` which has no single equivalent `plaform_family`.

##### ChefModernize/SimplifyAptPpaSetup

The `ChefModernize/SimplifyAptPpaSetup` cop detects `apt_repository` resources that setup Ubuntu PPAs by using their full URL. For example, `http://ppa.launchpad.net/webupd8team/atom/ubuntu` can be simplified to just `ppa:webupd8team/atom`.

##### ChefRedundantCode/StringPropertyWithNilDefault

The `ChefRedundantCode/StringPropertyWithNilDefault` cop detects String type resource properties that set their default value to `nil`. All String type properties default to `nil`, so this doesn't need to be set.

##### ChefRedundantCode/PropertySplatRegex

The `ChefRedundantCode/PropertySplatRegex` cop detects String type resource properties that validate their input with a regex of `/.*/`. This regex will match on any String value and isn't necessary.

##### Other Cookstyle fixes and changes

- `ChefDeprecations/IncludingYumDNFCompatRecipe` will now remove any inline conditionals around the `include_recipe` statement during autocorrection so that it doesn't leave behind invalid Ruby.
- `ChefDeprecations/WindowsTaskChangeAction` will no longer fail when the action value isn't a String type value.
- `ChefSharing/InvalidLicenseString` won't autocorrect `apache v2` to `Apache-2.0`.
- `Layout/EndAlignment` and `Layout/DefEndAlignment` now have autocorrection enabled to eliminate the need for manually fixing indentation in cookbooks.
- `ChefStyle/UsePlatformHelpers` now detects and autocorrects `node['platform'].eql?()` usage.
- `Style/ModuleFunction` cop has been disabled because this caused library helpers to fail to load.
- All metadata cops now properly autocorrect legacy metadata that included HEREDOCs.
- The `TargetRubyVersion` is now set to 2.3 to match the version of Ruby that shipped in Chef Infra Client 12. This config value is used to enable/disable cops and autocorrection that may break Ruby code in these older Chef Infra Client releases. If you are on a later release of Chef Infra Client, you can set this value to Ruby 2.6 to enable additional cops and autocorrection.

#### Fauxhai 7.6

Fauxhai has been updated to 7.6 with FreeBSD 12.1 data for use in ChefSpec. Thanks to [@nhuff](https://github.com/nhuff)!

#### kitchen-vcenter 2.6.4

kitchen-vcenter has been updated to 2.6.2. This update fixes multiple bugs from spinning up nodes in Test Kitchen. Thanks [@leotaglia](https://github.com/leotaglia/) and [@cattywampus](https://github.com/cattywampus/) for these fixes.

#### knife-ec2 1.0.31

knife-ec2 has been updated to 1.0.31 with a fix for SSH connection failures that occurred if the instance has no public DNS name.

#### chef-apply 4.1.5

chef-apply has been updated to 4.1.5 to add the missing CHEFVAL001 error message.

#### ChefSpec 9.1

ChefSpec has been updated to 9.1 with a new matcher `include_any_recipe` that allows you to write specs to ensure that cookbooks aren't including recipes. Thanks [@jasonwbarnett](https://github.com/jasonwbarnett/). This release also fixes a bug mocking out the `Chef::Provider` class when a cookbook uses Poise's `resource_provider_mixin`. Thanks [@Annih](https://github.com/Annih/) for this fix.

### Platform Support

Chef Workstation packages are now validated on Debian 10.

## Chef Workstation 0.15.18

### Bug Fixes

- We fixed an issue with the macOS Catalina (10.15) notarization process. In Chef Workstation 0.15.6, users were seeing errors when trying to run `chef install` and other tools. These errors had a message similar to: `terminated by signal SIGKILL (Forced quit))`. This type of error was caused by `ffi` attempts to load native bindings into insecure memory, which is disabled by default in MacOS Catalina. We added an entitlement to allow this loading to happen.

    Apple [previously detailed](https://developer.apple.com/news/?id=12232019a) updates to the notarization process that takes effect on February 3rd, 2020. You can read about the notarization requirements and process [here](https://developer.apple.com/developer-id/).

### Updated Components

- Updated `win32-service` from `2.1.4` to `2.1.5`. This version removes deprecation warnings about the `ffi` gem from being outputted on Windows. Thank you [@Dreweasland](https://github.com/Dreweasland) for this fix!

## Chef Workstation 0.15.6

### Updated Components

#### Chef Infra Client

Chef Infra Client has been updated from 15.6 to 15.7 which includes improvements to the `archive_file`, `cron`, `cron_d`, `file`, `launchd`, `sudo`, `user`, `windows_task`, and `x509_certificate` resources as well as the usual collection of bug fixes and bootstrap improvements.

#### Berkshelf

Berkshelf has been updated from 7.0.8 to 7.0.9, which resolves errors when running `berks verify` and when using the ``--skip-syntax-check`` flag.

#### Cookstyle

Cookstyle has been updated from 5.19 to 5.20 with a new Chef cop ChefDeprecations/DeprecatedChefSpecPlatform to detect legacy platforms in ChefSpecs. This release also includes improvements to autocorrection and detection of deprecated content in the Chef cops.

#### Chef InSpec

Chef InSpec has been updated from 4.18.39 to 4.18.51 with the following improvements:

- Example groups can now use InSpec resources
- The user resource can now check the last login date on Windows
- Improved the fetchers to fail consistently

### Debian Support

We now produce Chef Workstation packages for Debian 8 and 9.

### macOS Binary Signing

Each binary in the macOS Chef Workstation installation is now signed to improve the integrity of the Workstation installation and improve compatibility with future macOS updates.

## Chef Workstation 0.14.16

### Workstation App on Windows

The Chef Workstation App is now installed by default on Windows and is no longer considered experimental. If you would like to run this application at boot to ensure your system stays up to date, you can select this option during the installation.

### Smaller Size

We continue to optimize the size of the Chef Workstation package with this release taking up 9% less space on disk and containing nearly 5,000 fewer files.

### Updated Components

#### chef-vault

The chef-vault gem has been updated to 4.0.1. This release includes bug fixes from [@MarkGibbons](https://github.com/MarkGibbons) and [@jeremy-clerc](https://github.com/jeremy-clerc) as well as a new way to update existing keys to sparse-mode by running `knife vault update --keys_mode sparse` thanks to [@jeunito](https://github.com/jeunito).

#### knife-ec2

knife-ec2 has been updated to 1.0.26 with multiple bug fixes for provisioning new systems in EC2.

#### kitchen-ec2

kitchen-ec2 has been updated to 3.3.0. This new version improves how we search for security groups by tags, improves the logic that detects usage of the chef Test Kitchen provisioner, and improves security group and spot instance logic. Thanks [@slapvanilla](https://github.com/slapvanilla) and [@bdwyertech](https://github.com/bdwyertech) for these enhancements.

#### Cookstyle 5.19

Cookstyle has been updated from 5.16 to 5.19. This new release contains 7 new Chef Cops and a large number of detection and autocorrection improvements for existing cops:

##### ChefRedundantCode/GroupingMetadata

The `ChefRedundantCode/GroupingMetadata` cop removes the legacy `grouping` metadata from the metadata.rb file. This metadata was never consumed by any Chef Infra services and doesn't need to be defined.

##### ChefStyle/OverlyComplexSupportsDependsMetadata

The `ChefStyle/OverlyComplexSupportsDependsMetadata` cop cleans up overly complex methods of declaring `supports` or `depends` metadata via an array. This rule will detect and correct the array or each form of declaring this metadata when there are fewer than three items.

**Overly complex metadata:**

```ruby
%w(windows apt).each |cb|
  depends cb
end
```

**Simpler form:**

```ruby
depends 'apt'
depends 'windows'
```

##### ChefModernize/ResourceForcingCompileTime

The ChefModernize/ResourceForcingCompileTime cop detects hostname, build_essential, chef_gem, and ohai_hint resources that are being set to run at compile-time by forcing an action on the resource block. These resources include compile-time properties which should be set to force the resources to run at compile-time.

##### ChefModernize/ExecuteSysctl

The ChefModernize/ExecuteSysctl detects the usage of execute to load sysctl values. Chef Infra Client 14.0+ includes the sysctl resource which should be used to idempotently add or remove sysctl values without the need for chaining file and execute resources.

##### ChefModernize/DslIncludeInResource

The ChefModernize/DslIncludeInResource cop detects resources and providers that include either the Chef::DSL::Recipe or Chef::DSL::IncludeRecipe classes. Starting with Chef Infra Client 12.4+, this is done automatically for each resource and provider.

##### ChefRedundantCode/AptRepositoryNotifiesAptUpdate

The ChefRedundantCode/AptRepositoryNotifiesAptUpdate cop detects apt_repository resources that notify an execute resource to run apt-get update. Updating apt cache is performed automatically when the apt_repository makes any updates to the repository config and doesn't need to be performed again afterward.

##### ChefRedundantCode/AptRepositoryDistributionDefault

The ChefRedundantCode/AptRepositoryDistributionDefault cop detects apt_repository resources that set the distribution property to node['lsb']['codename'] which is the default and doesn't need to be set in cookbook code.

### Security Updates

#### OpenSSL

OpenSSL has been updated to 1.0.2u to resolve [CVE-2019-1551](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1551)

#### Git

The embedded git client has been updated to 2.24.1 to resolve the following CVEs:

- [CVE-2019-1348](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1348)
- [CVE-2019-1349](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1349)
- [CVE-2019-1350](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1350)
- [CVE-2019-1351](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1351)
- [CVE-2019-1352](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1352)
- [CVE-2019-1353](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1353)
- [CVE-2019-1354](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1354)
- [CVE-2019-1387](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1387)
- [CVE-2019-19604](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-19604)

## Chef Workstation 0.13.35

### Performance Improvements

This release of Chef Workstation ships with several optimizations to our Ruby installation to improve the performance of loading the various commands bundled with Workstation. These improvements are particularly noticeable on non-SSD hosts and on Windows.

### Updated Components

#### Chef Infra Client 15.6.10

Chef Infra Client has been updated to 15.6.10 which includes multiple resource fixes and optimizations.

#### Cookstyle 5.16

Cookstyle has been updated from 5.13 to 5.16 with 22 new cops, improvements to existing cops, a new TargetChefVersion config option, and expanded cop departments.

##### TargetChefVersion Config

Cookstyle now includes a new top-level configuration option `TargetChefVersion`. This new configuration option works similarly to RuboCop's `TargetRubyVersion` config option and allows you to specify a Chef Infra version that you want to target in your Cookstyle analysis. This prevents Cookstyle from autocorrecting cookbook code in a way that would make your cookbook incompatible with your desired Chef Infra Client version. It also makes it easier to perform staged upgrades of the Chef Infra Client by allowing you to step the `TargetChefVersion` one major version at a time.

Example .rubocop.yml config specifying a TargetChefVersion of 14.0:

```yaml
AllCops:
  TargetChefVersion: 14.0
```

##### New ChefSharing and ChefRedundantCode Departments

Cookstyle now includes two new Chef cop departments with a large number of existing cops moved into these more appropriate departments. Our goal is to have clearly defined cop departments that can be enabled or disabled to detect particular conditions in your cookbooks. Cops in the new ChefSharing department are focused around sharing cookbooks internally or on the public Supermarket. This includes things like ensuring proper license strings and complete metadata. Cops in the ChefRedundantCode category detect and correct unnecessary cookbook code. Anything detected by ChefRedundantCode cops can be removed regardless of the Chef Infra Client release you run in your infrastructure, so these are always safe to run.

With the addition of these new departments, we've moved many cops out of the ChefCorrectness department. Going forward only cops that detect code that may fail a Chef Infra Client run or cause it to behave incorrectly will be included in this category. We hope that ChefCorrectness along with ChefDeprecations are used in most cookbook CI pipelines.

#### kitchen-azurerm

kitchen-azurerm has been updated from 0.14.9 to 0.15.0 with the following improvements:

- Enable the WinRM HTTP listener by default. Thanks @sean-nixon
- Allow overriding the `subscription_id` by setting the `AZURE_SUBSCRIPTION_ID` ENV variable
- Add a new `nic_name` config. Thanks @libertymutual
- Support for creating VM with Azure KeyVault certificate. Thanks @javgallegos

#### kitchen-dokken

kitchen-dokken has been updated to 2.8.1 which fixes a bug that prevented ENV vars from being passed into containers.

#### kitchen-google and knife-google

kitchen-google and knife-google plugins have been updated to allow the updated google-api-client SDK v0.34.

#### knife-ec2

knife-ec2 has been updated from 1.0.17 to 1.0.21 with the following fixes:

- Resolved a missing credential error when using aws-profile.
- Mask AWS access keys data in any error or debug logs.
- Raises an error if password length is less than 8 characters on Windows and will stop warning on passwords over 14 characters.

#### knife-tidy

knife-tidy has been updated from 2.0.1 to 2.0.6 to resolve issues if an org was named `cookbooks` and to improve error messages.

#### mixlib-install

mixlib-install has been updated from 3.11.21 to 3.11.24, which properly identifies Windows 2019 hosts.

## Chef Workstation 0.12.20

### Updated Components

#### Chef Infra Client

The Chef Infra Client has been updated from 15.4.45 to 15.5.16 with updated helpers, Chefignore improvements, and a new chef_sleep resource:

##### New Cookbook Helpers

Chef Infra Client now includes a new `chef-utils` gem which ships with a large number of helpers to make writing cookbooks easier. Many of these helpers existed previously in the `chef-sugar` gem. We've renamed many of the named helpers for consistency while providing backwards compatibility with existing `chef-sugar` names. Existing cookbooks written with `chef-sugar` should work unmodified with any of these new helpers. Expect a Cookstyle rule in the near future to help you update existing `chef-sugar` code to use the newer built-in helpers.

For more information on all of the new helpers available, see the [chef-utils readme](https://github.com/chef/chef/blob/master/chef-utils/README.md)

##### Chefignore Improvements

We've reworked how chefignore files are handled in `knife` which has allowed us to close out a large number of long outstanding bugs. `knife` will now traverse all the way up the directory structure looking for a chefignore file. This means you can place a chefignore file in each cookbook or any parent directory in your repository structure. Additionally, we've made fixes that ensure that commands like `knife diff` and `knife cookbook upload` always honor your chefignore files.

##### chef_sleep Resource

The new `chef_sleep` resource can be used to sleep for a specified number of seconds during a Chef Infra Client run. This may be helpful to use with other commands that return a completed status before they're actually ready. In general, don't use this resource unless you truly need it.

Using with a Windows service that starts, but isn't immediately ready:

```ruby
service 'Service that's slow to start and reports as started' do
  service_name 'my_database'
  action :start
  notifies :sleep, chef_sleep['wait for service start']
end

chef_sleep 'wait for service start' do
  seconds 30
  action :nothing
end
```

### Cookstyle

The Cookstyle cookbook linter has been updated from 5.10 to 5.13 and includes 17 new Chef cops for detecting deprecated and outdated cookbook code. This release also updates the underlying RuboCop engine used by Cookstyle which includes a large number of bug fixes that better detect violations and prevent false positives. See the [Cookstyle Release Notes](https://github.com/chef/cookstyle/blob/master/RELEASE_NOTES.md#cookstyle-513) for a complete list of changes between 5.10 and 5.13.

This new release also allows you to use `cookstyle` specific comments in your cookbook code to enable or disable cops instead of the standard `rubocop` comments. We think that it will be easier to understand the cops that you intend to control if you use `cookstyle` comments. You can continue to use the existing `rubocop` comments, if you prefer them, since both types of comments will be honored by Cookstyle.

Rubocop comment to disable a cop:

```ruby
'node.normal[:foo] # rubocop: disable ChefCorrectness/Bar'
```

Cookstyle comment to disable a cop:

```ruby
'node.normal[:foo] # cookstyle: disable ChefCorrectness/Bar'
```

### Foodcritic

Foodcritic has been updated from 16.1.1 to 16.2.0. This release includes a fix for detecting incorrect notification actions and ships with updated Chef Infra Client Metadata. Keep in mind that Foodcritic is no longer being actively developed and users should migrate to Cookstyle instead.

### Chef InSpec

Chef InSpec has been updated from 4.18.0 to 4.18.39. This release includes a large number of bug fixes to resources:

- The `service` resource now includes a `startname` property for Windows and systemd services.
- The `nginx` resource now includes parsing support for wildcard, dot prefix, and regex.
- The `iis_app_pool` resource now handles empty app pools.
- The `filesystem` resource now supports devices with very long names.
- The `apt` better handles URIs and supports repos with an `arch`.
- The `oracledb_session` has received multiple fixes to make it work better.

### knife-ec2

The `knife-ec2` plugin has been updated from 1.0.16 to 1.0.17 which includes a fix for an error when launching non-T2 type instances.

### Performance Improvements

This release of Chef Workstation ships with several optimizations to our Ruby installation that improve the performance of the included commands, especially on Windows systems. Expect to see more here in future releases.

### Smaller Installation Size

We've continued to optimize Chef Workstation to reduce the install size. Chef Workstation 0.12 has ~5% fewer files than the 0.11 release. Stay tuned for further optimizations of our install footprint in the coming months.

## Chef Workstation 0.11.21

### Two Important Regression Fixes

- Fixes Test Kitchen, which once again works with Policyfiles on Windows.
- Fixes Chef CLI commands, so once again commands with user input such as `chef exec` or license acceptance succeed.

### Notable Updates

- The Workstation menu bar application supports dark mode on macOS.
- The Workstation install size is now ~4% smaller! More improvements to come!

### New Components

#### mdl

Chef Workstation includes the [mdl](https://github.com/markdownlint/markdownlint) command line tool for linting markdown.

### Updated Components

#### Cookstyle

We updated Cookstyle to 5.10.13, which includes 11 new Chef cops for detecting deprecated code and refactoring some legacy Heavy Weight Resource Providers (HWRPs).

#### Fauxhai-ng

We updated Fauxhai-ng to 7.5.1, which fixes missing `platform_family` data in the `opensuse-15` data file.

#### Test Kitchen

We updated Test Kitchen has to 2.3.4, which includes more robust code for finding the Chef binary on Windows and also improves some logging messages.

#### kitchen-inspec

We updated the kitchen-inspec plugin to 1.3.1, which allows relative paths in the GIT fetcher and resolves failures when using inputs.

### Security Updates

libxlst was updated from 1.1.30 to 1.1.34 to resolve these vulnerabilities:

- [CVE-2019-11068](https://www.cvedetails.com/cve/CVE-2019-11068/)
- [CVE-2019-13117](https://www.cvedetails.com/cve/CVE-2019-13117/)
- [CVE-2019-13118](https://www.cvedetails.com/cve/CVE-2019-13118/)

## Chef Workstation 0.10.41

### Updated Components

#### Updated Chef Command Line

This release lays the ground work for massive speed improvements to the chef command. A new native binary chef command will allow us to slowly replace code with significantly faster native code. Stay tuned for more announcements in the coming months.

#### Chef Infra Client

Chef Infra Client has been updated from 15.3 to 15.4 with updated resources and several significant fixes to `knife bootstrap`. See the [Chef Infra Client 15.4 Release Notes](https://discourse.chef.io/t/chef-infra-client-15-4-45-released/16081) for a complete list of the new and improved functionality.

#### Chef InSpec

Chef InSpec has been updated from 4.16 to 4.18 with the following changes:

##### New Features

- We've released our beta Chef InSpec plug-in for HashiCorp Vault. Check it out in our [inspec-vault GitHub repo](https://github.com/inspec/inspec-vault) and let us know what you think -- or better yet, start jumping in and contributing with us on it.
- Waivers, our new beta feature, was added to Chef InSpec! Waivers allows you to better manage compliance failures. We would love to hear your feedback on this! See the [InSpec Waivers documentation](https://www.inspec.io/docs/reference/waivers/) for more details.

##### Improvements

- The `interface` resource now has a name property.
- Expanded `user` resource to include the passwordage, maxbadpasswords, and badpasswordattempts properties with Windows.
- The `sys_info` resource now supports ip_address, fqdn, domain, and short options when giving a version of the hostname.
- Sped up initial load/response time for all commands by removing pre-leading of resources on invocation of inspec.
- If an error occurs when using the `json` resource with a command source, you will now get the error message from STDERR returned in the report.
- We improved the formatting of the usage help, so what you see when you type `inspec exec --help` should look better!

#### Cookstyle

Cookstyle has been updated from 5.6.2 to 5.9.3, which includes 13 new Chef cops, improved detection in existing cops, and improved autocorrection. See the [Cookstyle 5.7, 5.8, and 5.9 release notes](https://github.com/chef/cookstyle/blob/master/RELEASE_NOTES.md) for additional information on the new cops.

#### knife-google

knife-google was updated from 3.3.7 to 4.2.0 with support for bootstrapping nodes with Chef Infra Client 15 and adding multiple local SSD interfaces to a new instance.

#### knife-vsphere

knife-vsphere was updated from 4.0.1 to 4.0.3, which resolves a bug in determining the state of instances.

#### knife-vcenter

knife-vcenter was updated from 2.0.3 to 2.0.6 to fix vm clone operations.

#### kitchen-digitalocean

kitchen-digital has been updated from 0.10.4 to 0.10.5 to add Debian-10 and FreeBSD-12 image aliases.

### Security Updates

#### Ruby

Ruby has been updated from 2.6.4 to 2.6.5 in order to resolve the following CVEs:

- [CVE-2019-16255](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16255): A code injection vulnerability of Shell#[] and Shell#test
- [CVE-2019-16254](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16254): HTTP response splitting in WEBrick (Additional fix)
- [CVE-2019-15845](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15845): A NUL injection vulnerability of File.fnmatch and File.fnmatch?
- [CVE-2019-16201](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16201): Regular Expression Denial of Service vulnerability of WEBrick's Digest access authentication

## Chef Workstation 0.9.42

### New Software

#### `kitchen-vcenter`

We now include the [`kitchen-vcenter`](https://github.com/chef/kitchen-vcenter) plugin for Test Kitchen. This is the official Chef Test Kitchen plugin for the VMware REST API. This plugin gives Test Kitchen the ability to create, bootstrap, and test VMware vms.

#### `knife-azure`

We now include the [`knife-azure`](https://github.com/chef/knife-azure) plugin for Knife. This plugin is used to create, delete, and enumerate Microsoft Azure resources to be managed by Chef.

#### `knife-vcenter`

We now include the [`knife-vcenter`](https://github.com/chef/knife-vcenter) plugin for Knife. This is the official Chef Knife plugin for the VMware REST API. This plugin gives Knife the ability to create, bootstrap, and manage VMware vms.

### Software Updates

#### `chef` CLI

The `chef -v` command has been updated to run much faster. Yay!

#### Chef Infra Client

Chef Infra Client has been updated from 15.2 to 15.3 with updated resources, a new way to write streamlined custom resources, and updated platform support! See the [Chef Infra Client 15.3 Release Notes](https://discourse.chef.io/t/chef-infra-client-15-3-14-released/15909) for a complete list of the new and improved functionality.

#### Chef InSpec

Chef InSpec has been updated from 4.10.4 to 4.16.0 with the following changes:

- A new `postfix_conf` has been added for inspecting Postfix configuration files.
- A new `plugins` section has been added to the InSpec configuration file which can be used to pass secrets or other configurations into Chef InSpec plugins.
- The `service` resource now includes a new `startname` property for determining which user is starting the Windows services.
- The `groups` resource now properly gathers membership information on macOS hosts.

See the [Chef InSpec 4.16.0 Release Notes](https://discourse.chef.io/t/chef-inspec-4-16-0-released/15818) for more information.

#### Chef Workstation App

Chef Workstation App has been updated with the following changes:

- Updated all dialog windows to match the Chef design.
- Removed the menu (file, edit, etc.) from Windows to match the style guide.
- Fixed the About Chef Workstation Page links (Package Details, License Agreement, and Release Notes).
- Fixed the update interval so it automatically notifies about new releases.
- Fixed the "Switch To Channel" button.

#### Cookstyle

Cookstyle has been updated from 5.1.19 to 5.6.2. This update brings the total number of Chef cops to 94 and divides the cops into four separate departments. The new departments make it easier to search for specific cops and to enable and disable groups of cops. Instead of just "Chef", we now have the following departments:

- `ChefDeprecations`: Cops that detect (and in many cases correct) deprecations that will prevent cookbooks from running on modern versions of Chef Infra Client.
- `ChefStyle`: Cops that will help you improve the format and readability of your cookbooks.
- `ChefModernize`: Cops that will help you modernize your cookbooks by including features introduced in new releases of Chef Infra Client.
- `ChefEffortless`: Cops that will help you migrate your cookbooks to the Effortless pattern. These are disabled by default.

You can run cookstyle with just a single department:

```bash
cookstyle --only ChefDeprecations
```

You can also exclude a specific department from the command line:

```bash
cookstyle --except ChefStyle
```

You can also disable a specific department by adding the following to your .rubocop.yml config:

```yaml
ChefStyle:
  Enabled: false
```

See the [Cookstyle cops documentation](https://github.com/chef/cookstyle/blob/master/docs/cops.md) for a complete list of cops included in Cookstyle 5.6.

Going forward, Cookstyle will be our sole Ruby and Chef Infra cookbook linting tool. With the release of Cookstyle 5.6, we're officially deprecating Foodcritic and won't be shipping Foodcritic in the next major release of Chef Workstation (April 2020). See our [Goodbye, Foodcritic blog post](https://blog.chef.io/goodbye-foodcritic/) for more information on why Cookstyle is replacing Foodcritic.

#### `kitchen-ec2`

`kitchen-ec2` has been updated from 3.1.0 to 3.2.0. This adds support for Windows Server 2019 and adds the ability to look up security group by `subnet_filter` in addition to `subnet_id`.

#### `kitchen-inspec`

`kitchen-inspec` has been updated from 1.1.0 to 1.2.0. This renames the `attrs` key to `input_files` and `attributes` key to `inputs` to match InSpec 4. The old names are still supported but issue a warning.

#### `knife-ec2`

`knife-ec2` has been updated from 1.0.12 to 1.0.16. This resolves the following issues:

- Fix argument error for --platform option [#609](https://github.com/chef/knife-ec2/pull/609) ([dheerajd-msys](https://github.com/dheerajd-msys))
- Fix for Generate temporary keypair when none is supplied [#608](https://github.com/chef/knife-ec2/pull/608) ([kapilchouhan99](https://github.com/kapilchouhan99))
- Color code fixes in json format output of knife ec2 server list [#606](https://github.com/chef/knife-ec2/pull/606) ([dheerajd-msys](https://github.com/dheerajd-msys))
- Allow instances to be provisioned with source/dest checks disabled [#605](https://github.com/chef/knife-ec2/pull/605) ([kapilchouhan99](https://github.com/kapilchouhan99))

#### Test Kitchen

Test Kitchen has been updated from 2.2.5 to 2.3.2 with the following changes:

- Add `keepalive_maxcount` setting for better control of ssh connection timeouts.
- Add `lifecycle_hooks` information to `kitchen diagnose` output.

#### `knife-google`

The knife-google plugin has been updated to 4.1.0 with support for bootstrapping Chef Infra Client 15 and also includes a new ``knife google image list command`` which lists project and public images.

For example `knife google image list --gce_project "chef-msys"`:

  ```
   NAME                             PROJECT        FAMILY         DISK SIZE  STATUS
   kpl-w-image                      chef-msys      windows        60 GB      READY
   centos-6-v20190916               centos-cloud   centos-6       10 GB      READY
   centos-7-v20190916               centos-cloud   centos-7       10 GB      READY
   coreos-alpha-2261-0-0-v20190911  coreos-cloud   coreos-alpha   9 GB       READY
   coreos-beta-2247-2-0-v20190911   coreos-cloud   coreos-beta    9 GB       READY
   ....
   ....
   ....
  ```

### Security Updates

#### Git

Git has been updated from 2.20.0 to 2.23.0 on Windows and from 2.14.1 to 2.23.0 on non-Windows systems. This brings the latest git workflows to our users who don't have it installed another way and fixes two CVEs:

- non-Windows systems: [CVE-2017-14867](https://www.cvedetails.com/cve/CVE-2017-14867/)
- Windows systems: [CVE-2019-1211](https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/CVE-2019-1211)

#### Nokogiri

Nokogiri has been updated from 1.10.2 to 1.10.4 in order to resolve [CVE-2019-5477](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5477)

#### OpenSSL

OpenSSL has been updated from 1.0.2s to 1.0.2t in order to resolve [CVE-2019-1563](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1563) and [CVE-2019-1547](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-1547).

#### Ruby

Ruby has been updated from 2.6.3 to 2.6.4 in order to resolve [CVE-2012-6708](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2012-6708) and [CVE-2015-9251](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2015-9251).

### Removals

#### `chef verify`

Removed the `chef verify` subcommand. This command has been deprecated with a warning for a long time and shouldn't have been used by users. It's an internal command used to test the components included in Chef Workstation. Instead, we extracted it to scripts run by our CI system, which is where it should have been the whole time.

### Platform Support Updates

#### macOS 10.15 Support

Chef Workstation is now validated against macOS 10.15 (Catalina). Additionally, Chef Workstation will no longer be validated against macOS 10.12.

## Chef Workstation 0.8.7

#### Chef Infra Client

Chef Infra Client has been updated from 15.1 to 15.2 with new and improved resources and support for RHEL 8. See the [Chef Infra Client 15.2 Release Notes](https://docs.chef.io/release_notes.html#chef-infra-client-15-2) for a complete list of new and improved functionality.

#### Chef InSpec

Chef InSpec has been updated from 4.7.3 to 4.10.4 with the following changes:

- Fixed handling multiple triggers in the `windows_task` resource
- Fixed exceptions when resources are used with incompatible transports
- Un-deprecated the `be_running` matcher on the `service` resource
- Added `sys_info.manufacturer` and `sys_info.model` resources
- Added `ip6tables` resource

#### Cookstyle

Cookstyle has been updated from 5.0 to 5.1.19 with twenty-four new Chef specific cops to detect, and in many cases, to auto-correct errors in your cookbook code. With the release of Cookstyle 5.1, we've started the process of replacing Foodcritic with Cookstyle. Cookstyle offers a modern configuration system, auto-correction, and a faster and more reliable engine thanks to RuboCop. We will continue to port useful rules from Foodcritic to Cookstyle, as well as add rules that were not possible in the legacy Foodcritic engine. See the [Cookstyle 5.1 Release Notes](https://github.com/chef/cookstyle/blob/master/RELEASE_NOTES.md#cookstyle-51) for a complete list of new rules.

#### kitchen-azurerm

kitchen-azurerm has been updated from 0.14.8 to 0.14.9, which adds a new `use_ephemeral_osdisk` configuration option. See Microsoft's [Empheral OS Disk Announcement](https://azure.microsoft.com/en-us/updates/azure-ephemeral-os-disk-now-generally-available/) for more information on this new feature.

#### kitchen-ec2

kitchen-ec2 has been updated from 3.0.1 to 3.1.0 with several new features:

- Added support for SSH through Session Manager. Thanks [@awiddersheim](https://github.com/awiddersheim)
- Adds support for searching for multiple security groups, as well as searching by group name. Thanks [@bdwyertech](https://github.com/bdwyertech)
- Allows asking for multiple instance types and subnets for spot pricing. Thanks [@vmiszczak-teads](https://github.com/vmiszczak-teads)

#### kitchen-vagrant

kitchen-vagrant has been updated from 1.5.2. to 1.6.0. This new version properly truncates the instance name to avoid hitting the 100 character limit in Hyper-V, and also updates the hostname length limit on Windows from 12 characters to 15 characters. Thanks [@Xorima](https://github.com/Xorima) and [@PowerSchill](https://github.com/PowerSchill).

#### knife-ec2

knife-ec2 has beeen updated from 1.0.8 to 1.0.12. This new version includes multiple fixes for network configuration setup, a new `--cpu-credits` option for launching T2/T3 instances as unlimited, and fixes for issues with attaching emphemeral disks.

## Chef Workstation 0.7.4

### Bug Fixes

- [404](https://github.com/chef/chef-workstation/issues/404), in which `inspec` was failing to load due to gem conflicts.

## Chef Workstation 0.6.2

### Bug Fixes

- Rubygems has been rolled back to 3.0.3 to resolve duplicate bundler gems that shipped in ChefDK 4.1.7. This resulted in warning messages when running commands as well as performance degradations.
- Fixed 'chef install foo.lock.json' errors when loading cookbooks from Artifactory.

### Red Hat 8 Support

Chef Workstation builds are now validated for Red Hat 8. Red Hat 8 builds are now listed on [downloads.chef.io](https://downloads.chef.io) and our [Omnitruck API](https://docs.chef.io/api_omnitruck.html)

### Updated Components

#### knife-ec2 1.0.8

Knife-ec2 has been updated to 1.0.8. This release removes previously deprecated bootstrap command-line options that were removed from Chef Infra Client 15.

#### knife-vsphere 3.0.1

Knife-vsphere has been updated to 3.0.1 to resolve Ruby warnings that occured when running some commmands.

#### Fauxhai 7.4.0

Fauxhai has been updated to 7.4.0, which adds additional platforms for use with ChefSpec testing.

- Updated `suse` 15 from 15.0 to 15.1
- Added a new `redhat` 8 definition to replace the 8.0 definition, which is now deprecated
- Updated all `amazon` and `ubuntu` releases to Chef 15.1
- Added `debian` 10 and 9.9

#### Chef InSpec 4.7.3

Chef InSpec has been updated to 4.7.3, which adds a new `ip6tables` resource and includes new `aws-sdk` gems that are necessary for the Chef InSpec AWS Resource Pack.

### Security Fixes

The `lodash` package in the Workstation menu bar application has been updated to `4.17.14` to resolve [CVE-2018-16487](https://nvd.nist.gov/vuln/detail/CVE-2018-16487)

## Chef Workstation 0.5.1

### Updated Components

#### Chef Infra Client 15.1

Chef Infra Client has been updated to 15.1 with new and improved resources, improvements to target mode, bootstrap bug fixes, new Ohai detection on VirtualBox hosts, and more. See the [Chef Infra Client 15.1 Release Notes](https://github.com/chef/chef/blob/master/RELEASE_NOTES.md#chef-infra-client-151) for a complete list of new and improved functionality.

#### Chef InSpec 4.6.9

Chef InSpec has been updated from 4.3.2 to 4.6.9 with the following changes:

- InSpec `Attributes` have now been renamed to `Inputs` to avoid confusion with Chef Infra attributes.
- A new InSpec plugin type of `Input` has been added for defining new input types. See the [InSpec Plugins documentation](https://github.com/inspec/inspec/blob/master/docs/dev/plugins.md#implementing-input-plugins) for more information on writing these plugins.
- InSpec no longer prints errors to the stdout when passing `--format json`.
- When fetching profiles from GitHub, the URL can now include periods.
- The performance of InSpec startup has been improved.

#### Cookstyle 5.0.0

Cookstyle has been updated to 5.0.0 with a large number of bugfixes and major improvements that lay the groundwork for future autocorrecting of cookobook style and deprecation warnings.

The RuboCop engine that powers Cookstyle has been updated from 0.62 to 0.72, which includes several hundred bugfixes to the codebase. Due to some of these bugfixes, existing cookbooks may fail when using Cookstyle 5.0. Additionally, some cops have had their names changed and the Rubocop Performance cops have been removed. If you disabled individual cops in your .rubocop.yml file, this may require you to update your confg.

This new release also merges in code from the `rubocop-chef` project, providing new alerting and autocorrecting capabilities specific to Chef Infra Cookbooks. Thank you [@coderanger](http://github.com/coderanger) for your work in the rubocop-chef project and [@chrishenry](http://github.com/chrishenry) for helping with new cops.

#### Foodcritic 16.1.1

Foodcritic has been updated from 16.0.0 to 16.1.1 with new rules and support for the latest Chef:

- Updated Chef Infra Client metadata for 15.1 to include the new `chocolatey_feature` resources, as well as new properties in the `launchd` and `chocolatey_source` resources
- Added new rule to detect large files shipped in a cookbook: `FC123: Content of a cookbook file is larger than 1MB`. Thanks [@mattray](http://github.com/mattray)
- Allowed configuring the size of the AST cache with a new `--ast-cache-size` command line option. Thanks [@Babar](http://github.com/Babar)

#### ChefSpec 7.4.0

ChefSpec has been updated to 7.4 with better support stubbing commands, and a new `policyfile_path` configuration option for specifying the path to the PolicyFile.

#### kitchen-dokken 2.7.0

kitchen-dokken has been updated to 2.7.0 with new options for controlling how containers are setup and pulled. You can now disable user namespace mode when running privileged containers with a new `userns_host` config option. There is also a new option `pull_chef_image` (true/false) to control force-pulling the chef image on each run to check for newer images. This option now defaults to `true` so that testing on latest and current always actually mean latest and current. See the [kitchen-digitalocean readme](https://github.com/test-kitchen/kitchen-digitalocean/blob/master/README.md) for `kitchen.yml` config examples.

#### kitchen-digitalocean 0.10.4

kitchen-digitalocean has been updated to 0.10.4 with support for new distros and additional configuration options for instance setup. You can now control the default DigitalOcean region systems that are spun up by using a new `DIGITALOCEAN_REGION` env var. You can still modify the region in the driver section of your `kitchen.yml` file if you'd like, and the default region of `nyc1` has not changed. This release also adds slug support for `fedora-29`, `fedora-30`, and `ubuntu-19`. Finally, if you'd like to monitor your test instances, the new `monitoring` configuration option in the `kitchen.yml` driver section allows enabling DigitalOcean's instance monitoring. See the [kitchen-dokken readme](https://github.com/someara/kitchen-dokken/blob/master/README.md) for `kitchen.yml` config examples.

#### knife-vsphere 3.0.0

knife-vsphere has been updated to 3.0. This new version adds support for specifying the `bootstrap_template` when creating new VMs. This release also improves how the plugin finds VM hosts, in order to support hosts in nested directories.

#### knife-ec2 1.0.7

knife-ec2 has received a near-complete rewrite with this release of Chef Workstation. The new knife-ec2 release switches the underlying library used to communicate with AWS from `fog-aws` to Amazon's own `aws-sdk`. The official AWS SDK has greatly improved support for the many AWS authentication methods available to users. It also has support for all of the latest AWS regions and instance types. As part of this switch to the new SDK we did have to remove the `knife ec2 flavor list` command as this used hard coded values from fog-aws and not AWS API calls. The good news is, we were able to add several new commands to the plugin. This makes provisioning systems in AWS even easier.

##### knife ec2 vpc list

This command lists all VPCs in your environment including the ID, which you need when provisioning new systems into a specific VPC.

```
$ knife ec2 vpc list
ID            State      CIDR Block     Instance Tenancy  DHCP Options ID  Default VPC?
vpc-b1bc8d9d  available  10.0.0.0/16    default           dopt-1d78412a    No
vpc-daafd931  available  172.0.0.0/16   default           dopt-1d78412a    Yes
```

##### knife ec2 eni list

This command lists all ENIs in your environment including the ID, which you need when adding the ENI to a newly provisioned instance.

```
$ knife ec2 eni list
ID                     Status  AZ          Public IP       Private IPs    IPv6 IPs  Subnet ID        VPC ID
eni-0123f25ae7805b651  in-use  us-west-2a  63.192.209.236  10.0.0.204               subnet-4ef3b123  vpc-b1bc8d9d
eni-2451c913           in-use  us-west-2a  137.150.209.123 10.0.0.245               subnet-4ef3b123  vpc-b1bc8d9d
```

##### knife ec2 securitygroup list

This command lists all security groups in your environment including the ID, which you need when assigning a newly provisioned instance a group.

```
$knife ec2 securitygroup list
ID                    Name                                     VPC ID
sg-12332d875a4a123d6  not-today-hackers                        vpc-dbbf59a2
sg-123708ab12388cac5  open-to-the-world                        vpc-dbbf59a2
```

##### knife ec2 subnet list

This command lists all subnets in your environment including the ID, which you need when placing a newly provisioned instance in a subnet.

```
$ knife ec2 subnet list
ID               State      CIDR Block      AZ          Available IPs  AZ Default?  Maps Public IP?  VPC ID
subnet-bd2333a9  available  172.31.0.0/20   us-west-2b  4091           Yes          Yes              vpc-b1bc8d9d
subnet-ba1135c9  available  172.31.16.0/20  us-west-2a  4091           Yes          Yes              vpc-b1bc8d9d
```

### End of Ubuntu 14.04 support

Ubuntu 14.04 entered the end-of-life phase April 30, 2019. Since this version of Ubuntu is now end-of-life, we've stopped building packages for Ubuntu 14.04. If you rely on Ubuntu 14.04 in your environment, we highly recommend upgrading your host to Ubuntu 16.04 or 18.04.

### Security Updates

#### curl 7.65.1

- CVE-2019-5435: Integer overflows in curl_url_set
- CVE-2019-5436: tftp: use the current blksize for recvfrom()
- CVE-2018-16890: NTLM type-2 out-of-bounds buffer read
- CVE-2019-3822: NTLMv2 type-3 header stack buffer overflow
- CVE-2019-3823: SMTP end-of-response out-of-bounds read
- CVE-2019-5443: Windows OpenSSL engine code injection

#### cacerts 5-11-2019 release

- Our `cacert` bundle has been updated to the 5-11-2019 bundle, which adds four additional CAs.

## Chef Workstation 0.4.2

### Bug Fixes

- Resolved a regression in Chef Workstation 0.4.1 where the binaries for chef-client and inspec were not available on the command line

## Chef Workstation 0.4.1

### Breaking Changes

#### Chef EULA

Usage of Chef Workstation 0.4, Chef Infra Client 15, and InSpec 4 requires accepting the [Chef EULA](https://docs.chef.io/chef_license.html#chef-eula). See the [frequently asked questions](https://www.chef.io/bmc-faq/) for information about the license update and the associated business model change.

#### Chef Provisioning

Chef Provisioning is no longer included with Chef Workstation, and will be officially end of life on August 31, 2019. The source code of Chef Provisioning and the drivers have been moved into the chef-boneyard GitHub organization and won't be further maintained. Current users of Chef Provisioning should contact your Chef Customer Success Manager or Account Representative to review your options.

#### `knife bootstrap` against cloud providers

`knife bootstrap` was [rewritten](https://github.com/chef/chef/blob/cfbb01cb5648297835941679bc9638d3a823ad5e/RELEASE_NOTES.md#knife-bootstrap) in Chef Infra Client 15.
The `knife-*` cloud providers need to be updated to use this new API.
As of Chef Workstation 0.4, `knife bootstrap` functionality against the cloud providers will be broken.
We will fix this ASAP in a Chef Workstation 0.5 release.
The only gem *not* affected is the `knife-windows` gem.
It has already been re-written to leverage the new bootstrap library.

Affected gems:

- `knife-ec2`
- `knife-google`
- `knife-vsphere`

If you leverage this functionality, please wait to update Chef Workstation until 0.5 is released with fixes for these gems.

### Improved Chef Generate command

The `chef generate` command has been updated to produce cookbooks and repositories that match Chef's best practices.

- `chef generate repo` now generates a Chef repository with Policyfiles by default. You can revert to the previous roles / environment behavior with the `--roles` flag.
- `chef generate cookbook` now generates a cookbook with a Policyfile and no Berksfile by default. You can revert to the previous behavior with the `--berks` flag.
- `chef generate cookbook` now includes ChefSpecs that utilize the ChefSpec 7.3+ format. This is a much simpler syntax that requires less updating of specs as older platforms are deprecated.
- `chef generate cookbook` no longer creates cookbook files with the unecessary `frozen_string_literal: true` comments.
- `chef generate cookbook` no longer generates a full Workflow (Delivery) build cookbook by default. A new `--workflow` flag has been added to allow generating the build cookbook. This flag replaces the previously unused `--delivery` flag.
- `chef generate cookbook` now generates cookbooks with metadata requiring Chef 14 or later.
- `chef generate cookbook --kitchen dokken` now generates a fully working kitchen-dokken config.
- `chef generate cookbook` now generates Test Kitchen configs with the `product_name`/`product_version` method of specifying Chef Infra Client releases as `require_chef_omnibus` will be removed in the next major Test Kitchen release.
- `chef generate cookbook_file` no longer places the specified file in a "default" folder as these aren't needed in Chef Infra Client 12 and later.
- `chef generate repo` no longer outputs the full Chef Infra Client run information while generating the repository. Similar to the `cookbook` command you can view this verbose output with the `--verbose` flag.

### Updated Components and Tools

#### Chef InSpec 4

Chef InSpec has been updated to 4.3.2 which includes the new InSpec AWS resource pack with **59** new AWS resources, multi-region support, and named credentials support. This release also includes support for auditing systems that use `ed25519` SSH keys.

#### Chef Infra Client 15

Chef Infra Client has been updated to Chef 15 with **8** new resources, target mode prototype functionality, `ed25519` SSH key support, and more. See the [Chef Infra Client 15 Release Notes](https://github.com/chef/chef/blob/master/RELEASE_NOTES.md#chef-infra-client-150293) for more details.

#### Fauxhai 7.3

Fauxhai has been updated from 6.11 to 7.3. This removes all platforms that were previously marked as deprecated. So if you've noticed deprecation warnings during your ChefSpec tests, you will need to update those specs for the latest [supported Faxhai platforms](https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md). This release also adds the following new platform releases for testing in ChefSpec:

- RHEL 6.10 and 8.0
- openSUSE 15.0
- CentOS 6.10
- Debian 9.8 / 9.9
- Oracle Linux 6.10, 7.5, and 7.6

#### Test Kitchen 2.2

Test Kitchen has been updated from 1.24 to 2.2.5. This update adds support for accepting the Chef Infra Client and Chef InSpec EULAs during testing, as well as support for newer `ed25519` format SSH keys on guests. The newer release does remove support for the legacy Librarian depsolver and testing of Chef Infra Client 10/11 releases in some scenarios. See the [Test Kitchen Release Notes](https://github.com/test-kitchen/test-kitchen/blob/master/RELEASE_NOTES.md#test-kitchen-22-release-notes) for additional details on this release.

#### Kitchen-ec2 3.0

Kitchen-ec2 has been updated to 3.0, which uses the newer `aws-sdk-v3` and includes a large number of improvements to the driver including improved hostname detection, backoff retries, additional security group configuration options, and more. See the [kitchen-ec2 Changelog](https://github.com/test-kitchen/kitchen-ec2/blob/master/CHANGELOG.md#v300-2019-05-01) for additional details.

#### kitchen-dokken 2.6.9

Kitchen-dokken has been updated to 2.6.9 with a new config option `pull_platform_image`, which allows you to disable pulling the platform Docker image on every Test Kitchen converge / test. This is particularly useful for local platform image testing.

kitchen.yml example:

```yaml
driver:
  name: dokken
  pull_platform_image: false
```

## Chef Workstation 0.3.2

### Support for managing Chef EULA required products

We've updated the included products to be able to manage remote installations of Chef EULA required products:

- Test Kitchen
- `chef-run`
- `knife bootstrap`

### New Policy File Functionality

`include_policy` now supports `:remote` policy files. This new functionality allows you to include policy files over http. Remote policy files require remote cookbooks and `install` will fail otherwise if the included policy file includes cookbooks with paths. Thanks [@mattray](https://github.com/mattray)!

### Security Updates

#### Rubygems 2.7.9

Rubygems has been updated from 2.7.8 to 2.7.9 to resolves the following CVEs:

- CVE-2019-8320: Delete directory using symlink when decompressing tar
- CVE-2019-8321: Escape sequence injection vulnerability in verbose
- CVE-2019-8322: Escape sequence injection vulnerability in gem owner
- CVE-2019-8323: Escape sequence injection vulnerability in API response handling
- CVE-2019-8324: Installing a malicious gem may lead to arbitrary code execution
- CVE-2019-8325: Escape sequence injection vulnerability in errors

#### curl 7.65.0

- CVE-2019-5435: Integer overflows in curl_url_set
- CVE-2019-5436: tftp: use the current blksize for recvfrom()
- CVE-2018-16890: NTLM type-2 out-of-bounds buffer read
- CVE-2019-3822: NTLMv2 type-3 header stack buffer overflow
- CVE-2019-3823: SMTP end-of-response out-of-bounds read

### Updated Components and Tools

#### Chef 14.12.3

ChefDK now ships with Chef 14.13.11. See [Chef 14.14 release notes](https://docs.chef.io/release_notes.html) for more information on what's new.

It also updates `knife bootstrap` to support installing and managing Chef Infra Client 15 on remote nodes. See [Accepting the Chef EULA](https://docs.chef.io/chef_license_accept.html#workstation-products) general instructions for accepting the license (command line flag, environment variable or configured in `~/.chef/config.rb`).

#### InSpec 3.9.0

ChefDK now ships with InSpec 3.9.0. See [InSpec 3.9.0 release details](https://github.com/inspec/inspec/releases/tag/v3.9.0) for more information on what's new.

#### Ruby 2.5.5

Ruby has been updated from 2.5.3 to 2.5.5, which includes a large number of bug fixes.

### Test Kitchen 1.25

Test Kitchen has been updated to 1.25 with backports of many non-breaking Test Kitchen 2.0 features:

- Support for accepting the Chef 15 license in Test Kitchen runs. See Accepting the Chef License for usage details.
- A new --fail-fast command line flag for use with the concurency flag. With this flag set, Test Kitchen will immediatly fail when any converge fails instead of continuing to test additional instances.
- The policyfile_path config option now accepts relative paths.
- A new berksfile_path config option allows specifying Berkshelf files in non-standard locations.
- Retries are now honored when using SSH proxies

#### kitchen-hyperv

kitchen-hyperv has been updated to 0.5.3, which now automatically disables snapshots on the VMs and properly waits for the IP to be set.

#### kitchen-vagrant

kitchen-vagrant has been updated to 1.5.1, which adds support for using the new bento/amazonlinux-2 box when setting the platform to amazonlinux-2.

#### kitchen-ec2

kitchen-ec2 has been updated to 2.5.0 with support for Amazon Linux 2.0 image searching using the platform 'amazon2'. This release also adds supports Windows Server 1709 and 1803 image searching.

#### kitchen-dokken

kitchen-dokken has been updated to 2.7.0:

- The Chef Docker image is now pulled by default so that locally cached latest or curent container versions will be compared to those available on DockerHub. See the readme for instructions on reverting to the previous behavior.
- User namespace mode can be disabled when running privileged containers with a new userns_host config option. See the readme for details.
- You can now disable pulling the platform Docker images for local platform image testing or air gapped testing. See the readme for details.

#### knife-vsphere

knife-vsphere has been updated to 2.1.3, which adds support for knife's `bootstrap_template` flag and removes the legacy `distro` and `template_file` flags.

#### `chef-run`

The Chef Apply gem has been updated to 0.2.13, which adds support for installing and managing Chef Infra Client 15 on remote nodes. See [Accepting the Chef EULA](https://docs.chef.io/chef_license_accept.html#workstation-products) general instructions for accepting the license (command line flag or environment variable). Additionally the license can be accepted in the `~/.chef-workstation/config.toml` by adding:

```
[chef]
chef_license = "accept"
```

#### Push Jobs Client

Push Jobs Client has been updated to 2.5.6, which includes significant optimizations and minor bug fixes.

#### Other updates

- `openssl`: 1.0.2r -> 1.0.2s (bugfix only release)
- `cacerts`: 2019-01-23 -> 2019-05-15
- `kitchen-vagrant`: 1.5.1 -> 1.5.2
- `mixlib-install`: 3.11.12 -> 3.11.18
- `ohai`: 14.8.11 -> 14.8.12

## Chef Workstation 0.2.53

### Updated Components and Tools

#### ChefDK 3.8.14

Chef Workstation now ships with ChefDK 3.8.14. Those changes included in these release notes.

#### InSpec 3.6.6

Chef Workstation now ships with Inspec 3.6.6. See <https://github.com/inspec/inspec/releases/tag/v3.6.6> for more information on what's new.

#### Fauxhai 6.11.0

- Added Windows 2019 Server, Red Hat Linux 7.6, Debian 9.6, and CentOS 7.6.1804.
- Updated Windows7, 8.1, and 10, 2008 R2, 2012, 2012 R2, and 2016 to Chef 14.10.
- Update Oracle Linux 6.8/7.2/7.3/7.4 to Ohai 14.8 in EC2
- Updated the fetcher logic to be compatible with ChefSpec 7.3+. Thanks @oscar123mendoza
- Removed duplicate json data in gentoo 4.9.6

#### Other updates

- `kitchen-digitalocean`: 0.10.1 -> 0.10.2
- `mixlib-install`: 3.11.5 -> 3.11.11
- `delivery-cli`: 0.5.0 -> 0.5.2

### Security Updates

#### OpenSSL

OpenSSL updated to 1.0.2r to resolve [CVE-2019-1559](https://nvd.nist.gov/vuln/detail/CVE-2019-1559)

## Chef Workstation 0.2.48

### Improvements

#### Chef 14.10.9

Chef Workstation now ships with Chef 14.10.9. See <https://docs.chef.io/release_notes.html> for more information on what's new.

#### InSpec 3.4.1

Chef Workstation now ships with Inspec 3.4.1. See <https://github.com/inspec/inspec/releases/tag/v3.4.1> for more information on what's new.

#### kitchen-inspec 1.0.1

Support bastion configuration in transport options.

#### kitchen-vagrant 1.4.0

This fixes audio for virtualbox users by disabling audio in virtualbox by default to prevent interrupting the host's Bluetooth audio.

#### kitchen-azurerm 0.14.8

Support Azure Managed Identities and apply vm_tags to all resources in resource group.

#### Updated Components and Tools

- `bundler`: 1.16.1 -> 1.17.3
- `chef-apply`: 0.2.4 -> 0.2.7
- `kitchen-tidy`: 1.2.0 -> 2.0.0
- `rubygems`: 2.7.6 -> 2.7.8

### Deprecations

- `chef provision` - Chef Provisioning has been in maintenance mode since 2015 and due to the age of it's dependencies it can't be included in ChefDK 4 which is scheduled for an April release. Additional information on the future of Chef Provisioning will be announced in the coming weeks

## Chef Workstation 0.2.43

### New Features

- New option: `chef generate cookbook --kitchen (dokken|vagrant)` Generate cookbooks with a specific kitchen configuration (defaults to vagrant).

### Improvements

#### Chef 14.8.12

ChefDK now ships with Chef 14.8.12. See <https://docs.chef.io/release_notes.html> for more information on what's new.

#### OpenSSL

OpenSSL updated to 1.0.2q to resolve:

- Microarchitecture timing vulnerability in ECC scalar multiplication ([CVE-2018-5407](https://nvd.nist.gov/vuln/detail/CVE-2018-5407))
- Timing vulnerability in DSA signature generation ([CVE-2018-0734](https://nvd.nist.gov/vuln/detail/CVE-2018-0734))

#### Updated Components and Tools

- `kitchen-ec2`: 3.0.6 -> 3.0.6
- `inspec`: 3.0.52 -> 3.2.6
- `test-kitchen`: 1.23.2 -> 1.24.0

## Chef Workstation 0.2.41

### Bug Fixes

- Fixed internal CI scripts that automatically post release notes to discord

## Chef Workstation 0.2.40

### New Features

- Updated Kitchen EC2 to add support for new `arm64` architecture

### Bug Fixes

- If there was an issue trying to create the local policyfile bundle, `chef-run` would not exit appropriately. This has been fixed.

## Chef Workstation 0.2.39

This release doesn't have any release notes.

## Chef Workstation 0.2.35

This release doesn't have any release notes.

## Chef Workstation 0.2.29

### Chef 14.6.47

ChefDK now ships with Chef 14.6.47. See [https://docs.chef.io/release_notes.html](https://docs.chef.io/release_notes.html) for more information on what's new.

### Smaller package size

ChefDK RPM and Debian packages are now compressed. Additionally many gems were updated to remove extraneous files that don't need to be included. The download size of packages has decreased accordingly (all measurements in megabytes):

- .deb: 108 -> 84 (22%)
- .rpm: 112 -> 86 (24%)

### Platform Additions

macOS 10.14 (Mojave) is now fully tested and packages are available on downloads.chef.io.

### Updated Tooling

#### Fauxhai

Fauxhai has been updated from 6.6.0 to version 6.9.1. This update brings in the latest mocked Ohai run data for use with ChefSpec. This release adds data for Linux Mint 19, macOS 10.14, Solaris 5.11 (11.4 release), and SLES 15. This release also deprecates the following platforms for removal April 2018: Linux Mint 18.2, Gentoo 4.9.6, All versions of ios_xr, All versions of omnios, All versions of nexus, macOS 10.10, and Solaris 5.10. See [https://github.com/chefspec/fauxhai/tree/master/lib/fauxhai/platforms](https://github.com/chefspec/fauxhai/tree/master/lib/fauxhai/platforms) for a complete list of non-deprecated platform data for use with ChefSpec.

#### Foodcritic

Foodcritic has been updated from 14.1 to 14.3. This updates the metadata that ships with Foodcritic to provide the latest Chef 13.11 and 14.5 metadata, while removing metadata from older Chef releases. This update also removes the FC121 rule, which was causing confusion with community cookbook authors. This rule will be added back when Chef 13 goes EOL in April 2019.

#### InSpec 3

This release updates Inspec from 2.2.112 to 3.0.12. This is a major milestone and includes the plugin system, global attributes, enhanced skip messaging, and more. Please head over to [https://www.inspec.io](https://www.inspec.io) for a full rundown.

#### Kitchen AzureRM

The Kitchen AzureRM driver now supports the Shared Image Gallery.

#### Kitchen DigitalOcean

The Kitchen DigitalOcean driver now supports FreeBSD 10.4 and 11.2 in Kitchen configs.

#### Kitchen EC2

Kitchen EC2 has been updated to better support Windows systems. The auto-generated security group will now include support for RDP and the log directory will alway be created.

#### Kitchen Google

Kitchen Google now includes support for adding labels to instances with a new `labels` config that accepts labels as a hash.

#### Knife Windows

Knife Windows has improved Windows detection support to identify Windows 2012r2, 2016, and 10. Additionally when bootstrapping nodes, there is now support for using the client.d directories.

#### Security Updates

Ruby has been updated to 2.5.3 to resolve the following vulnerabilities:

- `CVE-2018-16396`: Tainted flags aren't propagated in Array#pack and String#unpack with some directives
- `CVE-2018-16395`: OpenSSL::X509::Name equality check doesn't work correctly

## Chef Workstation 0.2.27

This release doesn't have any release notes.

## Chef Workstation 0.2.21

This release doesn't have any release notes.

## Chef Workstation 0.1.162

This release doesn't have any release notes.

## Chef Workstation 0.1.155

This release doesn't have any release notes.

## Chef Workstation 0.1.150

This release doesn't have any release notes.

## Chef Workstation 0.1.148

This release doesn't have any release notes.

## Chef Workstation 0.1.142

This release doesn't have any release notes.

## Chef Workstation 0.1.139

This release doesn't have any release notes.

## Chef Workstation 0.1.137

This release doesn't have any release notes.

## Chef Workstation 0.1.133

This release doesn't have any release notes.

## Chef Workstation 0.1.120

This release doesn't have any release notes.

## Chef Workstation 0.1.119

This release doesn't have any release notes.
