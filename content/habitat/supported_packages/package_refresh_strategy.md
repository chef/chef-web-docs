+++
title = "Chef Habitat package refresh strategy"

[menu.habitat]
  title = "Habitat package refresh strategy"
  identifier = "habitat/supported_packages/refresh strategy"
  parent = "habitat/supported_packages"
  weight = 10
+++

A Habitat package is an artifact that has the built application artifacts, lifecycle configurations, and a manifest that includes a plan file that defines the build and runtime dependencies of the application.
The package is bundled into a Habitat Artifact (`.HART`) file, which is a binary distribution of a given package built with Chef Habitat.
The package is immutable and cryptographically signed with a key so you can verify that the artifact came from where you expected it to come from.
Artifacts can be exported to run in a variety of runtimes with zero refactoring or rewriting.

A package is defined by the package origin and package name: `<ORIGIN>/<PACKAGE_NAME>`.
For example: `core/node`

## Habitat package support

### Previous package support approach and limitations

We regularly refreshed and released all Habitat packages in the core origin to the stable channel on Chef Habitat SaaS Builder.
We encouraged users to use packages from the stable channel as a best practice. Initially, we designed the stable channel for consistent stability across packages; however, this model is less effective for core libraries, which require specific lifecycle policies.
We didn't remove packages---we skipped any that we couldn't refresh due to incompatibility or build issues.

This led to several issues:

- Deprecation or relegation of packages and major version upgrades can cause potential disruption to existing applications or installations.
- We could only include security fixes that had a minor impact.
  This model prevents the deprecation or removal of outdated packages and limits the inclusion of significant security fixes or major version updates.
  This could lead to risks when using pinned packages, as they may not upgrade to more secure versions.

For example, we continued to release PostgreSQL 9.3 in the core channel despite being out of support, as removing it could disrupt existing applications.

### Multi-channel package refresh approach

The multi-channel package refresh approach manages Habitat package updates and lifecycles using year-based channels, for example "base-2025". These channels provide a reliable and consistent environment for users, ensuring long-term support and stability for their applications and deployments.

- **Multiple channels**: The base-YYYY channels, where YYYY indicates the year of release, create a stable environment with the latest packages, are supported for three years, and are created every three years, for example base-2025, base-2028, and base-2031.

  The initial base-YYYY release has breaking changes because it has major upgrades and removes end-of-life packages.
  Subsequent releases within the channel maintain stability and compatibility.

- **Update strategy**: The multi-channel approach allows you to update packages by major version in new base-YYYY channels, minimizing disruption for users who continue to point to the previous base-YYYY channel.
- **Deprecation strategy**: The multi-channel approach excludes EOL or deprecated packages from new base-YYYY releases, but those packages remain in existing base-YYYY channels, minimizing disruption for users.
- **Impact on existing channels**: The stable channel in the core origin is deprecated because it has legacy and unsupported packages.
- **Channel compatibility**: Packages in a particular channel are always compatible with all other packages within a channel.
  This is applicable even for cross-origin packages.
- **Refresh with Chef Habitat**: Chef Habitat allows users to specify the channel from where a package build should happen with `--refresh-channel` or `HAB_REFRESH_CHANNEL` environment variable.
- **Sync scripts**: Sync scripts allow you to synchronize packages from Chef Habitat SaaS Builder to a user-deployed On-Prem Builder.
- **Maintenance cycles**: Each package has an associated maintenance cycle during a package refresh to identify if multiple major or minor versions for that project are available.
- **Package naming conventions**: Packages follow specific naming conventions based on their versioning schema, ensuring consistency and reliability in updates.
- **Package intake process**: If Chef Habitat users wants to have a new package added to the core origin, they can request it with Aha Ideas. If the requested package meets the support and usage thresholds, we will consider it alongside other feature requests during planning periods.

## Chef-owned origins and supported channels

Chef maintains the following origins and release channels:

core
: The core origin has packages for common dependencies and compilers and is maintained by Progress Chef.

  - **base** channel always points to the latest base-YYYY channel.
    This becomes the default channel when building, downloading, or installing packages from core origin.
  - **base-YYYY** channel that has the latest versions of core origin packages in the base-YYYY's supported period.
  - **Point-in-time** releases for versions of core packages in **base-YYYY-timestamp** channels whenever a package is updated.
  - **LTS-2024 intermediate support channel named** for supporting bug fixes/CVE fixes in core origin packages required for building existing releases of Chef products.
    This channel becomes EOL once existing releases of Chef products are EOL.

chef
: The chef origin has packages of Chef products like Chef Infra Client, Chef InSpec, Chef Habitat, and Chef Automate.

  - **stable** channel has all releases of Chef products.
    This becomes the default channel when building, downloading, or installing packages from chef origin.
  - **base-YYYY** channel has the releases of Chef products built with the core origin dependencies from the corresponding base-YYYY channel.
    The base-YYYY channel in Chef origin is supported as long as Chef products in those channels are supported.
  - **Point-in-time** releases and versions of Chef products in **base-YYYY-timestamp** channels.
  - **LTS-2024 intermediate support channel** for supporting bug fixes/CVE fixes in existing releases of Chef products.
    This channel becomes EOL once existing releases of Chef products are EOL.

