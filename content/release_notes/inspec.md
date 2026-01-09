+++
title = "Chef InSpec release notes"
draft = false
product = ["inspec"]
linkTitle = "Chef InSpec"
summary = "Chef InSpec release notes"

[menu]
  [menu.release_notes]
    title = "Chef InSpec"
    identifier = "release_notes/release_notes_inspec.md Chef InSpec"
    parent = "release_notes"
    weight = 80
+++

<!-- markdownlint-disable-file -->
<!-- cSpell:disable  -->
<!-- vale off -->

## Chef InSpec 7.0.95

Release date: October 16th, 2025

### New features

#### Resource modernization

We've removed the following resources from InSpec core and are now releasing them separately in resource packs:

- docker_container
- docker_image
- docker_plugin
- docker_service
- elasticsearch
- ibmdb2_conf
- ibmdb2_session
- mongodb
- mongodb_conf
- mongodb_session
- opa_api
- opa_cli
- podman
- podman_container
- podman_image
- podman_network
- podman_pod
- podman_volume
- rabbitmq_config
- sybase_conf
- sybase_session

These resources are now bundled into the following resource packs:

- Docker
- Elasticsearch
- Ibmdb2
- MongoDB
- OPA
- Podman
- RabbitMQ
- Sybase

These resource packs are released as Ruby gems and you can add these gems as a dependency in an InSpec profile. For example:

```yaml
depends:
  - name: inspec-docker-resources
    gem: inspec-docker-resources
```

##### Resource pack availability

At the time of this release, the following resource packs _are_ available:

- Elasticsearch
- Docker
- MongoDB
- Podman
- RabbitMQ

At the time of this release, the following resource packs _aren't_ available:

- Ibmdb2
- OPA
- Sybase

The Ibmdb2, Sybase, and OPA resource packs will be made available as Ruby gems from Chef's Ruby gem server soon.
If you need to use resources from these resource packs, wait until they've been made available before you upgrade to Chef InSpec 7.

##### Resource pack features

Modularizing these resources into separate resource packs streamlines InSpec core, maintains full profile compatibility, and enables independent development and delivery of future resource packs.

We've added these features to help manage these gem-based resource packs:

