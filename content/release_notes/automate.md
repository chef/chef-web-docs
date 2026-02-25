+++
title = "Chef Automate release notes"
draft = false
product = ["automate"]
linkTitle = "Chef Automate"
summary = "Chef Automate release notes"

[menu]
  [menu.release_notes]
    title = "Chef Automate"
    identifier = "release_notes/release_notes.md Chef Automate"
    parent = "release_notes"
    weight = 10
+++

<!-- markdownlint-disable-file -->
<!-- cSpell:disable  -->
<!-- vale off -->

## Chef Automate upgrade journey

Upgrade Chef Automate based on your current version of Chef Automate.

| Your Current Version              | Upgrade To     |
|-----------------------------------|----------------|
| Any version before 20220329091442 | 20220329091442 |
| 20220329091442                    | 3.0.x          |
| 3.0.49                            | 4.x            |

See the [Chef Automate 4.x upgrade documentation](https://docs.chef.io/automate/major_upgrade_4.x/) for more information.

## Chef Automate 4.13.361

Released on November 6, 2025

### Improvements

- Support for deprecated ciphers in configuration. For more information, see the [Configuration Overview](https://docs.chef.io/automate/configuration/).
- Updated the wal_sender_timeout and wal_receiver_timeout in HA Postgres from 60 to 60000 seconds.

### Compliance profile updates

We updated the Chef compliance profiles to version 1.0.0/20251027061057, which includes the new and improved profiles for:

- CIS SUSE Linux 15 v2.0.0 Audits
- CIS Red Hat Enterprise Linux 10 v1.0.0
- CIS Windows Server 2022 v4.0.0

### Bug fixes

The issue where the Projects selection drop-down would disappear in specific scenarios has been resolved.

### Security

#### Security updates

- Updated go-viper to fix the following CVEs:

  - CWE-117

- Updated nginx to 1.28.0 to resolve the following CVEs:

  - CVE-2024-24989
  - CVE-2024-24990
  - CVE-2024-7347
  - CVE-2024-32760
  - CVE-2024-35161
  - CVE-2025-23419

- Updated tar-fs from version to 3.1.1 to address the following CVE:

  - CVE-2025-59343

- Updated from cross-spawn 7.0.3 to 7.0.6, which fixes:

  - CVE-2024-21538

- Updated OpenSearch to the TuxCare OpenSearch 1.3.20.tuxcare.1.0.2 to address the following CVEs:

  - CVE-2025-25193
  - CVE-2024-47554
  - CVE-2021-28170
  - CVE-2025-48924
  - CVE-2024-38820
  - CVE-2025-48913
  - CVE-2024-38819
  - CVE-2024-38828
  - CVE-2024-38820
  - CVE-2025-22233

- Updated Postgres 13.22 to resolve the following CVEs:

  - CVE-2025-8714
  - CVE-2025-8715
  - CVE-2025-8713

- Updated OpenJDK to 17.0.16+8 to address the following CVEs:

  - CVE-2025-30749
  - CVE-2025-30754
  - CVE-2025-50059
  - CVE-2025-50106

- Updated Angular 19.2.15 to address the following CVE:

  - CVE-2025-59052

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.1243/20241227194506
- Chef Habitat Builder version: 10717/20250805204117
- Chef Infra Server version: 15.10.83
- Chef InSpec version: 5.22.95/20250805133317

### Service versions

This release uses:

- Postgres: 13.22.tuxcare.1.0.1
- OpenSearch: 1.3.20.tuxcare.1.0.2
- Nginx: 1.28.0
- Haproxy: 2.8.15

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef InSpec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.24.4
- OpenJDK: 17.0.16+8
- Angular: 19.2.15

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.13.311

Released on September 15, 2025

### Bug fixes

- Chef Automate now properly allows and validates extended validation certificates when Chef Infra Server services connect to external databases.
- We improved upgrade handling for Habitat in Chef Automate HA clusters with shared backends.
  Automate now performs Habitat upgrades with minimal disruption and reduced impact on cluster health, addressing previous issues during upgrade processes.

### Compliance profile updates

- We updated the Chef compliance profiles to version 1.0.0/20250901083043. This includes the new and improved profiles for:

  - CIS Apache Tomcat 10.1 v1.1.0 (Audits)
  - CIS IBM AIX 7 v1.1.0 (Audits)

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.1243/20241227194506
- Chef Habitat Builder version: 10717/20250805204117
- Chef Infra Server version: 15.10.66
- Chef InSpec version: 5.22.95/20250805133317

### Service versions

This release uses:

- Postgres: 13.21.0
- OpenSearch: 1.3.20-tuxcare
- Nginx: 1.25.4
- HAProxy: 2.8.15

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.13.295

Released on September 2, 2025

### New features

Added the `--verify-restore-config` flag to the Automate Command Line Interface (CLI) High Availability (HA) Restore command for snapshot and base-path verification.

### Compliance profile updates

The compliance profiles were updated to version 1.0.0/20250813155029, which includes the new and improved profiles for:

- CIS Oracle Database 23 ai v1.0.0
- CIS Ubuntu 22.04 v2.0.0 audits profile
- CIS RHEL 8 v3.0.0 improvement in control 5.2.3.13 (removed unwanted code)
- CIS PostgreSQL 16 v1.0.0 (Audits) control 7.2 (log replication default to on)
- CIS PostgreSQL 16 v1.0.0 (Audits) control 3.1.8 (used correct anecdote for hours)
- CIS IBM AIX 7 v1.1.0 (audits profile)

### Bug fixes

Updated the self-signed certificate for the Postgres and Open search packages for the Automate HA packages.

### Maintenance

- Updated the following packages to ensure they're as up-to-date as possible:

  - OpenSearch (version specific to Chef commercially licensed from TuxCare)
  - OpenJDK
  - Golang
  - NodeJS
  - Angular
  - Chef components:

    - knife-ec-backup
    - InSpec
    - Habitat
    - Chef Server

- PostgreSQL and libraries to support the same

- MinIO
- Dex
- OpenSSL
- HAProxy
- Curl

### Security updates

Many of the underlying packages were upgraded to improve security posture. Refer to the list of packages upgraded in the **Maintenance** section.

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.1243/20241227194506
- Chef Habitat Builder version: 10717/20250805204117
- Chef Infra Server version: 15.10.63
- Chef InSpec version: 5.22.95/20250805133317

### Service versions

This release uses:

- Postgres: 13.21.0
- OpenSearch: 1.3.20-tuxcare
- Nginx: 1.25.4
- HAProxy: 2.8.15

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.13.168

Released on May 15, 2025

### New features

- Added ServiceNow version Xanadu. ([#8857](https://github.com/chef/automate/pull/8857))

### Bug fixes

- Resolved an issue where Automate would not exit maintenance mode after being turned off. ([#8849](https://github.com/chef/automate/pull/8849))

#### Enhancements and bug fixes for Chef Automate High Availability

- Fixed a bug where backend node IPs weren't properly registered on frontend nodes. ([#8868](https://github.com/chef/automate/pull/8868))
- Resolved an issue where configuration values were reset to defaults following an upgrade. ([#8875](https://github.com/chef/automate/pull/8875))
- Updated documentation to include `max_connection` configuration for HA setups. ([#8852](https://github.com/chef/automate/pull/8852))
- Corrected handling of the `skip_migration` file that previously blocked restore command execution. ([#8823](https://github.com/chef/automate/pull/8823))
- Updated documentation to reflect the use of $HOME for config verification services. ([#8874](https://github.com/chef/automate/pull/8874))
- Automated verification services now correctly reference the home directory using the $HOME environment variable. ([#8864](https://github.com/chef/automate/pull/8864))
- Addressed a bug where outdated node DNs persisted after certificate rotation. ([#8871](https://github.com/chef/automate/pull/8871))
- Added support for the new replication configuration in PostgreSQL. ([#8878](https://github.com/chef/automate/pull/8878))
- Improved certificate handling to support commas in subject names. ([#8864](https://github.com/chef/automate/pull/8864))
- Removed the deprecated certificate rotation command to prevent confusion. ([#8871](https://github.com/chef/automate/pull/8871))
- Fixed a connection leak in the automate-backend-sidecar service. ([#8859](https://github.com/chef/automate/pull/8859))
- Maintenance mode status is now accurately reflected in the system status summary. ([#8864](https://github.com/chef/automate/pull/8864))
- The chef-automate version command now includes the airgap bundle version. ([#8864](https://github.com/chef/automate/pull/8864))
- Revised HA architecture diagrams for improved clarity and accuracy. ([#8881](https://github.com/chef/automate/pull/8881))

### Security

#### Security updates

(examples: dependency updates, CVE fixes)

- Updated action mailer to 7.0.8.5, which fixes

  - CVE-2024-47889

### Chef packaged product versions

This release uses:

- Chef Habitat version:1.6.1205/20241107140309
- Chef Habitat Builder version: 9497/20221221224518
- Chef Infra Server version: 15.10.33/20250220084434
- Chef InSpec version: 4.56.61/20240809111842

### Service versions

This release uses:

- Postgres: 13.18
- OpenSearch: 1.3.20
- Nginx: 1.25.4
- HAProxy: 2.2.29
- Dex: 2.35.0

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.22.5
- OpenJDK: 11.0.22+7
- Angular: 17.3.0

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.13.118

Released on March 3, 2025

### Improvements

- The Infra Server in Automate now allows organizations to be accessed by having "dex" or "assets" as a substring. ([#8744](https://github.com/chef/automate/pull/8744))

### Bug fixes

- Fixes the issue of Automate stopping from loading more than 100 controls in the compliance reports page for a node. ([#8673](https://github.com/chef/automate/pull/8673))
- Fixes the issue that stopped Automate from expanding the control test results for a node when the number of tests exceeds 50. ([#8673](https://github.com/chef/automate/pull/8673))
- Added preflight check for ports 6432 and 5432 in Automate HA verification.

### Security

#### Security improvements

- The X-XSS-Protection and CSP header values are now configurable. ([#8767](https://github.com/chef/automate/pull/8767))
- Remove the plain text password and encrypt it while storing it for Automate and Automate HA in the configs.

#### Security updates

- Updated `open-policy-agent/opa` to v0.42.0
- Updated `lodash` to v4.17.19
- Updated `crypto` to v0.31.0

### Chef packaged product versions

This release uses:

- Chef Habitat version:1.6.1205/20241107140309
- Chef Habitat Builder version: 9497/20221221224518
- Chef Infra Server version: 15.10.33/20250220084434
- Chef InSpec version: 4.56.61/20240809111842

### Service versions

This release uses:

- Postgres: 13.18
- OpenSearch: 1.3.20
- Nginx: 1.25.4
- HAProxy: 2.2.29
- Dex: 2.35.0

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.22.5
- OpenJDK: 11.0.22+7
- Angular: 17.3.0

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.13.76

Released on January 9, 2025

### Bug fixes

- The Chef Automate Compliance page now shows more results when you select the "+" symbol. ([#8673](https://github.com/chef/automate/pull/8673))
- The `knife search` and `knife tidy` commands can now return more than 10,000 records. See the [knife search documentation](https://docs.chef.io/automate/troubleshooting/#issue-knife-search-limits-at-10000-records) for configuration changes. ([#8699](https://github.com/chef/automate/pull/8699))
- Fixed an issue where all OpenSearch node server names were set to an empty string. ([#8711](https://github.com/chef/automate/pull/8711))

### Security

#### Security updates

- Updated Dex to v2.27.0, which fixes following issues:

  - CVE-2020-26290
  - CVE-2020-27847

- Updated Ruby to v3.1.6, which fixes following issues:

  - CVE-2021-33621
  - CVE-2024-27280

- Updated Postgres to v13.18, which fixes following issues:

  - CVE-2024-7348

- Updated OpenSearch to 1.3.20, which fixes following issues:

  - CVE-2024-22243
  - CVE-2024-38808
  - CVE-2024-38809

### Chef packaged product versions

This release uses:

- Chef Habitat version:1.6.1205/20241107140309
- Chef Habitat Builder version: 9497/20221221224518
- Chef Infra Server version: 15.10.27/20250102025130
- Chef InSpec version: 4.56.61/20240809111842

### Service versions

This release uses:

- Postgres: 13.18
- OpenSearch: 1.3.20
- Nginx: 1.25.4
- HAProxy: 2.2.29
- Dex: 2.35.0

### Supported external Chef products

- Chef Automate Incident Creation App and Chef Automate Integration App are now supported on the Washington ServiceNow platform

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.22.5
- OpenJDK: 11.0.22+7
- Angular: 17.3.0

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.13.37

Released on December 4, 2024

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20241128081652, which includes the new and improved profiles for:

  - CIS Oracle Linux 9 v2.0.0(Audits)
  - CIS Debian Linux 12 v1.0.1(Audits)
  - CIS Debian Linux 11 v2.0.0(Audits)
  - CIS Windows Server 2022 v3.0.0(Audits)
  - CIS MSSQL Server 2022 v1.1.0(Audits)
  - CIS RHEL 9 v2.0.0 (Audits)
  - CIS Ubuntu 24.04 v1.0.0 (Audits)

### Bug fixes

- Fixed a typo in the certificate template script for Automate HA. ([#8616](https://github.com/chef/automate/pull/8616))
- Fixed to reflect node name in URL while filtering by node name in the Compliance page. ([#8621](https://github.com/chef/automate/pull/8621))
- Fixed to prevent OpenSearch restart by preventing config changes during the upgrade when adding or removing nodes. ([#8632](https://github.com/chef/automate/pull/8632))
- Fixed to avoid log line misses in case of centralized logging. You can refer to <https://docs.chef.io/automate/centralize_logs> for more configurations. ([#8635](https://github.com/chef/automate/pull/8635))
- Fixed to apply Postgres root-ca certificate in the PostgreSQL backend node through the certificate rotate template. ([#8637](https://github.com/chef/automate/pull/8637))

### Maintenance

- We updated the embedded Chef Infra Server to 15.10.21. This Infra Server installed from this version of Automate would require the application of an Automate License before use. For more information, see <https://docs.chef.io/automate/chef_automate_license/#chef-server-under-automate-license>.

### Security

#### Security updates

(examples: dependency updates, CVE fixes)

- Updated Golang version to 1.22.5, which fixes CVE issues. There are a few things to note:

  - CVE-2024-38513
  - CVE-2024-25124
  - CVE-2023-45128
  - CVE-2023-45141
  - CVE-2023-41338

- Updated OpenSearch to 1.3.19, which fixes the following CVEs:

  - CVE-2024-29736
  - CVE-2024-32007

### Chef packaged product versions

This release uses:

- Chef Habitat version:1.6.521/20220603154827
- Chef Habitat Builder version: 9497/20221221224518
- Chef Infra Server version: 15.10.21/20241126093701
- Chef InSpec version: 4.56.61/20240809111842

### Service versions

This release uses:

- Postgres: 13.14
- OpenSearch: 1.3.19
- Nginx: 1.25.4
- Haproxy: 2.2.29
- Dex: 2.27.0

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.22.5
- OpenJDK: 11.0.22+7
- Angular: 17.3.0

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.13.5

Released on September 27, 2024

### Bug fixes

- We've fixed a bug to ensure all controls are listed in JSON and CSV format when downloading compliance reports. This fix enhances the reliability of the download process ([#8601](https://github.com/chef/automate/pull/8601)).
- We've fixed a bug to ensure that Automate and Automate HA deployments with external database work properly ([#8613](https://github.com/chef/automate/pull/8613)).

### Chef packaged product versions

This release uses:

- Chef Habitat version:1.6.521/20220603154827
- Chef Habitat Builder version: 9497/20221221224518
- Chef Infra Server version: 15.10.12/20240910074923
- Chef InSpec version: 4.56.61/20240809111842

### Service versions

This release uses:

- Postgres: 13.14
- OpenSearch: 1.3.14
- Nginx: 1.25.4
- Haproxy: 2.2.29
- Dex: 2.27.0

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.19.3
- OpenJDK: 11.0.22+7
- Angular: 11.2.6

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.13.0

Released on September 24, 2024

### New features

- Deploy Chef Automate HA on Azure provisioned infrastructure ([#8592](https://github.com/chef/automate/pull/8592)).

### Improvements

- Improved welcome UI screen for Automate ([#8539](https://github.com/chef/automate/pull/8539)).
- Improved Automate HA solution ensures services don't flap when re-booted nodes - ability to modify `fail_timeout`, `health_check_interval` parameters ([#8548](https://github.com/chef/automate/pull/8548))

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20240823105414, which includes the new and improved profiles for:

  - RHEL 7 v4.0.0
  - RHEL8 v3.0.0
  - STIG RHEL 9
  - Windows 2016 v3.0.0
  - Windows 2019 v3.0.1
  - STIG Microsoft IIS Server
  - STIG Postgres SQL

### Bug fixes

- Fixed bug to ensure that complete report of controls is available for any date of compliance report in UI ([#8533](https://github.com/chef/automate/pull/8533)).
- Fixed bug to improve handling of user provided data in string literal ([#8543](https://github.com/chef/automate/pull/8543)).

### Maintenance

- Updated embedded Chef Infra Server to 15.10.12
- Updated embedded Chef Inspec to 4.56.61

### Security

#### Security updates

- Updated MinIO to fix following CVEs ([#4625](https://github.com/habitat-sh/core-plans/pull/4625)):

  - CVE-2021-43858
  - CVE-2022-24842
  - CVE-2022-31028
  - CVE-2022-35919
  - CVE-2023-25812
  - CVE-2023-28433
  - CVE-2023-28433
  - CVE-2023-28434
  - CVE-2023-28432
  - CVE-2023-27589
  - CVE-2024-36107
  - CVE-2024-24747
  - CVE-2021-41137
  - CVE-2020-11012
  - CVE-2021-21287
  - CVE-2021-21362
  - CVE-2021-21390
  - CVE-2018-1000538

- Removed end of life workflow components from Chef Automate ([#8472](https://github.com/chef/automate/pull/8472)) to solve following CVEs:

  - CVE-2023-26111
  - CVE-2022-24999
  - CVE-2022-46175
  - CVE-2022-38900
  - CVE-2022-31129
  - CVE-2021-43138
  - CVE-2022-0355
  - CVE-2022-24785
  - CVE-2021-32804
  - CVE-2021-32803
  - CVE-2022-0144
  - CVE-2022-21680
  - CVE-2022-21681
  - CVE-2022-0155
  - CVE-2021-37713
  - CVE-2021-37712
  - CVE-2021-37701

- Updated Angular in Chef Automate to 17.3.5 with all development dependencies including TypeScript and nodeJS to solve following CVE:

  - CVE-2022-24999
  - CVE-2022-46175
  - CVE-2021-3807

  ([#8365](https://github.com/chef/automate/pull/8365), [#8451](https://github.com/chef/automate/pull/8451), [#8336](https://github.com/chef/automate/pull/8336), [#8337](https://github.com/chef/automate/pull/8337))

- Updated curl package to 8.7.1 ([#4676](https://github.com/habitat-sh/core-plans/pull/4676), [#8537](https://github.com/chef/automate/pull/8537)) to fix following CVEs:

  - CVE-2023-38545
  - CVE-2023-38546
  - CVE-2024-2398
  - CVE-2023-46218

- Updated OpenSSL to 1.0.2zi ([#8536](https://github.com/chef/automate/pull/8536)) to solve following CVEs:

  - CVE-2021-3712
  - CVE-2022-0778
  - CVE-2022-1292
  - CVE-2022-2068
  - CVE-2022-4304
  - CVE-2023-0215
  - CVE-2023-0286
  - CVE-2023-0464
  - CVE-2023-0465
  - CVE-2023-0466
  - CVE-2023-3446
  - CVE-2023-3817

- Updated NodeJS to 14.23.3 ([#3831](https://github.com/chef/chef-server/pull/3831)) to solve following CVEs:

  - CVE-2023-23918
  - CVE-2023-23919
  - CVE-2023-23920
  - CVE-2023-23936
  - CVE-2023-24807

### Chef packaged product versions

This release uses:

- Chef Habitat version:1.6.521/20220603154827
- Chef Habitat Builder version: 9497/20221221224518
- Chef Infra Server version: 15.10.12/20240910074923
- Chef InSpec version: 4.56.61/20240809111842

### Service versions

This release uses:

- Postgres: 13.14
- OpenSearch: 1.3.14
- Nginx: 1.25.4
- Haproxy: 2.2.29
- Dex: 2.27.0

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.19.3
- OpenJDK: 11.0.22+7
- Angular: 11.2.6

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.12.144

Released on July 29, 2024

### Automate licensing

The Chef Automate UI now notifies you if your Chef License is about to expire or has already expired. Enter a new license by selecting the link in the license notification at the top of the Automate UI and then paste your license in the **Apply new Chef Automate license** dialog.

For more information, see the [Automate licensing documentation](https://docs.chef.io/automate/chef_automate_license/) or [contact your account team representative](https://www.chef.io/contact-us).

### Improvements

- Password in backend nodes of Automate HA can be rotated from the Bastion system.
- Removed ambiguity on the restriction of special characters in external database passwords ([#8308](https://github.com/chef/automate/pull/8308)).
- Added a note in the Security Best Practices section so that users don't inadvertently update cache control headers in the configuration ([#8446](https://github.com/chef/automate/pull/8446)).
- Remove database locking issue while restarting front end nodes and adding new nodes ([#8419](https://github.com/chef/automate/pull/8419), [#8444](https://github.com/chef/automate/pull/8444), [#8469](https://github.com/chef/automate/pull/8469), [#8475](https://github.com/chef/automate/pull/8475), [#8462](https://github.com/chef/automate/pull/8462), [#8481](https://github.com/chef/automate/pull/8481), [#8432](https://github.com/chef/automate/pull/8432)).
- Use an external /hab volume instead of /tmp to solve cross device linking issues ([#8435](https://github.com/chef/automate/pull/8435), [#8436](https://github.com/chef/automate/pull/8436), [#8416](https://github.com/chef/automate/pull/8416)).
- Updated Chef Automate Incident Creation app and Chef Automate Integration App to support ServiceNow Utah and Vancouver versions.

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20240704055643, which includes the new and improved profiles for:

  - CIS AIX 7.2 v1.1.0
  - CIS Microsoft Windows Server 2012 R2 v3.0.0
  - CIS MariaDB 10.6 v1.0.0
  - CIS MacOS 13 Ventura v2.0.0
  - CIS Microsoft Windows 11 Enterprise v3.0.0
  - STIG Oracle Linux 8 v1.8.0
  - CIS RHEL 8 v3.0.0
  - CIS RHEL 7 v4.0.0

- This version improves the following profiles:

  - CIS RHEL 7 v3.1.1 - code optimisation
  - CIS CentOS Linux 7 v3.1.2 Benchmark Level 1 - Server controls were incorrect improved the password regex check

- This version also fixes the following issues:

  - CIS PostgresSQL v1.0.0 - removed default values from configuration.

### Bug fixes

- Fixed a bug to solve the scrolling issue in compliance reports ([#8392](https://github.com/chef/automate/pull/8392))
- Searching in Infrastructure report UI is now case insensitive ([#8395](https://github.com/chef/automate/pull/8395))
- Fixed a bug to improve the ease of filtering of nodes while doing wildcard search ([#8417](https://github.com/chef/automate/pull/8417))
- Fixed a bug to show filtered data in the event feed report after modifying the event feed date ([#8442](https://github.com/chef/automate/pull/8442))
- Fixed a bug to find the log file in Automate ([#8414](https://github.com/chef/automate/pull/8414))

### Security

#### Security updates

- Prototype pollution vulnerability has been solved to prevent exploitation during Javascript runtime: CVE-2022-46175, CVE-2022-24999 ([#8365](https://github.com/chef/automate/pull/8365), [#8337](https://github.com/chef/automate/pull/8337))
- Updated ansi-regex package version to fix CVE-2021-3807 ([#8365](https://github.com/chef/automate/pull/8365), [#8336](https://github.com/chef/automate/pull/8336))
- HA proxy package in Automate HA has been upgraded to solve CVE-2023-25725 ([#8380](https://github.com/chef/automate/pull/8380))
- Updated NATS server to solve CVE-2022-24450, CVE-2020-26892 ([#8423](https://github.com/chef/automate/pull/8423), [#8394](https://github.com/chef/automate/pull/8394))
- Solved a vulnerability in SAML connector to process SAML Signature validation: CVE-2020-27847
- Nullified shell escape sequence injection vulnerability in Rack components by solving CVE-2022-30123 ([#8385](https://github.com/chef/automate/pull/8385))
- Updated Nginx version to solve CVE-2022-41741 ([#8426](https://github.com/chef/automate/pull/8426))
- Updated OpenJDK to solve CVE-2023-22067, CVE-2024-20918, CVE-2024-20921, CVE-2024-20919, CVE-2024-20926, CVE-2024-20945, CVE-2024-20952, CVE-2023-22081 and CVE-2023-22025 ([#8384](https://github.com/chef/automate/pull/8384))
- Updated Postgres database to solve CVE-2023-2454 and CVE-2023-39417 ([#8434](https://github.com/chef/automate/pull/8434), [#8412](https://github.com/chef/automate/pull/8412))
- Removed dependency from [polyfill.io](http://polyfill.io/) JS package to solve CVE-2024-38526 ([#8470](https://github.com/chef/automate/pull/8470))

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.521/20220603154827
- Chef Habitat Builder version: 9497/20221221224518
- Chef Infra Server version: 15.4.0/20230105061154
- Chef InSpec version: 4.56.22/20220517052126

### Service versions

This release uses:

- Postgres: 13.14
- OpenSearch: 1.3.14
- Nginx: 1.25.4
- Haproxy: 2.2.29
- Dex: 2.27.0

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.19.3
- OpenJDK: 11.0.22+7
- Angular: 11.2.6

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.12.69

Released on March 6, 2024

### Bug fixes

- Fixed a bug when patching the backup path using `chef-automate config patch`. ([#8341](https://github.com/chef/automate/pull/8341))

### Security

#### Security improvements

- Fixed a security issue that allows Chef tags to accept HTML text, URL, all special characters, and weak cipher. ([#8355](https://github.com/chef/automate/pull/8355))

#### Security updates

- Updated OpenSearch to 1.3.14 to fix the following CVE issues:

  - CVE-2023-45807
  - CVE-2023-31141
  - CVE-2023-25806
  - CVE-2023-23933
  - CVE-2023-23613
  - CVE-2023-23612
  - CVE-2023-20860
  - CVE-2023-20861

- Updated NodeJS to 14.21.3 to fix the following CVEs:

  - CVE-2023-23918
  - CVE-2023-23919
  - CVE-2023-23920
  - CVE-2023-23936
  - CVE-2023-24807

- Updated marked to version 4.0.10 to fix the following CVEs:

  - CVE-2022-21681
  - CVE-2022-21680

- Updated expressJS version to 4.18.2 to fix the following CVEs:

  - CVE-2022-24999

- Update ansi-regex to 5.0.1 which fixes the following CVEs:

  - CVE-2021-3807

- Update rack to 2.2.6.4 which fixes the following CVEs:

  - CVE-2022-30123

- Update yaml.v2 to 2.4.0 which fixes the following CVEs:

  - CVE-2022-3064

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.521/20220603154827
- Chef Habitat Builder version: 9497/20221221224518
- Chef Infra Server version: 15.4.0/20230105061154
- Chef InSpec version: 4.56.22/20220517052126

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.3.14
- Nginx: 1.21.3
- Haproxy: 2.2.29
- Dex: 2.27.0

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.19.3
- OpenJDK: 11.0.20+8
- Angular: 11.2.6

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.12.40

Released on December 13, 2023

### New features

- You now can rotate the passwords on OpenSearch in Automate ([#8300](https://github.com/chef/automate/pull/8300)).
- Automate HA is supported on Red Hat Enterprise Linux 9 and Oracle Linux 9 operating systems ([#8310](https://github.com/chef/automate/pull/8310)).

### Improvements

- Certificate rotation can now be done in all the Automate HA nodes using a single command ([#8261](https://github.com/chef/automate/pull/8261)).
- Automate HA with this release won't need downtime to add a new node to the cluster ([#8275](https://github.com/chef/automate/pull/8275)).
- Automate HA pre-deployment verification check now has the check to verify if all the nodes have the same hab uid ([#8290](https://github.com/chef/automate/pull/8290)).
- Automate can show the Node Attributes in correct precedence in the Infra Server View tab ([#8319](https://github.com/chef/automate/pull/8319)).
- To better understand product usage integrated with Pendo using a wrapper library ([#8299](https://github.com/chef/automate/pull/8299)).

### Bug fixes

- Fixed bug that was causing pre-deployment verification checks to fail in Automate HA for Kernel version 3.10 ([#8288](https://github.com/chef/automate/pull/8288)).
- Fixed bug that was causing pre-deployment verification checks to fail in Automate HA for SSH access ([#8296](https://github.com/chef/automate/pull/8296)).
- Automate can handle scenarios where Automate backup gateway service slowness to read backups causes failure while restoration ([#8297](https://github.com/chef/automate/pull/8297)).

### Security

#### Security Improvements

- Added Angular built-in sanitization. ([#8289](https://github.com/chef/automate/pull/8289))

#### Security updates

(examples: dependency updates, CVE fixes)

- Updated DoorKeeper in ocid to resolve:

  - CVE-2020-10187

**Private Chef Supermarket users using this version of Automate must refresh their logins and re-authenticate Supermarket with Chef Identity**

- Updated Dex library to v2.35 to resolve:

  - CVE-2022-39222

- Updated Minio to fix:

  - CVE-2023-28433
  - CVE-2023-28432
  - CVE-2023-28434

- Updated `moment.js` to v2.29.4 to resolve:

  - CVE-2022-31129
  - CVE-2022-24785

- Updated `prismjs` to v1.29.0 to resolve:

  - CVE-2022-23647

- Updated `rule` to v2.7.2 to resolve:

  - CVE-2023-22467

- Updated `d3` to v7.8.5 to resolve:

  - CWE-400

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.521/20220603154827
- Chef Habitat Builder version: 9497/20221221224518
- Chef Infra Server version: 15.4.0/20230105061154
- Chef InSpec version: 4.56.22/20220517052126

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.3.7
- Nginx: 1.21.3
- Haproxy: 2.2.29
- Dex: 2.27.0

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.19.3
- OpenJDK: 11.0.20+8
- Angular: 11.2.6

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.11.0

Released on October 31, 2023

### Improvements

- The Chef Automate HA config generation process now supports adding an IP address when backing up with MinIO. ([#8241](https://github.com/chef/automate/pull/8241))
- The `chef-automate version` command now returns the CLI version installed on the bastion host. ([#8242](https://github.com/chef/automate/pull/8242))
- The `chef-automate status` and `chef-automate service-version` commands now have `--accept-hab-license` flag to accept Chef Habitat license. ([#8267](https://github.com/chef/automate/pull/8267))

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20231018131051, which includes the new and improved profiles for:

  - STIG Windows Server 2022 v1.2.0
  - CIS Windows Server 2022 v2.0.0(Audits)
  - CIS Windows Server 2016 v2.0.0(Audits)

### Bug fixes

- Fixed `chef-automate verify` to run on a five-node Automate HA cluster. ([#8251](https://github.com/chef/automate/pull/8251))
- Fixed `chef-automate config patch` command, which was returning an error when patching the Automate config file to centralize the log file. ([#8259](https://github.com/chef/automate/pull/8259))

### Security

#### Security updates

- The Inspec commands like archive, json, check and exec are run in sandboxed and secured environment which will fix:

| ID             | Category | Fixed Issue                                                                                 |
|----------------|----------|---------------------------------------------------------------------------------------------|
| CVE-2023-40050 | security | Run Inspec commands like archive, json, check and exec in Sandboxed and secured environment |

- Updated Terraform to version 1.5.7 which fixes [CVE-2023-4782](https://nvd.nist.gov/vuln/detail/CVE-2023-4782)

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.521/20220603154827
- Chef Habitat Builder version: 9497/20221221224518
- Chef Infra Server version: 15.4.0/20230105061154
- Chef InSpec version: 4.56.22/20220517052126

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.3.7
- Nginx: 1.21.3
- Haproxy: 2.2.29
- Dex: 2.27.0

### Supported external Chef products

This release supports the following Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.19.3
- OpenJDK: 11.0.20+8
- Angular: 11.2.6

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.10.29

Released on September 25, 2023

### New features

- On-premises deployments of Automate HA with Chef Managed database can be done on infrastructure provisioned on the Google Cloud Platform.
- You can configure GCS backup and configuration support from the bastion host in Automate HA. We extend the capability to verification and config generator workflow during pre and post deployment of Automate HA. Please refer the documentation for [HA backup storage for GCS](https://docs.chef.io/automate/ha_backup_restore_object_storage/#for-_gcs_) ([#8133](https://github.com/chef/automate/pull/8133), [#8211](https://github.com/chef/automate/pull/8211), [#8215](https://github.com/chef/automate/pull/8215))

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20230905035531, which includes the new and improved profiles for:

  - CIS Oracle Solaris 11.4 v1.0.0
  - CIS Windows Server 2019 Audits v2.0.0

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.521/20220603154827
- Chef Habitat Builder version: 9497/20221221224518
- Chef Infra Server version: 15.4.0/20230105061154
- Chef InSpec version: 4.56.22/20220517052126

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.3.7
- Nginx: 1.21.3
- Haproxy: 2.2.29
- Dex: 2.27.0

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.19.3
- OpenJDK: 11.0.20+8
- Angular: 11.2.6

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.10.1

Released on September 6, 2023

### Announcement

We're delighted to announce that our continuous effort to improve the installation and deployment experience of Automate HA has enabled the following features:

- Ability to generate deployment config in an interactive way
- Perform verification checks before deployment
- Control Automate HA cluster from a single central bastion system

### Improvements

- The ability to patch Chef Server FQDN and Root-CA in Automate HA from Bastion. ([#8099](https://github.com/chef/automate/pull/8099))
- The habitat package versions of the services running on front-end nodes can be monitored using the `chef-automate service-versions` command from the bastion host in Automate HA. ([#8113](https://github.com/chef/automate/pull/8113))
- The habitat services data reporting to Automate can be managed using the `chef-automate applications` command from the bastion host in Automate HA. ([#8114](https://github.com/chef/automate/pull/8114))
- The internal root certificates of the Automate nodes can be managed using the `chef-automate internal-ca` command from the bastion host in Automate HA. ([#8115](https://github.com/chef/automate/pull/8115))
- Improve `external-os-s3-bucket-access-check` verification check to add index delete permission to the s3 bucket. ([#8119](https://github.com/chef/automate/pull/8119))
- The config generator is improved to bring in bug fixes and more abilities. ([#8122](https://github.com/chef/automate/pull/8122))
- The update and deployment process in Automate HA validates the configuration with the option to skip validation in case of failure. ([#8123](https://github.com/chef/automate/pull/8123))
- The config `verify` command is now improved to enhance the checks. ([#8138](https://github.com/chef/automate/pull/8138), [#8139](https://github.com/chef/automate/pull/8139), [#8140](https://github.com/chef/automate/pull/8140), [#8144](https://github.com/chef/automate/pull/8144), [#8149](https://github.com/chef/automate/pull/8149))
- More configurations available in the standalone Chef Server are also available to be patched from the Bastion host in Automate HA. Please refer to the [Chef Infra Configuration In Chef Automate](https://docs.chef.io/automate/chef_infra_in_chef_automate/) document. ([#8152](https://github.com/chef/automate/pull/8152), [#8160](https://github.com/chef/automate/pull/8160))

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20230831114438, which includes the new and improved profiles for:

  - CIS Oracle Solaris 11.4 v1.0.0

### Bug fixes

- Fixing issue to show Compliance Trend graph for more than 24 hours. ([#8106](https://github.com/chef/automate/pull/8106))
- The patched token will now be used instead of regenerating a new token during update/add/delete nodes from the Automate HA cluster. ([#8118](https://github.com/chef/automate/pull/8118))
- Stop cleaning up of a2 workspace by running the `cleanup` command from Bastion in the Automate HA cluster. ([#8154](https://github.com/chef/automate/pull/8154))

### Security

#### Security Improvements

- Improve Automate API responses to be more actionable and more restrictive to safeguard against Server Side Security Request Forgery.

#### Security updates

(examples: dependency updates, CVE fixes)
Updated OpenJDK version to v11.0.20+8 which fixes the following CVEs:

- CVE-2023-22036
- CVE-2023-22006
- CVE-2023-22041
- CVE-2023-22045
- CVE-2023-22049
- CVE-2023-21968
- CVE-2023-21967
- CVE-2023-21939
- CVE-2023-21938
- CVE-2023-21954
- CVE-2023-21937
- CVE-2023-21930
- CVE-2023-25193

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.521/20220603154827
- Chef Habitat Builder version: 9497/20221221224518
- Chef Infra Server version: 15.4.0/20230105061154
- Chef InSpec version: 4.56.22/20220517052126

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.3.7
- Nginx: 1.21.3
- Haproxy: 2.2.29
- Dex: 2.27.0

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.19.3
- OpenJDK: 11.0.20+8
- Angular: 11.2.6

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.9.9

Released on August 3, 2023

### New features

- Automate HA eases setting up the cluster by introducing the `chef-automate verify` command, which checks the configurations across the nodes in the cluster before deployment. The same command can be used and verify the cluster configurations after deployment for easy troubleshooting. This will make the deployment and maintenance of Automate HA cluster much easy and transparent. Refer to the detailed documentation here: <https://docs.chef.io/automate/ha_verification_check/>
- The users in the Chef Server running in Automate can be authorized to log in to Private Supermarket. Refer
[Supermarket Integration](https://docs.chef.io/automate/supermarket_integration_with_automate/) to get more details. ([#7909](https://github.com/chef/automate/pull/7909))
- Automate HA eases the creation of the initial configuration file by introducing a user-driven configuration generator. [#7923](https://github.com/chef/automate/pull/7923)

### Improvements

- The rotated certificates are now preserved for the addition/deletion/upgrade of nodes after rotating the certificates for individual nodes in Automate HA cluster. ([#7945](https://github.com/chef/automate/pull/7945))
- The status of all the services on all the nodes of an Automate HA cluster can be monitored from Bastion using the `chef-automate status` command. ([#7950](https://github.com/chef/automate/pull/7950))
- An individual service running on frontend nodes of Automate HA cluster can be restarted from Bastion using the `chef-automate restart-services` command. ([#7958](https://github.com/chef/automate/pull/7958))
- The services in a given or all frontend nodes can be stopped from the Bastion host using the `chef-automate stop` command. ([#7966](https://github.com/chef/automate/pull/7966))
- The versions of all the running services for a given or all nodes in Automate HA cluster can be monitored from the Bastion host using the `chef-automate version` command. ([#7970](https://github.com/chef/automate/pull/7970))
- The data related to chef-client runs and chef-server actions in Automate can be managed from the Bastion host using the `chef-automate infrastructure` command ([#7944](https://github.com/chef/automate/pull/7944))
- The es-sidecar service now honors the setting at the global backup configuration. ([#7976](https://github.com/chef/automate/pull/7976))
- Ability to connect to external OpenSearch cluster using proxy SSL server. ([#7984](https://github.com/chef/automate/pull/7984))
- The lag of PG follower nodes concerning the leader node in a PG cluster is now shown in the `chef-automate status` command. ([#8054](https://github.com/chef/automate/pull/8054))
- The gather log command now captures logs from different locations in the PG cluster. ([#8058](https://github.com/chef/automate/pull/8058))
- The AWS deployment of Automate HA now allows you to choose the private subnet. ([#8062](https://github.com/chef/automate/pull/8062))
- Improved documentation for all the configuration for frontend and backend nodes of Automate HA. Refer this section: <https://docs.chef.io/automate/ha_config/> ([#8048](https://github.com/chef/automate/pull/8048))
- The benchmark performance numbers are available for reference in Automate document. Refer <https://docs.chef.io/automate/ha_performance_benchmarks/> ([#8051](https://github.com/chef/automate/pull/8051))

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20230414090134, which includes the new and improved profiles for:

  - CIS Oracle MySQL Community Server 5.7 v2.0.0 (Audit)
  - CIS IBM AIX 7.1 v2.1.0 (Audits)
  - CIS RHEL 8 v2.0.0 (Audits)
  - CIS Ubuntu 22.04 v1.0.0
  - CIS Suse Linux Enterprise 12v3.1.0
  - STIG Windows 11 v1r2

- This version also fixes bugs for the following profiles:

  - CIS CentOS Linux 7 Benchmark v3.1.2 : UMASK wrong check issue(Control 5.5.5)
  - CIS CentOS Linux 8 Benchmark v2.0.0 : handled false positive for sudo access controls
  - CIS RHEL 8 Benchmark v2.0.0 : handled false positive for sudo access controls
  - CIS RHEL 7 Benchmark v3.1.1 : handled false positive for sudo access controls
  - CIS Windows 2019 v1.3.0 Bug fix for controls in 19 series
  - CIS CentOS Linux 7 Benchmark v3.1.2 control 5.1.4

### Bug fixes

- Fix the issue that stops syncing the configuration from bootstrap nodes when a new node is added to an Automate HA cluster. ([#7949](https://github.com/chef/automate/pull/7949))
- Fix to display the correct status on running `chef-automate status summary` from Bastion host when Automate services are stopped in frontend nodes. ([#7968](https://github.com/chef/automate/pull/7968))
- Chef Automate can now be provisioned using AMI images that use IMDSv2. ([#7982](https://github.com/chef/automate/pull/7982))
- Update the dex bundle to fix frequent disconnection with the Postgres database. ([#8007](https://github.com/chef/automate/pull/8007))
- Automate HA Bastion host honors the IAM role attached and shouldn't ask for AWS credentials from users. ([#8057](https://github.com/chef/automate/pull/8057))
- Fix to remove nodes without impacting the other nodes in the AWS environment deployed Automate HA cluster. ([#8070](https://github.com/chef/automate/pull/8070))

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.521/20220603154827
- Chef Habitat Builder version: 9497/20221221224518
- Chef Infra Server version: 15.4.0/20230105061154
- Chef InSpec version: 4.56.22/20220517052126

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.3.7
- Nginx: 1.21.3
- Haproxy: 2.2.29
- Dex: 2.27.0

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.19.3
- OpenJDK: 11.0.17+8
- Angular: 11.2.6

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.7.52

Released on June 8, 2023

### Announcement

Automate has moved the product builds from Golang version 1.15 to 1.19 to keep the language features up to date.
The change in the Golang version will impact the custom certificates used for interaction with external systems. The common name field of X.509 certificates will no longer be considered the hostname when the Subject Alternative Name (SAN) is absent.

Please refer to the [Update Non-SAN certificates for 4.7.x update documentation](https://docs.chef.io/automate/upgrade_san_certificates/) for more information.

### Improvement

- Updated Automate HA documentation to setup AWS OpenSearch and RDS clusters. ([#7898](https://github.com/chef/automate/pull/7898))
- Added documentation to benchmark the impact of DataLifeCycle Settings on OpenSearch `max_shards_per_node` value. ([#7906](https://github.com/chef/automate/pull/7906))

### Bug fixes

- Fix the issue to allow upgrade of only frontend or backend nodes using `chef-automate upgrade` command in Automate HA. ([#7896](https://github.com/chef/automate/pull/7896), [#7926](https://github.com/chef/automate/pull/7926))
- The run-list tab for a node with policy files is now loading without any error in Infra Server view. ([#7900](https://github.com/chef/automate/pull/7900))
- The graceful removal of frontend node using `chef-automate node remove` command in Automate HA is now fixed. ([#7922](https://github.com/chef/automate/pull/7922))
- The PG and OpenSearch instance type is now no more mandatory for AWS deployment of Automate HA. ([#7939](https://github.com/chef/automate/pull/7939))
- The issue which stops from passing full path while running `chef-automate config patch` command from Bastion host in Automate HA is fixed. ([#7942](https://github.com/chef/automate/pull/7942))

### Maintenance

- Automate is now built using Golang version 1.19.3. This version of Golang has multiple improvements and security updates.
Please refer the [Golang 1.19 Release Notes](https://go.dev/doc/go1.19)

### Security

#### Security updates

(examples: dependency updates, CVE fixes)

The update of Golang framework to 1.19.3 resolves the following CVE issues:

- CVE-2021-41772
- CVE-2021-41771
- CVE-2021-38297
- CVE-2021-36221
- CVE-2021-34558
- CVE-2021-33198
- CVE-2021-33197
- CVE-2021-33196
- CVE-2021-33195
- CVE-2021-31525
- CVE-2021-29923
- CVE-2021-27919
- CVE-2021-27918
- CVE-2021-3114
- CVE-2020-28851
- CVE-2012-2666
- CVE-2022-23806
- CVE-2022-23772
- CVE-2022-23773
- CVE-2020-28367
- CVE-2020-28366
- CVE-2020-28362
- CVE-2017-15041
- CVE-2016-5386

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.521/20220603154827
- Chef Habitat Builder version: 10078/20220929100217
- Chef Infra Server version: 15.4.0/20230105061154
- Chef InSpec version: 4.56.22/20220517052126

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.3.7
- Nginx: 1.21.3
- Haproxy: 2.2.18
- Dex: 2.27.0

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.19.3
- OpenJDK: 11.0.17+8
- Angular: 11.2.6

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.5.177

Released on May 8, 2023

### New features

- You can now get the status of all the nodes in Automate HA cluster using the `chef-automate status summary` command from Automate HA Bastion host. ([#7776](https://github.com/chef/automate/pull/7776))
- You can now run `chef-automate start` from the Bastion host of Automate HA. ([#7808](https://github.com/chef/automate/pull/7808))
- Automate deployed Chef Infra Server now supports S3 as cookbook storage. ([#7796](https://github.com/chef/automate/pull/7796))
- Adding Nginx API endpoint to expose Nginx metrics for Automate. ([#7846](https://github.com/chef/automate/pull/7846))

### Improvements

- Ability to pass Sudo Password using environment variable while running CLI commands in Automate HA Bastion node. ([#7774](https://github.com/chef/automate/pull/7774), [#7799](https://github.com/chef/automate/pull/7799))
- The `chef-automate cert-rotate` command now rotates checks for new certificates before applying them in the HA nodes ([#7700](https://github.com/chef/automate/pull/7700), [#7843](https://github.com/chef/automate/pull/7843))
- The `chef-automate info` command is refactored and written in Golang ([#7798](https://github.com/chef/automate/pull/7798))
- You can now run `iam` commands from Automate HA bastion node. ([#7695](https://github.com/chef/automate/pull/7695))
- You can now run `license` commands from Automate HA bastion node. ([#7768](https://github.com/chef/automate/pull/7768))
- The deploy command with unique CN for every node will deploy OpenSearch nodes with an updated list of Domain Names. ([#7771](https://github.com/chef/automate/pull/7771), [#7815](https://github.com/chef/automate/pull/7815))
- Automate HA deployment command won't show warning or error related to unused or unset terraform variables. ([#7702](https://github.com/chef/automate/pull/7702))
- The `chef-automate backup restore` shows all the errors properly when invoked from the Automate HA Bastion host. ([#7734](https://github.com/chef/automate/pull/7734))
- The `chef-automate config patch` can now reconfigure the OpenSearch backup location. ([#7744](https://github.com/chef/automate/pull/7744))
- Modified the `default_max_size` config for maximum request size to 4MB for Automate shipped Chef Server. ([#7783](https://github.com/chef/automate/pull/7783))
- Added `ssh_group_name` in the Automate HA deployment configuration to pass the customized ssh user group. ([#7819](https://github.com/chef/automate/pull/7819))

### Bug fixes

- Fixed the bug to display Node Error log data for failed nodes in the client runs the report. ([#7705](https://github.com/chef/automate/pull/7705))
- Fixed the bug causing Automate to download zero-byte reports on the export of compliance and client-run reports for many nodes. ([#7707](https://github.com/chef/automate/pull/7707), [#7710](https://github.com/chef/automate/pull/7710))
- Fixed the bug which changes the assigned project of an Automate token on toggling the status ([#7720](https://github.com/chef/automate/pull/7720), [#7825](https://github.com/chef/automate/pull/7825))
- Fixed the bug to show the client-run report for scans older than a day for a node. ([#7724](https://github.com/chef/automate/pull/7724))
- Fixed the bug to apply the `fqdn` passed from the Automate HA Bastion host to the Automate HA frontend nodes during deployment and upgrade. ([#7729](https://github.com/chef/automate/pull/7729))
- Fixed the bug which abruptly stops `gather-logs` when invoked from Automate HA Bastion host. ([#7732](https://github.com/chef/automate/pull/7732))
- Fixed the bug to show proper error messages while testing data feed integration using S3. ([#7736](https://github.com/chef/automate/pull/7736))
- Fixed the bug to show the Chef Infra Server name in the breadcrumb navigation bar of Infra Server nodes. ([#7737](https://github.com/chef/automate/pull/7737))
- Fixed the bug to list the correct nodes when searched using error suggestions through Client Run reports. ([#7745](https://github.com/chef/automate/pull/7745))
- Fixed the bug to display the trend graph of Compliance ingestions for ten days. ([#7748](https://github.com/chef/automate/pull/7748))
- Fixed the bug to allow multiple edits of notification service settings. ([#7752](https://github.com/chef/automate/pull/7752))
- Fixed the bug to show waived controls in the Compliance reports of a node. ([#7753](https://github.com/chef/automate/pull/7753), [#7841](https://github.com/chef/automate/pull/7841))
- Fixed the bug to filter events correctly by the timeline in the event-feed dashboard. ([#7756](https://github.com/chef/automate/pull/7756))
- Fixed the bug to allow scrolling to the top using the floating scroll button in the Client Run tab. ([#7791](https://github.com/chef/automate/pull/7791))
- Fixed the bug to retain the FQDN of a node after updating in Automate HA. ([#7834](https://github.com/chef/automate/pull/7834))
- Fixed the bug causing errors while adding nodes in the Automate HA cluster deployed in AWS. ([#7838](https://github.com/chef/automate/pull/7838))
- Fixed the bug to stop updating the admin password on an update of frontend nodes of Automate HA cluster ([#7851](https://github.com/chef/automate/pull/7851))

### Compliance profile updates

Compliance profiles are updated to version 1.0.0/20230414090134, which includes the new and improved profiles for:

- CIS Oracle MySQL Community Server 5.7 v2.0.0
- CIS Azure Foundation v1.5.0
- CIS IBM AIX 7.1 v2.0.0
- CIS RHEL 8 v2.0.0
- CIS Oracle Linux 8 v2.0.0

### Maintenance

- Updated Elixir version to 1.14.0 for notification service. ([#7784](https://github.com/chef/automate/pull/7784))

### Security

#### Security updates

- Updated node package minimist to version 1.2.7 which fixes [CWE-1321](https://cwe.mitre.org/data/definitions/1321.html)
- Updated node package karma to version 1.2.7 which fixes [CVE-2022-2421](https://nvd.nist.gov/vuln/detail/CVE-2022-2421)
- Updated node package jsprim to version 2.0.2 which fixes [CVE-2021-3918](https://nvd.nist.gov/vuln/detail/CVE-2021-3918)
- Updated node packages to fix [CVE-2022-37601](https://nvd.nist.gov/vuln/detail/CVE-2022-37601)

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.521/20220603154827
- Chef Habitat Builder version: 10078/20220929100217
- Chef Infra Server version: 15.4.0/20230105061154
- Chef InSpec version: 4.56.22/20220517052126

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.3.7
- Nginx: 1.21.3
- Haproxy: 2.2.18
- Dex: 2.27.0

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.15
- OpenJDK: 11.0.17+8
- Angular: 11.2.6

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.5.37

Released on February 13, 2023

### New features

- You can now set the configuration for a deployment from Automate HA bastion node using the `chef-automate config set` command. ([#7670](https://github.com/chef/automate/pull/7670))
- You can now add nodes in an AWS-deployed Automate HA cluster using `chef-automate node add` command. ([#7683](https://github.com/chef/automate/pull/7683))

### Improvements

- You can now fetch and apply certificates from a root or local location with read-only access. ([#7678](https://github.com/chef/automate/pull/7678))
- You can now use an existing AWS S3 bucket when configuring AWS deployment of Chef Automate. ([#7681](https://github.com/chef/automate/pull/7681))

### Compliance profile updates

Compliance profiles are updated to version 1.0.0/20230209124416, which includes the new and improved profiles for:

- CIS RHEL 9 v1.0.0

### Bug fixes

- The `chef-automate cleanup` command now removes the content of the directory `/hab` even if it's a symbolic link in Automate HA. ([#7679](https://github.com/chef/automate/pull/7679))
- Fixed the `chef-automate backup restore` command so it will restore a Chef Automate backup even when a front-end node is unhealthy. ([#7688](https://github.com/chef/automate/pull/7688))
- Fixed a bug where OpenSearch was consuming a lot of memory when ingesting compliance report data. ([#7704](https://github.com/chef/automate/pull/7704))

### Security

#### Security Improvements

- Changes are made to fix CWE-409 vulnerability ([#7676](https://github.com/chef/automate/pull/7676))

#### Security updates

Updated OpenSearch to version 1.3.7, which fixes the following vulnerabilities:

- CVE-2022-42889

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.521/20220603154827
- Chef Habitat Builder version: 10078/20220929100217
- Chef Infra Server version: 15.4.0/20230105061154
- Chef InSpec version: 4.56.22/20220517052126

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.3.7
- Nginx: 1.21.3
- Haproxy: 2.2.18
- Dex: 2.27.0

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.15
- OpenJDK: 11.0.17+8
- Angular: 11.2.6

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.5.2

Released on January 12, 2023

### New features

- Ability to add new frontend and backend nodes for AWS deployment of Automate HA. ([#7616](https://github.com/chef/automate/pull/7616))

### Improvements

- Improved CLI message for config show command in AWS-managed DB in Automate HA. ([#7644](https://github.com/chef/automate/pull/7644))
- Improved CLI message while triggering file system backup from AWS Managed DB. ([#7650](https://github.com/chef/automate/pull/7650))
- Ability to avoid configuration of EBS volumes for backend nodes in Automate HA deployment with AWS Managed DB. ([#7652](https://github.com/chef/automate/pull/7652))
- Improved the console notification while deleting more than allowed nodes from Automate HA deployed environment. ([#7657](https://github.com/chef/automate/pull/7657))
- Chef Server updated to version 15.4.0. This version of Infra Server supports Infra Client 15.x and later versions. ([#7645](https://github.com/chef/automate/pull/7645))
- Root CA is now optional in config during deployment of Automate HA ([#7654](https://github.com/chef/automate/pull/7654))

### Bug fixes

- Fix for error encountered while fetching cookbooks for Chef Infra Server configured with policy files. ([#7624](https://github.com/chef/automate/pull/7624))
- Fix to avoid population of junk data in `managed_rds_certificate` during AWS deployment of Automate HA. ([#7647](https://github.com/chef/automate/pull/7647))

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.521/20220603154827
- Chef Habitat Builder version: 10078/20220929100217
- Chef Infra Server version: 15.4.0/20230105061154
- Chef InSpec version: 4.56.22/20220517052126

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.3.6
- Nginx: 1.21.3
- Haproxy: 2.2.18
- Dex: 2.27.0

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.15
- OpenJDK: 11.0.17+8
- Angular: 11.2.6

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.4.10

Released on January 4, 2023

### New features

- Ability to patch configurations from Bastion host of Automate HA ([#7470](https://github.com/chef/automate/pull/7470))
- Enhance Compliance Reporting APIs based on date range instead of a single date. Refer to the enhanced compliance report documentation. ([#7498](https://github.com/chef/automate/pull/7498))
- Added new Automate CLI command to uninstall Automate HA services from the nodes in On-Prem deployment of Automate HA ([#7481](https://github.com/chef/automate/pull/7481), [#7519](https://github.com/chef/automate/pull/7519))
- Support for AWS-managed database services for On-Prem deployment of Automate HA ([#7492](https://github.com/chef/automate/pull/7492))
- Ability to apply custom certificates to Automate services during deployment of Automate HA. Refer <https://docs.chef.io/automate/ha_cert_deployment> ([#7476](https://github.com/chef/automate/pull/7476), [#7500](https://github.com/chef/automate/pull/7500), [#7513](https://github.com/chef/automate/pull/7513))
- Ability to rotate certificates of Frontend and Backend nodes from the bastion node of Automate HA. Refer <https://docs.chef.io/automate/ha_cert_rotation> ([#7494](https://github.com/chef/automate/pull/7494), [#7522](https://github.com/chef/automate/pull/7522), [#7526](https://github.com/chef/automate/pull/7526), [#7536](https://github.com/chef/automate/pull/7536), [#7540](https://github.com/chef/automate/pull/7540), [#7541](https://github.com/chef/automate/pull/7541), [#7543](https://github.com/chef/automate/pull/7543), [#7544](https://github.com/chef/automate/pull/7544))
- Ability to capture journal logs at the custom path for Automate and each node of Automate HA. Refer <https://docs.chef.io/automate/centralizing_log> ([#7508](https://github.com/chef/automate/pull/7508), [#7542](https://github.com/chef/automate/pull/7542), [#7533](https://github.com/chef/automate/pull/7533))
- Ability to view configurations of all the nodes from Bastion host of Automate HA ([#7570](https://github.com/chef/automate/pull/7570))
- Added new Automate CLI command to add and delete frontend and backend nodes of Automate HA for On-Prem deployment ([#7563](https://github.com/chef/automate/pull/7563))

### Improvements

- Refactor the document for Backup and Restore of Automate HA ([#7433](https://github.com/chef/automate/pull/7433))
- Improved the documentation for On-Prem deployment of Automate HA ([#7493](https://github.com/chef/automate/pull/7493))
- Updated *knife-ec-backup* to version 3.0.1 ([#7505](https://github.com/chef/automate/pull/7505))
- Improved Automate HA troubleshooting document ([#7571](https://github.com/chef/automate/pull/7571))
- Updated Chef Automate Incident Creation app and Chef Automate Integration App to support ServiceNow San Diego and Tokyo versions
- Improved Backup deletion command to validate backup id before operation ([#7641](https://github.com/chef/automate/pull/7641))
- Increased the default value of max shards to 2500([#7564](https://github.com/chef/automate/pull/7564))
- More configurations for Chef Server are now patchable when deployed with Automate and Automate HA. Refer the document for the complete list <https://docs.chef.io/automate/chef_infra_in_chef_automate/> ([#7572](https://github.com/chef/automate/pull/7572))

### Compliance profile updates

Compliance profiles are updated to version 1.11.1/20221202074320, which includes the new and improved profiles for:

- Rocky Linux 8 v1.1.0
- Oracle Linux 8 v2.0.0
- Alma Linux 8 v2.2.0
- Microsoft Sharepoint v1.1.0
- STIG RHEL 7 v3r8
- CIS Windows Server 2019 v1.3.0
- STIG Windows Server 2019 v2r2
- CIS RHEL 8 v2.2.0 control5.3.16 fix
- CIS GKE v1.2.0
- CIS Windows 2016 v1.4.0
- CIS Azure Fundamental v1.0.0

### Bug fixes

- Fix for Automate HA (v4.3.0) Backend node upgrade failure ([#7566](https://github.com/chef/automate/pull/7566))
- Fix for errors while fetching *gather-logs* data from faulty/inactive node ([#7525](https://github.com/chef/automate/pull/7525))

### Maintenance

### Security

#### Security updates

Updated OpenSearch version to 1.3.6 which fixes the following vulnerabilities:

- CVE-2022-22971
- CVE-2022-35980

Updated OpenJDK version to 11.0.17+8 which fixes the following vulnerabilities:

- CVE-2022-21619
- CVE-2022-21626
- CVE-2022-21624
- CVE-2022-21628
- CVE-2022-39399
- CVE-2022-21618
- CVE-2022-34169
- CVE-2022-21541

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.521/20220603154827
- Chef Habitat Builder version: 10078/20220929100217
- Chef Infra Server version: 14.15.10/20220510065931
- Chef InSpec version: 4.56.22/20220517052126

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.3.6
- Nginx: 1.21.3
- Haproxy: 2.2.18
- Dex: 2.27.0

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

### Supported framework versions

This release is built on the following framework versions:

- GoLang: 1.15
- OpenJDK: 11.0.17+8
- Angular: 11.2.6

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.3.0

Released on October 6, 2022

### New features

- Disaster Recovery setup documentation for On-Prem deployment of Automate HA. ([#7425](https://github.com/chef/automate/pull/7425))
- Documented steps to add/remove/replace nodes in the existing Automate HA cluster. ([#7406](https://github.com/chef/automate/pull/7406))

### Improvements

- Updated contextual CLI messages for a seamless upgrade journey. ([#7377](https://github.com/chef/automate/pull/7377))
- Copying ElasticSearch configuration to equivalent OpenSearch configuration. ([#7377](https://github.com/chef/automate/pull/7377))
- Better disk space detection and improved shard allocation. ([#7377](https://github.com/chef/automate/pull/7377))
- Auto deletion of old indexes which are no longer required. ([#7377](https://github.com/chef/automate/pull/7377))
- Auto correction of old AWS S3 URL pattern for S3 backup. ([#7377](https://github.com/chef/automate/pull/7377))
- Added habitat package to ensure that **knife-ec-backup** can be performed on an air-gapped bundle and is available in the manifest file. ([#7424](https://github.com/chef/automate/pull/7424))
- Automation of backup configuration during On-Prem Deployment. ([#7410](https://github.com/chef/automate/pull/7410))

### Compliance profile updates

Compliance profiles are updated to version 1.11.1/20220809102847, which includes the new and improved profiles for:

- [CIS MS](http://1.ms/) Office 365 v1.4.0.
- CIS Microsoft Windows 2022 v1.0.0.
- CIS Oracle Linux 8 v2.0.0.
- CIS GKE v1.2.0.
- CIS Rocky Linux v1.0.0.
- STIG Ubuntu 20.04 v1R2.

**This update also includes fixes for:**

- CIS RHEL8 v2.0.0 control 6.2.7.
- CIS Windows Server 2012 v2.5.0 few controls title correction.
- CIS SQL Server 2019 v1.2.0 removes non ASCII characters from the title.

### Bug fixes

- Better handle mismatch of controls and empty keys in the compliance report. ([#7379](https://github.com/chef/automate/pull/7379))
- Reduced failure possibility of data-collector API by ensuring that token is added to member policy.
- Improved search capability on client run reports to support node name search with ".". ([#7437](https://github.com/chef/automate/pull/7437))
- Fixed a bug related to using AWS S3 bucket access and secret key while deploying HA on AWS infrastructure. ([#7453](https://github.com/chef/automate/pull/7453))
- Fixed a bug related to Restore of Automate HA for Non-S3 Backup object store. ([#7446](https://github.com/chef/automate/pull/7446))

### Security

#### Security Improvements

- Content security policy headers (CSP headers) are added to Automate APIs ([#7458](https://github.com/chef/automate/pull/7458))

#### Security updates

(examples: dependency updates, CVE fixes)

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.521/20220603154827
- Chef Habitat Builder version: 9978/20211221122808
- Chef Infra Server version: 14.15.10/20220510065931
- Chef InSpec version: 4.56.22/20220517052126

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.2.4
- Nginx: 1.21.3
- Haproxy: 2.2.18

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.2.59

Released on August 12, 2022

### Compliance profile updates

Compliance profiles are updated to version 1.0.0/20220722105137, which includes the new and improved profiles for:

- CIS Apache HTTP Server 2.4 v2.0.0
- CIS Windows Server 2022 v1.0.0
- STIG Ubuntu 20.04 v1.2.0
- CIS Windows Server 2016 v1.3.0
- CIS MSSQL Server 2016 v1.3.0
- CIS Oracle 12c v3.0.0
- CIS Oracle 18c v1.0.0
- CIS Oracle 19c v1.0.0

This update also includes fixes for:

- CIS RHEL 8 v2.0.0 fix for control 6.2.7

### Bug fixes

- The compliance reports node name search is now case insensitive. ([#7310](https://github.com/chef/automate/pull/7310))

### Maintenance

- Updated the Habitat version to 1.6.521 ([#4517](https://github.com/chef/automate/pull/4517))
- Added support for SUSE Linux Enterprise Server 12 SP5 to Chef Automate HA.

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.521/20220603154827
- Chef Habitat Builder version: 9978/20211221122808
- Chef Infra Server version: 14.15.10/20220510065931
- Chef InSpec version: 4.56.22/20220517052126

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.2.4
- Nginx: 1.21.3
- Haproxy: 2.2.18

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

See the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.2.47

Released on August 1, 2022

### Improvements

- Ability to install Automate HA on instances configured to use a different SSH port other than the default one ([#7261](https://github.com/chef/automate/pull/7261))
- The upgrade process of Chef Automate HA has been improved ([#7270](https://github.com/chef/automate/pull/7270)).

### Bug fixes

- To display the organization name in the breadcrumbs in Infra Server View ([#7213](https://github.com/chef/automate/pull/7213))
- To display the disclosure banner in the Automate UI ([#7243](https://github.com/chef/automate/pull/7243))
- To delete the corresponding Client when a Node is deleted in Infra Server View ([#7271](https://github.com/chef/automate/pull/7271))
- To display controls with special characters on the Compliance Report Controls page ([#7289](https://github.com/chef/automate/pull/7289))

### Maintenance

- The downloadable Automate Airgapped Bundles will be retained for 60 days instead of 30 days.

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 9978/20211221122808
- Chef Infra Server version: 14.15.10/20220510065931
- Chef InSpec version: 4.51.1/20211201163039

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.2.4
- Nginx: 1.21.3
- Haproxy: 2.2.18

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.2.22

Released on July 5, 2022

### Improvements

- Chef Automate can now check the proxy environment setting when you download the latest manifest ([#7170](https://github.com/chef/automate/pull/7170)).
- Support for OpenSearch connectivity over HTTP ([#7209](https://github.com/chef/automate/pull/7209)).

### Bug fixes

- The listing of requested reports for Project Editor and Viewer roles when Large Compliance Report ingestion is enabled is now fixed. ([#7206](https://github.com/chef/automate/pull/7206))
- The listing of profiles is fixed when the Passed, Failed or Skipped nodes tab is selected. ([#7215](https://github.com/chef/automate/pull/7215))

### Security

#### Security Improvements

- The Login id_token flow is modified not to use cookie but from the HTTP response ([#7145](https://github.com/chef/automate/pull/7145)).

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 9978/20211221122808
- Chef Infra Server version: 14.15.10/20220510065931
- Chef InSpec version: 4.56.22/20220517052126

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.2.4
- Nginx: 1.21.3
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.2.10

Released on June 23, 2022

### New features

- Chef Automate can now ingest and process Inspec Scan reports of size larger than 4MB ([#7074](https://github.com/chef/automate/pull/7074)).
  See the [Large Compliance Report Ingestion documentation](https://docs.chef.io/automate/large_compliance_report/) for more information.

### Improvements

- Automate HA documentation improvements

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20220609120848, which includes the fixes for:

  - CIS RHEL 8 v2.0.0

### Bug fixes

- Restricted SSH access to bastion nodes in Automate HA to the bastion server ([#7186](https://github.com/chef/automate/pull/7188)).

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 9978/20211221122808
- Chef Infra Server version: 14.15.10/20220510065931
- Chef InSpec version: 4.56.22/20220517052126

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.2.4
- Nginx: 1.21.3
- Haproxy: 2.2.2

See the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.1.3

Released on June 17, 2022

### Chef Automate High Availability

Chef Automate High Availability is now available with supported [Public Documentation](https://docs.chef.io/automate/ha/).

### New features

- Chef Automate now supports the [Managed Services](https://docs.chef.io/automate/managed_services/) of **AWS RDS** and **AWS OpenSearch**.

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20220609120848, which includes the following profile changes:

  - RHEL 8 v 2.0.0
  - Mongo DB 3.6 v1.1.0

and fixes for:

- Windows 2016 Server 1607 v 1.3.0
- Windows 10 Enterprise 1909 v1.8.1
- Stig Windows 10
- Stig Windows 12 r2 v3
- Windows 2012 r2 v2.5.0
- Windows 2019 v1.2.1

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 9978/20211221122808
- Chef Infra Server version: 14.15.10/20220510065931
- Chef InSpec version: 4.56.22/20220517052126

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.2.4
- Nginx: 1.21.3
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.0.91

Released on June 9, 2022

### Improvements

- Automate supports substring search consistently in Compliance and Infra tabs ([#7076](https://github.com/chef/automate/pull/7076)).

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20220603123504, which includes the following profile changes:

  - RHEL 8 v 2.0.0
  - Mongo DB 3.6 v1.1.0

and Fixes for:

- Windows 2016 Server 1607 v 1.3.0
- Window 10 Enterprise 1909 v1.8.1
- Stig Windows 10 Server
- Stig Windows 12 Server r2 v3
- Windows 2012 Server r2 v 2.5.0
- Windows 2019 Server v1.2.1

### Security

#### Security Improvements

- Stop showing external OpenSearch credentials in plain text ([#7024](https://github.com/chef/automate/pull/7024)).

#### Security updates

(examples: dependency updates, CVE fixes)
OpenJDK is updated to 11.0.15_10 which fixes the following vulnerabilities:

- CVE-2022-21426
- CVE-2022-21434
- CVE-2022-21443
- CVE-2022-21449
- CVE-2022-21476
- CVE-2022-21496

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 9978/20211221122808
- Chef Infra Server version: 14.15.10/20220510065931
- Chef InSpec version: 4.56.22/20220517052126

### Service versions

This release uses:

- Postgres:13.5
- OpenSearch: 1.2.4
- Nginx: 1.21.3
- Haproxy: 2.2.2

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.0.54

Released on May 25, 2022

### New features

- In Chef Automate a new security feature has been implemented to lock users on multiple failed attempts while logging in ([#6923](https://github.com/chef/automate/pull/6923)).
- The Chef Automate bundle for airgapped customers is now available. Click [here](https://packages.chef.io/airgap_bundle/current/automate/latest.aib) to download the bundle ([#6973](https://github.com/chef/automate/pull/6973)).

### Improvements

- Pagination has been implemented to show all the controls of the `ListControl` API ([#6910](https://github.com/chef/automate/pull/6910)).

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20220518045206, which includes the following profile changes:

  - Postgres 11 v1.0.0

### Security

#### Security updates

Updated url-parse to v1.5.10:

- CVE-2022-0686
- CVE-2022-0691
- CVE-2022-0639
- CVE-2022-0512
- CVE-2021-3664

Updated minimize to 1.2.6

- CVE-2021-44906

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 9978/20211221122808
- Chef Infra Server version: 14.15.10/20220510065931
- Chef InSpec version: 4.51.1/20211201163039

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.2.4
- Nginx: 1.21.3
- Haproxy: 2.2.2

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 4.0.27

Released on May 13, 2022

### Elasticsearch support

Elasticsearch support has been removed from this version (4.0.27) of Chef Automate.

### Bug fixes

- Bug fix related to migration of PostgreSQL data after major upgrade #[7013](https://github.com/chef/automate/pull/7013)

### Maintenance

- Support for Embedded OpenSearch and External OpenSearch Version 1.2.4 added.

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 9978/20211221122808
- Chef Infra Server version: 14.15.10/20220510065931
- Chef InSpec version: 4.51.1/20211201163039

### Service versions

This release uses:

- Postgres: 13.5
- OpenSearch: 1.2.4
- Nginx: 1.21.3
- Haproxy: 2.2.2

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 3.0.49

Released on April 25, 2022

### OpenSearch support

The upcoming release will be a major version upgrade with support for OpenSearch. Chef Automate won't automatically upgrade to the major upgrade. Click [here](https://www.chef.io/blog/chef-automate-is-moving-to-opensearch) to know more.

### Improvements

- The Check-In history in node details will have an improved look and feel on desktop dashboard ([#6702](https://github.com/chef/automate/pull/6702)).
- Included opt-in telemetry for Profiles search, Data Feed, Data Lifecycle, Identity Management, Access Management, and Node Management ([#6840](https://github.com/chef/automate/pull/6840), [#6863](https://github.com/chef/automate/pull/6863), [#6864](https://github.com/chef/automate/pull/6864), [#6903](https://github.com/chef/automate/pull/6903), [#6913](https://github.com/chef/automate/pull/6913), [#6917](https://github.com/chef/automate/pull/6917)).

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20220422141333, which includes the following profile changes:

  - STIG Windows 2012R2 v3 release 1
  - STIG Windows 2016 2.1.0
  - CIS Windows 2012R2 2.5.0
  - CIS Windows 2012 2.3.0
  - Mac OS 11 1.2.0
  - Microsoft IIS
  - Windows 2016 1.3.0
  - CIS Windows 2019 1.2.1
  - Ubuntu 20.04 1.1.0
  - CIS Oracle Database 19c (Linux) 1.0.0
  - CIS AWS Linux 2 2.0.0
  - CIS Oracle Database 12c 3.0.0
  - RHEL 7 3.1.1
  - RHEL 8 1.0.1
  - Centos 8 1.0.1
  - Centos 7 3.1.2
  - RHEL 6 3.0.0
  - Ubuntu 18.04 2.1.0
  - Debian Linux 9 1.0.1
  - Windows 10 H2 1.10.0
  - Centos 6 3.0.0
  - Oracle Linux 7 3.1.1
  - Oracle 18c 1.0.0
  - STIG RHEL8 1.2.0
  - CIS MSSQL Server 2016 v1.3.0
  - IS MSSQL Server 2019 v1.2.0

### Bug fixes

- The Infinite render loop in check-in history on the desktop dashboard has been fixed ([#6756](https://github.com/chef/automate/pull/6756)).
- The 0-byte file download of Compliance Reports in Chrome/Edge has been fixed ([#6824](https://github.com/chef/automate/pull/6824)).
- The visualization of the check-in time of nodes in the Nodes tab under Infra Server has been fixed([#6858](https://github.com/chef/automate/pull/6858)).

### Maintenance

- Updated Inspec version to 4.56.22 ([#6958](https://github.com/chef/automate/pull/6958))

### Security

#### Security Improvements

- Enable Strict Transport Security header for Automate services ([#6846](https://github.com/chef/automate/pull/6846))

### Chef packaged product versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 9978/20211221122808
- Chef Infra Server version: 14.13.42/20220228221324
- Chef InSpec version: 4.56.22/20220423215911

### Service versions

This release uses:

- Postgres: 13.5
- ElasticSearch: 6.8.23
- Nginx: 1.21.3
- Haproxy: 2.2.2

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 3.0.23

Released on April 19, 2022

### Maintenance

- Support for **Embedded PostgreSQL Version 13.5** added.

### Chef packaged product versions

This release uses:

- Chef Habitat version:1.6.181/20201030172917
- Chef Habitat Builder version: 9978/20211221122808
- Chef Infra Server version: 14.13.42/20220228221324
- Chef InSpec version: 4.51.1/20211201163039

### Service versions

This release uses:

- Postgres: 13.5
- ElasticSearch: 6.8.23
- Nginx: 1.21.3
- Haproxy: 2.2.2

### Supported external Chef products

This release supports the following external Chef products:

- Chef Infra Server version: 14.0.58+
- Chef Inspec version: 4.3.2+
- Chef Infra Client: 17.0.242+
- Chef Habitat: 0.81+

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest_semver.json) for the latest release.

## Chef Automate 20220329091442

Released on March 29, 2022

### Announcement

_This is the last release of the current series of releases. The upcoming release will be a **Major Version Upgrade**. Chef Automate won't upgrade automatically to the major upgrade. Click [here](https://www.chef.io/blog/change-to-chef-automate-version-and-release-numbering) to know more.*

### Bug fixes

- The License expiration issue of the banner being shown at the incorrect time has now been fixed ([#6830](https://github.com/chef/automate/pull/6830)).
- Fixed `chef-server-ctl test` command for Chef Server running embedded with Chef Automate ([#6726](https://github.com/chef/automate/pull/6726)).

### Improvements

- Improved **Telemetry Coverage** for notifications under **Settings** page ([#6812](https://github.com/chef/automate/pull/6812)).

### Chef Product Versions

This release uses:

- Chef Habitat version:1.6.181/20201030172917
- Chef Habitat Builder version: 9978/20211221122808
- Chef Infra Server version: 14.13.42/20220228221324
- Chef InSpec version: 4.51.1/20211201163039

### Service versions

This release uses:

- Postgres: 9.6.24
- ElasticSearch: 6.8.23
- Nginx: 1.21.3
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20220322122400

Released on March 23, 2022

### Improvements

- The **Internal Database Services** can be skipped when it's externally configured to optimize host resources ([#6606](https://github.com/chef/automate/pull/6606)).
- Improved telemetry coverage for **Chef Infra Server** Policy Files and Policy Groups under Infrastructure ([#6797](https://github.com/chef/automate/pull/6797), [#6805](https://github.com/chef/automate/pull/6805)).

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 9978/20211221122808
- Chef Infra Server version: 14.11.36/20211227114241
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.24
- ElasticSearch: 6.8.23
- Nginx: 1.21.3
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20220310123121

Released on March 14, 2022

### Improvements

- Improved telemetry coverage for **Chef Infra Server Environments**, **Clients**, **Nodes** and **Data Bags** under **Infrastructure** ([#6740](https://github.com/chef/automate/pull/6740), [#6749](https://github.com/chef/automate/pull/6749), [#6760](https://github.com/chef/automate/pull/6760), [#6775](https://github.com/chef/automate/pull/6775)).

### Bug fixes

- The backup timeout issue for the large data backups has been fixed ([#6733](https://github.com/chef/automate/pull/6733)).

### Maintenance

- Upgraded **Postgres** to **9.6.24** ([#6759](https://github.com/chef/automate/pull/6759)).

### Security

#### Security updates

Upgraded PostgreSQL to 9.6.24:

- CVE-2021-23222
- CVE-2021-23214

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 9978/20211221122808
- Chef Infra Server version: 14.11.36/20211227114241
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.24
- ElasticSearch: 6.8.23
- Nginx: 1.21.3
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20220223121207

Released on February 28, 2022

### Improvements

- Improved telemetry coverage for Chef Infra Server Roles under Infrastructure ([#6708](https://github.com/chef/automate/pull/6708))

### Security

#### Security Improvements

- Improved security by removing login tokens from URL strings and instead using an HTTP POST request. ([#6716](https://github.com/chef/automate/pull/6716))

### Chef Product Versions

This release uses:

- Chef Habitat version:1.6.181/20201030172917
- Chef Habitat Builder version: 9978/20211221122808
- Chef Infra Server version: 14.11.36/20211227114241
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.23
- Nginx: 1.21.3
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20220209045542

Released on February 9, 2022

### Bug fixes

- Chef Automate can now run compliance cloud scans on any AWS API resource outside of a private cloud using proxy settings. ([#6641](https://github.com/chef/automate/pull/6641))
- `chef-server-ctl` commands like `cleanup-bifrost`, `grant-server-admin-permissions`, etc., will work with external Postgres as well. ([#6643](https://github.com/chef/automate/pull/6643))
- Fixed a notification service integration failure. ([#6638](https://github.com/chef/automate/pull/6638))

### Security

#### Security Improvements

#### Security updates

- [CVE-2021-23017](https://nvd.nist.gov/vuln/detail/CVE-2021-23017) - Upgraded Nginx to 1.21.3 for Chef Habitat builder-api-proxy.

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 9978/20211221122808
- Chef Infra Server version: 14.4.4/20210520120637
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.23
- Nginx: 1.21.3
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20220121191356

Released on January 27, 2022

### Security

#### Security updates

Upgraded Elasticsearch to 6.8.23:

- [CVE-2021-44832](https://nvd.nist.gov/vuln/detail/CVE-2021-44832)

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.4.4/20210520120637
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres:9.6.11
- ElasticSearch: 6.8.23
- Nginx: 1.21.3
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20220113154113

Released on January 17, 2022

### Improvements

- Added two new CLI options:

  - `complianceResourceRunCount` will return a **CSV** file with the number of unique compliance resources reporting to Chef Automate within a range of dates. ([#6448](https://github.com/chef/automate/pull/6448))
  - `complianceResourceRunReport` will return a **CSV** file that contains data about compliance resources reported to Chef Automate within a range of dates. ([#6448](https://github.com/chef/automate/pull/6448))

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.11.36/20211227114241
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.22
- Nginx: 1.21.3
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20220103112354

Released on January 5, 2022

### Improvements

- Chef Automate now supports externally deployed PostgreSQL 13 ([#6491](https://github.com/chef/automate/pull/6491)).

See [our documentation](https://docs.chef.io/automate/postgres_external_upgrade) for steps on upgrading an external PostgreSQL database from 9.6 to 13.

### Maintenance

- Upgraded the embedded version of Chef Infra Server to 14.11.36 ([#6183](https://github.com/chef/automate/pull/6183))

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.11.36/20211227114241
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.22
- Nginx: 1.21.3
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20211220104140

Released on December 20, 2021

### Improvements

Added two new CLI options:

- **uniqNodeRunReport** returns the number of unique nodes reporting to Chef Automate within a range of dates. ([#6355](https://github.com/chef/automate/pull/6335))
- **nodeRunReport** returns a CSV file that contains data about nodes that have reported to Chef Automate within a range of dates. ([#6355](https://github.com/chef/automate/pull/6335))

### Bug fixes

- Fixed an issue where compliance profiles would not upload in ZIP format. ([#6146](https://github.com/chef/automate/pull/6146))

### Security

#### Security updates

Upgraded Elasticsearch to 6.8.22:

- [CVE-2021-45046](https://nvd.nist.gov/vuln/detail/CVE-2021-45046)
- [CVE-2021-44228](https://nvd.nist.gov/vuln/detail/CVE-2021-44228)
- [CVE-2021-22137](https://nvd.nist.gov/vuln/detail/CVE-2021-22137)
- [CVE-2021-22144](https://nvd.nist.gov/vuln/detail/CVE-2021-22144)

Upgraded AdoptOpenJDK version to 11.0.13+8 :

- [CVE-2021-35550](https://nvd.nist.gov/vuln/detail/CVE-2021-35550)
- [CVE-2021-35556](https://nvd.nist.gov/vuln/detail/CVE-2021-35556)
- [CVE-2021-35559](https://nvd.nist.gov/vuln/detail/CVE-2021-35559)
- [CVE-2021-35561](https://nvd.nist.gov/vuln/detail/CVE-2021-35561)
- [CVE-2021-35564](https://nvd.nist.gov/vuln/detail/CVE-2021-35564)
- [CVE-2021-35565](https://nvd.nist.gov/vuln/detail/CVE-2021-35565)
- [CVE-2021-35567](https://nvd.nist.gov/vuln/detail/CVE-2021-35567)
- [CVE-2021-35578](https://nvd.nist.gov/vuln/detail/CVE-2021-35578)
- [CVE-2021-35586](https://nvd.nist.gov/vuln/detail/CVE-2021-35586)
- [CVE-2021-35603](https://nvd.nist.gov/vuln/detail/CVE-2021-35603)

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.4.4/20210520120637
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.22
- Nginx: 1.21.3
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20211201164433

Released on December 1, 2021

### Bug fixes

- The last release caused high CPU usage and ingestion failures, described in ([#6295](https://github.com/chef/automate/pull/6295)). This release reverts the code changes made in `compliance` and `ingest-service`.

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.4.4/20210520120637
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.21.3
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20211125063136

Released on November 29, 2021

### Improvements

- New global events have been added to understand Node Summary Count ([#5810](https://github.com/chef/automate/pull/5810)).
- You can enable Content-Security-Policy Header ([#5757](https://github.com/chef/automate/pull/5757)).
- You can search **Node Managers** by name and filter Node Managers by Cloud Provider in `Settings -> Node-Integration` ([#6039](https://github.com/chef/automate/pull/6039)).
- You can now modify the number of items in a page for `Infrastructure -> Infra-Server` page ([#6074](https://github.com/chef/automate/pull/6074), [#6196](https://github.com/chef/automate/pull/6196)).

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20211110062104, which includes the following profile changes:

  - Window 2016 v1.2.0

### Bug fixes

- Blank page while adding new credentials has been fixes. Navigate to the page by: `Compliance -> scan job -> Nodes Added` ([#6073](https://github.com/chef/automate/pull/6073)).
- Improper display of Webhook Type has been fixed. Navigate to the page by: `Settings -> Notifications` ([#6104](https://github.com/chef/automate/issues/6104)).
- The issue with the **Save** button for `Reset Credentials` under `Settings -> Node Credential` has been fixed  ([#6147](https://github.com/chef/automate/pull/6147)).

### Maintenance

- Upgraded Ruby to v3.0 ([#5852](https://github.com/chef/automate/pull/5852))
- Upgraded OpenJDK to 11.0.12+7 ([#5405](https://github.com/chef/automate/pull/5405))

### Security

#### Security Improvements

- Added more request id validation in the authentication module ([#6085](https://github.com/chef/automate/pull/6085))

#### Security updates

(examples: dependency updates, CVE fixes)

- [CVE-2021-23017](https://nvd.nist.gov/vuln/detail/CVE-2021-23017) - Upgraded Nginx to 1.21.3
- [CVE-2021-2161](https://nvd.nist.gov/vuln/detail/CVE-2021-2161), [CVE-2021-2163](https://nvd.nist.gov/vuln/detail/CVE-2021-2163) - Upgraded OpenJDK to 11.0.12+7
- [CVE-2019-20149](https://nvd.nist.gov/vuln/detail/CVE-2019-20149) - Upgraded kind-of to 6.0.3
- [CVE-2020-7789](https://nvd.nist.gov/vuln/detail/CVE-2020-7789) - Upgraded node-notifier to 8.0.2

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.4.4/20210520120637
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.21.3
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20211102170523

Released on November 10, 2021

### Improvements

- You can now easily use **accordion** to select credentials and add nodes under `Compliance -> Scan Jobs` ([#5788](https://github.com/chef/automate/pull/5788))
- **Azure Compliance Scan** now allows you to filter subscriptions based on tags ([#5870](https://github.com/chef/automate/pull/5870))

### Bug fixes

- Automate allows you to add organisations of same name but in different Chef Server under `Infrastructure->Infra Server` ([#6017](https://github.com/chef/automate/pull/6017))

### Security

#### Security updates

(examples: dependency updates, CVE fixes)

- [CVE-2021-37713](https://nvd.nist.gov/vuln/detail/CVE-2021-37713) - Updated `tar` to `4.4.19`
- [CVE-2020-7789](https://nvd.nist.gov/vuln/detail/CVE-2020-7789) - Updated `node-notifier` to `10.0.0`

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.4.4/20210520120637
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20211020062000

Released on October 26, 2021

### New features

- Data Feed is now made GA. Data Feed supports 2 types of Integrations:

  - Webhook Integration - Supports 4 kinds of RESTful API based webhook integrations.
    - ServiceNow
    - Splunk
    - ELK
    - Custom Webhook
  - Storage Integration - Supports 2 kinds of storage types.
    - AWS S3
    - Minio

  For detailed documentation please refer to [docs.chef.io](https://docs.chef.io)

### Security

#### Security Improvements

- Automate stops displaying the hidden directories and contents ([https://github.com/chef/automate/pull/5872](#5872))

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.4.4/20210520120637
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20211007102429

Released on October 12, 2021

### Improvements

- We've made UI Improvements for **Chef Infra Server** ([#5819](https://github.com/chef/automate/pull/5819), [#5837](https://github.com/chef/automate/pull/5837))
- **Azure API scan** can now run on multiple subscription ids. ([#5792](https://github.com/chef/automate/pull/5792))

### Compliance profile updates

Compliance profiles are updated to version 1.0.0/20211007053103, which includes the following profile changes:

- RHEL 8 V1.0.0 fixed for removing extra escape characters
- Apple Mac OS 11 Profile V1.2.0

### Bug fixes

- Chef Automate can now accommodate more than 100 nodes for Compliance Scan. ([#5761](https://github.com/chef/automate/pull/5761))

### Security

#### Security Improvements

- Changes are made to mask user credentials in **Data Feed Debug Logs**. ([#5845](https://github.com/chef/automate/pull/5845))

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.4.4/20210520120637
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210923171324

Released on September 27, 2021

### Improvements

- Manage **Telemetry** options from your **Profile** ([#5729](https://github.com/chef/automate/pull/5629))
- Add a Chef Infra Server using either a FQDN or an IP address ([#5724](https://github.com/chef/automate/pull/5724))
- Encrypted data bags can't be edited in Automate.([#5754](https://github.com/chef/automate/pull/5754))

### Bug fixes

- The **Edit Attributes** form for **Chef Infra Servers > Organizations > Your Org** closes correctly. ([#5255](https://github.com/chef/automate/issues/5255))

#### Security Improvements

- Added host header validation to secure the HTTP endpoint from attacks using DNS rebinding to bypass any IP or firewall-based access restrictions. ([#5647](https://github.com/chef/automate/pull/5647))

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.4.4/20210520120637
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210907035717

Released on September 13, 2021

### New features

- You can now check the details of **Runlist Dependencies** in the Policyfiles details page. Navigate to the Policyfile tab: **Infrastructure > Chef Infra Server > Server Name > Organization > Policyfiles > PolicyFile > Runlist** ([#5619](https://github.com/chef/automate/pull/5619))
- You can now view the **Details of the Nodes** a Policy Group is associated with. Navigate to the Policy Group: **Infrastructure > Chef Infra Server > Server Name > Organization > policygroups > PolicyGroup > Node** ([#5630](https://github.com/chef/automate/pull/5630))

### Improvements

- Chef Automate will now validate the availability of Chef Infra Server while adding. ([#5643](https://github.com/chef/automate/pull/5643))
- We've made the navigation to the ServiceNow integration docs more intuitive. Find them on [docs.chef.io](https://docs.chef.io/) by navigating to **Chef Automate > Integrations > ServiceNow**

### Compliance profile updates

Compliance profiles are updated to version 1.0.0/20210902061132, which includes the following profile changes:

- CentOS 6 IPV6 fixes
- Centos 6 control 6.2.6 Ensure root path fix
- CentOS 7 IPV6 fixes
- Centos 7 control 6.2.6 Ensure root path fix
- Centos 8 Boot loader EFI fix
- CentOS 8 - test to ensure base chains exist updated
- RHEL 7 v2.2.0 IPV6 fixes
- RHEL 6 IPV6 fixes
- RHEL 7 v2.1.1 IPV6 fixes
- Ubuntu 16.04 IPV6 fixes
- CIS Ubuntu 20.04 v1.0.0
- Stig windows server 2019 v1.1.0 few controls with incorrect logic updated

### Bug fixes

- Chef Automate now gets updated in Roles without description getting validated in Chef Infra Server. ([#5648](https://github.com/chef/automate/pull/5648))

### Security

#### Security updates

(examples: dependency updates, CVE fixes)

- [CVE-2020-15216](https://nvd.nist.gov/vuln/detail/CVE-2020-15216), [CVE-2020-7711](https://nvd.nist.gov/vuln/detail/CVE-2020-7711) - updated **goxmldsig** to 1.1.0

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.4.4/20210520120637
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210824134201

Released on August 27, 2021

### New features

- LDAP and SAML Chef Automate users can now set **Time Format** across the Chef Automate. Navigate to the **TIme Format**: **Profile > Time Format**. ([#5432](https://github.com/chef/automate/pull/5432))
- You can now check the details of **Cookbook Dependencies** in the Policyfiles details page. Navigate to the Policyfile tab: **Infrastructure > Chef Infra Server > Server Name > Organization > Policyfiles > PolicyFile > Cookbook Dependencies** ([#5484](https://github.com/chef/automate/pull/5484))
- You can check the details of Policy Group and the list of Policyfiles which are part of the Policy Group. Navigate to the Policy Group: **Infrastructure > Chef Infra Server > Server Name > Organization > policygroups > PolicyGroup** ([#5498](https://github.com/chef/automate/pull/5498))

### Improvements

- You can now set the **Log out time** duration if your system is idle upto a specific time. ([#5362](https://github.com/chef/automate/pull/5362))

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20210823105624, which includes the following profile changes:

  - Ubuntu 18.04 fix for SSHD Configuration MACs
  - Centos 7 fix for SSHD Configuration MACs
  - Rhel-7 v2.2.0 fix for SSHD Configuration MACs
  - Centos 6 fix for SSHD Configuration MACs
  - Rhel 6 fix for SSHD Configuration MACs
  - Rhel-7 v2.1.1 fix for SSHD Configuration MACs
  - Ubuntu 16.04 fix for SSHD Configuration MACs

### Bug fixes

- Automate Report Details API now returns the available Profile tags. ([#5483](https://github.com/chef/automate/pull/5483))
- Changes the default **Time Format** for Chef Automate to include the **Timestamp**. ([#5574](https://github.com/chef/automate/pull/5574))

### Security

#### Security Improvements

- Logout from Automate UI disables the session token usage ([#5433](https://github.com/chef/automate/pull/5433))

#### Security updates

(examples: dependency updates, CVE fixes)

- Upgraded package **handlebars** to 4.7.7
- Upgrade package **tar** to 4.4.15

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.4.4/20210520120637
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210813114337

Released on August 18, 2021

### New features

- You can now check the `Included Policies`, `Cookbook Dependencies` and `Revisions` in the Policyfiles details page. Navigate to the Policyfile tab: **Infrastructure > Chef Infra Server > Server Name > Organization > Policyfiles > PolicyFile** ([#5398](https://github.com/chef/automate/pull/5398))
- You can view and search the list of `Policy Group` on the Policy Groups page. Navigate to the Policy Groups tab: **Infrastructure > Chef Infra Server > Server Name > Organization > Policy Groups** ([#5409](https://github.com/chef/automate/pull/5409))
- Local Chef Automate users can set the **Time Format** across the Automate UI by setting it from: **Profile > Time Format**. ([#5378](https://github.com/chef/automate/pull/5378))

### Improvements

- Data feed service can now process 50k+ nodes in a given feed.

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20210806131012, which includes the following profile changes: ([#5406](https://github.com/chef/automate/pull/5406))

  - Bootloader permission check for CIS CentOS Linux 8 ver-1.0.0
  - CIS windows 10 enterprise 1909 v1.8.1
  - Update azure-inspec version for azure foundation profile
  - Ensure no unconfined services exist fails to check for unconfined_service_t

### Bug fixes

- The filtering out nodes using tags for Azure VMs in scan `Job -> Create Job` page is fixed. ([#5355](https://github.com/chef/automate/pull/5355))
- The frequent logouts for `/refresh` api failures has been fixed. ([#5395](https://github.com/chef/automate/pull/5395))
- The serial number for `windows` platform will be fetched correctly. ([#5445](https://github.com/chef/automate/pull/5445))

### Security

#### Security Improvements

- [CVE-2021-23362](https://github.com/advisories/GHSA-43f8-2h32-f4cj) - updated **hosted-git-info** to 2.8.9
- Upgrade **prismjs** to version 1.24.0
- [CWE-1333](https://cwe.mitre.org/data/definitions/1333.html) - updated **addressable** to 2.8.0
- Upgrade the **tar** version to 3.2.3

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.4.4/20210520120637
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210727104144

Released on August 2, 2021

### New features

- You can now check the `Policyfiles` from Chef Infra Server. Navigate to the Policyfiles tab: **Infrastructure > Chef Infra Server > Server Name > Organization > Policyfiles > PolicyFile**. ([#5327](https://github.com/chef/automate/pull/5327), [#5374](https://github.com/chef/automate/pull/5374), [#5377](https://github.com/chef/automate/pull/5377))

### Improvements

- **Login Landing Page** will now be displayed for all types of login. ([#5375](https://github.com/chef/automate/pull/5375))

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20210720091254, which includes the following profile changes: ([#5367](https://github.com/chef/automate/pull/5367)):

  - STIG Windows 10 v2.1.0
  - Fix for - ASLR check in CIS

### Bug fixes

- Fixed the pagination in **Compliance Report**. ([#5360](https://github.com/chef/automate/pull/5360))

### Security

#### Security Improvements

- We've made the following security improvements (Examples: New Security Configurations): ([#5363](https://github.com/chef/automate/pull/5363))

- Added SameSite=Lax to the Session Cookie

#### Security updates

The node modules are updated to fix the following CVE issues:

- [CVE-2021-23358](https://github.com/advisories/GHSA-cf4h-3jhx-xvhq) - Updated lodash to 1.13.1

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.4.4/20210520120637
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210720135142

Released on July 20, 2021

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20210714100005, which includes the following profile ([#5356](https://github.com/chef/automate/pull/5356)):

  - STIG Windows 10 v2.1.0
  - Fix for - ASLR check in CIS CentOS 8

### Bug fixes

- The black screen when logging in using SAML has been removed. ([#5368](https://github.com/chef/automate/pull/5368))

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.4.4/20210520120637
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres:9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210713164523

Released on July 19, 2021

### New features

- You can now search and delete the **Policyfiles** from Chef Infra Server. Navigate to the Policyfiles tab: **Infrastructure > Chef Infra Server > Server Name > Organization > Policyfiles**. ([#5321](https://github.com/chef/automate/pull/5321), [#5307](https://github.com/chef/automate/pull/5307))

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20210707133250, which includes the following profile ([#5297](https://github.com/chef/automate/pull/5297)):

  - Server motd regular expression bug fix - centOS 8.
  - Fix for - RHEL 7 v 2.2.0 - 5.3.1 control.
  - Fix for - Tomcat 8 V 1.1.0 - Bug Fix (Fixed Nokogiri dependency ).
  - Fix for - Server doesn't find files in /etc/sudoers.d - CentOS 8.
  - Fix for - Expand user shell timeout check to scan files in /etc/profiles.d - CentOS 8.
  - STIG Windows 2012/2012 R2 Domain Controller v3.1.0.

#### Bug fixes

- Fixed the User Preference Settings in Chef Automate ([#5284](https://github.com/chef/automate/pull/5284))

#### Security Improvements

We made the following security improvements (Examples: New Security Configurations): ([#5286](https://github.com/chef/automate/pull/5286))

- Enabled Strict-Transport-Security header in API
- Enabled Cross-site scripting (XSS) filters in browsers
- Disabled Content Sniffing
- Enabled X-Content-Type-Options header
- Enabled X-XSS-Protection header
- Enabled HTTP Strict-Transport-Security header

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.4.4/20210520120637
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210629161835

Released on July 5, 2021

### New features

- The Chef Automate allows you to add **Disclosure Text** to the login page. ([#5106](https://github.com/chef/automate/pull/5106))
- You can add a **Banner** or a warning message across the Chef Automate Interface. ([#5106](https://github.com/chef/automate/pull/5106))
- You can now check all the Policy Files from Chef Infra Server. Navigate to the Policy files tab: **Infrastructure > Chef Infra Server > Server Name > Organization > Policyfiles**. ([#5277](https://github.com/chef/automate/pull/5277))

### Improvements

- In the Chef Infra Server, the **Create** and **Save** buttons get enabled only when you are done and ready to save. ([#5276](https://github.com/chef/automate/pull/5276))
- A `subscription id` is added in **Node Integration** for Azure API in **Settings > Node Integration > Azure > API** ([#5291](https://github.com/chef/automate/pull/5291))
- We've made various changes like button alignment and unnecessary spaces to improve your user experience while working on Chef Automate Interface.

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20210625122945, which includes the following profile ([#5292](https://github.com/chef/automate/pull/5292))

  - Bug Fix - CentOS 8 v1.0.0

### Bug fixes

- Removed the ability to change the data bag `id` on the **Edit Data Bag** model. ([#5249](https://github.com/chef/automate/pull/5249))
- Fixed extra node creation in Chef Automate Interface while running `Node Scans`. ([#5290](https://github.com/chef/automate/pull/5290))

### Security

#### Security updates

The node modules are updated to fix the following CVE issues:

- [CVE-2020-28499](https://github.com/advisories/GHSA-7wpw-2hjm-89gp) - Updated `merge` to **2.1.1**
- [CVE-2021-23337](https://github.com/advisories/GHSA-35jh-r3h4-6jhm) - Updated `lodash` to **4.17.21**

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.4.4/20210520120637
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210616033549

Released on June 21, 2021

### New features

- You can now check and update the node **attributes** from Chef Infra Server. Navigate to the Attributes tab: **Infrastructure > Chef Infra Server > Server Name > Organization > Nodes**. ([#5194](https://github.com/chef/automate/pull/5194))

### Improvements

- The **Edit** functionality of Roles in **Environment** has been disabled. ([#5201](https://github.com/chef/automate/pull/5201))
- A spinner has been added to every delete operation performed in Chef Infra Server. ([#5234](https://github.com/chef/automate/pull/5234))

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20210605110738, which includes the following profiles ([#5195](https://github.com/chef/automate/pull/5195)):

  - CIS sles15 v1.0.0 - Optimisation and code clean
  - CIS Mssql server 2017 V1.2.0

### Bug fixes

- The page redirection has been fixed while adding node credentials from the **Scan Job** tab on the Compliance page. ([#5009](https://github.com/chef/automate/pull/5009))
- The Chef Environment Attributes capitalization has been fixed. ([#5205](https://github.com/chef/automate/pull/5205))

### Maintenance

- Chef Infra Server is updated from 14.1.0 to 14.4.4 which has the following changes ([#5213](https://github.com/chef/automate/pull/5213)):

  - Error pages no longer display the running version of OpenResty.
  - The opscode user which runs Chef Infra Server is no longer configured with an interactive shell.
  - Reindexing will now gracefully fail if there isn't 2.2x the current ElasticSearch data available on disk before attempting the reindex
  - The HTTP Strict-Transport-Security (HSTS) max-age value for the default Chef Infra Server website can now be configured. Set the new node['private_chef']['nginx']['hsts_max_age'] to define the time in seconds the browser should remember that a site is only to be accessed using HTTPS. This configuration defaults to 31536000 (1 year) and accepts a maximum value of 63072000 (2 years).
  - The Bifrost service was previously exposed externally on port 9683. This service is no longer required externally and is now only exposed to the local system to improve security.
  - Chef Infra Server now defaults to supporting only TLS 1.2 for API communication. This new default may require upgrading older releases of Chef Infra Client, which don't support TLS 1.2. On Linux/Unix/macOS systems TLS 1.2 is supported in Chef Infra Client 10.16.4 and later. On Windows systems, TLS 1.2 is supported on Chef Infra Client 12.8 or later.

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.4.4/20210520120637
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210601124849

Released on June 7, 2021

### New features

- You can check and update the run list of the nodes from Chef Infra Server. Navigate to the run list tab: **Infrastructure > Chef Infra Server > Server Name > Organization > Nodes**. ([#5086](https://github.com/chef/automate/pull/5086))
- Reset the client key for a node from the Chef Infra Server page. ([#5088](https://github.com/chef/automate/pull/5088))
- Add tags to specific nodes by selecting **Manage Tags** from the node list options (Find it in the "more information" ellipses `...`). ([#5108](https://github.com/chef/automate/pull/5108))

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20210527104155, which includes the following profiles:

  - CIS Windows 10 2004 v1.9.1
  - CIS MSSQL Server 2019 V1.1.0

### Bug fixes

- The Chef Environment Cookbooks constraints capitalization has been fixed. ([#5089](https://github.com/chef/automate/pull/5089))

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.1.0/20210225010013
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210526024943

Released on May 31, 2021

### Improvements

- You can now search data Bags by specifying the name under the **Data Bags** tab in Chef Infra Server. You can search it at: **Infrastructure >> Chef Infra Server >> Server Name >> Organization >> Data Bags**.

### Compliance profile updates

- Compliance profiles are updated to version 1.0.0/20210519101158 which includes the following profiles:

  - Stig Windows 2016 v2.1.0
  - Stig windows Server 2019 v2.1.0
  - CIS SLES 15 V1.0.0
  - CIS MongoDB 3.6 v1.0.0

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.1.0/20210225010013
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210518074441

Released on May 24, 2021

### New features

- A new tab **Nodes** has been included in the Chef Infra Server, which allows you to search for a specific node, view the list of nodes, and delete a node. You can access it at: **Infrastructure** >> **Chef Infra Server** >> `Server Name` >> **Organization**. ([#5018](https://github.com/chef/automate/pull/5018)) ([#5042](https://github.com/chef/automate/pull/5042))

- In addition, selecting a specific node lets you view and update the information on Metadata, and Associated Tags for the selected node. ([#5071](https://github.com/chef/automate/pull/5071))

### Improvements

- An improved text validation has been included in the text fields of the roles, data bags, clients, and environment in Chef infra Server. ([#5026](https://github.com/chef/automate/pull/5026))

### Bug fixes

- The empty event feed in Chef Automate with an embedded Chef Server enabled has been fixed. ([#5052](https://github.com/chef/automate/pull/5052))

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.1.0/20210225010013
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210504084406

Released on May 10, 2021

### New features

- You can manage, create and modify *roles* directly in Chef Automate using Infra Server tab. [#4948](https://github.com/chef/automate/pull/4948), [#4991](https://github.com/chef/automate/pull/4991)

### Bug fixes

- We fixed the button for creating Chef Infra Servers so it stays the same size when you use it. [#4987](https://github.com/chef/automate/pull/4987).
- We increased the time limit for downloading large Client Run reports to five minutes, giving you more time to export your reports from Chef Automate. [#5002](https://github.com/chef/automate/pull/5002).

### Compliance profile updates

- 1.0.0/20210428072809

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.1.0/20210225010013
- Chef InSpec: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210420090302

Released on April 26, 2021

### Improvements

- Chef Infra Server UI has been improved and updated with more features.
- The UX of the Data Bags and Environments has been improved in Chef Infra Server ([#4954](https://github.com/chef/automate/pull/4954))
.

### Bug fixes

- The content tab data can now be loaded on the Cookbook details page ([#4927](https://github.com/chef/automate/pull/4927)).
- The message will now be shown if the admin key is invalid and the loading is active ([#4946](https://github.com/chef/automate/pull/4946))
.

### Compliance profile updates

- 1.0.0/20210415075651

### Maintenance

- Dependent Node Module updated ([#4781](https://github.com/chef/automate/pull/4781), [#4884](https://github.com/chef/automate/pull/4884))

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.1.0/20210225010013
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210406040048

Released on April 12, 2021

### Improvements

- UI Improvements have been made around Chef Server management ([#4888](https://github.com/chef/automate/pull/4888))

### Bug fixes

- Removed the 5 character restriction on **TLD** in **FQDN** while adding Chef Infra Servers ([#4890](https://github.com/chef/automate/pull/4890))

### Compliance profile updates

- 1.0.0/20210324103413

### Maintenance

- Dependent node modules updated ([#4835](https://github.com/chef/automate/pull/4835))

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.1.0/20210225010013
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210324172345

Released on March 30, 2021

### New features

- This release lets you manage more of your Chef Infra Server directly from Chef Automate. You can:

  - Create and update environments and data bags (along with data bag items).([4801](https://github.com/chef/automate/pull/4801), [4803](https://github.com/chef/automate/pull/4803))
  - Create clients and reset client keys.([4813](https://github.com/chef/automate/pull/4813))

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.181/20201030172917
- Chef Habitat Builder version: 8997/20200812161534
- Chef Infra Server version: 14.1.0/20210225010013
- Chef InSpec version: 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210309093358

Released on March 15, 2021

### New features

- Chef Infra Servers comes with following new abilities ([#4786](https://github.com/chef/automate/pull/4786), [#4787](https://github.com/chef/automate/pull/4787), [#4788](https://github.com/chef/automate/pull/4788), [#4790](https://github.com/chef/automate/pull/4790), [#4791](https://github.com/chef/automate/pull/4791), [#4792](https://github.com/chef/automate/pull/4792), [#4793](https://github.com/chef/automate/pull/4793)):

  - Chef Infra Servers can now be deleted from Automate User Interface. The Infra Server gets deleted along with it's associated Organisations and Cookbooks, Roles, Environments, Data-Bags and clients.
  - Ability to create Clients.

### Improvements

- Compliance Profiles have been updated ([#4724](https://github.com/chef/automate/pull/4724)).
- Elasticsearch is upgraded to 6.8.14 ([#4761](https://github.com/chef/automate/pull/4761)).
- OpenJDK 11.0.2 is moved to AdoptOpenJDK version 11.0.10+9 ([#4761](https://github.com/chef/automate/pull/4761)).
- Chef Server updated to version 14.1 ([#4780](https://github.com/chef/automate/pull/4780)).

### Bug fixes

- The connectivity of the Elasticsearch Service cluster nodes has been fixed ([#4769](https://github.com/chef/automate/pull/4769)).

### Known Issues

There are some investigated UI issues, listed here ([#4808](https://github.com/chef/automate/issues/4808)):

- **Create Client** button is misaligned.
- **Delete popup modal** width needs to be increased.
- **Roles List** page is misaligned.

### Chef Product Versions

This release uses:

- Chef Habitat version 1.6.181/20201030172917
- Chef Habitat Builder version 8997/20200812161534
- Chef Infra Server version 14.1.0/20210225010013
- Chef InSpec version 4.24.32/20210112215549

### Service versions

This release uses:

- Postgres: 9.6.11
- ElasticSearch: 6.8.14
- Nginx: 1.19.2
- Haproxy: 2.2.2

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210219171521

Released on March 1, 2021

### New features

- The updated *Infrastructure* tab lets you add Chef Infra Servers, giving you a comprehensive view of your Chef-managed systems.
  - Add organizations to each server.
  - View cookbooks, roles, environments, data bags, and clients for each organization.
  - Search and find roles, environments, data bag items, and clients from Chef Automate.

### Improvements

- Upgraded to Ruby version 2.6 ([4425](https://github.com/chef/automate/pull/4425)).
- Added IDs on the **Project** and **Role** pages in the *Settings* tab ([4393](https://github.com/chef/automate/pull/4393)).
- Added capability to create a backup from AWS ES service to AWS S3 ([4664](https://github.com/chef/automate/pull/4664))

### Bug fixes

- Chef Infra Server will proxy data-collector requests to Chef Automate (internal or external) instead of localhost. ([4711](https://github.com/chef/automate/pull/4711)).
- Chef Infra Server will startup even if the local Chef Automate instance is stopped or if the external Chef Automate fails to resolve. ([4684](https://github.com/chef/automate/pull/4684))

### Chef Product Versions

This release uses:

- Chef Habitat version 1.6.181/20201030172917
- Chef Habitat Builder version 8997/20200812161534
- Chef Infra Server version 14.0.65/20201020065137
- Chef InSpec version 4.24.32/20210112215549

## Chef Automate 20210129162733

Released on February 8, 2021

### Winter 2021 Self-Care Release

We resolved some internal technical debt in this release. Reduced technical debt strongly correlates with increased developer well-being, and happier devs are already at work improving Chef Automate for the next release.

This release uses:

- Chef Habitat version 1.6.181/20201030172917
- Chef Habitat Builder version 8997/20200812161534
- Chef Infra Server version 14.0.65/20201020065137
- Chef InSpec version 4.23.4/20200909235900

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210125155346

Released on January 25, 2021

### Improvements

- We made Chef Automate more secure by moving the credentials from your user configuration into a secrets store (#4571):

  - Supports LDAP and MSAD bind passwords in the secrets field
  - You can pass secrets as environment variables
  - The `config show` terminal output is secrets-free

### Bug fixes

- Fixed a bug in the `20210116175706` release that caused the `deployment-service` to crash with the migration of LDAP and MSAD passwords to an encrypted format.

### Chef Product Versions

This release uses:

- Chef Habitat version 1.6.181/20201030172917
- Chef Habitat Builder version 8997/20200812161534
- Chef Infra Server version 14.0.65/20201020065137
- Chef InSpec version 4.23.4/20200909235900

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20210112001354

Released on January 14, 2021

### Improvements

- We added a button to make downloading compliance node details easier. ([#4513](https://github.com/chef/automate/pull/4513))

### Compliance Profiles

We added:

- The community Google Cloud Platform CIS Profile 1.1.0 ([inspec-gcp-cis-benchmark](https://github.com/GoogleCloudPlatform/inspec-gcp-cis-benchmark))
- CIS Profiles for Windows 2019

### Bug fixes

- Selecting a specific date from the trend graph on the Compliance Tab loads the compliance data for that day. ([#4536](https://github.com/chef/automate/pull/4536))
- Selecting the pie chart on the Compliance Tab opens the corresponding report. ([#4536](https://github.com/chef/automate/pull/4536))
- Selecting "3 months" or "1 year" from the drop-down on the services sidebar loads data on the trend graph. ([#4489](https://github.com/chef/automate/pull/4489))
- We made the services sidebar easier to navigate by limiting the page-picker load to a maximum of five pages at one time. ([#4508](https://github.com/chef/automate/pull/4508))
- ServiceNow request failures give you a notification. ([#4500](https://github.com/chef/automate/pull/4500))

### Chef Product Versions

This release uses:

- Chef Habitat version 1.6.181/20201030172917
- Chef Habitat Builder version 8997/20200812161534
- Chef Infra Server version 14.0.65/20201020065137
- Chef InSpec version 4.23.4/20200909235900

View the [package manifest](https://packages.chef.io/manifests/current/automate/latest.json) for the latest release.

## Chef Automate 20201230192246

Released on January 11, 2021

### Improvements

- Filter service instances in the Applications Dashboard by their connected or disconnected status. ([#4452](https://github.com/chef/automate/pull/4452))
- Visualize waived nodes and controls in the *Reports* Overview graphs. ([#4456](https://github.com/chef/automate/pull/4456))
- The *Event Feed* displays the Policyfile cookbook names in updates. ([#4469](https://github.com/chef/automate/pull/4469))
- Dynamically resolve externally deployed ElasticSearch and PostgreSQL hostnames using resolvers/Dynamic Name Servers. ([#4454](https://github.com/chef/automate/pull/4454), [#4486](https://github.com/chef/automate/pull/4486), and [#4502](https://github.com/chef/automate/pull/4502))

### Bug fixes

- The log message displays an error instead of a warning when all Elasticsearch publishers are full. ([#4443](https://github.com/chef/automate/pull/4443))

### Chef Product Versions

This release uses:

- Chef Habitat version 1.6.181/20201030172917
- Chef Habitat Builder version 8997/20200812161534
- Chef Infra Server version 14.0.65/20201020065137
- Chef InSpec version 4.23.4/20200909235900

## Chef Automate 20201127104018

Released on December 7, 2020

### Improvements

- The Chef Automate Compliance APIs show data for the last 24 hours by default unless an `end_time` is specified. ([#4310](https://github.com/chef/automate/pull/4310))
- Select the *Last 24 hours* option in the *Reports* search bar to view scan results for the last 24 hours. Select *Choose Date (UTC)* to see scan results from a selected day based on UTC timestamps. ([#4358](https://github.com/chef/automate/pull/4358), [#4437](https://github.com/chef/automate/pull/4437), and [#4448](https://github.com/chef/automate/pull/4448))

### Bug fixes

- Resolved pagination issues in the *Client Runs* Run History means that pagination should now appear as expected. ([#4441](https://github.com/chef/automate/pull/4441))

### Chef Product Versions

This release uses:

- Chef Habitat version 1.6.181/20201030172917
- Chef Habitat Builder version 8997/20200812161534
- Chef Infra Server version 14.0.25/20200828081545
- Chef InSpec version 4.23.4/20200909235900

## Chef Automate 20201106153948

Released on November 23, 2020

### Improvements

- Customize whether your SAML sign-in session expires after the default 24 hours or a duration of your choice. ([#4400](https://github.com/chef/automate/pull/4400))

### Bug fixes

- Select different node status filters in *Client Runs* and experience smooth navigation without jarring page jumps. ([#4392](https://github.com/chef/automate/pull/4392))
- The search bar calendar appears over the *Reports* results tabs, no matter your browser's zoom level. ([#4412](https://github.com/chef/automate/pull/4412))

## Chef Automate 20201020140427

Released on November 9, 2020

### Improvements

- The server name no longer appears in network response headers to prevent any potential security scan failure. ([#4397](https://github.com/chef/automate/pull/4397))

### Chef Product Versions

This release uses:

- Chef Habitat version 1.6.139/20200824142405
- Chef Habitat Builder version 8997/20200812161534
- Chef Infra Server version 14.0.25/20200828081545
- Chef InSpec version 4.23.4/20200909235900

## Chef Automate 20201012185603

Released on October 26, 2020

### Improvements

- Experience a better workflow when managing node credentials (Settings > Node Credentials) with improved creation and deletion windows. ([#4323](https://github.com/chef/automate/pull/4323))
- The Local User sign in option may be removed from the browser sign in window if no local users exist. ([#4386](https://github.com/chef/automate/pull/4386))

### Chef Product Versions

This release uses:

- Chef Habitat version 1.6.139/20200824142405
- Chef Habitat Builder version 8997/20200812161534
- Chef Infra Server version 14.0.25/20200828081545
- Chef InSpec version 4.23.4/20200909235900

## Chef Automate 20201005173827

Released on October 12, 2020

### Improvements

- All internal services now listen only on localhost. ([#4338](https://github.com/chef/automate/pull/4338))
- The *Node Detail* view for *Reports* shows a "No tests were executed" results message when applicable. ([#4352](https://github.com/chef/automate/pull/4352))
- Filter in *Applications* with case-insensitive health filters. ([#4388](https://github.com/chef/automate/pull/4388))
- A confirmation screen appears when deleting a Node Integration. ([#4348](https://github.com/chef/automate/pull/4348))
- Delete a Node Integration and their associated nodes are also deleted. ([#4348](https://github.com/chef/automate/pull/4348))

### Bug fixes

- The rule name, not the rule ID, appears in the notification banner after creating an ingest rule for a project. ([#4331](https://github.com/chef/automate/pull/4331))
- The *Report Metadata* display in *Reports* no longer needs a horizontal scrollbar. ([#4356](https://github.com/chef/automate/pull/4356))
- The controls in the *Reports* scan results sidebar correctly map to their respective nodes. ([#4357](https://github.com/chef/automate/pull/4357))

### Chef Product Versions

This release uses:

- Chef Habitat version 1.6.139/20200824142405
- Chef Habitat Builder version 20200812161534
- Chef Infra Server version 14.0.25/20200828081545
- Chef InSpec version 4.23.4/20200909235900

## Chef Automate 20200922182722

Released on September 28, 2020

### Improvements

- The Go representation of Chef Automate's external API is now available as a self-contained Go module. ([#4298](https://github.com/chef/automate/pull/4298))
- Filter for all connected Applications services when querying the Chef Automate API. ([#4339](https://github.com/chef/automate/pull/4339))
- Filter secrets by name when querying the Chef Automate API. ([#4341](https://github.com/chef/automate/pull/4341))

### Bug fixes

- Fixed a bug where a harmless browser console error appeared if you had any pending project edits and viewed *Project Details* for any project. ([#4362](https://github.com/chef/automate/pull/4362))
- *Add User* and *Cancel* correctly appear separate from a full list of users when adding users to a local team in the browser. ([#4361](https://github.com/chef/automate/pull/4361))

### Chef Product Versions

This release uses:

- Chef Habitat version 1.6.56/20200618202635
- Chef Habitat Builder version 20200812161534
- Chef Infra Server version 14.0.25/20200828081545
- Chef InSpec version 4.23.4/20200909235900

## Chef Automate 20200908235050

Released on September 9, 2020

### Improvements

- Presto Chango: `Create Rule`, `Save Rule`, and `Add Condition` in Settings > Projects > Project Details don't appear for users without the `iam:projects:update` permission. ([#4316](https://github.com/chef/automate/pull/4316), [#4317](https://github.com/chef/automate/pull/4317), and [#4300](https://github.com/chef/automate/issues/4300))
- Did You Know?: The user menu in the top navigation bar includes a link for Chef Patents. ([#4283](https://github.com/chef/automate/pull/4283))

### Bug fixes

- Focused: Only users with the relevant `iam:projects:update` permission may edit a project. ([#4304](https://github.com/chef/automate/pull/4304) and [#4301](https://github.com/chef/automate/issues/4301))
- Softcoded: `fakechefserver.eastus.cloudapp.azure.com` no longer appears in the *Desktop Dashboard*'s *Node Details* display. ([#4299](https://github.com/chef/automate/pull/4299))

### Chef Product Versions

This release uses:

- Chef Habitat version 1.6.56/20200618202635
- Chef Habitat Builder version 20200812161534
- Chef Infra Server version 14.0.25/20200828081545
- Chef InSpec version 4.22.22/20200826191347

## Chef Automate 20200831163517

Released on September 1, 2020

### New features

- Moving Day: The Chef Automate documentation has a new URL -- [docs.chef.io/automate](https://docs.chef.io/automate) -- and the same design as the rest of our Chef documentation. You can still make pull requests for documentation changes in the Chef Automate repository, but the documentation directory has changed to `github.com/chef/automate/components/docs-chef-io`.
- FYI: Lightweight Role-Based Access Control (RBAC) for Chef Habitat Builder is now here! Learn more about [RBAC implementation](https://forums.habitat.sh/t/rbac-in-builder-saas/1343). ([#4269](https://github.com/chef/automate/pull/4269))

### Improvements

- Sunshine: See public packages under a public origin for Chef Habitat Builder with no browser-based authentication required. ([#4269](https://github.com/chef/automate/pull/4269))
- Expanded Horizons: Chef Infra Server included with Chef Automate now supports a wider range of TLS certificates when configured to send data collector data to an external Chef Automate server. ([#4279](https://github.com/chef/automate/pull/4279))

### Bug fixes

- New Location: `data-feed-service` moved from port 14001 to 10501 to be within our recommended ephemeral port range. ([#4171](https://github.com/chef/automate/pull/4271))

### Chef Product Versions

This release uses:

- Chef Habitat version 1.6.56/20200618202635
- Chef Habitat Builder API version 20200812161534
- Chef Infra Server version 14.0.25/20200828081545
- Chef InSpec version 4.22.8/20200804103652

## Chef Automate 20200816214709

Released on August 24, 2020

### Improvements

- Server Found: Addressed sporadic `500 Internal Server` errors from Chef Infra Server with a Chef Infra Server packages upgrade from 13.0.47 to 14.0.22. See [Chef Infra Server PR #2064](https://github.com/chef/chef-server/pull/2064) for further details. ([PR #4216](https://github.com/chef/automate/pull/4216))

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.56/20200618202635
- Chef Habitat Builder version: 20200601120044
- Chef Infra Server version: 14.0.22/20200812153858
- Chef InSpec version: 4.22.8/20200804103652

### Known Issues

- The Chef Infra Server included with Chef Automate may be unable to send data to the Data Collector endpoint of an external Chef Automate server. ([#4264](https://github.com/chef/automate/issues/4264))

## Chef Automate 20200811175306

Released on August 17, 2020

### New features

- Documented Google Cloud Storage (GCS) Backups. Thanks to [@mskdenigma](https://github.com/mskdenigma) and [@kavanista](https://github.com/kavanista) for their contributions in [#3609](https://github.com/chef/automate/pull/3609) and [#4106](https://github.com/chef/automate/pull/4106)!

### Bug fixes

- Entering "beta," "lega," or "feat" into a box no longer opens the feature flags window. ([#4204](https://github.com/chef/automate/pull/4202))

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.56/20200618202635
- Chef Habitat Builder version: 20200601120044
- Chef Infra Server version: 13.0.47/20200421235032
- Chef InSpec version: 4.22.8/20200804103652

## Chef Automate 20200807155122

Released on August 11, 2020

### New features

- Knowledge is Power: Learn more about [Azure AD as a SAML Identity Provider](https://automate.chef.io/docs/saml/#azure-ad). [#4136](https://github.com/chef/automate/pull/4136)
- Weeding: Delete individual services from the *Applications* dashboard's *Service Groups* display. [#4079](https://github.com/chef/automate/pull/4079)

### Improvements

- No Matter How Far: Number inputs in *Data Lifecycle* adjust to show the entire value rather than limiting the display to two digits. [#4121](https://github.com/chef/automate/pull/4121)
- Data Not Found: *Desktop* dashboard displays an empty state view when no data is available. [#4156](https://github.com/chef/automate/pull/4156)

### Bug fixes

- Better Option: Creating a project no longer automatically creates local teams. [#4149](https://github.com/chef/automate/pull/4149)
- High Availability: Adds and populates the bookshelf key pair, ensuring communication with the Chef Infra Server sandbox APIs. This is particularly important for bootstrapping HA deploys. [#4161](https://github.com/chef/automate/pull/4161)

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.56/20200618202635
- Chef Habitat Builder version: 20200601120044
- Chef Infra Server version: 13.0.47/20200421235032
- Chef InSpec version: 4.22.8/20200804103652

## Chef Automate 20200728181447

Released on July 30, 2020

### Improvements

- Live 24/7: The *Desktop* dashboard's *Node Details* displays live data for all fields. ([#4058](https://github.com/chef/automate/pull/4058))
- Nifty: Customize your columns for the *Filtered Desktop List* in the *Desktop* dashboard. ([#4083](https://github.com/chef/automate/pull/4083))
- Beta Boom: Learn more about our Data Feed beta feature with our [Data Feed documentation](https://automate.chef.io/docs/datafeed/). ([#3590](https://github.com/chef/automate/pull/3590))
- More Context: Chef Automate now ingests reports generated from Chef InSpec runtime exceptions with the addition of status and root level status messages. ([#4131](https://github.com/chef/automate/pull/4131))

### Bug fixes

- Across the World: The date picker in *Compliance Reports* no longer switches to the day before the selected date for users in Australia and parts of Asia. ([#4030](https://github.com/chef/automate/pull/4030))
- Unlocked: Fixes to Chef Habitat Builder and `backup-gateway` address issues caused by an MinIO upgrade, where configuration became encrypted with an ephemeral key. ([#4061](https://github.com/chef/automate/pull/4061))([#4077](https://github.com/chef/automate/pull/4077))
- Better: Experience improved performance for control and control tag suggestions in the *Reports* search bar. ([4134](https://github.com/chef/automate/pull/4134))
- New Standard: The default maximum request size for the Chef Infra Server is now 4MB to minimize the chances of dropping large reports. This change only affects new installs. You can patch your configuration manually to get the same effect if seeing dropped reports when running an earlier version of the Chef Automate-deployed Chef Infra Server. ([#4069](https://github.com/chef/automate/pull/4069))
- Not From Around Here: Chef Automate now detects non-local Chef Habitat users and groups. ([#4110](https://github.com/chef/automate/pull/4110)) ([#4122](https://github.com/chef/automate/pull/4122))

### Chef Product Versions

This release uses:

- Chef Habitat version: 1.6.56/20200618202635
- Chef Habitat Builder version: 20200601120044
- Chef Infra Server version: 13.0.47/20200421235032
- Chef InSpec version: 4.21.3/20200702113741

## Chef Automate 20200707173044

Released on July 13, 2020

### Improvements

- The Chef Automate Desktop dashboard list view features functional filters. ([#3981](https://github.com/chef/automate/pull/3981))

### Bug fixes

- Receive notifications for failed Chef Infra Client runs with no failed resources. ([#4043](https://github.com/chef/automate/pull/4043))

### Chef Product Versions

This release depends on:

- Chef Habitat version: 20200601120044
- Chef InSpec version: 4.21.3/20200702113741

## Chef Automate 20200701215317

Released on July 6, 2020

### Improvements

- Vroom: Experience improved report ingestion speed!
- Total Package: Chef Infra Server configuration now migrates with Chef Infra Server data as a part of the Chef Automate 1 migration process.
- Beyond API: We expanded Applications *Service Groups* management to the browser! Look under the *Data Lifecycle* settings.

### Bug fixes

- No Misdirection: Users no longer redirect to the Event Feed when trying to view the Scans list on a scheduled Scan Job with [PR #3950](https://github.com/chef/automate/pull/3950).
- Less Clicks: Chef Automate closes the "no license" pop-up window automatically within a few minutes for all users once a new license is applied, rather than requiring a manual browser refresh with [PR #3949](https://github.com/chef/automate/pull/3949).
- Unblocked: We restored functionality to Event Feed filters when filtering by Chef Infra Server, policyfiles, and cookbooks with [PR #3985](https://github.com/chef/automate/pull/3985), [PR #3986](https://github.com/chef/automate/pull/3986), and [PR #3992](https://github.com/chef/automate/pull/3992).
- Reactivate: You may now change an inactive API token to `active` in *Token Details* with [PR #3991](https://github.com/chef/automate/pull/3991).
- No More Blanks: Compliance Reports during exporting correctly account for control tag filters with a key and no value with [PR #4001](https://github.com/chef/automate/pull/4001).

## Chef Automate 20200617215626

Released on June 23, 2020

### Improvements

- Additional `inspec runner` logging means easier troubleshooting for "operation not permitted" errors with compliance profile installations.

### Bug fixes

- A "couldn't get logged in user" error no longer displays for non-local users upon sign in.
- Compliance Report nodes correctly filter by status when using Deep Filtering.

## Chef Automate 20200610173731

Released on June 15, 2020

### Improvements

- The short of it: Truncated reports show the correct number of test results.
- Closed and out: Optional configuration to sign-out users when they close the browser.

### Bug fixes

- A11y: Accessibility fixes across Chef Automate.
- Already there: GCP account scans won't fail with "project_id must be included".
- Finer points: Significant refinements to the Applications page filters.
- Scarequotes: Scans can handle tags with double-quotes.
- Projecting: Consistently displays the complete list of projects associated with teams or tokens in Automate.

## Chef Automate 20200603114954

Released on June 8, 2020

### New features

- Automatically create `admins`, `editors`, and `viewers` teams during Project creation.

### Improvements

- An improved Policies drop-down list in the *API Tokens* creation window sorts and labels Chef-managed policies and custom policies.
- Project filtering extends for scanned, manually-added nodes with an environment value that matches a project's rules. Node lists from *Scan Jobs* and *Compliance Reports* will match where applicable.
- Control results in the *Node Detail* display waived controls' execution results if applicable.
- *Compliance Reports* CSV exports include `waived status`, `waiver justification`, and `waiver expiration date` fields.

### Bug fixes

- We fixed a number of accessibility bugs: all inputs now have labels, all headings are in sequence, and all small text increased to a minimum 11px font size.
- We updated the Chef Habitat supervisor version to fix a memory leak issue.

## Chef Automate 20200529133631

Released on June 2, 2020

### Improvements

- No Mouse: Navigate on-page filter controls by keyboard, such as the Health Status buttons in the *Applications* dashboard.
- Keeping Tally: Compliance Report API includes a "removed_control_results" field, which shows how many failed/passed/skipped results are truncated when the report is too large. Learn more about these truncation settings in our [Compliance Configuration documentation](https://automate.chef.io/docs/configuration/#compliance-configuration).

### Bug fixes

- As Expected: Labels in the *Applications* Service Group Details sidebar wrap correctly in [PR #3767](https://github.com/chef/automate/pull/3767). Fixes [Issue #2150](https://github.com/chef/automate/issues/2150).
- Abracadabra: *Client Runs* includes restored checkboxes and **Delete Nodes** in [PR #3804](https://github.com/chef/automate/pull/3804). Fixes [Issue #3802](https://github.com/chef/automate/issues/3802).

## Chef Automate 20200520145933

Released on May 26, 2020

### Improvements

- Now Available: Filter your [SAML groups](https://automate.chef.io/docs/saml/#saml-configuration-settings) as a part of your configuration settings.

### Bug fixes

- Within Reach: Delete the last token on the *API Tokens* list with greater ease in [PR #3591](https://github.com/chef/automate/pull/3591). Fixes [Issue #2798](https://github.com/chef/automate/issues/2798).
- On Auto: Window automatically closes after deleting a Notification in [PR #3694](https://github.com/chef/automate/pull/3694). Fixes [Issue #3659](https://github.com/chef/automate/issues/3659).
- All in One Place: Compliance Reports no longer redistribute across multiple pages after applying a status filter in [PR #3664](https://github.com/chef/automate/pull/3664). Fixes [Issue #3144](https://github.com/chef/automate/issues/3144).
- Streamlined: Selecting a second drop-down list during API Token creation causes the first open drop-down list to automatically close as expected in [PR #3712](https://github.com/chef/automate/pull/3712). Fixes [Issue #3533](https://github.com/chef/automate/issues/3533).
- Expansion: We correctly support 64bit service IDs for the *Applications* dashboard in [PR #3718](https://github.com/chef/automate/pull/3718).
- Better Care: Most of our APIs no longer ignore unknown fields sent in JSON payloads. To opt out of this change, pass a `Content-Type: application/json+lax` request header to make the request behave as before, and to ignore and allow unknown fields. Fixed in [PR #3690](https://github.com/chef/automate/pull/3690).

## Chef Automate 20200513205422

Released on May 14, 2020

### Improvements

- Coordinated Universal Time: The time and date displays in *Event Feed* indicate their timezone value with the added "UTC" label.
- Magic: The *Dashboards* tab in the top navigation bar appears only to users with the authorization access to view *Event Feed*.
- Try It: Chef Automate works on smaller browser screens with responsive navigational displays.
- Adjustable: Prevent system overload by specifying the maximum number of inflight data collector requests, which has a default value of sixty times the number of the machine's available CPUs.

### Bug fixes

- Expansion: `Viewer` Policy members export compliance reports by default in [PR #3623](https://github.com/chef/automate/pull/3623).
- Cartography: The values of when to label nodes as missing and to remove node data in *Client Runs* correctly map as of [PR #3665](https://github.com/chef/automate/pull/3665). Fixes part of [Issue #3651](https://github.com/chef/automate/issues/3651).
- Less Shouting: Service Group channel names display as expected on the *Applications* dashboard rather than in all capital letters in [PR 3650](https://github.com/chef/automate/pull/3650). Fixes [Issue #3626](https://github.com/chef/automate/issues/3626).

## Chef Automate 20200506172513

Released on May 11, 2020

### Improvements

- Quick Change: Adding a legacy data collector token automatically adds the created API token to the IAM `Ingest` Policy.
- In Sight: Experience always visible user notifications, even if you scroll down the page!

### Bug fixes

- Restoration: The `/status` API endpoint works as expected.
- Limitless: We increased the maximum number of service IDs in the Applications dashboard, which provides one less reason for service-related outages.

## Chef Automate 20200429153636

Released on May 4, 2020

### New features

- Add policies when you make an API token with the new policy dropdown menu.
- Use the new `chef-automate backup integrity` command to validate your Chef Habitat Builder snapshots. This command includes subcommands to run validation checks and show snapshots' validation status.

### Improvements

- What's Not To Like?: **Apply Changes** in Project Filtering appears selectable in expected and appropriate situations.
- Brownie Points: Take a look at our documented [IAM Actions](https://automate.chef.io/docs/iam-actions/).
- Heads Up: New Scan Jobs require a defined version for Chef Automate Profiles and validates this requirement at creation, which ensures the profile's searchability and prevents profile malformation.
- Make a Bee-Line: We added a "created_at" field for the Nodes API endpoint, so you can see when the node first reported into Chef Automate.

### Bug fixes

- We fixed the breadcrumb navigation, so now you can navigate easily through pages in Compliance Reports with filters intact.
- Know Your Onions: We fixed our API versioning, making the [API Docs](https://automate.chef.io/docs/api/) even more useful.
- We restored SSM node scanning functionality for AWS EC2 and Azure VM Scan Jobs.
- Bee's Knees: Chef Automate allows buffer size configuration and rejects reports when too many messages exist in the buffer during ingestion.

## Chef Automate 20200420162758

Released on April 27, 2020

### Improvements

- Advanced Sifting: Scan Job Reports support project filtering. When manually creating a node in *Scan Jobs*, tag the new node with an `Environment` value, which will pass into Compliance Reports, and the Compliance ingestion will use that environment for project assignment.

## Chef Automate 20200416222158

Released on April 20, 2020

### New features

- Template for Awesome: Chef Automate includes 2 custom IAM roles and 2 custom IAM policies for compliance-only access with its standard Chef-managed policies and roles.

### Improvements

- Stand and Deliver: The *Clear Selection* button in the Project filter clears only the selections made instead of clearing and applying the lack of Project selection.

### Bug fixes

- Roster: The accurate list of remaining users on a team displays after removing a user.
- As It Should: The loading screen disappears as expected if you navigate away from *Compliance Profiles* before the page finishes loading.
- Moving Made Easy: Custom Identity and Access Management (IAM) v1 policies with a single-term resource, such as `cfgmgmt`, correctly migrate to IAM v2.
- OK Backup: The Chef Automate-deployed Chef Infra Server's `/universe` and `/version` endpoints handle correctly.
- Toggle On: The active/inactive status of a token toggles successfully in the browser.
- Act Locally: The Elasticsearch gateway is now only accessible on localhost.

## Chef Automate 20200408145843

Released on April 13, 2020

### New features

- Write This Down: In this release, users of Identity and Access Management v1 (IAM v1) **automatically upgrade** to Identity and Access Management v2 (IAM v2). All IAM v1 users, teams, tokens, and policies will migrate to IAM v2. Some details to keep in mind:

  - [API Tokens](https://automate.chef.io/docs/api-tokens/) created in the browser work differently in IAM v2. After [creation](https://automate.chef.io/docs/api-tokens/#creating-api-tokens), an API token will have zero permissions. Add the new API token to a policy to grant permissions.
  - Creating admin API Tokens from the CLI in IAM v2 uses a [new command](https://automate.chef.io/docs/api-tokens/#admin-tokens). The old CLI command won't work.
  - If your IAM v1 local team names contain non-alphanumeric characters other than hyphens and underscores, recreate these local teams and add them to policies for correct function in IAM v2.
  - Editor and Viewer roles change in IAM v2 from using the broad `infra:*` authorization action to more specific authorization actions, such as `infra:nodeManagers:*` and `infra:nodes:*`. We recommend updating the authorization actions for your custom roles accordingly.
- Amazed: Set [Data Lifecycle settings](https://automate.chef.io/docs/data-lifecycle/) directly in the browser!
- Every Morning: All appropriate views in Compliance Reports include Waiver information for nodes, profiles, and individual controls.

### Bug fixes

- Believe: Compliance Reports appear and correctly filter by Job ID after you click on **Report** for a listed Scan Job on the *Scan Jobs* page.
- Lately: Projects filter as expected when a page refreshes.
- I Need to Know: Chef Habitat Builder deployed with Chef Automate completes backups without failing.
- Someday: The previously scheduled time appears correctly when editing a Scan Job schedule.
- No Scrubs: Status counts in Compliance Reports display accurate numbers regardless of status filters.

### Backward incompatibilities

- From This Moment On: All API calls for removing or adding users to a team now expect `membership_ids` rather than `user_ids`.

## Chef Automate 20200325163209

Released on March 30, 2020

### Note

In the next Chef Automate release available on April 13th, 2020, users of Identity and Access Management v1 (IAM v1) will automatically upgrade to Identity and Access Management v2 (IAM v2). All IAM v1 users, teams, tokens, and policies will migrate to IAM v2. Some things to keep in mind:

- If you want to upgrade to IAM v2 before this next release, see our [upgrading to IAM v2 documentation](https://automate.chef.io/docs/iam-v2-guide/#upgrade-to-iam-v2), available until April 13th, 2020.
- API Tokens created in the browser will work differently in IAM v2. After creation, an API token will have zero permissions. Add the new API token to a policy to grant permissions.
- Check your scripts! Creating admin API Tokens from the CLI in IAM v2 uses a new command: `chef-automate iam token create <your token name here> --admin`.
- If your IAM v1 local team names contain non-alphanumeric characters other than hyphens and underscores, these local teams will need to be recreated to function correctly in IAM v2.

### Improvements

- Good Times: The Elasticsearch gateway timeout default value increases from 5 minutes to 10 minutes to support installations with backups in Amazon S3.
- That's the Way: The Project Update banner respects a multi-user environment. All users' browsers display pending edit notifications for projects and for project updates in progress.
- Don't Stop 'Til You Get Enough: Check out our expanded [IAM API documentation](https://automate.chef.io/docs/api/#operation/UpdateSelfMixin50)!
- Stayin' Alive: The "Your System is Compliant" banner appears when the scanned infrastructure's status is `waived` on the Compliance *Reports* page.
- Turn the Beat Around: Failed Compliance Scan Jobs return a more verbose error message.

### Bug fixes

- Got to Be Real: The Project Update banner shows on all pages consistently.
- Jump to It: The *Project Details* page updates correctly.
- Second Time Around: The *Save* button on the *IAM detail* pages disables in a consistent manner when you return a value to its original state.
- Stomp: IP addresses in a Compliance report no longer experience overwriting with incorrect values.
- Celebration: The region value for an AWS Account scan populates correctly.

## Chef Automate 20200316122114

Released on March 23, 2020

### Improvements

- If This Is It: Project update failures appear in the browser with an update banner that changes color and a clear failure message. Previously, a failed update showed the "edits pending" indicator with no explanation.
- Time Will Reveal: Search for a Compliance report with time ranges and experience faster results!
- Hello: Check out our expanded [backup and restore documentation](https://automate.chef.io/docs/backup/) based on user feedback.

### Bug fixes

- There's No Stopping Us: Users may delete Applications services in batch without size limits using Chef Automate CLI.

## Chef Automate 20200310163217

Released on March 16, 2020

### Improvements

- In Sync: Delete nodes on the *Client Runs* page and those nodes update as deleted in the Node Manager.
- Time: Fetch a Compliance report faster in the browser or the API.
- You Got It: Show Chef InSpec waiver information on Compliance report downloads, where applicable.
- Little Things: See the estimated completion time sooner when you run a project update.

### Bug fixes

- Never Gone: Editor and Viewer roles can view the *Scan Jobs* page and create a new scan job.
- Roll With It: Fixed a bug where Elasticsearch backup deletions failed because Elasticsearch only allows one backup deleted at a time.
- Step by Step: Experience increased resource efficiency when Elasticsearch performs a project update.

## Chef Automate 20200303183409

Released on March 9, 2020

### Improvements

- Reference Section: Explore lots of new [API Docs](https://automate.chef.io/docs/api/), which include API Tokens, IAM Policies, Scan Jobs, and Node Managers.
- Ripple Effect: Mark nodes as *Missing* on the *Chef Client Runs* page, and their state will update to *Missing* with the Node Manager and for nodes found at the `api/v0/nodes` endpoint.

### Bug fixes

- New Fix: IAM v2 users can now add a new data collector token when patching their existing configuration.
- Clear: We resolved an issue where a large Chef Client Runs export would result in invalid JSON.

### Backward incompatibilities

- Permanent Change: We removed all instances of `/iam/v2beta/` in paths. We now exclusively use `/iam/v2/`.

## Chef Automate 20200220011437

Released on February 24, 2020

### Improvements

- Update your projects in Access Management by selecting the `Update Projects` button that appears at the bottom of the page. A progress banner displays whenever an update is in progress.
- Backups for Chef Habitat artifacts are now incremental. Only Chef Habitat artifacts that don't exist previously in the backup repository will be copied in full.
- Chef Automate data backup includes Applications data.
- Chef Automate Compliance backend supports Chef InSpec waivers.

### Bug fixes

- We resolved bugs related to Chrome 80.0.3987.87 and modal windows in Chef Automate and in the Chef Automate API documentation.
- We fixed a goroutine memory leak, which affected all services using the `cereal-service` library.
- Chef Client Run reports with no `entity_uuid` field will now be rejected, which prevents bad report ingestion.
- Failing profiles will be skipped and logged in an error message when migrating from Chef Automate 1 to Chef Automate 2, which allows the migration to complete instead of fail.
- The Applications dashboard is now hidden if a user lacks the authorization for viewing.

## Chef Automate 20200131232134

Released on February 10, 2020

### New features

- Fresh: Use the now available compliance profiles for STIG updates:

  - RHEL 7 V2R6
  - RHEL 6 V1R26
  - Windows 2012 and 2012R2 Member Server V2R18
  - Windows 2016 V1R12

### Improvements

- Enhanced: The compliance profiles for CIS RHEL 8 include a number of improvements for logical correctness and readability.
- Elective: Chef Habitat Builder may be deployed with only Chef Automate Authorization services rather than all of Chef Automate.

### Bug fixes

- Better: Elasticsearch clusters managed externally to Chef Automate can now use Amazon S3 snapshots to successfully run back-ups.
- Consistency: When users modify their display names, the display name updates in the User Menu.
- Direct Effect: Deleting a project will be reflected immediately in the global project filter.

### Known Issues and Workarounds

- Alert!: If you use Chrome 80.0.3987.87, you may experience problems with modal windows. To resolve, navigate to a different page in Chef Automate, and then return the original page. We will have this issue fixed in the next release of Chef Automate. This modal window issue also affects our [API Documentation](https://automate.chef.io/docs/api), which should resolve by refreshing the page.

## Chef Automate 20200127203438

Released on February 3, 2020

### New features

- Released: [Identity and Access Management v2](https://automate.chef.io/docs/iam-v2-overview/) is now generally available! Upgrade with the Chef Automate CLI command: `chef-automate iam upgrade-to-v2`.

### Improvements

- One Less Step: Create and add users directly from a Team's detail page.
- Up-To-Date: Check out our refreshed [Applications Dashboard documentation](https://automate.chef.io/docs/applications-setup/) about how to see your Chef Habitat infrastructure in Chef Automate.

## Chef Automate 20200123225613

Released on January 27, 2020

### New features

- Look, Everyone: Applications Dashboard is now generally available! Learn more in our [Applications docs](https://automate.chef.io/docs/applications-setup/).
- Brand New: Check out our new [Chef Automate-deployed on-prem Builder](https://automate.chef.io/docs/on-prem-builder/), featuring both Chef Automate and Chef Habitat Builder on-prem together!

### Improvements

- Quicker Than Ever: We improved the 3-dot menu at the end of table rows, so the displays load much faster now.
- See The Difference: The user management display features consistency improvements.
- The More, The Better: We added more information to the output of the `chef-automate backup show <backup_id>` command to support debugging.
- On The Same Page: The modified profiles search endpoint uses one (1) for the first page now, instead of zero, for consistency with other APIs.

### Bug fixes

- Mended: We repaired a broken `--patch-config` flag for backup restores. Under most cases, this flag was being ignored and would result in a restore having the exact configuration as the backup.

### Beta Features

#### Identity and Access Management v2

- Prepare for Glory: We increased the project limit from 6 to 300.
- Squashed: Fixed bug associated with using the browser back button after navigating from the *Teams* page to the *Users* page in Settings.
- Targeted: The project filter and project assignment dropdown now features the ability to search for specific projects!
- One Click: It's now possible to clear all your project selections at once in the project filter.

## Chef Automate 20200115001116

Released on January 21, 2020

### New features

- Point of Reference: Check out our InSpec profiles for the CIS RHEL 8 v1.0.0 benchmark.

### Improvements

- Specific: Filtering by one or more control filters returns Compliance Reports with only the specified controls.

### Bug fixes

- Less is More: Selecting the last day of the year on the *Compliance Reports* date filter no longer shows all data for the entire year.
- How Stimulating: You may notice fixes for various minor display issues, which previously required refreshing the web browser to display properly.
- Only the Guest List: The compliance profiles for CIS Azure Foundations v1.1.0 have a performance fix to control 1.3 that limits the query of AD users to only Guest users.
- Full Report: Exported reports from the *Client Runs* page now includes full results, and matches the displayed results on the *Client Runs* page.
- Enforced: You can now select `policy_name` as a filter in *Compliance Reports* page.
- Dedupe: Adding an `aws-ec2` integration no longer creates duplicate node records as Chef Automate now recognizes nodes already reported by `chef-client`.

### Beta Features

#### Applications

- More API Docs: We added Applications-related [API docs](https://automate.chef.io/docs/api/) for [Service Groups and Services](https://automate.chef.io/docs/api/#tag/service_groups) and for [Service Management](https://automate.chef.io/docs/api/#tag/retention).
- New Option: Filter service groups and services by disconnected status.
- No More Switch: We removed the backend feature flag for the Applications Dashboard.

#### Identity and Access Management v2

- Required Conditions: A project now needs to have zero ingest rules and be up-to-date in order to be deleted.
- Better: Fixed a bug that caused errors to display poorly when adding users to teams or adding members to policies.
- Accurate: Experience improved progress percentage calculation for project updates.
- As Is: Underscores no longer change to hyphens when using the UI to create IDs for teams, tokens, and projects.
- Correct Terminology: IAM-related error messages now use "members" instead of "subjects" to align with [IAM v2](https://automate.chef.io/docs/iam-v2-overview/#members-and-policies).

## Chef Automate 20191211163405

Released on December 16, 2019

### New features

- Groundwork: We added some initial back-end and API support for Chef InSpec Waivers with more work to continue in the new year.

### Improvements

- Level Up: Chef Automate now uses Habitat 0.90.6, ElasticSearch 6.8.3, and OpenJDK 11.
- Whack-a-mole: We resolved a few vulnerabilities that popped up from our periodic `npm audit`. (No actual moles were harmed.)
- No Dawdling: Purges will now fail if each step of the purge doesn't happen within 10 minutes of scheduled execution.
- Bite-sized: Compliance profiles now have server-side filtering and pagination! To maintain backward compatibility, only requests with the `per_page` parameter set to a non-default value, other than zero, will be paginated.
- All the Metadata!: Client Run and Compliance Node detail views now display more metadata.
- What's Up, Doc?: The [API docs](https://automate.chef.io/docs/api/) feature a new section on our authentication header format, which follows the OpenAPI specifications for security definition objects.

### Bug fixes

- Desensitized: The system now tolerates the final virgule in file paths, such as `/path/to/backupid/`. Previously, when passing a file path for backup purposes, only file paths with the last `/` removed would work, such as `/path/to/backupid`.
- Rock On: We changed our configuration to avoid a low `DefaultMaxTasks` constraint for users on SUSE Linux Enterprise Server (SLES). Chef Automate failures with the error message "fork rejected by pids controller" should no longer appear.
- Restored: Input styles on a random assortment of input fields resumed their normal, happy, and uniform styles after recent layout updates.
- Working...: Menus in the top navigation no longer display behind the progress spinner overlay.
- Permanent Marker: Users may no longer edit the name or tags on ingested nodes, or nodes with no manager, but other ingested nodes fields may be edited.
- Noted: Clean up of the scanning functionality ensures that errors, when they exist, are always reported.

### Beta Features

#### Applications

- API It Up: The output of Habitat health checks is now exposed with the Applications APIs.
- Expected Behavior: Selecting a health status filter with zero services in the *Service Group* Details sidebar no longer causes a new service group to be selected.
- Steady: Selecting a new health status filter on the *Service Group* table will only change the *Service Group* Details sidebar if the new health status filter results don't include the currently selected Service Group.
- Reversed: The *Service Groups* display used to switch current and previous health statuses when generating messages about health status changes, but we fixed this.
- Keep It Simple: Note a small performance improvement by avoiding a double fetch of data.

#### Identity and Access Management v2

- Speedy: Experience a substantially faster loading of the *Projects List* page, since we removed a network call for each project.
- Re-ordered: The percentage done display now progresses correctly after selecting the *Update Projects* button. Previously, the percentage done display would sometimes start at 100% and then quickly reset due to a minor race condition.
- Stand Still: The *Global Project Filter* no longer auto refreshes its project list while you select your projects. Previously, users lost their selection due to the periodic auto refresh of the displayed project list.

## Chef Automate 20191129172405

Released on December 9, 2019

### New features

- Knowledge is Power: [API docs](https://automate.chef.io/docs/api) are live! Expect to see more documentation being added over the next few months.
- New API endpoint: Export all historical reports for a node!
- The Latest: Chef InSpec profiles for new Security Technical Implementation Guides (STIGs) are now available:

  - RHEL 6 V1R25
  - RHEL 7 V2R5
  - Windows 2012 and 2012 R2 (member server) V2R17
  - Windows Server 2016 V1R11
- Ready: Check out our Chef InSpec profile for the CIS Debian Linux 9 v1.0.0 benchmark.

### Improvements

- Time Alignment: Experience improved labeling and adjusted UTC time display when selecting dates in Calendar displays and adding a new Schedule for Scan Jobs.
- Keeping Tabs: A http `/status` endpoint is now available for monitoring a Chef Automate installation.
- Quick: Authorization-related pages in the Chef Automate display will load much faster.
- Compact: Compliance-related page displays now use the 3-dot control menu to improve the experience on smaller screens.
- Synced: Event Feed now displays all dates and times in UTC.
- Exit: Users now have the ability to sign out if their license has expired.
- Nothing Here: Filter by a control tag that doesn't have any value in the Compliance Reports display.
- Geography: Allow users to specify a default region to use when accessing the AWS API with an AWS Node Integration.

### Bug fixes

- Corrected: Fixed an issue with control 4.1.6 in the CIS Ubuntu 18.04 compliance profile.
- Fitting: Control 1.4.3 in the CIS CentOS 7 compliance profile will match either `/usr/sbin/sulogin` or `/sbin/sulogin` now.
- Exam: Control 4.1.12 in the CIS CentOS 7 compliance profile now correctly tests `auditd` entries.
- Boundaries Set: The compliance profile for CIS OSX 10.13 v1.0.0 no longer attempts to pull Chef InSpec resource code from GitHub.
- Massive Edit: Compliance export fields with more than 32,000 characters in a cell will be truncated to avoid Excel reading errors.

### Known Issues

- In the Future: Formatting issues with the Profile Search input and Node Integration Create/Edit inputs will be resolved in the next release.

### Beta Features

#### Applications

- Organized: The newly refactored Applications API allows for consistency.
- No More: The disconnected service CLI command is deleted.
- Magic: We resolved the timewizard filtering bug.
- Moved: You may noticed that we updated the Applications URL paths with our move away from beta.

#### Identity and Access Management v2

- In An Instant: When creating a new project, owner, editor, and viewer policies are now automatically created.
- Divine Design: it's now possible to [configure the project limit](https://automate.chef.io/docs/iam-v2-guide/#configuring-project-limit).
- At Once: Custom roles may now be deleted directly from the UI.
- Squashed: Fixed bug that prevented email addresses from being used when adding member expressions in the UI.

## Chef Automate 20191104205453

Released on November 12, 2019

### Improvements

- Adjustable: The default worker count for Scan Job workers will now be calculated based on available CPU. The new default is now equal to the number of CPUs plus two, so the minimum worker count is 2 and the maximum worker count is 10. Previously, the default was 10 unless user-configured otherwise.

### Beta Updates

#### Applications

- Squashed: Resolved bug where disconnected services weren't reconnecting despite sending a new health check message.

## Chef Automate 20191030224959

Released on November 4, 2019

### New features

- Resourceful: IAM v2 Beta now includes resource-scoped access! We added resource-scoped access to the role-based access already present in Beta. Resource-scoped access allows you to create projects. When combined with policies, these projects refine your permissions around API Tokens, Teams, Roles, Policies, and ingested client run nodes and compliance nodes. Users with access to multiple projects can filter their view directly in the top navigation. Check out the updated [IAM v2 user guide](https://automate.chef.io/docs/iam-v2-guide/) to learn more about our new features.

### Improvements

- Not Nothing: Within the API, you can now filter for an empty control tag value by requesting values with an empty string. This improvement will be expanded to the user interface (UI) in the near future.

### Bug fixes

- Cited Sources: References on controls are now being read in correctly in Elasticsearch and are included on the full compliance report. References should be objects with a "ref" key/value, and a "uri" or "url" key/value. Anything not adhering to these standards will be ignored.
- Time Travel: We resolved an issue on the Client Runs node history where all runs were listed as "a few seconds ago". This field represents the duration of the run, which now has been updated for clarity.

## Chef Automate 20191024135531

Released on October 28, 2019

### New features

- Historical Record: A new API endpoint exists to download historical reports for a Client Runs node, and respects time filters.

### Improvements

- Capital: Filter suggestions on the *Client Runs* page now display names with accurate casing.
- All Summed Up: The Controls tab on *Compliance Reports* page now shows the total amount of controls in the tab header.

### Bug fixes

- Making Reality Happen: A bug caused some displays of local time to be labeled as UTC, but now the time correctly displays in UTC time.
- Camouflage: We resolved a bug that caused nodes in the *Client Runs* page to not display their attributes.

## Chef Automate 20191015190829

Released on October 21, 2019

### New features

- Know More: Check out the newly added Controls List tab in the *Compliance Reports* page! Currently, you can view up to 100 controls at a time. Use the search bar filters, including control tag filters, to narrow down the list. We plan to expand the number of viewable controls to the total controls count in the near future.

### Bug fixes

- Lens Fix: Resolved a bug where viewing Scan Results from the *Profile Details* view didn't correctly apply the control filter and distorted the status results.

## Chef Automate 20191007115919

Released on October 14, 2019

### Improvements

- Reset the Clock: The *API Tokens*, *Node Credentials*, and *Node Integrations* pages have been updated to follow our new standard for date/time values, such as `Wed, 03 Jul 2019 17:08:53 UTC`.
- Enhanced: Wildcard search on the *Compliance Reports* page now supports full platform and full profile searches, so now you can search with the version number included.
- Specific: Compliance Reports, whether viewed with download, scan results, or node details, will now only include controls matching the specified control tag filters when a control tag filter is applied.
- Quality: The compliance profiles for STIG RHEL 7 now feature Code Compliance Inspector (CCI) reference tags.
- More Control: The compliance profiles for STIG Windows Server 2019 now include control SV-103097r1 implemented.

### Bug fixes

- Logical: Compliance profiles for STIG Windows 2016 incorporates a fix for the test logic in control SV-88161r1.
- Rational: Compliance profiles for STIG RHEL7 V2R2 contains a fix for the test logic in control SV-86609r2.

## Chef Automate 20191001203421

Released on October 7, 2019

### New features

- Copy & Paste: Compliance Reports now saves the selected filters in the URL, which means a copied URL from Compliance Reports will reflect your applied filters!
- Time Scale: You can now use the trend graph in Compliance Reports to select a date for the calendar filter. Simply find the preferred date on the trend graph, click, and watch the page update with the new date filter!
- Try It Out: The Compliance Reports bubble graphs are now interactive! Click on one of the bubbles to apply the desired filter to the report.
- Sorted: You can now filter by control tag in the Compliance Reports UI! We appreciate your patience with this new functionality as we continue to squash some small bugs.
- New Entry: A new API endpoint is available for listing controls in compliance reporting with `a2-url/compliance/reporting/controls`
- More!: Check out our new compliance profiles:

  - CIS Apple MacOS 10.13 v1.0.0
  - STIG Windows Server 2019 V1R1

### Improvements

- Consistency: Entering an invalid URL will now redirect users to the *Event Feed* page.
- New, Yet the Same: The Compliance Reports search bar has been updated to use "Chef Organization" and "Chef Tag" instead of "Organization" and "Chef Tags," which is consistent with the *Client Runs* search bar.
- Are You Sure?: When deleting a node credential, a confirmation dialog box will appear before executing the delete query.
- We're sure: Release manifest signatures are verified during installation and upgrade.

### Bug fixes

- Export Options: Chef tags are now exported in the Client Runs JSON export!
- Ancient History: The Client Runs Run History panel no longer closes when filtering by date.
- Improvement: Fixed several controls in the CIS Windows Server 2016 v1.1.0 compliance profile where REG_MULTI_SZ registry keys weren't being correctly tested.
- Squashed: Resolved a bug where stale user membership data would load briefly on the *Team Details* page.
- Uncovered: Long profile titles and descriptions are no longer partially covered by action buttons.
- Time Travel: Fixed an issue in Compliance Reports where clicking on a day in the previous or next month on the calendar widget incorrectly selected that day in the currently selected month.
- Picture Perfect: Fixed a bug in restoring an Elasticsearch snapshot with many indices.
- Stay With the Plan: Fixed a bug in executing data lifecycle scheduled jobs.

## Chef Automate 20190904132002

Released on September 9, 2019

### New features

- New!: Check out the now available compliance profiles for CIS MacOS 10.13 v1.0.0.
- Level Up: Compliance profiles for CIS AWS v1.0.0 now provide both a Level 1 and Level 2 profile, and supersedes the previously released "Foundations" profile, which is no longer available in the *Profiles* page.

### Improvements

- Solid: Dex, part of Chef Automate's authentication system, now uses a more secure set of TLS ciphers.

### Bug fixes

- Sorted: Within the compliance reports' *Nodes* tab, the Platform column now correctly sorts by both platform name and platform version.
- Out of Order: For the CIS Windows 2016 v1.1.0 compliance profile, we fixed a bug where the security policy controls depended on a specific ordering of results when the ordering isn't significant.
- In Line: We matched CIS's recommendations by fixing the following compliance profiles:

  - CIS RHEL 7 v2.2.0 compliance profile now has the expected result of control 4.1.12 and doesn't expect the option `-S all`
  - CIS Ubuntu 18.04 compliance profile features fixed logic in control 4.1.7
- Render: We corrected the metadata for STIG compliance profiles, so that they use valid SemVer version strings.

### Backward incompatibilities

- The `data-lifecycle-service` component has been removed. Data retention is now configured on a per-service and per-policy basis though remote procedure calls to individual services. During the upgrade to this version, any configured service retention settings will be migrated as is. After the upgrade has completed, configuration of data retention with `chef-automate config` will no longer be supported. See the [data retention documentation for more information](https://automate.chef.io/docs/configuration/#data-retention) on configuring retention policies.
- After the upgrade to this version, the following configuration keys won't be accepted:

  - compliance.v1.sys.retention.compliance_report_days
  - event_feed_service.v1.sys.service.purge_event_feed_after_days
  - ingest.v1.sys.service.purge_converge_history_after_days
  - ingest.v1.sys.service.purge_actions_after_days
  - data_lifecycle

## Chef Automate 20190827222442

Released on September 3, 2019

### Bug fixes

- Unblocked: Fixed results that were incorrectly reported as zero when filtering by scan job or profile event type in the Event Feed.
- All Clear: Solved a bug where long certificate chains for external PostgreSQL might be erroneously rejected.
- Decreased Static: Reduced some cases where PostgreSQL connection closings resulted in noisy log messages.

## Chef Automate 20190820163418

Released on August 26, 2019

### Improvements

- Bumped: We updated the InSpec version included with Automate to version 4.12.0.

### Bug fixes

- Searching for Something: We now prevent empty string suggestions from being returned for the 'Error Message' filter type in the Client Runs search.
- No Detours: Clicking on a past Chef Infra run from Run History would incorrectly navigate the user back to the Client Runs nodes list rather than the Node Details page, but no longer!

## Chef Automate 20190813170406

Released on August 19, 2019

### New features

- Why Not Both?: You can now configure Automate to use both LDAP and SAML, rather than choosing between the two. You're now able to choose up to one provider each for both LDAP and SAML.

### Improvements

- Top Navigation Changes: *Event Feed* moved to under the *Dashboards* tab, and *Client Runs* relocated to under the *Infrastructure* tab.
- Better Fit: Chef Server Organization and Chef Server filters have been moved from the left-navigation menu to the on-page filter box for both the *Event Feed* and *Client Runs* pages. This change allows you to filter by multiple Server Organizations and Servers, and also to share and bookmark page URLs with filters still applied.
- More Sorting: We added a filter box to the *Event Feed* page with options to filter by Chef Server Organization, Chef Server, and Event Type.
- Status Check: The Nodes display under the Compliance tab now features filter buttons for *Failed*, *Passed*, and *Skipped* states.
- Key Point: We improved keyboard accessibility on the Chef Automate Sign In page.

### Bug fixes

- Resolved: We fixed an UI failure for older browsers without native `customElements` support.
- Corrected: The "Mark Nodes Missing" data lifecycle job no longer runs with the wrong threshold.

## Chef Automate 20190806202030

Released on August 12, 2019

### Improvements

- Teamwork: Look for an improved experience when managing local teams and their users.

### Bug fixes

- Bugs Done-y: Periodic "Apply Rules" backend calls would return 403 errors for most users on IAM v1, but this no longer happens.
- Don't Be Buggin': When migrating compliance data in ElasticSearch, incomplete reports are now skipped, which prevents service failures.

## Chef Automate 20190729085402

Released on August 5, 2019

### New features

- Login with SAML: You can now configure the `name ID policy format` to use. When left untouched, `name ID policy format` still defaults to `urn:oasis:names:tc:SAML:2.0:nameid-format:persistent`. Please consult the documentation for the [list of accepted values](https://automate.chef.io/docs/configuration/#saml).
- Check It Out: The following compliance profiles are now available:

  - CIS Apple OSX 10.12, v1.0.0
  - CIS Apple OSX 10.11, v1.1.0
  - CIS Apple OSX 10.10, v1.2.0
  - CIS Apple OSX 10.9, v1.3.0
  - CIS Apple OSX 10.8, v1.3.0
  - CIS Apple OSX 10.6, v1.0.0
  - CIS Apple OSX 10.5, v1.1.0
  - CIS Ubuntu 18.04 LTS, v1.0.0

### Improvements

- Clear Your Mind: We removed the shadows from the top and left navigation menus to make Chef Automate easier on your eyes.
- New Version: Chef InSpec has been upgraded to version 4.7.18.
- Even More Suggestions: We increased the maximum number of suggestions on the *Compliance* page's search bar to 100.
- Better Sorting: We made improvements on how local users are filtered in the following Windows profiles:

  - CIS Microsoft Windows Server 2016, v1.1.0
  - CIS Microsoft Windows Server 2016, v1.0.0
  - CIS Microsoft Windows Server 2012, v2.0.1
  - CIS Microsoft Windows Server 2012 R2, v2.3.0
  - CIS Microsoft Windows Server 2012 R2, v2.2.1
  - STIG Microsoft Windows Server 2016, v001.009
  - STIG Microsoft Windows Server 2016, v001.006

### Bug fixes

- Found: Our recent fix addresses some suggested values missing from the *Compliance* page's search bar.
- Getting Through: We squashed a bug where notifications weren't being sent for some custom InSpec profiles.
- No More Annoying Boxes: We turned off browser form autocompletion for both the *Client Runs* and *Compliance* pages' search bars to save some sanity when entering a search filter.

## Chef Automate 20190722200451

Released on July 29, 2019

### Upgrade Impact

ICYMI: If you are upgrading from a version prior to 20190410001346, please read our [Important Compliance Outage Announcement](https://discourse.chef.io/t/important-compliance-outage-information-on-automate-2-april-15th-upgrade/14909).

### Improvements

- Consistency: The updated Compliance search bar now displays the same look as the Client Runs search bar.
- Parallelize This!: Experience performance improvements for multi-ElasticSearch node setups when ingesting a high load of Chef Infra reports.
- Profile Updates: The CIS RHEL 7 v2.2.0 and CIS Ubuntu 18.04 v1.0.0 compliance profiles feature numerous improvements. Changes include code readability improvements, and updates to the control logic that ensures controls pass and fail correctly for certain edge cases.

### Bug fixes

- May I Suggest?: The Clients Runs search bar now will list all suggested cookbooks rather than limiting results when the suggested values exceeded 100 items.

## Chef Automate 20190717161024

Released on July 22, 2019

### Upgrade Impact

ICYMI: If you are upgrading from a version prior to 20190410001346, please read our [Important Compliance Outage Announcement](https://discourse.chef.io/t/important-compliance-outage-information-on-automate-2-april-15th-upgrade/14909).

### Improvements

- Easily Read: We've improved the readability of the CIS RHEL and Ubuntu compliance profiles.
- Check It Out: CIS Ubuntu 16.04 v1.0.0 compliance profile features a number of fixes and improvements.
- Keeps Going: `chef-automate airgap bundle create` now retries failed downloads of Habitat artifacts.
- Security Detail: Our default cipher suite configuration no longer includes CBC-mode ciphers.
- Default Try: `chef-automate backup restore` will attempt to restore the latest backup if no backup ID is given.

### Bug fixes

- That's Not My Name: Fixed an incorrect variable name in control SV-86877r3 of the STIG RHEL7 v002.003 compliance profile.
- No More Mr. Mice Guy: `chef-automate stop` no longer hangs due to a bug.
- Hugs not Bugs: A bug, related to HTTP_PROXY support in data-feed-service, previously prevented Automate from starting in some configurations, but we fixed that.

## Chef Automate 20190711110747

Released on July 15, 2019

### Upgrade Impact

ICYMI: If you are upgrading from a version prior to 20190410001346, please read our [Important Compliance Outage Announcement](https://discourse.chef.io/t/important-compliance-outage-information-on-automate-2-april-15th-upgrade/14909).

### New features

- You Get a Compliance Update!: Compliance profiles are now available for the following platforms and versions:

  - STIG Red Hat Enterprise Linux 7, v2.2 (Cat 1, 2, and 3)
  - STIG Red Hat Enterprise Linux 7, v002.003 (Cat 1, 2, and 3)
  - STIG Red Hat Enterprise Linux 6, v001.023 (Cat 1, 2, and 3)
  - STIG Microsoft Windows Server 2012/2012 R2 MS, v002.015
  - STIG Microsoft Windows Server 2016, v001.009

### Improvements

- Filled In: An array of each profile's basic metadata - name, version, sha, status - will now be included as part of each node entry, and available to retrieve with API.
- Adjust as Needed: Each maximum number of bundled Chef Client Runs (CCR) and Chef server action messages during ingestion now can be configured in Automate.

### Bug fixes

- Character Trouble: Duplicate node names with uppercase characters no longer cause the Client Runs export functionality to go into an infinite loop.

## Chef Automate 20190628200755

Released on July 1, 2019

### Upgrade Impact

ICYMI: If you are upgrading from a version prior to 20190410001346, please read our [Important Compliance Outage Announcement](https://discourse.chef.io/t/important-compliance-outage-information-on-automate-2-april-15th-upgrade/14909).

### Improvements

- In Detail: Client Run CSV export now includes the error message for failed runs.
- Independent of Shift: Compliance Reports wildcard searching is now case-insensitive.
- Search Improvement: Search and filter by InSpec version in Compliance Reports search.
- Easy on The Eye: JSON export for Compliance features properly formatted JSON.
- Beautify: Appending `?pretty` to most API endpoints now returns a pretty-printed JSON response.
- From the Top: The Compliance export endpoint now respects start time.
- New Endpoint: `/compliance/reporting/report-ids` returns a list of report IDs, and isn't limited by the Elasticsearch 10,000 pagination issue.

### Bug fixes

- Which One?: Notifications for client run failures no longer [incorrectly identifies the failing cookbook when using the `ignore_failure` property](https://github.com/chef/automate/issues/529).
- Stay Awhile: Users logging in with SAML won't be kicked out after 1 minute.
- No Mass Effect: Editing tags on one node added with bulk add resulted in [other nodes' tags being modified](https://github.com/chef/automate/issues/600), but we worked it out.

## Chef Automate 20190617144820

Released on June 24, 2019

### Upgrade Impact

ICYMI: If you are upgrading from a version prior to 20190410001346, please read our [Important Compliance Outage Announcement](https://discourse.chef.io/t/important-compliance-outage-information-on-automate-2-april-15th-upgrade/14909).

### New features

- Not a Random Search: Compliance Reports search now features wildcard searching, which is currently case-sensitive.

### Bug fixes

- Multiply: Chef Automate no longer chronically logs out when multiple tabs are open.

## Chef Automate 20190610211245

Released on June 17, 2019

### Upgrade Impact

ICYMI: If you are upgrading from a version prior to 20190410001346, please read our [Important Compliance Outage Announcement](https://discourse.chef.io/t/important-compliance-outage-information-on-automate-2-april-15th-upgrade/14909).

### New features

- Detect Easier: Search by common error message on the *Client Runs* page to find which nodes are failing in the same way.
- Compliance Updates, Part One: Compliance profiles for STIG Red Hat Enterprise Linux 6 v1.22 (Cat 1, 2, and 3) are now available.
- Compliance Updates, Part Two: Compliance profiles for STIG Windows Server 2012 / 2012 R2 Member Server v2.14 (Cat 1, 2, and 3) are now available.

### Improvements

- Spelled Out: User Menu and CLI have been updated to include the major version number of Automate (2) alongside the build number.

## Chef Automate 20190605190944

Released on June 10, 2019

### Upgrade Impact

ICYMI: If you are upgrading from a version prior to 20190410001346, please read our [Important Compliance Outage Announcement](https://discourse.chef.io/t/important-compliance-outage-information-on-automate-2-april-15th-upgrade/14909).

### New features

- New API support: Upon ingestion of a report from Chef Infra or Chef InSpec, metadata information about the node and status of the report will be sent to the `nodes` API. Make API calls to the `api/v0/nodes/search` endpoint to find out which of your nodes passed their penultimate scan and failed the most recent one. The same can be done for the ccr status, and filters can be combined. See the [Nodes API documentation](https://automate.chef.io/docs/nodes/) for more information and examples.

### Improvements

- The Feature Formerly Known As: The *Asset Store* page is now known as the *Profiles* page in Automate and its documentation.
- Change of Address: The following pages and their paths now appear under the expanded **Compliance** tab in the top navigation bar:

  - Reports - compliance/reports
  - Scan Jobs - compliance/scan-jobs
  - Profiles - compliance/compliance-profiles
- Bam!: New nodes can now be added directly from *Node Integration* page under the **Settings** tab.
- Search Expansion: New fields were added to the Compliance Report search:

  - Chef-server
  - Organization
  - Chef tags
  - Policy group
  - Policy name
- No More Magnifying Glass: The *Event Feed* page features larger text sizes for better readability.
- Customize Notifications: Specify to only send ServiceNow InSpec scan failure notifications for critical control failures.
- Search Multiplier: Filter nodes for a scan job using multiple tag key/value selections.
- Error Feedback: If a report is too large to be ingested, the scan job will now fail and send an error message.
- Narrow Down: Suggestions that appear in the Client Runs search bar are filtered to only show values from the nodes currently visible on the page.
- Name Tags Not Required: Nodes added without a name with cloud integrations will now use their ids instead.

### Bug fixes

- Replaced Filter: Wildcard filters of the same type in the Client Runs search bar are now treated as 'OR' filters.
- Keep It Simple: Compliance will now use one ElasticSearch connection per compliance-service instance. By reducing the number of sockets being managed, this solves a problem of receiving `couldn't get elastic connection` errors in Compliance.
- In Order: Search bar types under the *Client Runs* page are now sorted alphabetically.

## Chef Automate 20190513175357

Released on May 28, 2019

### Upgrade Impact

ICYMI: If you are upgrading from a version prior to 20190410001346, please read our [Important Compliance Outage Announcement](https://discourse.chef.io/t/important-compliance-outage-information-on-automate-2-april-15th-upgrade/14909).

### New features

- Expanded Forecast: Test your Azure configuration with API scanning, and scan the nodes in your Azure cloud account with Azure VM scanning. You can also test your Google Cloud Platform nodes with API scanning.
- Improved Inspection: The *Node Details* page in Compliance includes the ability to show InSpec version.

### Improvements

- Please Excuse Our Dust: The user menu in the top navigation bar features design consistency and accessibility improvements.

### Bug fixes

- Refreshing: A node rerun no longer results in a `No ssm plugin found for train` error.
- Analyze This!: Better error handling exists for remote (ssm) scan jobs.

## Chef Automate 20190506101326

Released on May 13, 2019

### Upgrade Impact

ICYMI: If you are upgrading from a version prior to 20190410001346, please read our [Important Compliance Outage Announcement](https://discourse.chef.io/t/important-compliance-outage-information-on-automate-2-april-15th-upgrade/14909).

### Bug fixes

- Token of Our Appreciation: You won't see the error message, `The security token included in the request is invalid`, when running the CIS AWS profile as a scan job in Automate and using only an AWS access key id and secret.
- Won't Leave You Hanging: Quickly running sequential backups no longer results in the backup process freezing.

## Chef Automate 20190501153509

Released on May 6, 2019

### Upgrade Impact

ICYMI: If you are upgrading from a version prior to 20190410001346, please read our [important announcement](https://discourse.chef.io/t/important-compliance-outage-information-on-automate-2-april-15th-upgrade/14909).

### Improvements

- More Time(stamps): Scan Results Nodes list, viewable from the Compliance Reporting Profiles, now displays in descending order of `end_time` and shows when it was scanned in the Scan Results view.
- CAPS LOCK ON: Case-insensitive search is available when using the Asset Store search functionality.
- Hello, My Name Is: Names are now one of the available tags for filtering Azure-VM nodes when creating a scan job.
- Customize This!: Any default configuration value for the Microsoft Active Directory (MSAD) integration now can be overridden without using the generic LDAP adapter as a workaround.
- Improved Control and Handling: The compliance profiles for STIG RHEL 7 V2R1 have two additional controls (SV-86587r4 and SV-95719r1) implemented. These controls previously resulted in a "skipped" result.

### Bug fixes

- Cleared Up: Sorting by control failures in the Compliance Reporting Nodes list view previously would cause a 400 issue.
- Set Right: The overview page for skipped nodes in Compliance Reporting has more consistent statuses.
- No Red Flags: The applications-service will now start when a feature flag isn't enabled on the upstream events-service.

## Chef Automate 20190422213145

Released on April 29, 2019

### Upgrade Impact

If you are upgrading from a version prior to 20190410001346, please read our [important announcement](https://discourse.chef.io/t/important-compliance-outage-information-on-automate-2-april-15th-upgrade/14909).

### Announcements

Upgrade Today! The release of the [7.5.0 Audit cookbook](https://supermarket.chef.io/cookbooks/audit) brings new features for Automate. Use a version > 7.5.0 of the Audit cookbook with Automate to enable population of IP Address and FQDN fields for JSON and CSV reports in Compliance Reporting.

## Chef Automate 20190415203801

Released on April 22, 2019

### Upgrade Impact

If you are upgrading from a version prior to 20190410001346, please read our [important announcement](https://discourse.chef.io/t/important-compliance-outage-information-on-automate-2-april-15th-upgrade/14909).

### New features

- Deep Filtering: View the state of your infrastructure with the Compliance tab from the perspective of a single profile, or a single profile and one of its child controls.
- Compliance Improvements: Compliance profiles for CIS Windows Server 2016 v1.1.0 (Domain Controller and Member Server) are now available in the Asset Store. In addition to the standard Level 1 and Level 2 profiles, we also include CIS's newly defined Next Generation Windows Security profiles, an optional compliance standard to be used in addition to Level 1 or Level 2.

### Improvements

- Skipped Profiles under Compliance Reporting node details got a refresh! You will now see the bolded name of the profile first, followed by the skip message from InSpec if one exists.

### Bug fixes

- Many Happy Returns: Previously, a scan job node read would fail with a 500 error if the credential was deleted. We now return the node object, regardless of the state of its associated credentials.
- On the Button: The report button will only appear on the actual scans list for a recurring job, rather than erroneously for a completed recurring job.
- Compliance Fix: Control 2.2.1.3 of the CIS CentOS 7 v2.2.0 compliance profile no longer depends on a `/etc/sysconfig/ntpd` file that doesn't exist on all systems and isn't required by CIS's specification.

## Chef Automate 20190410001346

Released on April 16, 2019

### Upgrade Impact

We're preparing the way for two great new features in Chef Automate---deep filtering in Compliance reporting and IAM v2 Beta. We're making changes to the format for compliance results, which means that we're migrating your compliance results to the new format.
For most users, this migration will happen quickly and in the background. However, if your system has tens of gigabytes of compliance results for the current day, the migration may take hours.

#### Migration Process

We'll migrate your current day's compliance data first, and then migrate your earlier compliance data.

We're making some systems unresponsive during the current day data migration, in order to protect your data's integrity. Once the migration for the current day's data finishes, these systems will operate normally. You'll  be able to use all of Chef Automate while we migrate your earlier compliance data.

During the current day's data migration:

- Compliance APIs and UI (Compliance page, Scan Jobs, Asset Store) won't be responsive
- Scan jobs and incoming scan reports (from audit cookbook or inspec exec) won't be processed

We're promoting this release to Automate's "current" channel---which means this upgrade goes live---at 00:01am UTC (5:01 PM PDT).
For customers who have automatic upgrades enabled, this should reduce the amount of time needed for the data migration, because you should have very little data in the current day's results.
We recommend that customers without auto upgrades configured run their manual upgrades upgrade at 00:01 UTC, or shortly thereafter, in order to minimize their downtime.

#### Upgrading manually

If your Chef Automate installation isn't configured for auto upgrades, you will need to upgrade manually.
We recommend that you run your manual upgrade at 00:01 UTC or shortly after to minimize downtime.

During the current day's data migration:

- Compliance APIs and UI (Compliance page, Scan Jobs, Asset Store) won't be responsive
- Scan jobs and incoming scan reports (from audit cookbook or inspec exec) won't be processed

Your chef-client runs will be unaffected by the data migration and you will have access to the Event Feed, Client Runs and Settings UI.

The length of time that your system is impacted by the data migration is determined solely by the amount of data in the current date and the throughput allocated (CPU, IO, etc.) to your environment. Additionally, you may see a performance impact while older data is migrated to the new format, depending on your hardware profile and the resources assigned to the various Automate services.

We recommend taking the following steps to ensure a painless experience:

1. Ensure that your system has an appropriate amount of heap memory assigned to Elasticsearch: <https://automate.chef.io/docs/configuration/#setting-elasticsearch-heap>
2. Schedule the upgrade as close to 00:01 UTC as possible to reduce the amount of data in the current day.
3. Test the upgrade in a non-production environment prior to upgrading if you have more than a few GBs of data. Monitor your resource consumption to ensure you have enough throughput and, if necessary, allocate more resources to minimize the impact to your system.
4. Disable other resource intensive processes (such as backups, re-indexing, etc.) during the upgrade, or schedule them run at different time before or after the upgrade
5. If you have problems with this upgrade, contact support for help: <https://www.chef.io/support/get-started/>

### New features

- Zoom and Enhance: New Detail View for Node Manager is now available. Navigating to a node manager's detail view will display its status and a list of the nodes that belong to that node manager.

### Improvements

- Easier to ID: Client run exports now include an IP address column.
- R-E-S-P-E-C-T: Compliance suggestions now show results that match with your selected filter.
- Make it Better, Do it Faster: We changed the controls in the CIS Windows Server 2012R2 V2.2.1 compliance profiles to be faster and have less load on domain controller instances.

### Bug fixes

- Once, Mice, Three Times an Exterminator: Fixed a number of controls in the CIS CentOS 7 v2.2.0 compliance profile:

  - Controls that check home directories now correctly exclude system accounts
  - Controls are now correctly marked as passed when previously marked as skipped in 6.2.10 and 6.2.13
  - Control in 6.2.10 now accounts for symlinks and directories starting with a `.` character
- On Time: The compliance profiles for CIS Windows 2012, 2012R2, and 2016 should now expect a value in seconds for `user lockout duration` rather than minutes.

## Chef Automate 20190325233053

Released on April 1, 2019

### New features

- Work It!: Existing Workflow users have access to the Workflow dashboard and tools in Chef Automate.
- Switch It!: Toggle `chef-automate maintenance [on|off]` to use the new load balancer maintenance configuration option. When in maintenance mode, the load balancer serves an HTTP 503 error page, which is helpful to some users (Lookin' at you, OWCA friends) keep their data safe during a maintenance window.

### Improvements

- Check It!: Rewrote controls in the CIS Windows Server 2012R2 V2.2.1 and STIG Windows 2016 compliance profiles, so they execute faster and with loads on the target system. Domain Controller instances with large numbers of users and groups should see improvement and particular benefits with these changes.
- Find It!: Find more with less using the improved matching options for designating credentials for nodes from cloud integrations. When specifying tag key/value matches for your node integration nodes, we now support wildcard matching for:

  - suffix - `*foo`
  - prefix - `foo*`
  - contains - `*foo*`
  - exact - `foo`
- Tag It!: We've removed the restriction that prevented users from adding node tags with `:`, `*`, etc.
- Filter It!: We've added a prefix wildcard search  (`foo*`) for scan jobs for the Automate manager node names and AWS-EC2 integration tag value searches.

### Bug fixes

- Clean It!: We were a little too conservative in our package cleanup mode---cleaning up only the first in the list of candidate packages---now we will clean up the entire set of obsolete Automate-installed packages.
- Use It!: Node Integrations update fixed! You'll now use your most recent credentials after updating a node integration, rather than re-using the older credentials.
- Fail It!: Scan jobs without any nodes should fail noisily (instead of silently)!
- Log It!: CIS compliance profiles for Windows Server won't return a false negative for the EventLog Retention control when the registry setting on the target host is stored as the datatype `REG_DWORD`.
- Spell It!: Event feed incorrectly displayed "keies," but now displays "keys" when multiple client keys are updated.

## Chef Automate 20190304193624

Released on March 11, 2019

### Improvements

- On the Fast Track: We changed the CIS Windows Server 2012R2 V2.2.1, CIS Windows Server 2016 V1.0.0, and STIG Windows Server 2016 V001.006 compliance profiles controls to be faster and smaller on domain controller instances.
- A11y: Link colors across Automate are now consistent and accessible.
- Just So: Manually added nodes are now grouped under the Automate node manager.

## Chef Automate 20190225235742

Released on March 4, 2019

### New features

- Now in Stock: The Compliance Store has InSpec profiles for DISA STIGs (RHEL 7 V2R1 and Windows Server 2016 V1R6), which replace the earlier "preview" profiles. Each STIG profile (Cat I Only, Cat II, etc.,) has its own InSpec profile.

### Improvements

- Same Throughout: The *Asset Store* page in the Automate UI has an especially consistent design. Shout out to UX for keeping things awesome!
- Vroom, Vroom: The Chef Client run ingestion pipeline performs even better than before.

### Bug fixes

- Written in Stone: Automate changes permissions on files correctly, ending this source of exec errors.
- Restoration Work: Made the certificate permissions restore correctly, so Automate restore succeeds.
- Squashed!: We called the exterminator on a bug preventing the export of larger data sets from the *Client Runs* page.
- Sorted Out: The deprecations column on the *Client Runs* page sorts in the way you would expect.

## Chef Automate 20190207004055

Released on February 11, 2019

### New features

- Compliance Update: You'll find a new profile for CIS Amazon Linux 2 v1.0.0 in the Compliance Store.

### Improvements

- Try It Out: Switch between IAM v1 and [IAM v2 beta](https://blog.chef.io/2019/01/24/introducing-the-chef-automate-identity-access-management-version-two-iam-v2-beta/) without changing the `automate-gateway` setting called `auth_middleware`. Even if you do set it, Automate ignores it. See the [IAM v2 beta guide](https://automate.chef.io/docs/iam-v2-guide/) for details regarding IAM v2.
- How Many?: See the number of deprecations on any node in the deprecations column on the *Client Runs* page. Turn this feature on by selecting it in the column settings.
- My One And Only: Selecting a status in the scan job form highlights that--and only that--status.
- When One is Enough: Views with only one page won't show pagination.
- Uniform Appearance: Made the look and feel the same for the *Notifications*, *Node Integrations*, *Node Credentials*, *Node Lifecycle*, and *Event Feed* pages.
- Keep It Distinctive: Improved error messaging and user experience when trying to create an API Token with the same ID as another API Token.
- New and Improved: The preview compliance profiles for Redhat7 and Windows Server 2016 STIGs have a number of new rules implemented, as well as a number of corrections to the test logic of existing rules.

## Chef Automate 20190131011635

Released on February 4, 2019

### Improvements

- New Name, Same Awesome: The Admin page has been renamed to Settings.
- Where's Waldo?: Notifications, Node Credentials, and Node Integrations can all now be found in the newly named Settings page.
- Moved Around: General Settings is now called Node Lifecycle, and located under the newly named Settings page.
- Improved Compliance: The STIG RedHat 7 preview compliance profile includes:

  - SV-86555r2_rule (Existing passwords are restricted to a 60-day maximum lifetime.)
  - SV-86619r2_rule (Default permissions for authenticated users ensure the user can only read and modify their own files.)
  - SV-86627r2_rule (Group Identifiers (GIDs) referenced in /etc/passwd are defined in the /etc/group.)
  - SV-86747r4_rule (Audit all uses of the creat syscall.)
  - SV-86749r4_rule (Audit all uses of the open syscall.)
  - SV-86751r4_rule (Audit all uses of the openat syscall.)
  - SV-86753r4_rule (Audit all uses of the open_by_handle_at syscall.)
  - SV-86755r4_rule (Audit all uses of the truncate syscall.)
  - SV-86757r4_rule (Audit all uses of the ftruncate syscall.)
  - SV-86795r6_rule (Audit all uses of the mount command and syscall.)
  - SV-86877r3_rule (SSH daemon must only use MACs employing FIPS 140-2 approved cryptographic hash algorithms.)
  - SV-86943r2_rule (System must not forward IPv6 source-routed packets.)

### Bug fixes

- Not the Silent Deep: `chef-automate backup delete` command no longer silently fails to delete backups.
- Clear-cutting: Internal request logs were being written to disk without log rotation. No more! Our fix cleans up any instances of these logs that have been left around.
- The Client-run Export now has:

  - Corrected behavior of Total Resource Count to provide correct values.
  - Removed fields that shouldn't be associated with a node.
- Clear Away: Node credential validation used to wrongly display an error, but we worked it out.
- Resolved: A Compliance report export error when exporting larger reports is now fixed.
- Can't Click That: Disabled buttons no longer act as clickable on mouse-over.

## Chef Automate 20190124232144

Released on January 28, 2019

### New features

- Client Runs: Search and filter by Chef tags! You'll see filter in the client runs search-bar.

### Improvements

- See What You Need: You'll only see the nodes that you added manually or through a cloud integration on the Scanner Nodes Page. You won't see all ingested compliance nodes.
- Sort & Report: When you filter a Compliance report by a control, that's what you'll get on your exported CSV or JSON.
- That's So Metadata: See the Chef Client version for each node in the nodes-list view by clicking the gear icon at top right of table and checking that checkbox.
- That's So Metadata: Navigate to the Chef Client run summary view and you'll find that we now display the chef-client version on the node as well as deprecations count.
- Improved Compliance: The STIG Windows Server 2016 preview compliance profile includes:

  - SV-87923r1_rule (Software certificate installation files must be removed from Windows Server 2016.)
  - SV-88287r1_rule (The built-in administrator account must be renamed.)
  - SV-88289r1_rule (The built-in guest account must be renamed.)
  - SV-88475r1_rule (The built-in guest account must be disabled.)
- Improved Compliance: The STIG RedHat 7 preview compliance profile includes:

  - SV-86551r2_rule (operating system must be configured so that passwords are restricted to a 24 hours/1 day minimum lifetime.)

### Bug fixes

- Inspec 1 Reports: Automate accepts reports generated with InSpec 1 as well as InSpec 2. Not to nag, but we'd still like you to update to the new InSpec, ASAP.
- There Can Only Be One: Prevent users from creating credentials with both a password and ssh key. Only one or the other should be included in a credential.

## Chef Automate 20190116225739

Released on January 22, 2019

### New features

- IAM v2 Beta: Open beta for Chef Automate's new identity and access management system! We've improved policies, with policy statements that allow fine-grained control and basic policy management from Chef Automate's user interface. We've also introduced roles, so you now have role-based access control (RBAC). Check out the [new IAM v2 beta guide](https://automate.chef.io/docs/iam-v2-guide/) to get started with our new features.
- Why not Both?: Download the Chef client nodes report in CSV and JSON formats from the Client Runs page. Try the search and filter tools to narrow down the list before downloading.

### Improvements

- Change your View: Customize your view of Client Runs by selecting the gear icon at the top right corner of the table.
- Now Loading: Added a loading state indicator to the Client Runs page.
- New Design, Same Modal: Revised design displays for the error logs modal on the node detail page.
- Music to Your Ears: We've improved the screen reader friendliness of our Admin page forms to declare each field label.
- Scanner Nodes: Added bulk creation and bulk deletion docs for the scanner nodes.
- Gather Logs: Now there's a snapshot of service metrics in the bundle created with `chef-automate gather-logs` to help the support team work even more effectively.
- Improved Compliance: The STIG Windows Server 2016 preview compliance profile includes:

  - SV-86487r3_rule (Standard Mandatory DoD Notice and Consent Banner)
  - SV-88287r1_rule (The built-in administrator account must be renamed.)
  - SV-88289r1_rule (The built-in guest account must be renamed.)
- Bam!: The compliance profile for CIS AWS Foundations v1.1.0 has control 2.4 'Ensure CloudTrail trails are integrated with CloudWatch Logs'.

### Bug fixes

- Deleted and Visible: Deleted scan job names and username appear on the Event Feed.
- Copy That: You may now copy a token from Automate UI on Firefox.
- Shhhhh: Use the new 'quiet' option on the resource `ignore_failure` field in Chef client runs.
- Final Countdown: Set context timeout on compliance ingestion calls, which rejects reports that can't be ingested because of a heavy load.
- Oops: Fixed the `Chef Automate <build version>` link to lead to the right release notes.
- Red Alert Repair: Fixed the preview compliance profiles for Windows 2016 STIG so that it stops yammering warnings about "constant already initialized".
- The compliance profile for CIS AWS Foundations v1.1.0 has:

  - a fix to control 1.24 - Now it only checks the 'AdministratorAccess' AWS-managed policy.
  - a fix to control 2.1 - Removed "name" for AWS Config config and delivery channel.
- Aristotle This!: Corrected the test logic on a number of Windows 2016 and RHEL 7 STIGs preview compliance profiles.
- Can I Quote That?: Added quote marks around supported RHEL releases in CIS RHEL compliance profiles, so the release value won't be interpreted as a number. This fixes profiles not running on, for example, RHEL 7.10.

### Backward incompatibilities

- Can I See Your ID, InSpec?: Report ingestion enforces InSpec 2.0.0 as the minimum supported version and rejects reports from anything underage. This circumvents a bug that could crash the service when processing reports with required, but missing, fields.

## Chef Automate 20181212095204

Released on December 17, 2018

### New features

- Terminated node cleanup: Terminating AWS nodes managed through the node manager integration also deletes the corresponding nodes on the client-runs page.
- Named Tokens: Create tokens with unique alphanumeric IDs, aka letters and numbers, from the API tokens page in the **Admin** tab. You don't have to do this, and if you don't name your token, we'll still generate a token automatically for you.
- Token Details: Every token has its own details page, where you can examine its details and change its name.

### Improvements

- Better Compliance Reporting: Chef Automate checks incoming compliance reports for valid node `uuid`s attached. Reports without valid node `uuid`s get rejected.
- Faster Compliance Reporting: We increased the number of threads so the service ingests more reports.

### Bug fixes

- Deleted and stopped: Deleted scan jobs won't run in the background. Marking nodes for deletion stops the inspec-agent from running them.
- Unmarshal error: Stopped including the invalid character `-` after array elements in uploaded inherited profiles.

### Backward incompatibilities

- Telemetry opt-out: We removed opting-out of telemetry with the API. We also fixed opting-out of telemetry with the Chef Automate config, and you can still opt out from the browser.

## Chef Automate 20181203095916

Released on December 10, 2018

### Improvements

- Back It Up: Keep your filtering and sorting selections when you move back and forth from the Client Runs page. This also makes sharing your view of the Client Runs page better.
- Compliance Improvements: New controls in preview releases for STIGs on RHEL7 and Windows 2016.

### Bug fixes

- Wrap-Around Names: Now you can see the whole long control name.
- Click the Button: Set your telemetry options, use the the profile button in the top nav and then select `About Chef Automate`.
- Compliance Fix: Removed control 3.6 from the compliance profile for CIS AWS v1.1.0 Level 1 because it only applies to Level 2.

## Chef Automate 20181126154627

Released on December 3, 2018

### Improvements

- Platform Node Filter: The Client Runs node list and details includes the platform version number. This means you can filter the node list to an exact platform version, using either strings or the wildcards `*` and `?`.
- Persist Filters: The Client Runs filters stay applied even when you look at the node details and then use the browser back button to see the entire node list.
- Compliance Improvements: The STIG RHEL 7 V2R1 preview compliance profiles includes controls for auditd implementations.

### Bug fixes

- Fat Finger Fix: Added validation at 'submit' to the Node Status configuration in the Admin settings.
- Compliance Updates: CIS AWS v.1.1, control 2.1 (Ensure CloudTrail is enabled in all regions) correctly fails if no CloudTrail trails are configured.

## Chef Automate 20181118185209

Released on November 26, 2018

### Improvements

- Satisfying Security Needs: We've tuned Automate's UI cache control. We maintain strict no caching on all authentication-related interactions (login), while otherwise allowing some private caching in the UI.

## Chef Automate 20181112131523

Released on November 19, 2018

*Happy Thanksgiving!*

### Improvements

- Faster Feed: Make all the Chef Actions you like, now our Event Feed won't backup.
- Satisfying Security Needs: Automate can't fit into an `<iframe>` is now restricted by the returned header `X-Frame-Options=samesite` on all UI-related parts.
- Compliance Updates: The CIS Azure v1.0.0 profile includes manual test instructions for some controls without automated tests. Added more preview compliance controls controls and improved the test logic for the STIG RHEL 7 and Windows 2016 (Cat I) profiles.

### Bug fixes

- Reasonable terms: Elasticsearch failing with an "immense term" error message when ingesting reports with very large fields.
- InSpec Control Code Improvements: Fixed the metadata on the CIS AWS Foundations v1.0.0 compliance profile so that it runs correctly with Inspec 3. Fixed controls in the CIS RHEL 7 v2.2.0 compliance profile that could potentially give a false positive result.

### Backward incompatibilities

- The CIS RHEL 7 v2.2.0 compliance profile controls for the `shadow` resource that aren't compatible with InSpec 1. From now on, they'll give a skipped result with an explanation message.

## Chef Automate 20181029174254

Released on November 5, 2018

### New features

- Gone, Node: Delete missing nodes directly from the Client Runs page. Admin users will see a new set of controls for deleting missing nodes.

### Improvements

- Outta Here: Remove scan jobs through the Automate user interface.

### Bug fixes

- Same-Same: The configuration style for setting the log level matches the configuration style of other services. You can also set the log level to `debug` or `warning`.

## Chef Automate 20181020020209

Released on October 29, 2018

### New features

- Easier nested page navigation: All "Go back" bars on nested pages have been changed to Breadcrumbs components, which allow the user to see where they're in the application page tree.
- New BETA feature: Google Cloud API scan support with the integrations and scan jobs screens.

### Improvements

- More data, no problem: Automate migration is improved to be more reliable and stable for systems with a large amount of data.
- Migration Guard: Automate migration is protected from starting if the data is considered possibly corrupted or malformed.
- Updated Reporting: Compliance reporting is now rejecting reports with no node_uuid defined.

### Bug fixes

- Daylight Savings Adjustment: Fixes excess/deficient number of buckets in the Event Feed Guitar Strings control for the weeks that include the beginning or end of daylight saving.
- Precision Reporting: Scan jobs with more than 100 nodes now accurately report their job status.
- Hours of Operation: Aborted scan jobs are now updated with an end_time.
- Ingest Logging: The ingest-service listens to log level configuration. Use either of the below config settings to set the ingest-service log level to debug.

```
[ingest.v1.sys.log]
level = "debug"

[global.v1.log]
level = "debug"
```

- ES Sidecar Logging: The es-sidecar-service listens to log level configuration. Use either of the below config settings to set the es-sidecar-service log level to debug.

```
[es_sidecar.v1.sys.log]
level = "debug"

[global.v1.log]
level = "debug"
```

- Automate Migration Fix: Now updates the Node State from the last chef-client run on disk.
- CIS RHEL 7 server compliance profiles fixes: Controls 6.2.7 through 6.2.14 will now exclude system users (root, sync, halt, shutdown) from tests, as per CIS procedure.
- CIS RHEL5 server compliance profiles fixes:

  - Controls, which test service state, now correctly use the `be_enabled` matcher instead of the non-existent `be_disabled` matcher.
  - Controls, which CIS doesn't specify automated tests for, will now result in a skipped result instead of having no code.

## Chef Automate 20181015112149

Released on October 22, 2018

### Improvements

- Doublewide: We made the Client Runs search bar wider so you can read the suggestions dropdown more easily.
- InSpec Control Code Improvements: CIS Azure Foundations v1.0.0 implements controls 3.3 and 3.7.
- Compliance Update: The STIG RHEL7 Cat I preview compliance profile includes SV-86557r3 and SV-86863r4 and gives more meaningful skip messages on a number of controls.

### Bug fixes

- Secrets Logging: The `secrets-service` listens to log level configuration. Use either of the below config settings to set the `secrets-service` log level to `debug`.

```
[secrets.v1.sys.log]
level = "debug"

[global.v1.log]
level = "debug"
```

- Configuration Logging: The `config-mgmt-service` listens to log level configuration. Use either of the below config settings will set the `config-mgmt-service` log level to `debug`.

```
[config_mgmt.v1.sys.log]
level = "debug"

[global.v1.log]
level = "debug"
```

- Use "Add notification" and "Edit notification" links without causing a full page refresh.

## Chef Automate 20181011135231

Released on October 15, 2018

### New features

- Compliance Update: Compliance now includes CIS certified InSpec profiles for CIS Google Cloud Platform Foundation Benchmark v1.0.0.
- New General Settings Page: When logged in as an admin, the general settings page will let you customize when an infrastructure node is considered missing, and when nodes that are considered missing are deleted.

### Improvements

- Reworked "Go Back" Bar: The "Go Back" bar will now remember when search bar filters are applied on the Client Runs page and keep them applied.
- InSpec Control Code Improvements: InSpec control code has been improved in the preview profiles for RHEL7 and Windows 2016 STIGs.
- Expanded Wildcard Search Support: Wildcard search is now supported for aws-api filtering during scan job creation.

### Bug fixes

- Locking It Down: The job scheduler endpoints, which can be modified by applying settings using curl, were previously open to all users, but should have only allowed admins to modify them. This has been fixed. (These same job scheduler endpoints are now able to be set with the UI on the new general settings page as an admin.)
- Made It Right: The automate-gateway version endpoint was fixed, so it will return the correct version when queried (`/api/v0/gateway/version`).
- No Node, No Scan Job: Resolved issue where users where able to create a scan job with no node(s) attached.
- Abandoned jobs no more: Service restarts won't leave a scan job in an eternal 'scheduled' or 'running' state. Now, the service checks for abandoned jobs at startup and handles them as needed.

## Chef Automate 20181001090525

Released on October 8, 2018

### New features

- Local Teams in the Browser: Admins can create and remove teams, edit team descriptions, and add or delete team members from the Automate UI.
- Upgrade with Users: Keep your users when upgrading to the new Automate!  Administrators stay admins, too. Automate automatically adds all local users with the administrator role to the admins team, so they'll have admin-level access after the upgrade.
- Lost an Admin Password? No Problem! We've added a reset admin command to the CLI.   See the changes before you make them with `chef-automate iam admin-access restore <pass> --dry-run` to see what changes need to be made - then run again without the `--dry-run` argument to actually make the changes to your Chef Automate installation. This command lets you:

  - recreate the `admin` user with the new password
  - recreate the `admins` team
  - add the `admin` user to the `admins` team
  - recreate the Administrator policy
  - add the `admins` team as a subject in the Administrator policy.

### Improvements

- What's the Diff: Easier-to-read diff for resources that change on a client run.
- Hold the Door: Retrieve the threshold value--for the configurations that set it--through the API.
- Un-listed: Deleting a user from the list view also deletes them from Local teams and existing policies. Likewise, deleting Local Teams and API Tokens also removes them from existing policies. An admin needs to do it, natch.
- Upgrade Compatibility: We run some extra tests to make sure that your Automate upgrade is really compatible and will work smoothly. In particular, you'll see the steps you need to take to upgrade your SAML configuration, if you have it. You can this compatibility check--it's OK if you don't use SAML--by adding `--skip-saml-check` to the upgrade command.
- Moar & Better Compliance: We improved the STIG RHEL7 cat1 v001.002 preview release compliance profile and the STIG Windows Server 2016 cat1 v001.006 preview release. We added STIG RHEL 7 cat1 v002.001 including the quality improvements from v001.002
- Minor Semver: We updated CIS Azure Foundations v1.0.0 resource pack to 1.2.0
- Delete Nodes from the Command Line: There's a new CLI command for deleting infrastructure nodes. For more information, see the docs on the Client Runs page under [Deleting Nodes](https://automate.chef.io/docs/client-runs/#deleting-nodes) and the [CLI Command Reference Page](https://automate.chef.io/docs/cli-chef-automate/).
- No Haunting Nodes: Deleted nodes won't show up in the Client Runs search bar as suggestions.
- Login with LDAP/SAML/MSAD: `ca_contents` settings in configs for SAML/LDAP/MSAD are now validated before applying them to the system, and related errors will be easier to spot.
- Does Anybody Really Know What Time It Is: Select the date/time with the inputs on job scheduling.

### Bug fixes

- Right Log: The ingest service uses log level that's set in the config.
- Recent Events: The event feed guitar strings graph displays very recent events.
- Locals Only: LDAP or SAML users won't see "view your profile" on the menu, because only local users can save profiles.
- Major Metadata: Added major release metadata to CIS RHEL Compliance Profiles, so you can run profiles with older versions of Inspec.
- Get the Story Straight: The CIS RHEL 7 v2.2.0 Compliance Profile aligns with the CIS benchmark and skip message for 5.4.1.5
- Made it Right: Fixed control 17.3.1 for CIS Windows 2016 DC & MS.
- Login with MSAD: `ca_contents` can now be used for the MSAD connector.
- Login with SAML: `ca_contents` for the SAML connector have always been required, but hadn't been validated in that way--they now are.
- Better handling of missing nodes, deleting missing nodes, and data cleanup. See below for full details.

### Backward incompatibilities

In all prior versions, custom settings for managing node data--setting nodes missing, deleting missing nodes, and configuring data cleanup--were incorrectly applied. When you used the curl command against the api to set the settings, the command responded successfully, but resulted in the configuration being set to off. Thus, no nodes were marked missing, no data deleted, and no configuration data cleaned up. This was the result regardless of the value used for the setting.

To correct your settings, reapply the values you originally intended for your custom settings. You can find directions on how to set the values here: <https://automate.chef.io/docs/client-runs/#managing-node-data>

If you never tried to set any of these values, the defaults continue to apply and the operations that the settings applied to continue to work as expected. No action is needed.

We fixed the problems in using custom settings for managing node data in this release of Automate and we've increased the testing around managing node data to prevent this problem from recurring in the future.

## Chef Automate 20180920223835

Released on September 24, 2018

### New features

- Now With Wildcards: Use wildcards on Client Run filters. `?` stands in for a single character and `*` stands in for more than one. Think `Che?` vs. `Ch*`. Hit enter to see the results of your wildcard foo.

### Improvements

- Matching Checkboxes in the data collection box for a smoother experience.
- Let's Get Cookin': We're keeping your cookbook role information in Elasticsearch...and we're working on showing it in the user interface.

### Bug fixes

- Improved Automate Migration, Part One: We added better protection from potential panics in the event Elasticsearch crashes while migrating to the new Automate.
- Improved Automate Migration, Part Deux: We added better protection from potential panics in the event unexpected data is found while migrating to the new Automate.
- Overly Warm Welcomes: The Welcome window was overzealous--appearing even after you told it to go away--if you  didn't opt-in to data collection. We had a long talk and it understands that was inappropriate behavior. It won't happen again.
- Cleared the Filters: Automate won't filter by more than one job id when you navigate to a job's report summary.
- Updated the Client Runs Search Bar: Your browser won't freeze when the search bar looks for suggestions. We also fixed a bunch of other stuff to improve it for Edge, Firefox and Safari.
- Clear Roles: Node Details' Run List section shows the roles correctly, and you can expand a role to see its cookbooks.

## Chef Automate 20180912124609

Released on September 17, 2018

### New features

- "Missing" nodes now get deleted automatically after 30 days. This time period is configurable with the API. You can also configure when a node is marked missing (default is 1 day). See the docs on [Managing Node Data](https://automate.chef.io/docs/client-runs/#managing-node-data) for more information.
- Automatically Delete Missing Nodes: Automate marks any node that fails to check in within 24-hours as "missing" and then deletes missing nodes after 30 days. You can configure both check-in window and the delete-window, see the documentation on [Managing Node Data](https://automate.chef.io/docs/client-runs/#managing-node-data) for more information.

### Improvements

- Clean Up: Hitting delete on the Client Runs page completely clears a selected category.
- Now with Reruns: Re-run `inspec detect` jobs with the new button on the Automate scanner nodes list.
- See and do: You'll see what OS a compliance profile supports in the profile details.
- More Azure Compliance: Implemented additional controls for CIS Azure Foundations v1.1.0.
- Preview Compliance Profiles: You can use more STIG controls for DISA STIGs (RHEL7 and Windows 2016). These aren't the full STIG--yet--and we're putting them through more QA testing.

### Bug fixes

- Render Profiles: We added title strings to the CIS AWS Foundations v1.1.0 compliance profile to make it right.
- Keeping Secrets: You cant create an unused secret on the notifications page.
- Bring It Down: Download your uploaded compliance profiles.
- Check it: Fixed the checkbox for enabling and disabling sharing your anonymized usage and diagnostic data with Chef.
- Unblock it: Use your adblocker and still see the `share` button on search bar on the Client page.

## Chef Automate 20180831173550

Released on September 10, 2018

### New features

- Preview Compliance Profiles: You can use many of the Category I STIG controls for Windows 2016 and RHEL 7. These aren't the full STIG--yet--we show you "skip" results for not-yet-implemented controls.

### Improvements

- What's in a name: Now you'll see `node id` on the  node detail page.
- **Go Back** but keep the important stuff: The back button on the node detail page lets you keep your applied server or org filters.

### Bug fixes

- Control 2.2.2 in the CIS Windows 2016 DomainController profile won't query all the users and groups on the system.
- Stopped the Client Run page search bar from hanging while filling the autocomplete list.

### Backward incompatibilities

- So far, our improvements to the Client Runs search bar applies only to Chrome. We're working on improving it for Firefox, Safari, and Edge.

## Chef Automate 20180827132056

Released on August 28, 2018

### Bug fixes

- We updated the InSpec version included with Automate, so your scan jobs will pass. You won't see this error:

```
exit status 1,
/hab/pkgs/chef/inspec/2.2.55/20180803140814/lib/gems/inspec-2.2.55/lib/inspec/base_cli.rb:179:in `block in validate_reporters': 'json-automate' isn't a valid reporter type. (NotImplementedError)
```

## Chef Automate 20180817182829

Released on August 20, 2018

### New features

- New Compliance Profiles: You can use the CIS Azure Foundations benchmark v1.1.0 profile and the CIS CentOS 6 benchmark v2.0.2 profiles through the Compliance dashboard.
- DIY Password Administration: Asking your admin to change your password can be a drag...so we fixed it! You can change your own password by selecting your name or avatar in the upper right corner of any Chef Automate page and selecting "Your Profile" from the dropdown menu. Woohoo! Your admin can still reset your password for you in case you forget it.

### Improvements

- 8x faster data-collector endpoint: We made a big improvement and now the end point ingests 8x as many messages per second. You're welcome!
- Extended backup sessions: Backup operations will timeout after 120 minutes, instead of 10 minutes. You can also configure this when calling `chef-automate backup create`
- Streamlined user updates: When an admin successfully updates a user's full name, the edit mode closes and you're automatically taken back to the user's display.
- We touched up the Chef Runs node list paginator--it's at the bottom of the page--for better usability/accessibility.
- We tweaked the user interface updates.

### Bug fixes

- Corrected the `release` metadata on some Compliance profiles so the profiles are considered compatible with a target host.
- Fixed a number of controls in the CIS Centos 7 v2.2.0 compliance profile to be more accurate to the CIS benchmark.
- Fixed an issue in the CIS RHEL6 compliance profiles where some controls were assigned 0.0 impact without reason.
- Compliance reporting charts only scale along x-axis now to avoid oversizing.
- Long control list descriptions won't overflow from the table.
- Resolved bug that reset manager value to 'automate' on scanner node updates.
- Backup time-outs won't prevent the system from performing routine tasks such as configuring and updating the subsystems, running backups, etc.

## Chef Automate 20180810152540

Released on August 10, 2018

### New features

- View node resource change diffs using the new node run detail view.

### Improvements

- InSpec profiles for Compliance are even easier to use with new metadata about supported operating systems and versions.
- Error messages provide the Command ID of failed AWS SSM remote scans, so you can find and fix problems faster.
- Create scan jobs quicker--find manually managed node names with an asterisk (*) wildcard.

### Bug fixes

- We fixed some of the CIS RHEL 6 controls. They no longer include the non-existent `be_disabled` matcher when testing a service.
- "Copy URL" on the Client Runs filter works how you think it would.

## Chef Automate 20180807052402

Released on August 7, 2018

### New features

- Send notifications to ServiceNow with username and password authentication

### Bug fixes

- Unblocks Compliance ingestion by directing errors to the proper channels.

## Chef Automate 20180806202947

Released on August 6, 2018

### New features

- Use the new Date Zoom 'slider' on the Event Feed to look at a range of dates instead looking at a whole week.

### Bug fixes

- You can once again send InSpec scan failure notifications.

## Chef Automate 20180803154514

Released on August 6, 2018

### New features

- We added Compliance profiles for CIS CentOS 7 v2.2.0 and CIS Windows 2012R2 v2.3.0

### Improvements

- Zoom in to specific days on the Event Feed with zoom sliders at the top of the graph.
- Improved Automate's authorization service performance, letting you get about your actual work just a wee bit faster.

### Bug fixes

- Automate calmly and rationally lets you know that your license is close to expiriation, without the peculiar-looking screen glitch.

## Chef Automate 20180802181335

Released on August 2, 2018

### Improvements

- Automate tries to detect and fix cases where PostgreSQL doesn't come up because it wasn't cleanly stopped.
- Made a minor improvement to data-collector endpoint performance by avoiding a json translation.
- Moved the compliance service's secrets service into its own service.

### Bug fixes

- Reduced gRPC-related logging noise when everything is alright. (You can enable debug logging to see alarming--but harmless--messages about `loopyWriter.run returning` in regular intervals.)
- AWS credential-less jobs only report success if InSpec exit code was 1 (previously ignored exit code)
- Fixed broken buttons on license modals, so getting a trial license and applying a licenses through automate-ui works again.

## Chef Automate 20180728222031

Released on July 30, 2018

### New features

- Compliance now includes Inspec profiles for CIS's Cisco IOS 12 and 15 benchmarks
- You can use Chef Automate as an OAuth provider for Habitat Builder! Just follow [these directions](https://github.com/habitat-sh/on-prem-builder#oauth-application) to set it up. This is the ideal OAuth solution for using Builder and Automate in an air-gapped environment.

### Improvements

- Faster A1 to A2 migration.
- You'll see an new `Logout` button, as well as the `Retry` button, for help fixing the occasional connectivity issues that all networked systems sometimes have. If the `Retry` button isn't enough to fix your connection, you try the `Logout` button to log out and back in. If that still doesn't work, contact your sysadmin to take a look at your system.

### Bug fixes

- You can upload profiles in the compliance-service with non-string default options.
- Improved to the test logic for Inspec profiles for CIS Red Hat and Windows.
- Spelled "Policies" correctly on the event feed.
- Made the resource status of some unchanged resources show the correct processed status and icon.
- Scan jobs supports profiles with two or more dependencies.

## Chef Automate 20180720170058

Released on July 23, 2018

### New features

- Use usernames in authorization policies with `${a2:username}` in resources.
For example, *local users* can **read**, **update**, and **delete** their own Chef Automate user records using the API. The policy allowing this is (abbreviated):

  ```json
  {
    "id": "f9eb8c5a-3b8b-4695-ae39-ca434237f69b",
    "action": "*",
    "subjects": ["user:local:*"],
    "resource": "auth:users:${a2:username}"
  }
  ```

### Improvements

- You'll see improved performance ingesting Chef Client Runs because we improved the message handling in the Automate-Gateway.

## Chef Automate 20180717131009

Released on July 17, 2018

### Bug fixes

- Fixes an issue where installations that were previously upgraded from Automate 1.8.x would not see the `secrets-service` running after the latest upgrades.

## Chef Automate 20180714142423

Released on July 16, 2018

### Improvements

- We've refreshed the administrator's view of the **API Tokens** page with a better arrangement of the details for each token in the table, giving it a more consistent look and feel.
- These changes aren't just skin deep--we've also updated the underlying code to keep up with Chef's development conventions for improving better performance and maintainability. We did the same work for the **User Management** code.
- Sometimes your Automate instance has connectivity issues. We clarified the text for that pop-up error message to reflect that there is *some* connectivity problem, not necessarily a license problem, which is what it used to indicate.
- Reduced the bandwidth used in A2 back-end interactions by no longer sending on user/group information from automate-gateway.
- Improved error handling in the ingest service to avoid a rare possibility of segfault.

### Bug fixes

- LDAP identity management integration configs no longer insist that you define the optional attribute `base_group_search_dn`.
- MSAD identity management integration configs no longer insist that you define the optional attributes `bind_dn` and `bind_password`.
- Fixed a bug so you can from Chef Automate 1 with more than 250 Elasticsearch clusters.
- Fixed a bug in the last two releases that made Chef Automate 2 hang while upgrading to the newest version.

## Chef Automate 20180706210448

Released on July 9, 2018

### Improvements

- Introduced speed improvements for loading the node details page, especially when a large number of nodes are present in the system.

### Bug fixes

- Fixed a UI bug to make the tooltips easier to read by ensuring the background isn't transparent.
- When sending a too big request to Automate's API, the response's HTTP status code won't be 403, but 429.
- Deleting an installed profile only deletes the profile for that user (not all users).

### Known Issues

#### Hanging / Stuck Upgrades

##### Description

Upgrades to future versions of Chef Automate from this version can potentially fail, leaving the `deployment-service` in a loop with the following error:

```plain
hab[17347]: deployment-service.default(O): time="2018-07-11T11:56:37-05:00" level=error msg="Phase failed" error="hab-sup upgrade pending" phase="supervisor upgrade"
hab[17347]: deployment-service.default(O): time="2018-07-11T11:56:37-05:00" level=error msg="Converge failed" error="hab-sup upgrade pending"
hab[17347]: deployment-service.default(O): time="2018-07-11T11:56:37-05:00" level=error msg="Failed to converge" error="<nil>"
hab[17347]: deployment-service.default(O): time="2018-07-11T11:56:37-05:00" level=error msg="Periodic converge failed" error="hab-sup upgrade pending"
```

Calling `chef-automate upgrade status` will also return an error indicating that an upgrade is in progress:

```plain
Automate is upgrading to 20180706210448

Services requiring changes:
  automate-ui (current: 20180629131431) (expected: 20180706155359)
  authz-service (current: 20180620132402) (expected: 20180705062757)
  es-sidecar-service (current: 20180625212844) (expected: 20180705064421)
  teams-service (current: 20180620133222) (expected: 20180705063807)
  authn-service (current: 20180621233337) (expected: 20180705062612)
  notifications-service (current: 20180619233802) (expected: 20180702211310)
  compliance-service (current: 20180628140618) (expected: 20180706143930)
  license-control-service (current: 20180628092904) (expected: 20180705064710)
  local-user-service (current: 20180625145256) (expected: 20180705064833)
  session-service (current: 20180620133048) (expected: 20180705063631)
  ingest-service (current: 20180625213004) (expected: 20180705064541)
  config-mgmt-service (current: 20180620133538) (expected: 20180705064126)
  data-lifecycle-service (current: 20180620133705) (expected: 20180705064254)
  automate-gateway (current: 20180628141127) (expected: 20180706144457)
  secrets-service (current: NOT RUNNING) (expected: 20180706200804)
```

##### Workaround

Running the following command will result in the `deployment-service` resuming the upgrade the next time it attempts to converge service state, within 5 minutes:

```sh
touch /usr/lib/systemd/system/chef-automate.service
```

## Chef Automate 20180629132035

Released on July 2, 2018

### Improvements

- We made it easier to enable Chef Automate's LDAP integration with Microsoft Active Directory. If you specify `msad_ldap` as the auth connector, then we'll set common MSAD configuration values to their common defaults. This means you'll do less configuration and get going faster. If you need the flexibility of additional configuration values, you can still use the `ldap` connector.
- We're validating the completeness of the SAML and LDAP configurations you make with `chef-automate config set` or `chef-automate config patch`--the CLI will let you know if you're missing a required field.
- We added support for scanning EC2 nodes with their private IP when they don't have a public IP.
- We made a few performance improvements for ingesting Chef Client runs and chef-server actions through the legacy endpoint.
- We upgraded to Habitat 0.57.0, which we use to build and deploy Chef Automate. The upgrade will restart the entire Chef Automate process tree during the move to the updated Habitat supervisor. We've added logic for shutting down services in a controlled order during the upgrade. We're exploring approaches for minimizing disruptions in future upgrades. As always, if you encounter issues, we're here to help!

### Bug fixes

- Fixed the LDAP configuration on the migration from a Chef Automate 1.x installation to Chef Automate 2. Now the `user_id_attr` gets set.
- Fixed a UI bug to make the tooltips easier to read.

### Known Issues

#### Hanging / Stuck Upgrades

##### Description

Upgrades to future versions of Chef Automate from this version can potentially fail, leaving the `deployment-service` in a loop with the following error:

```
hab[17347]: deployment-service.default(O): time="2018-07-11T11:56:37-05:00" level=error msg="Phase failed" error="hab-sup upgrade pending" phase="supervisor upgrade"
hab[17347]: deployment-service.default(O): time="2018-07-11T11:56:37-05:00" level=error msg="Converge failed" error="hab-sup upgrade pending"
hab[17347]: deployment-service.default(O): time="2018-07-11T11:56:37-05:00" level=error msg="Failed to converge" error="<nil>"
hab[17347]: deployment-service.default(O): time="2018-07-11T11:56:37-05:00" level=error msg="Periodic converge failed" error="hab-sup upgrade pending"
```

Calling `chef-automate upgrade status` will also return an error indicating that an upgrade is in progress:

```plain
Automate is upgrading to 20180706210448

Services requiring changes:
  automate-ui (current: 20180629131431) (expected: 20180706155359)
  authz-service (current: 20180620132402) (expected: 20180705062757)
  es-sidecar-service (current: 20180625212844) (expected: 20180705064421)
  teams-service (current: 20180620133222) (expected: 20180705063807)
  authn-service (current: 20180621233337) (expected: 20180705062612)
  notifications-service (current: 20180619233802) (expected: 20180702211310)
  compliance-service (current: 20180628140618) (expected: 20180706143930)
  license-control-service (current: 20180628092904) (expected: 20180705064710)
  local-user-service (current: 20180625145256) (expected: 20180705064833)
  session-service (current: 20180620133048) (expected: 20180705063631)
  ingest-service (current: 20180625213004) (expected: 20180705064541)
  config-mgmt-service (current: 20180620133538) (expected: 20180705064126)
  data-lifecycle-service (current: 20180620133705) (expected: 20180705064254)
  automate-gateway (current: 20180628141127) (expected: 20180706144457)
  secrets-service (current: NOT RUNNING) (expected: 20180706200804)
```

##### Workaround

Running the following command will result in the `deployment-service` resuming the upgrade the next time it attempts to converge service state, within 5 minutes:

```
touch /usr/lib/systemd/system/chef-automate.service
```

## Chef Automate 20180621090851

Released on June 21, 2018

### Improvements

- Common case-related inconsistencies in LDAP attribute settings are now auto corrected, so if you configure `samAccountName`, `samaccountname`, or (the correct) `sAMAccountName`, Chef Automate will auto correct that behind the scenes.
- Performance--always at the forefront of Chef Automate development--got just a bit of a boost. We added a bit of pep to the checks that determine what your users have permission to see. The net effect is less lag time from start to finish when rendering a page in the browser.
- We've improved the accessibility behavior of our modals! Now tab navigation is a breeze and screen readers will be able to read the content starting with the auto detected title!
- Improved search bar on the client-runs page to narrow down options when an exact match is found and better sort by best matches.

### Bug fixes

- Too much of a good thing! Each time within a session when you visited the "Client Runs" tab, there was more backend traffic being generated (redundantly) to fetch the necessary data (observable on the Network tab in developer tools). Now it will content itself with just single calls to each needed service.
- LDAP `bind_password` now can include any special characters you want! To put it the configuration file, use the TOML syntax for quoted strings, for example:

  ```toml
  bind_password = '''$p3c"i'@l ! %#'''
  ```

## Chef Automate 20180615105327

Released on June 18, 2018

### New features

-

### Improvements

- The Event Feed is getting even better. Clicking on a date at the top will zoom into events for that day. To zoom out to the weekly view, click again on the date. Also, the number of items shown will adjust to the size of the browser window.
- Filtering by multiple fields (regions and tags) now supported for Azure-based scan jobs
- The auto complete suggestions from the Client Runs search bar have been refined to only supply suggestions the user is likely to be searching for, instead of many possible permutations of the search string.
- automate-gateway now lets you turn up its log level for debugging insights

### Bug fixes

- When you select the filter for node name in the Client Runs search bar, typing "node" to autocomplete now works.
- LDAP config bug fixes: It now works for `bindPW` settings containing dollar signs; and configurations that include `filter_groups_by_user_attr` now work, too.
- On your first-time launch of Automate, when you sign up for a trial license, you won't be presented with the second "welcome" pop-up that tediously said "hello" again, and asked you whether we could collect data again. The "welcome" pop-up will only appear on launch now when the license pop-up doesn't.

### Backward incompatibilities

-

## Chef Automate 20180608102534

Released on June 11, 2018

### Improvements

- The `chef-automate` command line tool now knows how to upgrade itself. With this change, the CLI will download updates from the running A2 service. These executables are cached in `~/.chef-automate`. You can disable this feature by setting `CHEF_AUTOMATE_NO_UPDATE_CLI=1` in the environment. Note that you will need to manually upgrade the CLI to this release before you can take advantage of the automatic upgrading functionality.
- We improved some error messages when working with backups with `chef-automate backup` so that it's easier to understand what went wrong.

### Bug fixes

- Resolved bugs on scan job creation page: AM/PM time selection respected and page no longer freezing on extra integration data
- Positioning for the tooltips on the navigation bar are improved.

## Chef Automate 20180604124326

Released on June 4, 2018

### New features

- The minimum version required for upgrading from Chef Automate 1.x to 2 is now 1.8.31.

### Improvements

- We sped up the `chef-automate status` command so you don't have to wait as long to determine the status of the system.
- We improved the error handling within the `chef-automate` CLI so that we can return unique exit codes based on the type of error. We're working on some automation to allow us to document these. For now, here's a list of exit code and error:

  - 113 `UnknownErrorExitCode`
  - 99  `DeploymentServiceUnreachableErrorExitCode`
  - 98  `DeploymentServiceCallErrorExitCode`
  - 97  `UnhealthyStatusErrorExitCode`
  - 96  `InvalidCommandArgsErrorExitCode`
  - 95  `PreflightErrorExitCode`
  - 94  `DeployErrorExitCode`
  - 93  `ConfigErrorExitCode`
  - 92  `MustBeRootErrorExitCode`
  - 91  `DiagnosticsErrorExitCode`
  - 90  `FileAccessErrorExitCode`
  - 89  `LicenseErrorExitCode`
  - 88  `MarshalErrorExitCode`
  - 87  `UpgradeErrorExitCode`
  - 86  `BackupErrorExitCode`
- `chef-automate` commands have a new flag `--result-json FILE`. When specified, you'll get a file summarizing the command execution in JSON format. This is intended to be used for automation. Please note that the output structures are subject to change -- but if this sounds useful to you, we'd love you to try it and provide some feedback.
- License expiry:

  - Display is now locale-aware
  - Checks now happen periodically in the background

### Bug fixes

- Positioning for the tooltip on the 'notifications' link in the nav bar is fixed.
- Accessibility improvements around modals for licenses and local user creation
- The Event Feed now handles long names and text wrapping cleanly.
- Fixed a panic that would occur if `--channel` was left unspecified when running `chef-automate upgrade-from-v1`.

## Chef Automate 20180519154949

Released on May 20, 2018

### New features

- This release doesn't contain any new major features, but we've got a great list of improvements and six bug fixes.

### Improvements

- When your license is getting close to expiration (within 90 days) -- whether a full license or a trial license--a banner appears reminding you that you need to take action to get that puppy renewed! It provides quick links to contact us as well as to a spot where you can apply a license in the UI.
- Compliance reports sent with scan jobs now trigger notifications.
- Scan jobs can be filtered by status.
- Improved experience when installing an already installed profile.
- Applying config to a running system is now more reliable (thanks, scheduled HUP).
- Upon requesting or applying a license, instead of a quick "License successful" notification you get the full whiz-bang experience confirming your license is approved and applied, along with details such as your expiration date.
- When applying or requesting a license, you now get positive visual feedback showing that the system is energetically working on your behalf, by disabling the button you just pressed during processing as well as showing a busy-spinner that's sure to keep you entertained. (Apologies but sometimes Chef Automate just responds too rapidly to even have time to show that it was off doing something, so you might not see our nitfy spinner at all.)
- On the Event Feed, updates to cookbooks now give you the name and version of the cookbook, instead of just the version (which wasn't all that helpful).
- Manual node creation now includes the option to add (any number of) tag key/value pairs, and those tags can be used as a search query when creating a scan job. This allows users to group manually added nodes to their preference, and easily run scan jobs on those groups.
- Profile events now show user in event feed if available.
- Improve behavior of Event Feed in the face of partial service availability.
- We now configure ElasticSearch to stop accepting writes when available free disk space on the system drops below 250MB. This protects the system as a whole and allows more graceful recovery.
- When you migrate from 1.x versions of Chef Automate, we're now able to bring along any notification rules you may have configured.
- The entire row of the Client Runs table is now clickable. Finding just the right spot to click was fun, but we know this is much better experience now.
- Cookbook name and version is displayed in the Event Feed for cookbook actions.
- We taught the deployment service where to store backups by default (`/var/opt/chef-automate/backups`). Now you don't have to configure a backup path for the system before taking backups, but you still can if you want to.
- Webhook notification now include `timestamp_utc` in the JSON payload.
- Many improvements to support for running Chef Automate in environments using proxied access to the internet.
- We added a global config entry for controlling the log level of the entire system. Some services require further enhancement to respect this setting, but the new config entry still allows you to control log level across much of the system.
- We love our legal team and they love it when you accept our terms of service and master license and service agreement before installing and using our commercial software. When you run `chef-automate deploy` you'll now be asked to accept TOS and MLSA. You can accept at the prompt by typing "y", "Y" and decline with "n". Since we know you may want to automate your installation, you can also accept in a non-interactive fashion by providing a new flag `--accept-terms-and-mlsa`.
- The `chef-automate status` command now includes service uptime and process ID. For those of you not yet familiar with Habitat, this enhancement lets you obtain more detailed status information without having to drop out of the `chef-automate` CLI experience.
- Our preflight check now verifies internet connectivity to the key services that are needed for a successful deploy.
- Speaking of our preflight check, we now also check the version of the `chef-automate` CLI. We'll let you know if you need to update. We also increased the minimum free disk space required to 5GB. Presently, a fresh install of Chef Automate installs 2.6GB into `/hab` and we now require 250MB of free space in order to enable writes for ElasticSearch. So, we increased the minimum free disk space to make sure you have enough room to add some data to the system.
- Improve UI handling of 403 unauthorized errors in Admin/API Token view.
- We no longer print credentials on the console during initial deployment. When you deploy, we'll generate a secure random password that you can use to bootstrap access to Chef Automate's web UI and we'll record this for you in `automate-credentials.toml` which is written in the directory from which you invoked `chef-automate deploy`.
- We realized the `--admin-password` flag for the `deploy` and `upgrade-from-v1` subcommands wasn't quite safe for general consumption so we've taken the measure of hiding it for now (shhh). The issue is that the local-user-service validates passwords for complexity and this can cause deploys set off into the world with weak passwords to fail at the end in a way that's a bit of a bummer to recover from. If you need to set a custom password at deploy-time, you still can, but please be sure to use a strong one.
- Prevent a communication breakdown between `chef-automate` client and server that we observed in some cases due to a disagreement about certificates. We now reset properly when retrying a failed connection and expect this to improve the reliability of deploy.

### Bug fixes

- We fixed a bug that surfaced when spaces made their way into your `no_proxy` environment variable.
- When proxy config was present for the notifications service, but no_proxy unset, we used strJoin on a nil value. This caused the templating engine to break and stop rendering the rest of the files. We fixed that.
- Instead of creating a segmentation violation, we now deploy Chef Automate respecting your proxy settings when invoking deploy as `http_proxy=$PROXY chef-automate deploy ...`.
- Fixed a templating error in automate-elasticsearch's `health_check`
- You can now request a trial license even if you don't check the 'allow Chef to send me information` box.
- Fixed a bunch of issues with the Node Detail Page. Icons on the resources list on the match the color of their corresponding rollup tab above, the Action type shows up in the column now, and everything is aligned correctly

## Chef Automate 20180514204156

Released on May 14, 2018

### New features

- Scan jobs with AWS. Add an AWS to A2 automate-URL/integrations. You can add a management service for AWS account scanning and a manager for EC2 scanning, which skips credential information for nodes running in EC2. Your credentials for AWS account scanning need to access: `ec2:DescribeRegions`, `sts:GetCallerIdentity`, `IAM-ListAccountAliases` and global read permissions. For EC2 scanning, youaccess to: `sts:GetCallerIdentity`, `ec2:DescribeInstances`, `ec2:DescribeInstanceStatus`, `ec2:DescribeRegions`.
With AWS EC2 scanning, you can associate groups of nodes with credentials by the key/value tag associated with the node. In EC2, you can choose to read credential information from your environment and use the AWS SSM functionality to perform "credential-less" infrastructure scanning. For "credential-less" EC2 scanning, you need access to `sts:GetCallerIdentity`, `ec2:DescribeInstances, ec2:DescribeInstanceStatus`, `ec2:DescribeRegions, ssm:*`

- Get notified in Slack or with webhook when client run failures or compliance scan failures happen. Click the bell icon in the top right corner, to configure your notifications. Currently, only compliance scans using the Audit Cookbook trigger notifications. Scan Jobs configured from Automate don't trigger notifications.

- Get a list of active nodes from the CLI by using the command `chef-automate node-inventory`. This outputs the list of nodes in JSON to the terminal. Output JSON to a file by adding a file path.

- Liveness agent messages are now accepted and ingested. Nodes with liveness agent cookbooks on them will checkin with automate and prevent nodes from being labelled missing even if they're not converging on a regular basis.

- When running without a license, user will now be invited to enter their contact information to get a trial license, after which A2 will download and apply the license (but please see the Known Issue below).

- `API Key` changed to `API Token` in admin panel, to normalize our terminology.

### Improvements

- Notifications now works with proxy servers.
- `chef-automate config` commands now return errors if you've tried to set keys that don't exist
- `/nodes` page has moved to `/client-runs` to disambiguate chef-client nodes from node manager nodes.

### Bug fixes

- User id hash for the compliance profile identifier has been replaced with username
- Resolved "unclickable" buttons on credentials add screen
- Resolved several small bugs re: job creation and editing
- Resolved compliance reporting pages sorting issues

### Known Issues

- If a user doesn't have permission to access notifications, the error displayed to the user will state there was an error loading notifications instead of properly stating the user doesn't have permissions.
- On the Event Feed, Profiles and Scan Job events will show in the list, but won't be visualized as icons in the graph or be included in the counts.
- Requesting a trial license will only succeeded if the user has checked the 'allow Chef to send me information` box. This isn't intended, and will be fixed in the next release.
- When deploying behind a proxy with the `https_proxy` or `http_proxy` environment variables set, but nothing set for `no_proxy`, the `notifications-service` fails to start. To workaround this, please set `no_proxy=""` when running `chef-automate init-config` or `chef-automate deploy`.

## Chef Automate 20180504185246

Released on May 7, 2018

### New features

- License Checking: You'll know your license is up-to-date. When you log in, we'll check to see if you have a current license, and if you don't, we'll show you new helper tool to enter your valid license and get access to Automate. You can also still apply your license using the command line or in your config file.

- New Scan Jobs Creation Page:  Create scan jobs with a query-based model. First, select a manager base, such as manually managed or aws-ec2, and then build a query using tags, regions, names, or whatever is applicable. In the end, you'll get a regularly scheduled job that applies to both your current nodes and the nodes you add in the future.

### Improvements

- A wider "Check In" column on the Client Runs page prevents the "no data" boxes from breaking into two lines

### Bug fixes

- Users without permission to see the event feed see an alert, instead of seeing 'no data' with a 403 error in the console.

### Backward incompatibilities

- Updated the Client Runs page route from `/nodes` to `/client-runs` to prevent confusion with the node manager. You'll want to check if you've bookmarked or saved searches with `/nodes` in the path.

## Chef Automate 20180501212258

Released on May 1, 2018

### Improvements

- We added some new event types to the Event Feed, which means you'll see fewer question mark icons.

### Bug fixes

- Changed the header to reveal the top section of all pages in the app.

### Known Issues

- In Firefox, the link to display groupings of individual events on the Event Feed doesn't work.
- In Firefox, incorrect styling on a button for showing more details about successful runs causes it to exceed the page margin.

## Chef Automate 20180430173459

Released on April 30, 2018

### New features

- We now support Compliance Elasticsearch Migrations, both from Automate 1-to-Automate 2 and Automate 2-to-Automate 2. Our Beta customers can keep their data when upgrading to the latest Automate 2. Remember, a migration begins with the current day--today--and then works backward in time to the first record. While the current day--today--migrates, it blocks both ingestion and the UI, which makes the app look like it's taking a long time to start. A migration usually takes only a few minutes, but on larger systems--such as those with 150k nodes--a migration may take as long as 10 minutes. Migrations take place quietly and in the background. During the historical compliance data migration, the compliance service remains available for viewing and ingests new reports as usual. Migrations happen automatically at the compliance service start-up.

### Improvements

- Improved Compliance Profile Store: Install market profiles to your namespace faster. All market profiles included in Automate 2 are Inspec 2 compatible.
- Improved Compliance Reporting UI: Use a simpler single-date-picker in the search bar and adjust the trend graph to show the last ten days, month, three months, or year.

### Bug fixes

- Delete user session on logout.
- Fix Node Run Summary view shows run ID instead of the node ID.
- Define or specify users with *username* instead of *email* in the users API.
- Users in different timezones, meaning across UTCs, can view all the reports because we now account for differences in user's times as well as their dates.
- Legacy profile routes used by audit cookbook for fetching profiles have been exposed in A2, meaning you should now be able to refer to your installed A2 profiles when using the audit cookbook.

## Chef Automate 20180424200344

Released on April 30, 2018

### Bug fixes

- Fixed the `chef-automate admin-token` command. This command was non-functional in the previous release and would return an error like:

```plain
Failure: couldn't generate admin API token: rpc error: code = Unknown desc = permission API token: rpc error: code = InvalidArgument desc = invalid CreatePolicyReq.Subjects[0]: value doesn't match regex pattern "^(?:team|user):(?:local|ldap|saml):(?:[^:*]+|[*])$|^(?:(?:team|user):)?[*]$|^token:(?:[^:*]+|[*])$"
```

## Chef Automate 20180424150704

Released on April 24, 2018

### Bug fixes

- Fixed the `chef-automate admin-token` command. This command was non-functional in the previous release and would return an error like:

```
Failure: couldn't generate admin API token: rpc error: code = Unknown desc = permission API token: rpc error: code = InvalidArgument desc = invalid CreatePolicyReq.Subjects[0]: value doesn't match regex pattern "^(?:team|user):(?:local|ldap|saml):(?:[^:*]+|[*])$|^(?:(?:team|user):)?[*]$|^token:(?:[^:*]+|[*])$"
```

## Chef Automate 20180420141712

Released on April 24, 2018

### New features

- We've added the ability to collect anonymized usage and diagnostic data to help us improve your experience. On your first login, you'll see a checkbox to opt out. If you're upgrading to this version, you'll be automatically opted-in. If you'd like to opt out, click on your profile in the top right corner and select "About Chef Automate." But we'd like you to opt-in so that we can make the product better.

### Improvements

- Added the automatic node attributes to the Node Details page

### Bug fixes

- Fixed where the Event Feed guitar duplicated events across strings.
- Fixed an issue in the node detail view where the Run ID was displayed instead of the node name.

### Backward incompatibilities

- Removed all ``google.protobuf.Empty`` GRPC messages from ``config-mgmt-service`` and ``ingest-service endpoints``. This is a breaking change for service to service communication, but won't be a problem if you update all the Automate services at the same time. This change will be a problem for mixing old services with this version.

## Chef Automate 20180416135645

Released on April 16, 2018

### New features

- Added support for the new front-end telemetry endpoint. Users can control their telemetry settings in the welcome modal, which is accessible from the user dropdown in the nav by clicking 'About Chef Automate'.
- Added the command `admin-token` to the `chef-automate` CLI. It allows admins to generate an API token that also has admin level access. In particular, this is useful for changing the default permissions within Automate, as well as granting other API tokens access to the API. See `chef-automate admin-token --help` for more information.

### Improvements

- Increased continuity with new Automate colors on the Client Runs page.
- Shortened Elastic Search index names fit more Compliance time series indices on the URL without exceeding the 2k URL limit.
- Improved Compliance performance for all APIs using the ES backend datastore.
- Increased granularity in the Compliance UI, down to one day on the Compliance UI trend graphs.

### Bug fixes

- Client Runs/Node List UI icon sits in a column next to the text

### Backward incompatibilities

- Changed backend storage of the API Keys to use Postgres. The upgraded experience without the token migration is that all of the existing API Keys disappear. Migrate the existing API Keys with the following steps :

  - create an admin token, using `chef-automate admin-token` (or use an existing admin token, if you already created one)
  - run `hab pkg exec chef/authn-service migrate-tokens -auth-token <admin token>`

- Shortened Elastic Search index names fit more Compliance time series indices on the URL without exceeding the 2k URL length limit. Users need to first reset compliance data and then re-ingest all of their compliance data by re-sending the reports through to Automate. Use the following commands *while logged onto* their Automate instance:

```bash
### Delete compliance-service indices (we can not use a wildcard as `action.destructive_requires_name` is enabled)
curl -s http://localhost:10141/_cat/indices/comp*?h=i | while read compliance_index; do curl -X DELETE http://localhost:10141/$compliance_index; done

### Delete compliance-service templates
curl -X DELETE http://localhost:10141/_template/comp*

### Restart compliance-service
chef-automate restart-services
```

## Chef Automate 20180406143035

Released on April 9, 2018

### New features

- Hover over events on the guitar strings graph to see tooltip information.

### Improvements

- Added authorization coverage to all public API endpoints! 
- Updated design on the node details page to better show our Chef-ness.
- Added a summary panel to the event feed features a summary panel showing the total number of events for the last 7 days as well as a breakdown of create, delete, and update actions.

### Bug fixes

- See 'no data' when no data is available on the Client Runs page. Removed old and broken tooltips.
- Data ingestion with Chef Client 12 failed on runs sending resources with before and/or after attributes different from what Automate expected. Automate was adjusted for these cases and now successfully ingests the data.

### Upgrade notes and instructions

Automate 2 upgrades should occur automatically and are generally a hands-off process, but we may ask you to perform some manual tasks from time-to-time as we work to improve.

### Backward incompatibilities

-

## Chef Automate 20180403044658

Released on April 3, 2018

### New features

#### Introspection API

Use the introspection API endpoint to check current user permissions on HTTP endpoints exposed by the Automate 2 gateway with the `/admin/introspect` endpoint.

##### Request

`GET /admin/introspect`

Returns a list of all permitted, but non-parameterized, endpoints

Check individual endpoints, parameterized or not, with the HTTP POST method, passing the endpoint path (e.g. `{"path":"/admin/users/foo@bar.com"}`) as the body of the request.

### Improvements

#### Icons on the event feed

The Event Feed visualization has icons for each event type. See *what* events happened over the last week.

#### Configuration management authorization

All configuration management endpoints now undergo an authorization check. Users have default access to these endpoints by curl and the UI.

### Bug fixes

- see the latest compliance scan history result first instead of last
- filter by multiple profiles and multiple nodes
- multiple API methods of the same name but from different services are individually resolved (notably affected the GetVersion method, which exists on most services)
- nav icon tooltips now display in the UI

### Upgrade notes and instructions

Automate 2 upgrades should occur automatically and are generally a hands-off process, but we may ask you to perform some manual tasks from time-to-time as we work to improve this process.

This week, restart the Habitat supervisor process to clean up some stale state to prevent instability in the future:

```
sudo pkill hab-sup
```

### Backward incompatibilities

As new UI elements are being introduced, there are currently some caching issues. Clearing the browser cache is necessary if you've run Autoamte 2 previously to ensure the latest UI elements load properly.

## Chef Automate 20180326145220

Released on March 26, 2018

### New features

#### Event Feed visualization filtering

Select an event type from the Event Feed drop-down menu to display only that event-type on the guitar string.

#### New `chef-automate config` commands

The new commands allow a user to `show`, `set`, and `patch` Automate's config.

- `chef-automate config show` returns the TOML representation of the current override config that's persisted and applied by the `deployment-service`. Write the TOML to a file instead of `STDOUT` by giving a file path as the first position argument. e.g.:

  `chef-automate config show /etc/chef-automate/config.toml`

- `chef-automate config set` accepts the first positional argument as a path to a file containing the TOML AutomateConfig and makes a configuration set request to the `deployment-service`. There, the `deployment-service` validates, persists and applies the new configuration. The command then streams the converge output to `STDOUT` and exits appropriately, depending on the converge results. e.g.:

  `chef-automate config set /etc/chef-automate/config.toml`

- `chef-automate config patch` updates parts of the configuration without needing to first save and then modify the entire existing configuration. `patch` differs from `set` in the method that configuration is applied.  `patch` accepts a configuration subset, which is merged with the existing Automate config before it's applied, where `set` requires a full and validated configuration. `chef-automate config patch` accepts a positional argument to determine the configuration location. e.g.:

  `chef-automate config patch /etc/chef-automate/enable-debug.toml`

### Improvements

#### authz-service: Persistance of stored policies

Before, the policies stored in A2 were only kept in memory, and reset on every server restart.
Now, stored policies are persisted to A2's PostgreSQL instance, and thus survive restarts.
In the process, the bootstrapping logic for policies has changed: authz-service now ensures the policies we provide are in the database on startup and forbids deleting them.
For now, this is solved by having fixed IDs for the (three) default policies.

#### Extended wildcard matching for "subjects" in policies

Before, the only wildcard option for "subjects" in policies was `"*"`.
Now, in addition to that, partial wildcards are possible, like `"user:local:*"` for any local user, or `"client:*" for any API client.
This enables authorizing API clients to *only post data to the corresponding endpoint*, and not access any other API.

### Bug fixes

### Backward incompatibilities

- `chef-automate configure-service` no longer exists.
- `chef-automate config fetch` no longer exists.
- `chef-automate config set auth` no longer exists.

## Chef Automate 20180322085330

Released on March 22, 2018

### New features

#### Event feed visualization filters by type

If you select an event type, you'll notice that the 'guitar strings' visualization will show only events of that type.

#### No data experience for Client Runs

If a node has no client run data associated with it, you'll see it in the list but you won't be be able to click into the details (because there are none). Instead it will be marked with 'no data.'

### Improvements

### Bug fixes

#### Don't prefix external teams twice

In the previous release, an externally provided team would have been prefixed twice: for example, `admins` (LDAP) would be recognized and processed as `team:ldap:team:ldap:admins`.
As a consequence, policies written for `team:ldap:admins` would fail to match.

#### Unable to Install with `umask 0027`

Prior to this release, Chef Automate failed to install on systems with a restrictive `umask` of `0027`. Automate is now able to install on systems with this `umask` without needing to change system settings.

#### Elasticsearch not Starting Because of `noexec` Mounts

This release fixes an issue that prevented Elasticsearch from starting when there were no mounts available that the `hab` user could write to and exec from. Elasticsearch now creates and uses its own temp directory for loading the required executable code.

#### Sign out in Firefox

Fixed a bug that prevented you from signing out in Firefox. We don't want you to leave, but you should be able to have the choice.

#### Chef Server and Server Org filters on the left sidebar

Fixed some corner cases with the filter selection logic.

### Backward incompatibilities

#### Changed Subjects of local users for Policies

Changed the format of local user subjects in authorization policies. Before, this was `user:local:a980dc21-1d54-4614-86a8-a144fc91c282`, now, it's `user:local:admin@example.com`.

#### Policies are versioned in our public API

All policy creation requests now need to include a version key, e.g.

```json
    {
      "action": "*",
      "subjects": [
        "user:local:alice@example.com"
      ],
      "id": "06c293e7-e27a-4e7b-bb9d-11b83ba8b133",
      "resource": "cfgmgt:foo:bar",
      "effect": "allow",
      "version": "v0"
    }
```

## Chef Automate 20180319150121

Released on March 19, 2018

### Improvements

- Updated event-type dropdown filter on the event feed to use a custom element from our UI library
- Updated sidebar chef-server and organization loading to use ngrx/store
- Added loading state to the event feed
- Enabled configuring all settings in a new deployment with the `config.toml`

### Bug fixes

- Made the signout button clickable
- Selecting a chef-server or organization no longer deletes it on the backend
- Ingest a Chef run from year one and view the nodes on the nodes details page

### Backward incompatibilities

#### Default configuration changes

Changes to Chef Automate's internal data and file format configurations requires resetting configurations** manually on installations pre-dating 2018/03/09 (Y/M/D).

1. Install an updated version of the `chef-automate` tooling following the steps in the installation guide
2. Create a new Chef Automate configuration file

```bash
chef-automate init-config
```

1. Modify the `config.toml` to with your custom configurations
2. Apply the new configuration

```bash
systemctl stop chef-automate            # stop the Chef automate service
rm -rf /hab/sup/default/specs/*         # remove habitat service state
rm -rf /hab/svc/deployment-service/data # remove persisted configuration data
chef-automate deploy config.toml        # re-deploy with the config file from your initial deployment
```

#### Compliance Elasticsearch doc_type change

Changed the ElasticSearch document type for indices from `_doc` to `doc` to ensure backward compatibility with ElasticSearch 5. Users need to first reset compliance data and then re-ingest all of their compliance data by re-sending the reports through to Automate. Use the following commands *while logged onto* their Automate instance:

```bash
### Delete compliance-service indices (we can't use a wildcard as `action.destructive_requires_name` is enabled)
curl -s http://localhost:10141/_cat/indices/comp*?h=i | while read compliance_index; do curl -X DELETE http://localhost:10141/$compliance_index; done

### Delete compliance-service templates
curl -X DELETE http://localhost:10141/_template/comp*

### Restart compliance-service
chef-automate restart-services
```

#### Changed Subjects for Policies

Changed the format of user subjects in authorization policies. User subjects now contain a `local`, `SAML`, or `LDAP` namespace, depending on the login process, and an id. For example:

```bash
user:local:08a8684b-db88-4b73-90a9-3cd1661f5466
```