chef-platform
: The chef-platform origin has packages of Chef 360 Platform skills.

  - **stable** channel has all releases of Chef 360 Platform skills.
    This becomes the default channel when building, downloading, or installing packages from chef origin.
  - **base-YYYY** channel has the releases of Chef 360 Platform skills that are built with the core origin dependencies from the corresponding base-YYYY channel.
    The base-YYYY channel in chef-platform origin is supported as long as Chef 360 Platform skills in those channels are supported.
  - **Point-in-time** releases and versions of Chef 360 Platform skills in **base-YYYY-timestamp** channels.

habitat
: The habitat origin has packages for deploying Chef Habitat On-Prem Builder.

  - **stable** channel has all releases of Habitat On-Prem Builder-related packages.
  - **base-YYYY** channel has the releases of On-Prem Builder-related packages that are built with the core origin dependencies from the corresponding base-YYYY channel.
  - **Point-in-time** releases and versions of On-Prem Builder related packages in **base-YYYY-timestamp**.

{{< note >}}

- With Chef Habitat 2, we moved the Habitat binary packages to the chef origin to consistently ship all Chef product packages in the same origin.
- Subsequent major releases of Chef products like Infra Client 19 and InSpec 7 follow the new multi-channel approach---that is, releases are published in stable, base-YYYY, and point-in-time channels.

{{< /note >}}

## Intermediate support channel for existing Chef product releases

Existing Chef product releases, such as Chef Infra Client 18.x and Automate 4.x, are built from core origin dependencies in the stable channel.
However, we can't update the core origin dependencies in the stable channel when providing bug fixes or CVE fixes to these product versions because of limitations in the stable channel.

If we make bug or CVE fixes to existing Chef product versions, we source the core origin dependencies from the LTS-2024 intermediate support channel.

You don't need to make any changes to get Chef Automate upgrades, but you must get updates to the Chef Infra Client 18.x package (`chef/chef-infra-client`) from the LTS-2024 intermediate support channel to avoid dependency conflicts.

To do this, use the `--refresh-channel` option in Chef Habitat 2.x and above to specify release channel that you want to fetch packages from.

## Channel support

### Availability of packages in core origin

|                                         | stable                                                                           | base-YYYY                                                                          | base                                                      | LTS-2024                                                                                                                                                       |
| --------------------------------------- | -------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | --------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| All core packages used by Chef products | Old versions of core packages required for Habitat 1.x, Infra Client 18.x, InSpec 5.x | Latest versions of core packages required for Habitat 2.x, Infra Client 19.x, InSpec 7.x | Default channel that mirrors the latest base-YYYY channel | Has intermediate package updates required for providing bug fixes/CVE fixes in existing Chef product releases Infra Client 18.x, InSpec 7.x, Automate 4.x |
| Habitat 1.x and below                       | Yes                                                                              | NA                                                                                 | NA                                                        | NA                                                                                                                                                             |

### Availability of Chef product packages in chef origin

|                                                                                  | stable                          | base-YYYY                                                                              | LTS-2024                  | current |
| -------------------------------------------------------------------------------- | ------------------------------- | -------------------------------------------------------------------------------------- | ------------------------- | ------- |
| Infra Client 18.x and below, InSpec 5.x and below                          | Yes                             | NA                                                                                     | With latest CVE/Bug fixes | NA      |
| Habitat 2.x and above, Infra Client 19.x and above, InSpec 7.x and above | Yes (all versions and releases) | Yes (release built with the core origin dependencies from the corresponding base-YYYY) | NA                        | NA      |
| Automate 4.x and below                                                           | NA                              | NA                                                                                     | NA                        | Yes     |

## Deprecated or end-of-life (EOL) packages

- Packages that have reached the end of their support lifecycle are no longer maintained or updated, and are excluded from new base-YYYY releases. For example, if a package like `core/openssl11` reaches the end of its support lifecycle, it won't be included in the subsequent base-YYYY release channel.
  This approach allows customers to transition to the latest base-YYYY channel at their convenience while maintaining the previous base-YYYY channel, including the older packages for those who need them.
  However, the older packages won't receive support or be recommended for active use.
- This strategy ensures that deprecations don't adversely affect customers, granting the package management team the flexibility to implement significant changes without disrupting user workflows.

## Support strategy for channels

- When a new base-YYYY is released, the previous base-YYYY becomes deprecated.
  It's available for a certain period of time so that users have sufficient time to migrate, after which it becomes EOL.
- The stable channel is deprecated when base-2025 is released.
  It's available until Chef Infra Client 18 and Habitat 1.x is supported, after which it becomes EOL.

## Change in workflow for accessing packages from Chef Habitat Builder