- Automatic fallback to install missing resource pack gems, ensuring backward compatibility ([#7097](https://github.com/inspec/inspec/pull/7097))
- Automatic resolution of gem conflicts ([#7258](https://github.com/inspec/inspec/pull/7258))
- Improved dependency and source management for gem-based resources ([#7244](https://github.com/inspec/inspec/pull/7244))
- Version support for gem-based resources ([#7239](https://github.com/inspec/inspec/pull/7239))
- Support for vendoring gem-based resources ([#7355](https://github.com/inspec/inspec/pull/7355))

#### Licensing changes

Chef InSpec 7 may require a license to execute it depending on how you install it:

- The Chef Habitat package for Chef InSpec 7 doesn't require a license key to run.
- The `inspec` gem requires a license key to run.

Licensing is automatically managed based on the distribution and can't be manually enabled or disabled.

### Improvements

- Added support for `--log-level trace`, providing the most detailed logging for troubleshooting complex profile execution and resource loading issues. ([#7513](https://github.com/inspec/inspec/pull/7513))

### Bug fixes

- Resolved a gem version comparison type mismatch issue.  ([#7252](https://github.com/inspec/inspec/pull/7252))

### Dependency updates

- Upgraded Ruby to 3.4.2. ([#7380](https://github.com/inspec/inspec/pull/7380))
- Upgraded Habitat package for Ruby 3.4.x:
  - Windows ([#7401](https://github.com/inspec/inspec/pull/7401))
  - Linux ([#7400](https://github.com/inspec/inspec/pull/7400))
- Updated `tomlrb` from  >= 1.2  to  >= 1.3  ([#7328](https://github.com/inspec/inspec/pull/7328))
- Updated `faraday_middleware` from  >= 0.12.2, < 1.1  to  ~> 1.2, >= 1.2.1 . ([#7286](https://github.com/inspec/inspec/pull/7286))
- Updated `ostruct` from  ~> 0.1.0  to  >= 0.1, < 0.7  ([#7548](https://github.com/inspec/inspec/pull/7548))
- Updated `rubyzip` from  >= 1.2.2, < 3.0  to  >= 1.2.2, < 4.0  ([#7550](https://github.com/inspec/inspec/pull/7550))
- Updated `thor` from  >= 0.20, < 1.3.0  to  >= 0.20, < 1.5.0  ([#7551](https://github.com/inspec/inspec/pull/7551))
- Updated `parslet` from  >= 1.5, < 2.0  to  >= 1.5, < 3.0  ([#7552](https://github.com/inspec/inspec/pull/7552))
- Updated `rspec-its` from  ~> 1.2  to  >= 1.2, < 3.0  ([#7553](https://github.com/inspec/inspec/pull/7553))

## Chef InSpec 6.8.24

Release date: 29 January, 2025.

### New features

- Deprecation notice about moving core resource packs to their individual gems after the next major release ([#7219](https://github.com/inspec/inspec/pull/7219))

- Added the `--legacy` flag to the inspec automate upload command. ([#7200](https://github.com/inspec/inspec/pull/7200))

  The `inspec automate upload` command runs `inspec check` and `inspec export`, which were updated in Chef InSpec 5.22.36. This update led to a bug with InSpec profiles with `=begin =end`.

  Use the `--legacy` flag with profiles where the newer export and check methods may fail to parse older profiles correctly, particularly due to limitations in AST parsing.

### CVEs

- Fixes HTTP Request Smuggling in ruby webrick [CVE-2024-47220](https://nvd.nist.gov/vuln/detail/cve-2024-47220). ([#7214](https://github.com/inspec/inspec/pull/7214))
- Fixes the REXML denial of service vulnerability [CVE-2024-43398](https://nvd.nist.gov/vuln/detail/CVE-2024-43398). ([#7199](https://github.com/inspec/inspec/pull/7199))
- Fixes the REXML ReDoS vulnerability [CVE-2024-49761](https://nvd.nist.gov/vuln/detail/CVE-2024-49761). ([#7199](https://github.com/inspec/inspec/pull/7199))

### Improvements

- Use of a better cryptographic hashing algorithm on sensitive data. ([#7261](https://github.com/inspec/inspec/pull/7261))
- Improvements in the error handling of the plugin installation error. ([#7161](https://github.com/inspec/inspec/pull/7161))
- Fixed the encoding issues with special characters in passwords for Postgres Session resource ([#7277](https://github.com/inspec/inspec/pull/7277))

## Chef InSpec 6.8.11

Release date: November 6, 2024

### Enhancement

- Improved error handling when evaluating Chef InSpec licenses. ([#7121](https://github.com/inspec/inspec/pull/7121))
- Improved license & entitlement management and disabled telemetry for InSpec under Test Kitchen. ([#7168](https://github.com/inspec/inspec/pull/7168))

### Improvements

- Improved regular expressions used to load README files from InSpec profiles. ([#7198](https://github.com/inspec/inspec/pull/7198))

### Bug fixes

- The oracledb_session resource has the following bug fixes:

  - The oracledb_session resource now correctly executes profiles against Oracle Database 12 on Solaris.
  - The oracledb_session resource now correctly passes queries with certain special characters and escape backslashes to Oracle SQL. Previously, queries with special characters like `,` or `$` that were escaped using a double backslash (for example, `\\,`) were converted by oracledb_session to have four backslashes (for example `\\\\,`). ([#7136](https://github.com/inspec/inspec/pull/7136))

- The postgres_session resource now correctly returns an error when password authentication fails. ([#7154](https://github.com/inspec/inspec/pull/7154))

## Chef InSpec 6.8.1

Release date: July 31, 2024

### New features

- Added the sshd_active_config resource, which finds and tests configuration data for the OpenSSH daemon. ([#7070](https://github.com/inspec/inspec/pull/7070))
- Added the ssh_key resource which verifies the following SSH key types: RSA, ECDSA, DSA, and Ed25519. ([#6656](https://github.com/inspec/inspec/pull/6656))
- Added telemetry reporting for free and trial users. ([#6012](https://github.com/inspec/inspec/pull/6012))

### Enhancement

- Added C shell support to the sybase_session resource. ([#7069](https://github.com/inspec/inspec/pull/7069))

### Improvements

- Improved the InSpec Parallel status reporter, which was blinking when reporting the status of a profile with a lot of options. ([#6693](https://github.com/inspec/inspec/pull/6993))
- Updated the output of the `cmp` matcher when a control fails while using a negation such as 'should_not'. ([#6862](https://github.com/inspec/inspec/pull/6862))

  For example, if the value of `key` is `3`, then this fails:

  ```ruby
  its(key) { should_not cmp "3" }
  ```

  and returns this output:

  ```plain
  expected: 3
       got: 3
  ```

  The updated output returns:

  ```plain
  expected it not to be == "3"
       got: 3
  ```

  Thanks [@Taknok](https://github.com/Taknok)!

### Security improvements

- Improved the security of the nftables and oracledb_session resources when handling potentially malicious strings. ([#7078](https://github.com/inspec/inspec/pull/7078))
- Improved the security of the InSpec CLI when potentially malicious strings are passed as arguments. ([#7077](https://github.com/inspec/inspec/pull/7077))
- Improved the security of InSpec when handling strings that define a file path or URI of a fetched resource. ([#7079](https://github.com/inspec/inspec/pull/7079))

### Bug fixes

- The URL fetcher no longer uses the `git ls-remote` command without the `--symref` option. This was removed due to an incompatibility on Ubuntu 16 and RHEL 7 platforms. ([#7043](https://github.com/inspec/inspec/pull/7043))
- Fixed the `Uninitialized constant Parser::AST::Processor::Mixin` error with the Parser gem dependency. ([#7030](https://github.com/inspec/inspec/pull/7030))
- Fixed an error with the URL fetcher, which failed to work when executing from a directory that's not a Git repository. ([#7023](https://github.com/inspec/inspec/pull/7023))
- Removed the "Unrecognized feature name" warning when executing a profile with a custom InSpec reporter plugin. ([#6988](https://github.com/inspec/inspec/pull/6988))
- Fixed the `virtualization.virtual_system?` helper in the virtualization resource to correctly return `true` if run against a Podman container. ([#6947](https://github.com/inspec/inspec/pull/6947))
- Fixed the streaming reporter so that it captures InSpec scan progress correctly. ([#6912](https://github.com/inspec/inspec/pull/6912))
- Chef InSpec now correctly waives controls when run in Chef Infra Client Compliance Phase. ([#6919](https://github.com/inspec/inspec/pull/6919))
- Removed dependency on the activesupport Gem by removing the `blank?` method. ([#6914](https://github.com/inspec/inspec/pull/6914))
- Fixed the reporter integration used in Chef Infra Client Compliance Phase, which returned an undefined method error. ([#6859](https://github.com/inspec/inspec/pull/6859))

## Chef InSpec 6.6.0

Release date: November 14, 2023

### Chef licensing

Chef InSpec now requires a license key to run.
Before you can execute scans with InSpec, you must accept the Chef EULA and add a license key.

Commercial users can find their license key in [Chef Support Hub](https://community.progress.com/s/products/chef).  Users can [request a Free or Trial license](https://www.chef.io/licensing/inspec/license-generation-free-trial) that comes with product limitations. See the license tiers section below.

For more information on adding a license key to InSpec and Chef licenses, see [Chef InSpec's licensing documentation](https://docs.chef.io/inspec/license/) and [Chef licensing documentation](https://docs.chef.io/licensing/).

#### License tiers

We've updated the Chef End User License Agreement (EULA). The terms of the EULA are the same as they were before, but we've created three license tiers: Free, Trial, and Commercial.

The Free tier allows personal/non-commercial users to scan 10 targets for an unlimited period of time.
The Trial tier allows trial users to scan unlimited targets for 30 days.
The Commercial tier gives users the features and benefits that come with the subscription they've purchased.

Users who would like to try Chef InSpec 6 can [request a free or trial license](https://www.chef.io/licensing/inspec/license-generation-free-trial), which comes with product limitations.

See our [licensing documentation](https://docs.chef.io/licensing/) or contact [Chef Support](https://community.progress.com/s/products/chef) for more information.

### New features

#### InSpec Parallel

The new `inspec parallel` command allows you to simultaneously run multiple audits on multiple cloud or on-prem targets.
This can speed up audits and allow you to remediate problems more quickly.

For more information, see the [InSpec Parallel documentation](https://docs.chef.io/inspec/parallel/)

#### Audit Logging (Preview)

Audit Logging logs the commands and file accesses made through the underlying Train connection.
To enable this feature, set the environment variable `CHEF_PREVIEW_AUDIT_LOGGING` to any non-empty value and Chef InSpec will write logs to `~/.inspec/logs/inspec-audit-TIMESTAMP-PID.log` in JSON format.

This is a preview feature with limited capabilities. We're seeking user feedback for future feature development.
For more details, see [InSpec Audit Log](https://docs.chef.io/inspec/audit_log/).

#### Mandatory Profile Signing (Preview)

If you set the environment variable `CHEF_PREVIEW_MANDATORY_PROFILE_SIGNING` to any non-empty value, Chef InSpec 6 will only execute signed profiles for all profile executions.
Signed profiles, or `.iaf` files, are digital artifacts created using the `inspec sign` command.
They can be used to create a chain of trust between your content author and your compliance target.

For more information on the feature, which is in preview in Chef InSpec 6 but will be enabled in a future major version, please see [InSpec Signing](https://docs.chef.io/inspec/signing/).

### Bug fixes

#### Waiver files

We improved how InSpec handles malformed waiver files. ([6644](https://github.com/inspec/inspec/pull/6644))

Previously, InSpec would run until it finished processing a profile and then return an error if there was a problem with a waiver file. Error messages could be quite long and it could take InSpec hours to complete large profiles, wasting users' time.

Now InSpec exits immediately and returns an error if it detects a malformed waiver file. This includes waiver files missing required parameters and YAML files that fail linting.

#### InSpec Check and InSpec Export

We overhauled the `inspec check` and `inspec export` commands to use the parser library to improve security. ([6849](https://github.com/inspec/inspec/pull/6849))

### Breaking changes

- We no longer support Ruby 2.7 since it became end-of-life (EOL) in March 2023.

## Chef InSpec 5.23.6

Release date: September 23, 2025

### New features

- We added SOCKS5 proxy and Kerberos authentication options in the InSpec CLI. ([#7448](https://github.com/inspec/inspec/pull/7448))

  - Added the `--socks_proxy` option to specify a SOCKS5H proxy URL for tunneling WinRM connections.
  - Added the `--socks_user` and `--socks_password` options for authenticating with a SOCKS5 proxy.
  - Added the `--kerberos_realm` and `--kerberos_service` options for Kerberos authentication.

### Improvements

- Added Omnibus build support for macOS 13 and 14 on ARM64 architecture. ([#7524](https://github.com/inspec/inspec/pull/7524))

### Dependency updates

- Updated the `mongo` gem to version 2.21.3. ([#7504](https://github.com/inspec/inspec/pull/7504/))
- Updated train dependencies. ([#7508](https://github.com/inspec/inspec/pull/7508/))

  - `train/train-core` to >= 3.13.4
  - `train-winrm` to >= 0.4.0

- Updated `signet` to < 0.22.0. ([#7511](https://github.com/inspec/inspec/pull/7511/))

## Chef InSpec 5.22.95

Release date: August 5, 2025

### Bug fixes

- We fixed the Git fetcher so that it now correctly clears empty or invalid cache directories if it fails to fetch a profile from a Git repository. Previously, these empty directories would lead Test Kitchen to fail. ([#7398](https://github.com/inspec/inspec/pull/7398))
- We fixed the `Tried to load unspecified class: Date error` error that occurred when running an InSpec profile with a waiver file containing `expiration_date` while using the `--filter-waived-controls` flag. ([#7391](https://github.com/inspec/inspec/pull/7391))

#### Security fixes

- Upgraded rack in Omnibus from `2.2.11` to `2.2.14`. ([#7428](https://github.com/inspec/inspec/pull/7428)
- Upgraded thor from `>= 0.20, < 1.3.0` to `>= 0.20, < 1.5.0`. ([#7442](https://github.com/inspec/inspec/pull/7442))
- Upgraded thor for Omnibus from `1.3.1` to `1.4.0`. ([#7461](https://github.com/inspec/inspec/pull/7461)).

### Dependency updates

- Dropped Ruby 3.0 support. ([#7359](https://github.com/inspec/inspec/pull/7359))
- Upgraded Ruby and Ruby Devkit to 3.1.7 for Habitat packages.
- Upgraded Ruby and Ruby Devkit to 3.1.7 for Omnibus packages. ([#7423](https://github.com/inspec/inspec/pull/7423))
- Upgraded `rspec-its` from `~> 1.2` to `>= 1.2, < 3.0`. ([#7436](https://github.com/inspec/inspec/pull/7436))
- Upgraded `rspec` from `>= 3.9, <= 3.12` to `>= 3.9, <= 3.14`. ([#7432](https://github.com/inspec/inspec/pull/7432))
- Upgraded `rubyzip` from `>= 1.2.2, < 3.0` to `>= 1.2.2, < 4.0`. ([#7469](https://github.com/inspec/inspec/pull/7469))

## Chef InSpec 5.22.80

Release date: May 7, 2025

### Improvements

- We improved error handling in the `audit_policy` resource by raising a resource failure when the exit status is non-zero. This fixes issues such as `Error 0x00000057 occurred: The parameter is incorrect` on Windows clients. ([#7319](https://github.com/inspec/inspec/pull/7319))

- We've updated Train to handle newer versions of Windows where the WMI command-line (WMIC) utility is deprecated, for example, on Windows 10 version 21H1 and Windows Server 2022.
  Previously, Train returned the following error: `'windows_uuid_from_wmic': undefined method 'strip' for nil:NilClass`.
  In those newer Windows versions, Train now uses PowerShell's `Get-CimInstance` to detect the UUID.
  ([train #789](https://github.com/inspec/train/pull/789/)), ([train #788](https://github.com/inspec/train/pull/788/))

### Bug fixes

- We fixed the `inspec check` command when running profiles with empty files or files with only comments and no tests. ([#7332](https://github.com/inspec/inspec/pull/7332))

#### Waiver files

- We improved notifications when running a waiver with an empty waiver file. Previously, InSpec failed with an error, now it emits a warning and continues to run the profile. ([#7339](https://github.com/inspec/inspec/pull/7339))

- We added an error notification if executing a waiver with an unsupported file type. ([#7339](https://github.com/inspec/inspec/pull/7339))

- We improved errors when running a waiver with a malformed waiver file. Previously, InSpec would continue to run if a waiver file failed a lint, and then it would return an error notification with the first control after completing the profile. Now it exits immediately and returns an error. ([#6644](https://github.com/inspec/inspec/pull/6644))

- We added an error notification when running a waiver with a waiver file that's missing required parameters. ([#6644](https://github.com/inspec/inspec/pull/6644))

## Chef InSpec 5.22.72

Release date: March 5, 2025.

### Improvements

- Updated the group's resource to use the `getent` utility ([#7284](https://github.com/inspec/inspec/pull/7284)).

  Updated the `groups` resource to retrieve group information using the `getent` utility instead of directly reading from the `/etc/group` file. This resolves failures when groups exist but aren't listed in the `/etc/group` file.

### CVEs

- Upgraded Rack from 2.2.9 to 2.2.11 to address [CVE-2025-25184](https://nvd.nist.gov/vuln/detail/CVE-2025-25184). ([#7316](https://github.com/inspec/inspec/pull/7316))
- Updated train-winrm from 0.2 to 0.2.17 to address [CVE-2024-49761](https://nvd.nist.gov/vuln/detail/CVE-2024-49761). ([#7296](https://github.com/inspec/inspec/pull/7296))

### Bug fixes

- Fixed an issue in the `postgres_session` resource for special characters in passwords ([#7276](https://github.com/inspec/inspec/pull/7276)).

  Formatted and encoded the password variable for `postgres_session` to avoid breaking the connection string.

## Chef InSpec 5.22.65

Release date: December 13, 2024

### New features

- Added the `--legacy` flag to the `inspec automate upload` command. ([#7200](https://github.com/inspec/inspec/pull/7200))

  The `inspec automate upload` command runs `inspec check` and `inspec export`, which were overhauled in Chef InSpec 5.22.36. This overhaul led to a bug with InSpec profiles with `=begin =end`.

  Use the `--legacy` flag with profiles where the newer export and check methods may fail to parse older profiles correctly, particularly due to limitations in AST parsing.

### CVEs

- Upgraded Ruby Webrick from 1.8.1 to 1.9.1 to address [CVE-2024-47220](https://nvd.nist.gov/vuln/detail/cve-2024-47220). ([#7236](https://github.com/inspec/inspec/pull/7236))

### Improvements

- Improved regular expressions used to load README files from InSpec profiles. ([#7198](https://github.com/inspec/inspec/pull/7198))

### Dependency updates

- Upgraded Ruby and Ruby Devkit to 3.1.6 due to outdated embedded Perl version in Ruby 3.1.2. ([#7174](https://github.com/inspec/inspec/pull/7174))

## Chef InSpec 5.22.58

Release date: September 3, 2024

### Improvements

- Upgraded the minimum version of Ruby version from 2.4.0 to 3.0.3. ([#6790](https://github.com/inspec/inspec/pull/6790))

### Bug fixes

- The oracledb_session resource has the following bug fixes:

  - oracledb_session resource now correctly executes profiles against Oracle Database 12 on Solaris
  - The oracledb_session resource now correctly passes queries
    with certain special characters and escape backslashes to Oracle SQL.
    Previously queries with special characters like `,` or `$` that were escaped using a double backslash (for example, `\\,`)
    were converted by oracledb_session to have four backslashes (for example `\\\\,`).

  ([#7136](https://github.com/inspec/inspec/pull/7136))

- The postgres_session resource now correctly returns an error when the password authentication fails. ([#7154](https://github.com/inspec/inspec/pull/7154))

## Chef InSpec 5.22.55

Release date: August 5, 2024

### Enhancement

- Added C shell support to the sybase_session resource. ([#7069](https://github.com/inspec/inspec/pull/7069))

### Security improvements

- Improved the security of the nftables and oracledb_session resources when handling potentially malicious strings. ([#7078](https://github.com/inspec/inspec/pull/7078))
- Improved the security of the InSpec CLI when potentially malicious strings are passed as arguments. ([#7077](https://github.com/inspec/inspec/pull/7077))
- Improved the security of InSpec when handling strings that define a file path or URI of a fetched resource. ([#7079](https://github.com/inspec/inspec/pull/7079))

## Chef InSpec 5.22.50

Release date: May 22, 2024

### Bug fixes

- Fixed the `virtualization.virtual_system?` helper in the virtualization resource to correctly return `true` if run against a Podman container. ([#6949](https://github.com/inspec/inspec/pull/6949))
- Silenced warnings about transforming the URL fetcher into the git fetcher when executing profiles from a Git repository. This message is now added to the debug log. ([#6956](https://github.com/inspec/inspec/pull/6956))
- Fixed the `Uninitialized constant Parser::AST::Processor::Mixin` error with the Parser gem dependency. ([#7036](https://github.com/inspec/inspec/pull/7036))
- Fixed an error with the URL fetcher which failed to work when the current directory isn't a Git repository. ([#7023](https://github.com/inspec/inspec/pull/7023))

### Improvements

- Updated the output of the `cmp` matcher when a control fails while using a negation such as 'should_not'. ([#6986](https://github.com/inspec/inspec/pull/6986))

  For example, if the value of `key` is `3`, then this fails:

  ```ruby
  its(key) { should_not cmp "3" }
  ```

  and returns this output:

  ```plain
  expected: 3
       got: 3
  ```

  The updated output returns:

  ```plain
  expected it not to be == "3"
       got: 3
  ```

  Thanks [@Taknok](https://github.com/Taknok)!

## Chef InSpec 5.22.40

Release date: January 24, 2024

### Bug fixes

- Fixed the progress-bar reporter so the progress of an InSpec execution that includes an `its` block is displayed correctly. ([#6936](https://github.com/inspec/inspec/pull/6936))
- Fixed an issue where waivers were ignored when they were sent by Chef Infra Client in Compliance Phase using InSpec inputs. ([#6920](https://github.com/inspec/inspec/pull/6920))
- Removed dependency on the activesupport Gem by removing the `blank?` method. ([#6916](https://github.com/inspec/inspec/pull/6916))

## Chef InSpec 5.22.36

Release date: November 14, 2023

### Bug fixes

- Overhauled the `inspec check` and `inspec export` commands to use the parser library to improve security. ([6849](https://github.com/inspec/inspec/pull/6849))
- Fixed the security_policy resource, which was returning an array instead of a string for single values. ([6854](https://github.com/inspec/inspec/pull/6854))
- Fixed the `html2` reporter. The HTML output was improperly hiding controls when clicking checkboxes if a profile was inherited. ([#6811](https://github.com/inspec/inspec/pull/6811))
- Fixed the `inspec json` command, which failed to read CLI options properly. ([#6814](https://github.com/inspec/inspec/pull/6814))
- Fixed an issue with Chef Infra Client Compliance Phase in which the reporter integration was broken. ([6860](https://github.com/inspec/inspec/pull/6860))

## Chef InSpec 5.22.29

Release date: October 31, 2023

### End User License Agreement

We've updated the Chef End User License Agreement (EULA).
The terms of the EULA are the same as they were before, but we've created three licensing tiers: Free, Trial, and Commercial.

The Free tier allows personal/non-commercial users to scan 10 targets for an unlimited period of time.
The Trial tier allows trial users to scan unlimited targets for 30 days.
The Commercial tier gives users the features and benefits that come with the subscription they've purchased.

Contact [Chef Support](https://community.progress.com/s/products/chef) for more information.

### Security updates

Updates in this release provide fixes for the following CVE(s):

- CVE-2023-42658 InSpec archive command vulnerable to maliciously crafted profile (#[6721](https://github.com/inspec/inspec/pull/6721))

### Improvements

- Updated the Docker base image to support Ubuntu 22.04. ([#6526](https://github.com/inspec/inspec/pull/6526))
- Updated the Docker base image to support Mac M1 ([#6541](https://github.com/inspec/inspec/pull/6541))
- Updated the `--reporter` and `--config` CLI options so that reporter options in a config file are merged with reporter options set with the `--reporter` CLI option. ([#6568](https://github.com/inspec/inspec/pull/6568))

### Bug fixes

- Fixed controls in waiver files that were not getting waived if the control failed. ([#6588](https://github.com/inspec/inspec/pull/6588))
- Fixed `inspec exec` so that it can correctly fetch a profile from a repository that isn't managed with Git and doesn't have a `.git` directory. ([#6640](https://github.com/inspec/inspec/pull/6640))
- Fix for missing nil check for control variable in formatter's base. ([#6629](https://github.com/inspec/inspec/pull/6629))

## Chef InSpec 5.22.3

Release date: May 18, 2023

### New features

#### train-kubernetes

The train-kubernetes plugin now ships with Chef InSpec. This plugin allows you to perform compliance checks with the Kubernetes API. ([#6512](https://github.com/inspec/inspec/pull/6512))

See the [documentation on train plugins](https://docs.chef.io/inspec/plugins/) for more information about using train with Chef InSpec.
See the [train-kubernetes repository](https://github.com/inspec/train-kubernetes) for more information on train-kubernetes.

### New resources

Added the new nftables InSpec audit resource. This allows you to test IP packet filtering rules that are defined with nftables. ([#6499](https://github.com/inspec/inspec/pull/6499))

### Improvements

- Added support to the `postgres_session` resource for custom ports with a socket connection to the . ([#6494](https://github.com/inspec/inspec/pull/6494))

### Packaging

#### RHEL 9

Added support for installing Chef InSpec on RHEL 9. Scanning support already existed. ([#6403](https://github.com/inspec/inspec/pull/6403))

### Bug fixes

- Fix for a profile gem dependency loading issue when a dependent gem is required inside profile libraries. ([#6408](https://github.com/inspec/inspec/pull/6408))
- Fix for when a version of a profile dependency is specified that doesn't follow SemVer format. ([6410](https://github.com/inspec/inspec/pull/6410))
- Fix for configuring headers in the http resource on Windows using remote transport. ([#6484](https://github.com/inspec/inspec/pull/6484))
- Fix for host resource to resolve multiple IP addresses on Windows. ([#6481](https://github.com/inspec/inspec/pull/6481))

## Chef InSpec 5.21.29

Release date: January 24, 2023

### New features

- Added the `--enhanced-outcomes` option to the InSpec CLI. ([#6145](https://github.com/inspec/inspec/pull/6145))
- Added support for waiver files in CSV and JSON file formats. ([#6369](https://github.com/inspec/inspec/pull/6369))
- Added new Podman resources for testing containers, images, pods, volumes, and networks. ([#6183](https://github.com/inspec/inspec/pull/6183))
- Added the `only_applicable_if` keyword to the InSpec DSL. This allows you to mark a control as "not applicable" if the `only_applicable_if` block evaluates to `false`. ([#6229](https://github.com/inspec/inspec/pull/6229))

### Enhancements

- Enhanced the `lxc` resource to test properties ([#6243](https://github.com/inspec/inspec/pull/6243))

### Bug fixes

- Fixed the `inspec sign` command which would break if a period was included in the profile name. ([#6261](https://github.com/inspec/inspec/pull/6261))
- Fixed compatibility issues with the `oracledb_session` resource when run on AIX with C shell. ([#6257](https://github.com/inspec/inspec/pull/6257))
- Fixed the `launchd_service` resource so that a negative status doesn't make it crash. ([#6262](https://github.com/inspec/inspec/pull/6262))
- Fixed an issue when installing the train-kubernetes plugin. ([#6334](https://github.com/inspec/inspec/pull/6334))
- Fixed an undefined method error when running an InSpec command in airgrapped environments. ([#6337](https://github.com/inspec/inspec/pull/6337))
- Update Ruby from 2.7.4 to 3.1.2 for omnibus builds. This fixes two CVEs (CVE-2021-41819 and CVE-2021-41816). ([#6341](https://github.com/inspec/inspec/pull/6341))
- Fixed a bug in profiles that have a dependency that includes a dash followed by a release version (e.g. 2.2.0-13). ([#6377](https://github.com/inspec/inspec/pull/6377))

## Chef InSpec 5.18.14

Release date: July 13, 2022

### New features

- Added `inspec sign` command to enable creation of signed IAF files. ([#5995](https://github.com/inspec/inspec/pull/5995))
- Aliased the `inspec json` to the `inspec export` command. ([#5995](https://github.com/inspec/inspec/pull/5995))
- Added support for `resource_id` to all core resources. ([#6126](https://github.com/inspec/inspec/pull/6126), [#6119](https://github.com/inspec/inspec/pull/6119), [#6115](https://github.com/inspec/inspec/pull/6115), [#6112](https://github.com/inspec/inspec/pull/6112), [#6111](https://github.com/inspec/inspec/pull/6111), [#6110](https://github.com/inspec/inspec/pull/6110), [#6109](https://github.com/inspec/inspec/pull/6109), [#6108](https://github.com/inspec/inspec/pull/6108), [#6107](https://github.com/inspec/inspec/pull/6107), [#6106](https://github.com/inspec/inspec/pull/6106), [#6105](https://github.com/inspec/inspec/pull/6105), [#6103](https://github.com/inspec/inspec/pull/6103), [#6102](https://github.com/inspec/inspec/pull/6102), [#6101](https://github.com/inspec/inspec/pull/6101))
- Added support for Podman. ([#6159](https://github.com/inspec/inspec/pull/6159))

### Enhancements

- Enhanced the **x509_certificate** resource with new properties and matchers. ([#6041](https://github.com/inspec/inspec/pull/6041))

### Bug fixes

- Fixed the **processes** resource to consider processes without paths on Windows. ([#6100](https://github.com/inspec/inspec/pull/6100))
- Fixed a situation in which having a dependency on the same profile at different versions could lead to misleading results. ([#6074](https://github.com/inspec/inspec/pull/6074))

## Chef InSpec 5.17.4

Release date: May 24, 2023

### New features

- Added `zfs` resource ([#6004](https://github.com/inspec/inspec/pull/6004))

### Bug fixes

- Fixed `service` resource on `amazonlinux2022` ([#5998](https://github.com/inspec/inspec/pull/5998))
- Fixed `inspec json` command failing to populate the `inputs` field for the profile ([#6056](https://github.com/inspec/inspec/pull/6056))
- Fixed profile gem dependency installation failure when gem version isn't specified ([#6057](https://github.com/inspec/inspec/pull/6057))

## Chef InSpec 5.14.0

Release date: April 21, 2022

### New features

- Added `default_gateway` resource ([#5979](https://github.com/inspec/inspec/pull/5979)).
- Added `linux_audit_system` resource ([#5988](https://github.com/inspec/inspec/pull/5988)).

### Improvements

- Enhanced `file` resource, adding `be_immutable` matcher, `content_as_yaml` and `content_as_json` properties ([#5986](https://github.com/inspec/inspec/pull/5986)).
- Enhanced `service` resource with `be_monitored_by` and `have_start_mode` matchers ([#5981](https://github.com/inspec/inspec/pull/5981)).
- Enhanced `group` resource with `have_gid` matcher ([#5987](https://github.com/inspec/inspec/pull/5987)).

### Bug fixes

- By default, make cookstyle checks for `inspec check` optional  ([#5989](https://github.com/inspec/inspec/pull/5989)).

## Chef InSpec 5.12.2

Release date: April 8, 2022

### New features

- Added `mail_alias` resource ([#5961](https://github.com/inspec/inspec/pull/5961))
- Added `routing_table` resource ([#5972](https://github.com/inspec/inspec/pull/5972))

### Improvements

- Enhancements to output of progress-bar reporter ([#5966](https://github.com/inspec/inspec/pull/5956))
- Enhanced `docker_container` resource with `have_volume` matcher ([#5944](https://github.com/inspec/inspec/pull/5944))
- Enhanced `docker_image` resource with low-level "inspection" properties. ([#5945](https://github.com/inspec/inspec/pull/5945))
- Enhanced `user` resource with new matchers and properties ([#5959](https://github.com/inspec/inspec/pull/5959))

### Bug fixes

- Fixed the `service` resource on BSD to ensure installed: true isn't always returned. ([#5948](https://github.com/inspec/inspec/pull/5948))
- Updated Cisco XE device detection (train [#728](https://github.com/inspec/train/pull/728))

## Chef InSpec 5.10.5

Release date: March 23, 2022

### New features

- Added Linux container resource `lxc`. ([#5921](https://github.com/inspec/inspec/pull/5921))
- Re-added `ppa` resource. ([#5931](https://github.com/inspec/inspec/pull/5931))
- Added `cgroup` resource. ([#5935](https://github.com/inspec/inspec/pull/5935))

### Improvements

- Added the ability to detect Kubernetes and Podman containers to the `virtualization` resource. ([#5796](https://github.com/inspec/inspec/pull/5796))
- Description added to `inspec plugin list` and `search` commands. ([#5936](https://github.com/inspec/inspec/pull/5936))

### Bug fixes

- Fixed `postgres_session` resource to allow query errors to be tested rather than treated as control failures. ([#5937](https://github.com/inspec/inspec/pull/5937))
- Fixed `oracledb_session` resource when query has empty result. ([#5938](https://github.com/inspec/inspec/pull/5938))
- Fixed command timeout ignored when used with sudo on ssh transport. (train [#727](https://github.com/inspec/train/pull/727))

## Chef InSpec 5.7.9

Release date: March 17, 2022

### New features

- Enable SSL-based authentication over WinRM. ([#5793](https://github.com/inspec/inspec/pull/5793))
- Added `resource_id` property in the base class resources and also added to the JSON-based reporters. ([#5875](https://github.com/inspec/inspec/pull/5875), [#5890](https://github.com/inspec/inspec/pull/5890))
- Added the `ipnat` resource. ([#5883](https://github.com/inspec/inspec/pull/5883))
- Added the `ipfilter` resource. ([#5880](https://github.com/inspec/inspec/pull/5880))
- Added `progress-bar` real-time reporter. ([#5863](https://github.com/inspec/inspec/pull/5863))
- Added ability to declare and install `gem` dependencies part of the profile metadata file. ([#5871](https://github.com/inspec/inspec/pull/5871))
- Added the `cron` resource, a compatibility alias for the `crontab` resource. ([#5891](https://github.com/inspec/inspec/pull/5891))
- Added a resource code generator, `inspec init resource`. ([#5913](https://github.com/inspec/inspec/pull/5913))

### Improvements

- Added `target_id` sourced from `train` to the reporter interface. ([#5895](https://github.com/inspec/inspec/pull/5895))
- Added new properties and matchers to the `firewalld` resources. ([#5597](https://github.com/inspec/inspec/pull/5597))
- Added `lazy_instance` option to `FilterTable`, allowing plural resource definitions to conveniently access the resource instance with the lazy-loading columns. (#[5916](https://github.com/inspec/inspec/pull/5916))

### Bug fixes

- Fixed `--no-diff` option when the message contains a newline. ([#5884](https://github.com/inspec/inspec/pull/5884))
- Fixed the `inspec automate version` command to work properly. ([#5893](https://github.com/inspec/inspec/pull/5893))

### Breaking changes

- InSpec is now based on Ruby 3. You may need to reinstall plugins and `gem` dependencies of plugins.
- Removed legacy AWS and Azure resources from InSpec core. Since 2018, active development on these resources was part of the resource packs, and these old versions aren't maintained. ([#5915](https://github.com/inspec/inspec/pull/5915))
- Deprecated the `--target-id` CLI option. ([#5918](https://github.com/inspec/inspec/pull/5918))

## Chef InSpec 4.56.58

### End User License Agreement

We've updated the Chef End User License Agreement (EULA).
The terms of the EULA are the same as they were before, but we've created three licensing tiers: Free, Trial, and Commercial.

The Free tier allows personal/non-commercial users to scan 10 targets for an unlimited period of time.
The Trial tier allows trial users to scan unlimited targets for 30 days.
The Commercial tier gives users the features and benefits that come with the subscription they've purchased.

Contact [Chef Support](https://community.progress.com/s/products/chef) for more information.

### Security updates

Updates in this release provide fixes for the following CVE(s):

- CVE-2023-42658 InSpec archive command vulnerable to maliciously crafted profile (#[6720](https://github.com/inspec/inspec/pull/6720))

### Bug fixes

- Fixed resolving dependent profiles so that it works regardless of what version scheme you use for version pinning, not just semver (#[6471](https://github.com/inspec/inspec/pull/6471))
- Fixed the `service` resource to prevent negative status from crashing launchd resource ([#6751](https://github.com/inspec/inspec/pull/6751))
- Fixed the `inspec exec` command so that it can fetch a profile from a repository that isn't managed with Git and doesn't have a `.git` directory. ([#6750](https://github.com/inspec/inspec/pull/6750))
- Fixed the `inspec json` command so that inputs specified in an `inspec.yml` file are included in the output JSON file. ([#6059](https://github.com/inspec/inspec/pull/6059))
- Fixed an issue where a profile that includes different versions of a dependency would only list one of the versions in the reporter output. ([#6163](https://github.com/inspec/inspec/pull/6163))

#### InSpec resources

- Fixed the `mongodb_session` resource to log the info level instead of the debug level in profile run results. ([#6752](https://github.com/inspec/inspec/pull/6752))
- Fixed a bug with the `service` resource when run on Amazon Linux 2022 where InSpec would try to run initctl instead of systemd. ([#6017](https://github.com/inspec/inspec/pull/6017))
- Fixed the `processes` resource to consider processes without paths on Windows. ([#6130](https://github.com/inspec/inspec/pull/6130))

### Backward incompatibilities

- Upgraded to Ruby 3.1 and removed Ruby 2.7, which is EOL. ([#6713](https://github.com/inspec/inspec/pull/6713))

## Chef InSpec 4.56.20

### Bug fixes

- Updated Cisco XE device detection (train [#728](https://github.com/inspec/train/pull/728))
- Make cookstyle checks for `inspec check` optional by default ([#5992](https://github.com/inspec/inspec/pull/5992))

## Chef InSpec 4.56.19

### Bug fixes

- Fixed `postgres_session` resource to allow query errors to be tested rather than treated as control failures. ([#5942](https://github.com/inspec/inspec/pull/5942))
- Fixed `oracledb_session` resource when query has empty result. ([#5943](https://github.com/inspec/inspec/pull/5943))
- Fixed command timeout ignored when used with sudo on ssh transport. (train [#727](https://github.com/inspec/train/pull/727))

## Chef InSpec 4.56.17

### New features

- Added `timezone` resource. ([#5758](https://github.com/inspec/inspec/pull/5758))
- Added `user_permissions` property and `be_inherited` matcher to the `registry_key` resource. ([#5778](https://github.com/inspec/inspec/pull/5778))
- Added `user_permissions` property and `be_inherited` matcher to the `file` resource for Windows.
([#5775](https://github.com/inspec/inspec/pull/5775))
- Added `kernel_parameters` resource. ([#5782](https://github.com/inspec/inspec/pull/5782))
- Added support for streaming reporter plugins. ([#5829](https://github.com/inspec/inspec/pull/5829))

### Improvements

- Added `esx` platform support to the `bash` resource. ([#5785](https://github.com/inspec/inspec/pull/5785))
- Added ability to check whether a package is latest in the `package` resource. ([#5771](https://github.com/inspec/inspec/pull/5771))
- Added option to ignore rule comments in the `ip_table` resource. ([#5777](https://github.com/inspec/inspec/pull/5777))
- Simplify inheritance of core resources into custom resources. ([#5816](https://github.com/inspec/inspec/pull/5816))
- Added `target_id` sourced from `train` back to the reporter interface. ([#5917](https://github.com/inspec/inspec/pull/5917))
- Added new properties and matchers to the `firewalld` resources. ([#5919](https://github.com/inspec/inspec/pull/5919))
- Added `lazy_instance` option to `FilterTable`, allowing plural resource definitions to conveniently access the resource instances with the lazy-loading columns. (#[5922](https://github.com/inspec/inspec/pull/5922))

### Bug fixes

- Fixed parsing of multiline results in the `mssql_session` resource. ([#5776](https://github.com/inspec/inspec/pull/5776))
- Fixed an issue with the `package` resource when matching certain version numbers. ([#5797](https://github.com/inspec/inspec/pull/5797))
- Ensure that the CLI option, `--insecure` works with dependent profiles loaded with self-signed SSL certificates. ([#5799](https://github.com/inspec/inspec/pull/5799))
- Fixed `grub_conf` resource to capture non-indented grub conf values. ([#5810](https://github.com/inspec/inspec/pull/5810))
- Fixed `sestatus: command not found`error on Amazon Linux 2. ([#5828](https://github.com/inspec/inspec/pull/5828))
- Fixed `--no-diff` option when the message contains only one newline. ([#5884](https://github.com/inspec/inspec/pull/5884))
- Fixed the `inspec automate version` command to work properly. ([#5893](https://github.com/inspec/inspec/pull/5893))

### Breaking changes

- Drop testing support for EOL Ruby 2.5. ([#5783](https://github.com/inspec/inspec/pull/5783))

## Chef InSpec 4.52.9

### New features

- Added remote target support for Alpine Linux. ([#5744](https://github.com/inspec/inspec/pull/5744))
- Added a CLI option for executing profiles from private Supermarkets. ([#5749](https://github.com/inspec/inspec/pull/5749))
- Added the ability to specify a proxy as a parameter in the `http` resource. ([#5757](https://github.com/inspec/inspec/pull/5757))
- Added a CLI option to set an SSH configuration file path for SSH transport. ([#5759](https://github.com/inspec/inspec/pull/5759))
- Added support for TLS 1.3 to the `ssl` resource. ([#5762](https://github.com/inspec/inspec/pull/5762))

### Bug fixes

- Fixed an edge case in the `service` resource where InSpec may falsely detect services as enabled on FreeBSD if that service is the suffix of another enabled service. ([#5606](https://github.com/inspec/inspec/pull/5606))
- Fixed the `ibmdb2_session` resource so that it now correctly accepts queries with clauses. ([#5742](https://github.com/inspec/inspec/pull/5742))
- Fixed the `oracledb_session` resource to properly handle nil in the query output. ([#5717](https://github.com/inspec/inspec/pull/5717))
- Fixed the `packages` resource to correctly list only installed packages on Alpine Linux. ([#5765](https://github.com/inspec/inspec/pull/5765))

## Chef InSpec 4.50.3

### New features

- Add Windows support to the **http** resource. ([#5697](https://github.com/inspec/inspec/pull/5697))

### Bug fixes

- Add Rake as a runtime dependency to fix an issue with Cookstyle integration when running under Habitat. ([#5722](https://github.com/inspec/inspec/pull/5722))

### Backward incompatibilities

- Temporarily disable non-functional Cookstyle integration on Windows ([#5724](https://github.com/inspec/inspec/pull/5724))

## Chef InSpec 4.49.0

### New features

- Added support for testing Cassandra DB configurations and CQL commands. ([#5683](https://github.com/inspec/inspec/pull/5683))
- Added the CLI option `--filter-waived-controls` to increase execution speed when using waivers. ([#5327](https://github.com/inspec/inspec/pull/5327))
- Integrated `inspec check` with Cookstyle. ([#5618](https://github.com/inspec/inspec/pull/5618))

### Enhancements

- Restored support for Ubuntu 16.04 packages and testing. ([#5689](https://github.com/inspec/inspec/pull/5689))

### Bug fixes

- Resolved case-sensitivity issue for Windows `users` and `group` resources. ([#5667](https://github.com/inspec/inspec/pull/5667))
- Fixed the **oracledb_session** resource when invoking a query using OS user and DB role.([#5702](https://github.com/inspec/inspec/pull/5702))
- Additional **oracledb_session** resource fixes. ([#5706](https://github.com/inspec/inspec/pull/5706))

## Chef InSpec 4.46.13

### Enhancements

- Added `rocky` and `almalinux` Linux distributions to `service` resource. ([#5604](https://github.com/inspec/inspec/pull/5604))
- Added the ability to handle files without headers in the `csv` resource.  ([#5665](https://github.com/inspec/inspec/pull/5665))
- Added the option to establish connection using a UNIX socket in the `postgres_session` resource. ([#5664](https://github.com/inspec/inspec/pull/5664))
- We now build packages for Debian 11, macos 12, and Windows 11/2022. ([#5675](https://github.com/inspec/inspec/pull/5675))

### Bug fixes

- Fixed the --tags filter for dependent profiles. ([#5657](https://github.com/inspec/inspec/pull/5657))
- Fixed the --controls filter for dependent profiles. ([#5656](https://github.com/inspec/inspec/pull/5656))
- Fixed the `opa_cli` and `opa_api` resources so they're able to verify an empty result. ([#5671](https://github.com/inspec/inspec/pull/5671))

## Chef InSpec 4.41.20

### Improvements

- Added support for Alibaba Cloud Linux 3 to the Chef InSpec service resource. ([#5578](https://github.com/inspec/inspec/pull/5578))
- Replaced the WMI command-line (WMIC) utility in the Chef InSpec security_identifier resource with Common Information Model (CIM) cmdlets as the WMIC utility will be deprecated soon. ([#5636](https://github.com/inspec/inspec/pull/5636))
- Adjusted the exit code to Normal when attempting to install a plugin that's already installed. ([#5625](https://github.com/inspec/inspec/pull/5625))

### Bug fixes

- Fixed range based filtering in filter tables ([#5598](https://github.com/inspec/inspec/pull/5598))
- Fixed an issue in the Chef InSpec apache_conf resource when the ServerRoot isn't specified in the Apache configuration file. ([#5601](https://github.com/inspec/inspec/pull/5601))
- Fixed an issue when testing files with `chef exec` where the `--insecure` flag doesn't bypass SSL verification when downloading profiles over HTTPS. ([#5600](https://github.com/inspec/inspec/pull/5600))
- Fixed the `inspec --chef-license=accept` invocation to only show the license acceptance message and not show the InSpec CLI help command output. ([#5609](https://github.com/inspec/inspec/pull/5609))
- Fixed an error in the Chef InSpec `postgres_session` resource where the resource was unable to connect to a database. ([#5619](https://github.com/inspec/inspec/pull/5619))
- Fixed an error in the Chef InSpec apache_conf resource where it would overwrite any Apache configurations from the main Apache configuration file with configurations from any included configuration files. ([#5623](https://github.com/inspec/inspec/pull/5623))
- Updated the default branch from `master` to `main` in the Git URL for the `inspec-aws` repository, which is used when running `inspec init`. ([#5637](https://github.com/inspec/inspec/pull/5637))
- Updated the default branch from `master` to `main` in the `inspec-gcp` and `inspec-azure` repos. ([#5642](https://github.com/inspec/inspec/pull/5642))
- Fixed an error where the Chef InSpec `security_policy` resource returned a comma-separated string of local groups (rather than SIDs) instead of an array. ([#5629](https://github.com/inspec/inspec/pull/5629))
- Updated the git fetcher to handle profiles that have a default git branch that isn't `master`. ([#5638](https://github.com/inspec/inspec/pull/5638))
- Fixed a regression related to processing tags in certain formats using the `--tags` CLI option. ([#5643](https://github.com/inspec/inspec/pull/5643))

## Chef InSpec 4.41.2

### New features

- Added support for Open Policy Agent: added resources `opa_cli` and `opa_api`. ([#5592](https://github.com/inspec/inspec/pull/5592))

### Improvements

- Added `mongodb_session` resource and docs. ([#5572](https://github.com/inspec/inspec/pull/5572))
- Added `--tags` option to CLI exec command to filter controls by tag. ([#5596](https://github.com/inspec/inspec/pull/5596))

### Bug Fix

- Pinned mongo gem to 2.13.2 to avoid broken symlink [#5615](https://github.com/inspec/inspec/pull/5615) ([clintoncwolfe](https://github.com/clintoncwolfe))

## Chef InSpec 4.38.9

### Enhancements

- The `mssql_session` resource now allows named connections by no longer forcing a port. ([#5584](https://github.com/inspec/inspec/pull/5584))
- The PostgreSQL resources (postgres_session, postgres_conf, postgres_hba_conf, and postgres_ident_conf) now work with Windows. ([#5576](https://github.com/inspec/inspec/pull/5576))

### Bug fixes

- Fixed a bug that caused the year in an expiration date to be misinterpreted in waiver files. ([#5586](https://github.com/inspec/inspec/pull/5586))

### Backward incompatibilities

- Reverted adding the x25519 gem which adds the ED25519 SSH key exchange algorithm because it was causing segmentation faults. ([#5590](https://github.com/inspec/inspec/pull/5590))

## Chef InSpec 4.38.3

### New features

- Added a new mongodb_conf resource. ([#5562](https://github.com/inspec/inspec/pull/5562))

### Bug fixes

- Corrected the `AWS_SECRET_ACCESS_KEY` environment variable name in the documentation. ([#5566](https://github.com/inspec/inspec/pull/5566))
- Changed the Windows local pipe server connection to retry once on EPIPE. ([train #694](https://github.com/inspec/train/pull/694))
- Exceptions are now handled correctly in the `oracledb_session` resource. ([#5567](https://github.com/inspec/inspec/pull/5567))

## Chef InSpec 4.37.30

### Improvements

- Added support for Ed25519-based SSH key exchange algorithms. ([#5563](https://github.com/inspec/inspec/pull/5563))

### Bug fixes

- Fixed the mysql_session resource to raise an exception if there is an error in a connection or query. ([#5551](https://github.com/inspec/inspec/pull/5551))
- Fixed the postgres_session resource to raise an exception if there is an error in a connection or query. ([#5553](https://github.com/inspec/inspec/pull/5553))

## Chef InSpec 4.37.25

### Bug fixes

- Fixed the `inspec shell` to allow loading profiles that have their own dependent profiles. ([#5547](https://github.com/inspec/inspec/pull/5547))
- Docs correction: `sshd_config` is for daemon, not client. Thanks for this fix, [@jblaine](https://github.com/jblaine)! ([#5549](https://github.com/inspec/inspec/pull/5549))

## Chef InSpec 4.37.23

### Improvements

- Updated the `inspec init plugin` command ([#5536](https://github.com/inspec/inspec/pull/5536)) with the following changes:
  - The values of flags passed to the `inspec init plugin` command are now wrapped in double quotes instead of single quotes.
  - Template files are now ERB files.
  - The `activator` flag replaces the `hook` flag, which is now an alias.

- Added Ubuntu to the list of FIPS-enabled platforms. ([#5533](https://github.com/inspec/inspec/pull/5533))

### Backward incompatibilities

- Removed support for Chef Compliance Server and Chef Automate 1 from the `inspec automate` command, as both products are EOL. ([#5534](https://github.com/inspec/inspec/pull/5534))

## Chef InSpec 4.37.20

### Bug fixes

CLI command fixes:

- `inspec automate login --help` outputs the correct URL ([5529](https://github.com/inspec/inspec/pull/5529))
- `inspec detect --no-color` returns color-free output ([#5530](https://github.com/inspec/inspec/pull/5530))

### Backward incompatibilities

- This release ends support for EOL Ubuntu 16.04 and builds on 18.04 ([#5532](https://github.com/inspec/inspec/pull/5532))

## Chef InSpec 4.37.17

### Improvements

- Added support for `zfs_pool` and `zfs_dataset` resources on Linux ([#5523](https://github.com/inspec/inspec/pull/5523))
- Add docs for `toml` resource ([#5514](https://github.com/inspec/inspec/pull/5514))
- Add CI-CD docs ([#5489](https://github.com/inspec/inspec/pull/5489))
- Add explicit RHEL8 builders to omnibus build ([#5527](https://github.com/inspec/inspec/pull/5527))
- Improved `port` resource performance: adding more specific search while using `ss` command ([#5522](https://github.com/inspec/inspec/pull/5522))

### Bug fixes

- `file` resource `more_permissive_than` matcher returns nil instead of throwing exception when file doesn't exist ([#5519](https://github.com/inspec/inspec/pull/5519))

## Chef InSpec 4.37.8

### Bug fixes

- The HTTP resource response body is now coerced into UTF-8. ([#5510](https://github.com/inspec/inspec/pull/5510))
- The `automate login` command now will verify credentials before storing them. ([#5509](https://github.com/inspec/inspec/pull/5509))
- Modified the windows_feature resource to indicate if a feature is enabled rather than just available. ([#5506](https://github.com/inspec/inspec/pull/5506))

## Chef InSpec 4.37.0

### New features

- The new `inspec automate` command replaces the `inspec compliance` command, which is now deprecated. ([#5490](https://github.com/inspec/inspec/pull/5490))

### Improvements

- Updated OpenSSL to 1.1.1k on macOS to address several CVEs. ([#5493](https://github.com/inspec/inspec/pull/5493))

### Bug fixes

- Fixed an error when using profile dependencies and require_controls. ([#5487](https://github.com/inspec/inspec/pull/5487))
- Fixed the `windows_firewall_rule` resource when it failed to validate more than one rule. ([#5502](https://github.com/inspec/inspec/pull/5502))

## Chef InSpec 4.36.4

### New features

- Added the selinux resource which includes support for modules and booleans. ([#5458](https://github.com/inspec/inspec/pull/5458)) ([#5463](https://github.com/inspec/inspec/pull/5463))
- Added the pattern input option for DSL and metadata inputs. ([#5466](https://github.com/inspec/inspec/pull/5466))
- Added the `members_array` property for group & groups resources. ([#5479](https://github.com/inspec/inspec/pull/5479))
- Train now reads the username and port from the `.ssh/config` file and will use these values if present. ([train #659](https://github.com/inspec/train/pull/659))

### Bug fixes

- Switch to GNU timeout-based implementation of SSH timeouts. (train [#679](https://github.com/inspec/train/pull/679))
- Fixed the group resource when a member doesn't exist. ([#5470](https://github.com/inspec/inspec/pull/5470))

## Chef InSpec 4.33.1

### New features

- Added the new `--reporter-include-source` CLI option, which includes the source code of the controls in the output of the CLI reporter. ([#5465](https://github.com/inspec/inspec/pull/5465))

### Bug fixes

- Removed the default of 3600 seconds for `--command-timeout` CLI option. ([#5472](https://github.com/inspec/inspec/pull/5472))

## Chef InSpec 4.32.0

### New features

- Added ability to pass inputs to InSpec shell using input file and cli ([#5452](https://github.com/inspec/inspec/pull/5452)) For more information, see [How can I set Inputs?](https://docs.chef.io/inspec/inputs/#how-can-i-set-inputs) in the InSpec documentation.

### Bug fixes

- **Fix SSH Timeout PTY allocation ([train #676](https://github.com/inspec/train/pull/676)).** We fixed a bug that caused occasional failures in some command resources that use SSH transport and were mistakenly allocated a pseudoterminal (PTY) when setting a timeout. In some cases, the PTY changed how the resource was interpreted. This fix only uses PTY when explicitly requested.

## Chef InSpec 4.31.1

This release is a hotfix to address a regression in 4.31.0.

### Bug fixes

- Fix for error "timed out after 0 seconds" on all command resources under kitchen-inspec ([#5455](https://github.com/inspec/inspec/pull/5455))

## Chef InSpec 4.31.0

### New features

- Commands can now be set to timeout using the [command resource](https://docs.chef.io/inspec/resources/command/) or the [`--command-timeout`](https://docs.chef.io/inspec/cli/) option in the CLI. Commands timeout by default after one hour. ([#5443](https://github.com/inspec/inspec/pull/5443))
- Added the [`--docker-url`](https://docs.chef.io/inspec/cli/) CLI option, which can be used to specify the URI to connect to the Docker Engine. ([#5445](https://github.com/inspec/inspec/pull/5445))
- Added support for targeting Linux and Windows containers running on Docker for Windows. ([train #674](https://github.com/inspec/train/pull/674))

### Bug fixes

- Hash inputs will now be loaded consistently and accessed as strings or symbols. ([#5446](https://github.com/inspec/inspec/pull/5446))

## Chef InSpec 4.29.3

### New features

- The JSON metadata pass through configuration has been moved from the Automate reporter to the JSON Reporter ([#5430](https://github.com/inspec/inspec/pull/5430))
- MacOS packages are now built for the `arm` architecture (M1 chipset) ([#5432](https://github.com/inspec/inspec/pull/5432))

### Bug fixes

- The apt resource now correctly fetches all package repositories using the `-name` flag in an environment where ZSH is the user's default shell.  ([#5437](https://github.com/inspec/inspec/pull/5437))

- The `--controls` option in `inspec exec` now correctly filters the controls by name. ([#5434](https://github.com/inspec/inspec/pull/5434))

- Updates how InSpec profiles are created with GCP or AWS providers so they use `inputs` instead of `attributes`. ([#5435](https://github.com/inspec/inspec/pull/5435))

- `inspec exec` will now fetch profiles via Git regardless of the name of default branch. ([#5438](https://github.com/inspec/inspec/pull/5438))

## Chef InSpec 4.28.0

### New features

- Added the option to filter out empty profiles from reports. ([#5425](https://github.com/inspec/inspec/pull/5425))
- Exposed the `conf_path`, `content`, and `params` properties to the `auditd_conf` resource. ([#5422](https://github.com/inspec/inspec/pull/5422))
- Added the ability to specify `--user` when connecting to docker containers. ([train #669](https://github.com/inspec/train/pull/669))
- Added a `clear_cache` option to the InSpec CLI. ([#5266](http://github.com/inspec/inspec/pull/5266))

### Bug fixes

- Fixed the `crontab` resource when passing a username to AIX. ([#5418](https://github.com/inspec/inspec/pull/5418))
- Added Git to the Docker build. ([#5420](https://github.com/inspec/inspec/pull/5420))
- Stopped a backtrace from occurring when using `cmp` to compare `nil` with a non-existing file. ([#5427](https://github.com/inspec/inspec/pull/5427))

## Chef InSpec 4.26.13

### Bug fixes

- Fixed `skip_control` to work on deeply nested profiles. ([#5411](https://github.com/inspec/inspec/pull/5411))
- The `ssh_config` and `sshd_config` resources now correctly use the first value when a setting is repeated. ([#5414](http://github.com/inspec/inspec/pull/5414))

## Chef InSpec 4.26.4

### New features

- You can now directly refer to settings in the `nginx_conf` resource using the `its` syntax. Thanks [@rgeissert](https://github.com/rgeissert)! ([#5285](https://github.com/inspec/inspec/pull/5285))
- You can now specify the shell type for WinRM connections using the `--winrm-shell-type` option. Thanks [@catriona1](https://github.com/catriona1)! ([#5263](https://github.com/inspec/inspec/pull/5263))
- Plugin settings can now be set programmatically. Thanks [@tecracer-theinen](https:/github.com/tecracer-theinen)! ([#5393](https://github.com/inspec/inspec/pull/5393))

### Bug fixes

- Updated the `oracledb_session` to use more general invocation options. Thanks [@pacopal](https://github.com/pacopal)! ([#5193](https://github.com/inspec/inspec/pull/5193))
- Fixed an error with the `http` resource when packaged with Chef Infra Client by including `faraday_middleware` in the gemspec. ([#5391](https://github.com/inspec/inspec/pull/5391))
- Fixed an incompatibility between `parslet` and `toml` when used with Chef Infra. ([#5394](https://github.com/inspec/inspec/pull/5394))
- Improved programmatic plugin configuration. ([#5395](https://github.com/inspec/inspec/pull/5395))

## Chef InSpec 4.25.1

### New features

- Chef InSpec is now released natively on `aarch64` packages for the ARM architecture on Debian, SLES, and Ubuntu. ([#5386](https://github.com/inspec/inspec/pull/5386))

### Improvements

- OpenSSH Client on Windows can now be tested with the ssh_config and sshd_config resources. Thanks [@rgeissert](https://github.com/rgeissert)! ([#5288](https://github.com/inspec/inspec/pull/5288))

### Bug fixes

- Thor is now unconditionally required. ([#5388](https://github.com/inspec/inspec/pull/5388))

## Chef InSpec 4.24.32

### Improvements

- The local working directory is now ignored when a Docker image of InSpec is built. ([#5360](https://github.com/inspec/inspec/pull/5360))

### Bug fixes

- Docker images of InSpec are now built using Omnibus. ([#5362](https://github.com/inspec/inspec/pull/5362))

## Chef InSpec 4.24.28

### Improvements

- The `--reporter-message-truncation` option now also truncates the `code_desc` field. ([#5372](https://github.com/inspec/inspec/pull/5372))

### Bug fixes

- The documentation incorrectly stated that waivered controls will default to `run:false` when in fact they default to running. The documentation has been corrected and a test has been added.  Thanks [@dwmarshall](https://github.com/dwmarshall)! ([#5370](https://github.com/inspec/inspec/pull/5370))
- Chef InSpec 4.24.26 was released with a defect that caused every invocation to exit with an error mentioning the `supermarket` plugin and the `ffi` gem. This has been fixed by avoiding the 1.14.2 version of the `ffi` gem. ([#5375](https://github.com/inspec/inspec/pull/5375))

## Chef InSpec 4.24.26

### Improvements

- The `parse_config` resource now accepts `[` and `]` characters, which allows access to settings that contain dots. Thanks [@rgeissert](https://github.com/rgeissert)! ([#5252](https://github.com/inspec/inspec/pull/5252))
- The gemspec allows for Ruby 3.0 use and opens the way for future testing. ([#5357](https://github.com/inspec/inspec/pull/5357))
- Updated the RSpec dependency to version 3.10. ([#5342](https://github.com/inspec/inspec/pull/5342))
- The `mssql_session` resource expands its platform support to include macOS and Linux since the `sqlcmd` utility is now available on those platforms. Thanks [@kclinden](https://github.com/kclinden)! ([#5366](https://github.com/inspec/inspec/pull/5366))

### Backward incompatibilities

- macOS 10.13 is no longer a supported platform for Chef InSpec. ([#5311](https://github.com/inspec/inspec/pull/5311))

## Chef InSpec 4.24.8

### New features

- The Chef InSpec Omnibus package adds `ed25519` SSH key support. ([#5299](https://github.com/inspec/inspec/pull/5299))
- The addition of `resource_class` and `resource_params` to the JSON Reporter output reveals specific resources used and entered parameters to users. ([#5241]( https://github.com/inspec/inspec/pull/5241))
- Specify more than one platform in Chef InSpec Profiles with supported asterisk (`*`) wildcard use. ([#5302](https://github.com/inspec/inspec/pull/5302))

### Improvements

- Chef InSpec now ships with Ruby 2.7.2. Internal Ruby-related deprecation warnings are now turned off by default, but Chef InSpec-specific warnings aren't turned off. ([#5281](https://github.com/inspec/inspec/pull/5281))
- The `wmi` resource becomes more predictable by returning arrays for `wmi` properties. ([#5314](https://github.com/inspec/inspec/pull/5314))
- Updated dependencies reflects the removal of Ruby 2.4 support. ([#5325](https://github.com/inspec/inspec/pull/5325))

### Bug fixes

- The `grub_conf` resource no longer assumes that the default config for `grub2` contains `menuentry` lines. ([#5306](https://github.com/inspec/inspec/pull/5306))
- Accessing the home directory no longer causes an error if the `HOME` environment is absent. ([#5317](https://github.com/inspec/inspec/pull/5317))
- A Ruby 2.5 dependency issue that affected gem builds is fixed. ([#5321](https://github.com/inspec/inspec/pull/5321))

### Backward incompatibilities

- Ruby 2.4 is no longer supported. ([#5321](https://github.com/inspec/inspec/pull/5321))

## Chef InSpec 4.23.15

### Improvements

- The Chef Habitat packages for Chef InSpec use Ruby 2.6 instead of Ruby 2.5. ([#5287](https://github.com/inspec/inspec/pull/5287))

### Bug fixes

- Waivers return a consistent message for expiration dates rather a message dependent on the waiver's `run` value. ([#5278](https://github.com/inspec/inspec/pull/5278))

## Chef InSpec 4.23.11

### Improvements

- `inspec --help` now links to information about Chef's patents. ([#5255](https://github.com/inspec/inspec/pull/5255))

## Chef InSpec 4.23.10

### Bug fixes

- The Latest: The `junit2` reporter now works as expected. ([#5244](https://github.com/inspec/inspec/pull/5244))

## Chef InSpec 4.23.4

### New features

- Discretion: A mechanism marks inputs as `sensitive: true` and replaces their values with "***". ([#5054](https://github.com/inspec/inspec/pull/5054))
- Cut the Chatter: Use the `--no-diff` CLI option to suppress diff output for textual tests. ([#5054](https://github.com/inspec/inspec/pull/5054))
- Sorted: Control the order of controls in output, but not execution order, with the `--sort_results_by=none|control|file|random` CLI option. ([#5054](https://github.com/inspec/inspec/pull/5054))
- Test Better: Disable caching of inputs with a `cache_inputs: true` setting. ([#5211](https://github.com/inspec/inspec/pull/5211))

### Improvements

- Port Access: `postgres_session` allows for custom ports in the `postgres_session('username', 'password', 'host', 'port')` command. ([#5185](https://github.com/inspec/inspec/pull/5185))

### Bug fixes

- Unabridged: Addressed a `ps` output truncation edge case related to undefined output widths for some Linux systems. ([#5232](https://github.com/inspec/inspec/pull/5232))

## Chef InSpec 4.22.22

### New features

- Shiny: Check out the new `windows_firewall` and `windows_firewall_rule` resources! ([#4979](https://github.com/inspec/inspec/pull/4979))
- New Factor: New `junit2` reporter is now available! The `junit2` reporter shows the standard JUnit specification in XML format, and is recommended for all new users of JUnit. ([#5085](https://github.com/inspec/inspec/pull/5085))
- In Progress: We added a test in preparation for the macOS Big Sur (11.0) beta release. ([#5217](https://github.com/inspec/inspec/pull/5217))

### Improvements

- Revision: We converted the legacy `junit` reporter into a plugin. Nothing changed about using the `junit` reporter, but it's a great example of a plugin if you want to build your own! ([#5084](https://github.com/inspec/inspec/pull/5084))
- Better Finding: Experience more robust Darwin operating system detection. ([#5175](https://github.com/inspec/inspec/pull/5175))
- Lighter: We removed unused dependencies and the `inspec` gem no longer ships with the readme file. ([#5201](https://github.com/inspec/inspec/pull/5201), [#5203](https://github.com/inspec/inspec/pull/5203), and [#5202](https://github.com/inspec/inspec/pull/5202))
- Upgrade: Omnibus builds now use Ruby 2.6.6 for improved security. ([#5198](https://github.com/inspec/inspec/pull/5198))

### Bug fixes

- Restored: The `mysql_session` resource works again with `stdout`, `stderr`, and `exit_status` parameters. ([#5219](https://github.com/inspec/inspec/pull/5219))

### Backward incompatibilities

- Reminder: We no longer build packages for Debian 8 as it's considered end-of-life. ([5197](https://github.com/inspec/inspec/pull/5197))

## Chef InSpec 4.22.8

### New features

- For mysql and postgres session resources, we added functionality that protects passwords from printing out to the console. ([#5124](https://github.com/inspec/inspec/pull/5124))

### Improvements

- The Scientific Linux platform is now supported on the `service` resource. ([#5164](https://github.com/inspec/inspec/pull/5164))
- We fixed documentation examples for the `passwd` resource. ([#5171](https://github.com/inspec/inspec/pull/5171))

### Bug fixes

- We fixed a bug where failure messages would always end with `[TRUNCATED]` if truncation was enabled. This meant that you would even get the truncation text even if your message was short enough to begin with. ([#5165](https://github.com/inspec/inspec/pull/5165))

## Chef InSpec 4.22.1

### Bug fixes

- Chef InSpec's Chef Habitat builds for Linux no longer executes with a `PATH` that includes build dependency directories. ([#5148](https://github.com/inspec/inspec/pull/5148))

## Chef InSpec 4.22.0

### New features

- Chef InSpec reports the profile as "failed" instead of immediately terminating when a runtime error occurs during loading.
([#5128](https://github.com/inspec/inspec/pull/5128))

### Improvements

- The `service` resource features an update in preparation for the macOS Big Sur 11 release. ([#5130](https://github.com/inspec/inspec/pull/5130))

### Bug fixes

- The `=` character's presence in a CLI input no longer truncates the value passed to Chef InSpec. ([#5135](https://github.com/inspec/inspec/pull/5135))
- The `apt` resource skips unsupported `apt-cdrom` repositories when parsing lists. ([#5138](https://github.com/inspec/inspec/pull/5138))

## Chef InSpec 4.21.3

### Bug fixes

- Less Static: Chef InSpec logging entries no longer appear in the `html2` reporter output.

## Chef InSpec 4.21.1

### New features

- Clark Kent: New `html2` reporter now available! The `html2` reporter shows all the data from your Chef InSpec run and even allows you to customize your report formatting with custom JavaScript and CSS options. At a later date, the `html2` reporter will replace the current rspec-based `html` reporter.

### Improvements

- Check It Out!: The `interface` resource features several improvements:
  - The resource supports macOS and FreeBSD
  - The resource includes a pluralized `interfaces` to query multiple interfaces
  - New `ipv4_address` and `ipv6_address` properties return the primary IP address for an interface

### Bug fixes

- Better Performance: Chef InSpec no longer reopens a new SSH connection for each command when targeting hosts over SSH.

## Chef InSpec 4.20.10

### Bug fixes

- Chef InSpec works again with tools that depend on the `inspec` Ruby gem, which fixes a bug in the 4.20.6 release.

## Chef InSpec 4.20.6

### Bug fixes

- Certain substrings within a `.toml` file no longer cause unexpected crashes.

## Chef InSpec 4.20.2

### Improvements

- Accurate InSpec CLI input parsing for numeric values and structured data, which were previously treated as strings. Numeric values are cast to an integer or float; YAML or JSON structures are converted to a hash or an array.
- Suppress deprecation warnings on `inspec exec` with the `--silence-deprecations` option.
- Expanded `only_if`[documentation](https://www.inspec.io/docs/reference/dsl_inspec/).

### Bug fixes

- Fixed an issue in testing for file existence on Solaris 10.

## Chef InSpec 4.19.2

### New features

- Check out our new `x86_64`and `aarch64` packages for Amazon Linux.
- We added `aarch64` packages for RedHat.

### Bug fixes

- We restored Chef InSpec to work on Microsoft Windows after a build issue.

## Chef InSpec 4.19.0

### New features

- In Your Hands: Develop your own Chef InSpec Reporter plugin and determine how Chef InSpec will report result data. Learn more about [Chef Inspec plugins and implementation](https://www.inspec.io/docs/reference/plugins/) in our documentation.
- Easier Form: The `inspec archive` command packs your profile into a `tar.gz` file that includes the profile in JSON form as the  `inspec.json` file. Use this JSON file to programmatically examine the profile without needing to load it into Chef InSpec.

### Improvements

- More Dates: Chef InSpec accepts a variety of date formats in the `waivers.yaml` configuration file, rather than only the `YYYY-MM-DD` format.

## Chef InSpec 4.18.114

### New features

- Use the new `inspec` command options to control the size of reports:
  - `--reporter-message-truncation` sets a length limit for the `message` field in test failure report data.
  - `--reporter-backtrace-inclusion` determines if Ruby backtraces should be included in test failure report data.

## Chef InSpec 4.18.111

### Bug fixes

- Not a Blocker: Chef InSpec allows an input and a control to have the same name.
- Clarity: Inputs with a value passed by the user and no default value no longer cause incorrect "Input doesn't have a value" warnings.

## Chef InSpec 4.18.108

### Improvements

- Troubleshooting Help: `inspec compliance` logs if an error occurs when connecting to a Chef Automate instance.

## Chef InSpec 4.18.104

### New features

- Time Is Time: The `search` and `install` CLI commands now accept a `--source` option that allows a gem package source other than RubyGems.org.

### Improvements

- You Make My Dreams: The `virtualization` resource supports expanded detection of VMware, Hyper-V, VirtualBox, KVM and Xen hypervisors, and includes `virtual_system?` and `physical_system?` helper methods.

### Bug fixes

- Tell It Like It Is: The `service` resource correctly detects Windows hosts.

## Chef InSpec 4.18.100

### Bug fixes

- We fixed a problem in which the sudo password would appear to be ignored even if provided.
- We resolved an issue in which profiles couldn't be fetched from an Automate server.
- The `release` property of the `platform` resource no longer breaks for Chef Habitat with Linux.

## Chef InSpec 4.18.97

### Bug fixes

- Fixed an issue in which custom resources in resource packs couldn't be created.

## Chef InSpec 4.18.85

### New features

- Read SSL certificate contents from files or the content that you provide. Thank you to [@frezbo](https://github.com/frezbo) for this new feature!
- The `archive` command includes an `--airgap` mode, which allows it to re-package archives with remote dependencies and not fail.
- Improve your resource debugging experience with the new `--inspect` option for the `inspec shell` command.
- The `service` resource features new support for yocto-based Linux distributions. Thank you to [@michaellihs](https://github.com/michaellihs) for this addition!
- The `package` resource now includes support for FreeBSD. Thank you to [@fzipi](https://github.com/fzipi) for this work!

### Improvements

- Our macOS packaging is compatible with macOS Catalina. For more information, see [our recent blog post](https://blog.chef.io/chef-software-on-macos-catalina/).
- The `ControlEvalContext`, `LibraryEvalContext`, and `Resource` classes experienced removal of most meta-programming.
- We standardized the platform for the `etc_hosts`, `virtualization`, `ini`, and `xml` resources.

### Bug fixes

- The name of the option `--winrm-basic-auth-only` correctly matches the option provided by train. Thanks [@shawnifoley](https://github.com/shawnifoley) for this fix!
- The `oracledb_session` resource works again due to a missing quote fix.
- `command.exist?` now conforms to POSIX standards. Thanks to [@PiQuer](https://github.com/PiQuer)!
- Errors with bad tarball files will properly report.
- The `groups` resource on macOS no longer reports duplicates anymore.
- The JSON reporter's attributes array won't remain empty. Thanks [@nazliBeit](https://github.com/nazliBeit) for your contribution!
- Changed the `postfix_conf` resource's supported platform to the broader `unix`. Thank you to [@fzipi](https://github.com/fzipi) for this fix!

## Chef InSpec 4.18.51

### Improvements

- Readable: A message appears to the user when fetching a profile fails, instead of a wordy stack trace.
- New Standard: Updating to rspec 3.9 means that output on failures changes from "X should be Y" to "X is expected to be Y".
- No More Sign-in Sheet: The `WindowsUser` resource now tests for the user's last login date. Thank you [@mbaitelman](https://github.com/mbaitelman) for your contribution!
- Transformed: Wired up `control` blocks to use resources.

### Bug fixes

- Future Proofing: Compatibility fixes added in preparation for ruby 2.7.
- Logging at Last: Fixed `inspec detect` so the `--log-level=<level>` command works properly.

### Backward incompatibilities

- Technical Adjustment: Moved `lib/fetchers` to `lib/inspec/fetcher` and re-namespaced accordingly.

## Chef InSpec 4.18.39

### Bug fixes

- Expansion: You can now use inputs in `describe.one` blocks.
- Customize Today: The `npm` resource now works with a custom path on Windows.
- Wait, There's More: The `npm` resource now works under sudo on Unix.
- Translation: Fixed handling of text files within profiles on Windows by using UTF-8 encoding and converting newlines.
- Yay!: The `gem` resource works again.
- Decoder Ring: The `apt` resource now properly parses config files with an architecture specifier.

## Chef InSpec 4.18.38

This release doesn't have any release notes.

## Chef InSpec 4.18.24

This release doesn't have any release notes.

## Chef InSpec 4.18.0

### New features

- Exceptional: Use [Waivers](https://www.inspec.io/docs/reference/waivers/) to mark controls as being administratively expected to fail.

### Improvements

- What Do You Call...?: The `interface` resource now has a `name` property.
- Dazed and Conf-user-ed: Expanded user resource to include the `passwordage`, `maxbadpasswords`, and `badpasswordattempts` properties with Windows.

### Bug fixes

- Repaired: Fixed a regression in which most RSpec-based matchers were broken.
- Understandable: The `apt` resources now correctly parse quoted repository addresses.
- Back In Action: `inspec env` works again, instead of erroneously stacktracing.

## Chef InSpec 4.17.17

### Bug fixes

- Dynamically loaded resources work again in `describe.one` blocks.
- You can use `only_if` blocks on non-OS platforms, such as cloud providers.

## Chef InSpec 4.17.15

### Bug fixes

Fixed two bugs introduced in yesterday's release:

- Vision Quest: The new resource loader sees all the resources.
- Test Prep: RSpec test DSL uses InSpec lazy resource loading correctly.

## Chef InSpec 4.17.14

### Bug fixes

Fixed two bugs introduced in yesterday's release:

- Vision Quest: The new resource loader sees all the resources.
- Test Prep: RSpec test DSL uses InSpec lazy resource loading correctly.

## Chef InSpec 4.17.11

### Bug fixes

Fixed two bugs introduced in yesterday's release:

- Vision Quest: The new resource loader sees all the resources.
- Test Prep: RSpec test DSL uses InSpec lazy resource loading correctly.

## Chef InSpec 4.17.7

### New features

- Choice: The `sys_info` resource now supports `ip_address`, `fqdn`, `domain`, and `short` options when giving a version of the hostname.
- Boom!: We've released our beta Chef InSpec plug-in for HashiCorp Vault. Check it out in our [inspec-vault GitHub repo]( https://github.com/inspec/inspec-vault) and let us know what you think -- or better yet, start jumping in and contributing with us on it.
- Also: Waivers, our new beta feature, was added to InSpec! Waivers allows you to better manage compliance failures. We would love to hear your feedback on this! See our [documentation](https://www.inspec.io/docs/reference/waivers/) for more details.

### Improvements

- Accelerate: Sped up initial load/response time for all commands by removing pre-leading of resources on invocation of `inspec`.
- Better Debugging: If an error occurs when using the `json` resource with a `command` source, you will now get the error message from STDERR returned in the report.
- Makeover: We improved the formatting of the usage help, so what you see when you type `inspec exec --help` should look better!

### Bug fixes

- Squashed: We fixed a bug on `sys_info`, `etc_hosts`, and several other resources, which would cause a `ConversionError` stacktrace when used in a `describe` block. This bug would not occur when used as an information gathering call, such as `sys_info.manufacturer`.
- Compressed: Resolved encoding issues with the JSON reporter and .tar.gz profiles.
- Clear Expression: Fixed a deprecation warning on the `apt` resource when using the `=~` operator with `false`.
- Locating: Improved how the `postfix_conf` resource handles a non-standard config location.
- Remake: Refactored activator plugin to be more idiomatic.
- Excerpt: Resolved quoting issues with the `mssql_session` resource.
- Loaded: Fixed Plugin loader to check for the `inspec-core` gem if the `inspec` gem isn't found, and to fail gracefully otherwise.

## Chef InSpec 4.17.6

This release doesn't have any release notes.

## Chef InSpec 4.16.0

### New features

- One's Option: `inspec exec` now supports a new CLI option, `--input name=value`, which allows you to set an Input directly on the command line. While YAML files are still more practical and recommended for large numbers of inputs, use the `--input` option to set just one or two.
- Mail Me Maybe: Manage your Postfix mail transfer agent configurations with its new available resource. Thank you to [@dmgasper](https://github.com/dmgasper) for this!
- Slowly but Surely: InSpec now is ready to accept the `input` option from the audit cookbook and the kitchen-inspec plugin. This is another step on the journey of renaming 'attributes' to 'inputs'! You can use this immediately with kitchen-inspec, and stay tuned for the audit cookbook update!
- All in One Place: InSpec and Train plugins may now store configuration data in the user configuration file at `~/.inspec/config.json`. This change allows plugins to store things like authentication tokens, service discovery addresses, or other information in one place. Plugins aren't _required_ to use the configuration file, but it's one option.

### Improvements

- Check It Out!: We improved the output of inspec plugin list:
  - The output is now in a table format and includes built-in plugins
  - Installed plugins now display their versions
  - Filter which plugins to list via new CLI options
  - See `inspec plugin list -h` for more information
- Heads Up: The `inspec` check command will now issue a warning if the `inspec_version` constraint in a profile can't be satisfied by the current version of InSpec running it.

### Bug fixes

- Entirely Set: Resources were not fully initialized in some cases, which lead to broken messaging during reporting, but we fixed this.

## Chef InSpec 4.12.0

### New features

- Who's Who: The `service` resource now has a `startuser` property, which lets you examine the username that started the service.

### Bug fixes

- Comma Fix: Looks like we had some syntax errors in our examples in the documentation for the `wmi` resource, which [Jeff Brimager](https://github.com/sam1el) pointed out. A few commas later and all is well!
- Pluralization Matters: Another typo was fixed in the umask example.
- Present and Accounted: On MacOS, the `group` resource wasn't working correctly as it under-reported membership. That has been fixed. So if you are on MacOS, you are now a `staff` member. Congratulations!

### Backward incompatibilities

- No Longer Available: We've dropped support for SUSE Linux Enterprise Server (SLES) 11, which was EOL'd as of March 31, 2019.
- Tidying Up: The `inspec-core` gem, a distribution with fewer dependencies and no need for compilers, will no longer include WinRM functionality. This change doesn't impact most users of Chef InSpec, only those who use the specialized `inspec-core` version. If you need WinRM functionality, install the `train-winrm` gem, but please note that winrm support requires a compiler to install.

## Chef InSpec 4.11.3

This release doesn't have any release notes.

## Chef InSpec 4.10.4

### New features

- Structure Enhancement: The Habitat plugin now uses _scaffolding_, which allows users to follow current best practices.
When you run `inspec habitat profile create` now, the templates will be sourced from the Habitat scaffolding for InSpec rather than the older unmaintained templates in Chef InSpec itself.

### Improvements

- Finally!: Relative path support added for specifying a path to a profile in a Git repo. This means that you can organize multiple profiles into one git repo, and select an individual profile from any subdirectory in the git repo.
- Simmer Down: `inspec version` no longer checks and reports against rubygems.org versions. The version check no longer talks on the network. This makes the version check much faster, less likely to cause a failure under CI, and also less surprising behavior.

### Bug fixes

- More than One: The `windows_task` resource now handles multiple triggers.

## Chef InSpec 4.7.24

### New features

- Sweet: The `sys_info` resource features two new properties - `manufacturer` and `model` - which let you determine information about the hardware being inspected.

### Improvements

- Lights Out: The `service` resource no longer issues a deprecation warning when the `should be_running` matcher is used. There are no plans to remove this matcher in the foreseeable future. Thank you to users for their feedback on this!

### Bug fixes

- The Need For Speed: When installing plugins, the installer no longer tries to extract documentation from the underlying libraries, a process which usually failed in the past.  This change makes plugin installation much faster, more stable, and requires less disk space.
- Painted: Chef InSpec properly handles and reports exceptions with mutually incompatible resources and transports.  For example: Using a `file` resource on the `aws` transport.

## Chef InSpec 4.7.18

### Improvements

- For `inspec-aws` users, the release process for the [inspec-aws](https://github.com/inspec/inspec-aws) resource pack changed:

> This release begins the full naming convention of the `inspec-aws` project at 1.0.1. No breaking changes are present. To date, the project has been unversioned with many releases labeled as version 0.1.0 in the inspec.yml, so we're starting fresh at 1.0.0.
>
> Because `inspec-aws` has critical gem dependencies on Chef InSpec, it's important to use a version of `inspec-aws` that's compatible with a minimum version of Chef InSpec. This release requires Chef InSpec 4.7.x, and is likely to work with Chef InSpec 4.x.

## Chef InSpec 4.7.3

This release doesn't have any release notes.

## Chef InSpec 4.6.9

This release doesn't have any release notes.

## Chef InSpec 4.6.4

This release doesn't have any release notes.

## Chef InSpec 4.6.3

This release doesn't have any release notes.

## Chef InSpec 4.3.2

This release doesn't have any release notes.

## Chef InSpec 3.9.3

This release doesn't have any release notes.

## Chef InSpec 3.9.0

This release doesn't have any release notes.

## Chef InSpec 3.7.11

This release doesn't have any release notes.

## Chef InSpec 3.7.1

This release doesn't have any release notes.

## Chef InSpec 3.6.6

This release doesn't have any release notes.

## Chef InSpec 3.6.4

This release doesn't have any release notes.

## Chef InSpec 3.6.2

This release doesn't have any release notes.

## Chef InSpec 3.5.0

This release doesn't have any release notes.

## Chef InSpec 3.4.1

This release doesn't have any release notes.

## Chef InSpec 3.3.14

This release doesn't have any release notes.

## Chef InSpec 3.2.6

This release doesn't have any release notes.

## Chef InSpec 3.1.3

This release doesn't have any release notes.

## Chef InSpec 3.0.64

This release doesn't have any release notes.

## Chef InSpec 3.0.61

This release doesn't have any release notes.

## Chef InSpec 3.0.52

This release doesn't have any release notes.

## Chef InSpec 3.0.46

This release doesn't have any release notes.

## Chef InSpec 3.0.25

This release doesn't have any release notes.

## Chef InSpec 3.0.12

This release doesn't have any release notes.

## Chef InSpec 3.0.9

This release doesn't have any release notes.

## Chef InSpec 3.0.0

This release doesn't have any release notes.

## Chef InSpec 2.3.28

This release doesn't have any release notes.

## Chef InSpec 2.3.24

This release doesn't have any release notes.

## Chef InSpec 2.3.23

This release doesn't have any release notes.

## Chef InSpec 2.3.10

This release doesn't have any release notes.

## Chef InSpec 2.3.5

This release doesn't have any release notes.

## Chef InSpec 2.3.4

This release doesn't have any release notes.

## Chef InSpec 2.2.112

This release doesn't have any release notes.

## Chef InSpec 2.2.102

This release doesn't have any release notes.

## Chef InSpec 2.2.101

This release doesn't have any release notes.

## Chef InSpec 2.2.78

This release doesn't have any release notes.

## Chef InSpec 2.2.70

This release doesn't have any release notes.

## Chef InSpec 2.2.64

This release doesn't have any release notes.

## Chef InSpec 2.2.61

This release doesn't have any release notes.

## Chef InSpec 2.2.55

This release doesn't have any release notes.

## Chef InSpec 2.2.54

This release doesn't have any release notes.

## Chef InSpec 2.2.50

This release doesn't have any release notes.

## Chef InSpec 2.2.41

This release doesn't have any release notes.

## Chef InSpec 2.2.35

This release doesn't have any release notes.

## Chef InSpec 2.2.34

This release doesn't have any release notes.

## Chef InSpec 2.2.27

This release doesn't have any release notes.

## Chef InSpec 2.2.20

This release doesn't have any release notes.

## Chef InSpec 2.2.16

This release doesn't have any release notes.

## Chef InSpec 2.2.10

This release doesn't have any release notes.

## Chef InSpec 2.1.84

This release doesn't have any release notes.

## Chef InSpec 2.1.83

This release doesn't have any release notes.

## Chef InSpec 2.1.81

This release doesn't have any release notes.

## Chef InSpec 2.1.80

This release doesn't have any release notes.

## Chef InSpec 2.1.78

This release doesn't have any release notes.

## Chef InSpec 2.1.72

This release doesn't have any release notes.

## Chef InSpec 2.1.68

This release doesn't have any release notes.

## Chef InSpec 2.1.67

This release doesn't have any release notes.

## Chef InSpec 2.1.59

This release doesn't have any release notes.

## Chef InSpec 2.1.54

This release doesn't have any release notes.

## Chef InSpec 2.1.43

This release doesn't have any release notes.

## Chef InSpec 2.1.30

This release doesn't have any release notes.

## Chef InSpec 2.1.21

This release doesn't have any release notes.

## Chef InSpec 2.1.10

This release doesn't have any release notes.

## Chef InSpec 2.1.0

This release doesn't have any release notes.

## Chef InSpec 2.0.45

This release doesn't have any release notes.

## Chef InSpec 2.0.32

This release doesn't have any release notes.

## Chef InSpec 2.0.17

This release doesn't have any release notes.

## Chef InSpec 2.0.16

This release doesn't have any release notes.

## Chef InSpec 1.51.31

This release doesn't have any release notes.

## Chef InSpec 1.51.25

This release doesn't have any release notes.

## Chef InSpec 1.51.21

This release doesn't have any release notes.

## Chef InSpec 1.51.18

This release doesn't have any release notes.

## Chef InSpec 1.51.15

This release doesn't have any release notes.

## Chef InSpec 1.51.6

This release doesn't have any release notes.

## Chef InSpec 1.51.0

This release doesn't have any release notes.

## Chef InSpec 1.50.1

This release doesn't have any release notes.

## Chef InSpec 1.49.2

This release doesn't have any release notes.

## Chef InSpec 1.48.0

This release doesn't have any release notes.

## Chef InSpec 1.47.0

This release doesn't have any release notes.

## Chef InSpec 1.46.2

This release doesn't have any release notes.

## Chef InSpec 1.45.13

This release doesn't have any release notes.

## Chef InSpec 1.45.9

This release doesn't have any release notes.

## Chef InSpec 1.44.8

This release doesn't have any release notes.

## Chef InSpec 1.43.8

This release doesn't have any release notes.

## Chef InSpec 1.43.5

This release doesn't have any release notes.

## Chef InSpec 1.42.3

This release doesn't have any release notes.

## Chef InSpec 1.41.0

This release doesn't have any release notes.

## Chef InSpec 1.40.0

This release doesn't have any release notes.

## Chef InSpec 1.39.1

This release doesn't have any release notes.

## Chef InSpec 1.38.8

This release doesn't have any release notes.

## Chef InSpec 1.37.6

This release doesn't have any release notes.

## Chef InSpec 1.36.1

This release doesn't have any release notes.

## Chef InSpec 1.35.1

This release doesn't have any release notes.

## Chef InSpec 1.34.1

This release doesn't have any release notes.

## Chef InSpec 1.33.12

This release doesn't have any release notes.

## Chef InSpec 1.33.1

This release doesn't have any release notes.

## Chef InSpec 1.32.1

This release doesn't have any release notes.

## Chef InSpec 1.31.1

This release doesn't have any release notes.

## Chef InSpec 1.31.0

This release doesn't have any release notes.

## Chef InSpec 1.30.0

This release doesn't have any release notes.

## Chef InSpec 1.29.0

This release doesn't have any release notes.

## Chef InSpec 1.28.1

This release doesn't have any release notes.

## Chef InSpec 1.28.0

This release doesn't have any release notes.

## Chef InSpec 1.27.0

This release doesn't have any release notes.

## Chef InSpec 1.26.0

This release doesn't have any release notes.

## Chef InSpec 1.25.1

This release doesn't have any release notes.

## Chef InSpec 1.25.0

This release doesn't have any release notes.

## Chef InSpec 1.24.0

This release doesn't have any release notes.

## Chef InSpec 1.23.0

This release doesn't have any release notes.

## Chef InSpec 1.22.0

This release doesn't have any release notes.

## Chef InSpec 1.21.0

This release doesn't have any release notes.

## Chef InSpec 1.20.0

This release doesn't have any release notes.

## Chef InSpec 1.19.2

This release doesn't have any release notes.

## Chef InSpec 1.19.1

This release doesn't have any release notes.

## Chef InSpec 1.19.0

This release doesn't have any release notes.

## Chef InSpec 1.18.0

This release doesn't have any release notes.

## Chef InSpec 1.17.0

This release doesn't have any release notes.

## Chef InSpec 1.16.1

This release doesn't have any release notes.

## Chef InSpec 1.15.0

This release doesn't have any release notes.

## Chef InSpec 1.14.1

This release doesn't have any release notes.

## Chef InSpec 1.7.1

This release doesn't have any release notes.

## Chef InSpec 1.6.0

This release doesn't have any release notes.

## Chef InSpec 1.5.0

This release doesn't have any release notes.

## Chef InSpec 1.4.1

This release doesn't have any release notes.

## Chef InSpec 1.3.0

This release doesn't have any release notes.

## Chef InSpec 1.0.0

This release doesn't have any release notes.