- **Download packages from Chef Habitat Builder using a HAB_AUTH_TOKEN**: To download all new major releases of Chef products (Habitat 2.0, Infra 19, and others) and latest core origin packages from base-YYYY channels, you need to pass a `HAB_AUTH_TOKEN` generated using your license key (Free, Trial, Commercial) either as a flag to the [command](https://docs.chef.io/habitat/latest/reference/habitat_cli/#hab-pkg-download) or as an [environment variable](https://docs.chef.io/habitat/latest/reference/environment_variables/).
- **Accessing Builder UI using license key (Free, Trial, Commercial)**

{{< note >}}

For instructions on how to generate `HAB_AUTH_TOKEN` using a license key from Chef Habitat Builder UI, see the [Builder profile documentation](https://docs.chef.io/habitat/builder/saas/builder_profile/#add-a-progress-chef-license-key)

{{< /note >}}

### Sync packages to Chef Habitat On-Prem Builder

We provide a sync script that updates packages on Habitat On-Prem Builder from SaaS Builder. It handles the following tasks:

1. Performs a pre-flight check that returns a list of packages under core origin for that channel (for example, base-YYYY) that aren't created or maintained by Progress Chef.
1. If proceeding with the script:
   1. Those packages are demoted to unstable channel.
   1. Packages are downloaded from the specified channel (for example, base-2025) on Habitat SaaS Builder and uploaded to On-Prem Builder.

## Habitat package management

### Maintenance cycles

Package version refreshes can be classified into the following maintenance cycles:

1. Single major, one minor (so)
1. Single major, multiple minor (sm)
1. Multiple major, one minor (mo)
1. Multiple major, multiple minor (mm)

### Package naming conventions

Each package is identified by a unique string containing four sub-strings separated by a forward slash (`/`) called a packageIdent (`origin/name/version/release`).
This naming convention refers to packages in the core origin.

When one major version of the package is supported, follow these guidelines:

- The value of name should match the name of the project it represents.
- The plan file should be located within a directory of the same name in this repository.

For example, a single refresh maintains one major version of glibc and as such the package name is `core/glibc` with no suffix.

When more than one major version of the package is supported, and the project uses Semantic Versioning (SemVer):

1. **If the project honors SemVer** (breaking changes occur in major releases)
   - The value of name should match the name of the project it represents, plus the major version of the package being supported (as a suffix).
   - The plan file should be located within a directory of the same name (including the suffix) in this repository.
   - Example: `core/postgresql16` and/or `core/postgresql17`

1. **If the project doesn't honor SemVer** (referred to as Romantic Versioning or RomVer)
   - The value of name should match the name of the project it represents, plus the **major** and **minor** version of the package being supported (as a suffix).
   - The plan file should be located within a directory of the same name (including the suffix) in this repository.
   - Note: Romantic versions appear like SemVer in format but may introduce breaking changes as part of a "minor" update, resulting in version X.Y having a breaking change versus X.Z.
   - Example: `core/foo3_0`, `core/foo3_1`, `core/foo3_2`, and/or `core/foo3_3`

1. **If the project doesn't use SemVer**
   - Example: builder-api, perl
   - The packages are reviewed package to package and refresh to refresh.

{{< note >}}

Even we may alter a package name to include a major or minor version suffix,
we won't alter package versions from their project's source.
For example, if the package uses a DateVer schema in the format of _YYYYMMDD_,
we won't reformat it to _YYYY.MM.DD_.
This ensures that our automated build and detection systems can refer to the publishers' exact versions.

{{< /note >}}

### Support threshold

For packages that aren't dependencies for Progress Chef tools:

- There should be no published EOL date within the first two years of the base-YYYY support duration at the time of consideration.
  If the OEM drops support or doesn't provide a fix to known vulnerabilities during the timeframe, no updates are made available.
- There should be no open High or Critical CVEs for that package at the time of consideration.
  If any released package has a Critical/High CVE post-release, it's fixed as part of the next minor/directed refresh.
- It should have a valid licensing model that allows Progress Chef to distribute it as a Chef Habitat package.

### Usage threshold

A requested package is added for backlog prioritization if it belongs to one of the categories below:

- Commonly used development tools/programming languages
- High demand COTS

## Guidance for using packages from different origins and channels

- **Default channel**: While the base channel becomes the default channel for the core origin instead of the stable channel, we recommend specifying a particular base-YYYY channel. The base channel always points to the latest base-YYYY channel and using base to fetch packages could introduce breaking changes when we release a new base-YYYY channel.
- **Package pinning**: When applications have multiple dependencies, avoid pinning some dependencies to specific versions.
  This can introduce conflicting versions and cause the build to fail due to each package having a fixed dependency tree.
- **Applications with cross-origin dependencies**: For users developing applications with dependencies in multiple origins, the following practices ensure compatibility:

  - If you're using the latest version of a package in the chef origin, use the "base-YYYY" channel to build and run your application without any compatibility issues.
  - If you're using older package versions in the chef origin, use point-in-time channels such as "base-YYYY-timestamp" channels, to build and run your application without any compatibility issues.

- **Custom origins for custom packages**: Progress Chef recommends that users use their own origins for custom packages within On-Prem Builder instead of using Progress Chef owned origins (core, chef, chef-platform, habitat) to ensure that those packages aren't lost when syncing their On-Prem Builder with sync scripts.
