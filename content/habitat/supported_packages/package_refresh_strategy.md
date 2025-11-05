+++
title = "Chef Habitat package refresh strategy"

[menu.habitat]
  title = "Habitat package refresh strategy"
  identifier = "habitat/packages/refresh strategy"
  parent = "habitat/packages"
  weight = 10
+++

A Habitat package is an artifact that contains the built application artifacts, lifecycle configurations, and a manifest that includes a plan file that defines the build and runtime dependencies of the application.
The package is bundled into a Habitat Artifact (`.HART`) file, which is a binary distribution of a given package built with Chef Habitat.
The package is immutable and cryptographically signed with a key so you can verify that the artifact came from where you expected it to come from.
Artifacts can be exported to run in a variety of runtimes with zero refactoring or rewriting.

A package is defined by the package origin and package name: `<ORIGIN>/<PACKAGE_NAME>`.
For example: `core/node`

## Origins maintained by Progress Chef on SaaS Builder

Progress Chef maintains the following packages on Habitat SaaS Builder:

- **core**: contains packages for common dependencies and compilers
    maintained by Progress Chef
- **chef**: contains packages of Chef Products like Chef Infra Client,
    Chef Inspec, Automate, Habitat
- **chef-platform**: contains packages of Chef 360 skills
- **habitat:** contains packages required for an on-prem Builder setup

## Habitat package Refresh

### Current approach and limitations

All Habitat packages in the core origin are regularly refreshed and released to the stable channel on Habitat SaaS Builder.
Users are encouraged to use packages from the stable channel as best practice.
Initially, the stable channel was designed for consistent stability across packages.
However, this model is less effective for core libraries, which require specific lifecycle policies.
No packages are removed---those that can't be refreshed due to incompatibility or build issues are simply skipped.

- Deprecation or relegation of packages and major version upgrades can cause potential disruption to existing applications or installations.
- Security fixes that have a **minor** impact can be included only.
  The current model prevents the deprecation or removal of outdated packages and limits the inclusion of significant security fixes or major version updates.
  This could lead to risks when using pinned packages, as they might not upgrade to more secure versions.

For example, PostgreSQL 9.3 is still rebuilt in the core channel despite being out of support, as removing it could disrupt existing applications.
A shift to a multi-channel approach is suggested to better manage foundational components.

### Multi-channel package refresh approach

The new multi-channel approach for Chef Habitat packages introduces base-YYYY channels to manage package updates and lifecycles more effectively.

- **Multiple channels for different origins maintained by Progress Chef**: The base-YYYY channels, where YYYY indicates the year of release, provide a stable environment with the latest refreshed packages that are supported for three years.
  The initial base-YYYY release involves breaking changes due to major upgrades and the removal of end-of-life packages.
  Subsequent releases within the channel maintain stability and compatibility.
  Overall, the base-YYYY channels provide a reliable and consistent environment for users, ensuring long-term support and stability for their applications and deployments.
  For example, channels base-2025, base-2028, and base-2031 are released every three years.

- **Update strategy**: The multi-channel approach allows updating packages by major versions in the new base-YYYY channels, minimizing disruption for users who continue to point to the previous base-YYYY channel.
- **Deprecation strategy**: The multi-channel approach allows EOL/deprecated packages to be excluded from new base-YYYY releases but remain in the existing base-YYYY channels, minimizing disruption for users.
- **Impact on existing channels**: The stable channel in the core origin will be deprecated due to the presence of legacy and unsupported packages.
- **Channel compatibility**: Packages in a particular channel are always compatible with all other packages within a channel.
  This is applicable even for cross-origin packages.
- **Changes to Chef Habitat tools**: Updates to Chef Habitat allow users to specify the channel from where a package build should happen with a flag `--refresh-channel` or `HAB_REFRESH_CHANNEL` environment variable.
- **Sync scripts**: Sync scripts to sync packages from core, chef, and chef-platform origins from base-YYYY channels from Chef Habitat SaaS Builder to On-Prem Builder.
- **Maintenance cycles**: Each package has an associated maintenance cycle during a package refresh to help identify whether or not multiple majors or minors for that project are available.
- **Package naming conventions**: Packages follow specific naming conventions based on their versioning schema, ensuring consistency and reliability in updates.
- **Package intake process**: If a Chef Habitat user wants to have a new package added to the core origin, they should:
  - Request it in the form of an Aha Idea.
  - If the requested package meets the **Support** and **Usage** Threshold, these requests are considered alongside other feature requests during planning periods.

## Multiple channels in different origins

- **core**: Contains packages for common dependencies and compilers maintained by Progress Chef
  - **base** channel that always points to the latest base-YYYY.
    This becomes the default channel when building, downloading, or installing packages from core origin.
  - **base-YYYY** channel that has the latest versions of core origin packages in the base-YYYY's supported period.
  - **Point in time** versions of core packages in **base-YYYY-timestamp** whenever a package is updated.
  - **Intermediate support channel named as LTS-2024** for supporting bug fixes/CVE fixes in core origin packages required for building existing releases of Chef products.
    This channel becomes EOL once existing releases of Chef products are EOL.

- **chef**: Contains packages of Chef products like Chef Infra Client, Chef InSpec, Chef Habitat, and Chef Automate
  - **stable** channel has all releases of Chef products.
    This becomes the default channel when building, downloading, or installing packages from chef origin.
  - **base-YYYY** channel has the releases of Chef products built with the core origin dependencies from the corresponding base-YYYY channel.
    The base-YYYY channel in Chef origin is supported as long as Chef products in those channels are supported.
  - **Point-in-time** releases and versions of Chef products in **base-YYYY-timestamp**.
  - **Intermediate support channel named as LTS-2024** for supporting bug fixes/CVE fixes in existing releases of Chef products.
    This channel becomes EOL once existing releases of Chef products are EOL.

Note:

- *With Hab 2.0, hab binary packages are moved from core to chef origin to align with the practice of making all Chef product packages available in a single origin---that is, chef.*
- *Subsequent major releases of Chef products like Infra Client 19 and InSpec 7 follow the new multi-channel approach---that is, releases are published in stable, base-YYYY, and point-in-time channels.*

- **chef-platform**: Contains packages of Chef 360 skills
  - **stable** channel has all releases of Chef 360 skills.
    This becomes the default channel when building, downloading, or installing packages from chef origin.
  - **base-YYYY** channel has the releases of Chef 360 skills that are built with the core origin dependencies from the corresponding base-YYYY channel.
    The base-YYYY channel in chef-platform origin is supported as long as Chef 360 skills in those channels are supported.
  - **Point-in-time** releases and versions of Chef 360 skills in **base-YYYY-timestamp**.

Note: *The changes to chef-platform origin are rolled out in the next phase where Chef 360 skills also follow the multi-channel approach.*

- **habitat**: Contains packages required for an on-prem Builder setup
  - **stable** channel has all releases of on-prem Builder related packages.
  - **base-YYYY** channel has the releases of on-prem Builder related packages that are built with the core origin dependencies from the corresponding base-YYYY channel.
  - **Point-in-time** releases and versions of on-prem Builder related packages in **base-YYYY-timestamp**.

## Intermediate support channel for supporting existing Chef product releases

Existing Chef product releases, such as Infra 18.x and Automate 4.x, are built from "core origin" dependencies in the "stable" channel.
However, due to limitations in the "stable" channel, we can't update the core origin dependencies in the stable channel when providing bug fixes or CVE fixes to these product versions.

In scenarios where we need to provide bug fixes or CVE fixes to existing versions of Chef products, the core origin dependencies are sourced from the intermediate support channel "LTS-2024".
While users don't need to make any changes to receive Automate upgrades with CVE fixes, users of the Infra 18.x habitat package need to obtain the `chef/chef-infra-client` package from the intermediate support channel "LTS-2024" for building and running applications to avoid dependency conflicts.
To enable this, users can use the new flag `--refresh-channel`, which is now supported in Chef Habitat.

## Channel support matrix

### Availability of packages in core origin

|                                         | stable                                                                           | base-YYYY                                                                          | base                                                      | LTS-2024                                                                                                                                                       |
| --------------------------------------- | -------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | --------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| All core packages used by Chef products | Old versions of core packages required for Hab 1.x, Infra Client 18.x, InSpec 5.x | Latest versions of core packages required for Hab 2.x, Infra Client 19.x, InSpec 7.x | Default channel that mirrors the latest base-YYYY channel | Contains intermediate package updates required for providing bug fixes/CVE fixes in existing Chef product releases Infra Client 18.x, InSpec 7.x, Automate 4.x |
| Hab 1.x and below                       | Yes                                                                              | NA                                                                                 | NA                                                        | NA                                                                                                                                                             |

### Availability of Chef product releases in chef origin

|                                                                                  | stable                          | base-YYYY                                                                              | LTS-2024                  | current |
| -------------------------------------------------------------------------------- | ------------------------------- | -------------------------------------------------------------------------------------- | ------------------------- | ------- |
| Infra Client 18.x and below, InSpec 5.x and below                          | Yes                             | NA                                                                                     | With latest CVE/Bug fixes | NA      |
| Hab 2.x and above, Infra Client 19.x and above, InSpec 7.x and above | Yes (all versions and releases) | Yes (release built with the core origin dependencies from the corresponding base-YYYY) | NA                        | NA      |
| Automate 4.x and below                                                           | NA                              | NA                                                                                     | NA                        | Yes     |

## Deprecated or end-of-life (EOL) packages

- Deprecated/end-of-life (EOL) packages refer to packages that have reached the end of their support lifecycle.
  These packages are no longer maintained or updated, and they're excluded from new base-YYYY releases to minimize disruption for users.
- For example, if a package like `core/openssl11` reaches the end of its support lifecycle, it won't be included in the subsequent base-YYYY release channel.
  This approach allows customers to transition to the latest base-YYYY channel at their convenience while maintaining the previous base-YYYY channel, including the older packages for those who need them.
  However, the older packages won't receive support or be recommended for active use.
- This strategy ensures that deprecations don't adversely affect customers, granting the package management team the flexibility to implement significant changes without disrupting user workflows.

## Support strategy for channels

- When a new base-YYYY is released, the previous base-YYYY becomes deprecated.
  It's available for a certain period of time so that users have sufficient time to migrate, after which it becomes EOL.
- The stable channel is deprecated when base-2025 is released.
  It's available until Chef Infra Client 18 and Hab 1.x is supported, after which it becomes EOL.

## Change in workflow for accessing packages from Chef Habitat Builder

- **Download packages from Chef Habitat Builder using a HAB_AUTH_TOKEN**: To download all new major releases of Chef products (Hab 2.0, Infra 19, and others) and latest core origin packages from base-YYYY channels, you need to pass a `HAB_AUTH_TOKEN` generated using your license key (Free, Trial, Commercial) either as a flag to the [command](https://docs.chef.io/habitat/habitat_cli/#hab-pkg-download) or as an [environment variable](https://docs.chef.io/habitat/environment_variables/).
- **Accessing Builder UI using license key (Free, Trial, Commercial)**

**Note**: Find detailed instructions on how to generate `HAB_AUTH_TOKEN` using a license key from Chef Habitat Builder UI at <https://docs.chef.io/habitat/builder_profile/#add-a-progress-chef-license-key>.

### Syncing packages to on-prem Builder

A sync script is provided that:

1. Performs a pre-flight check that returns a list of packages under core origin for that channel (for example, base-YYYY) that aren't created or maintained by Progress Chef.
1. If proceeding with the script:
   1. Those packages are demoted to unstable channel.
   1. Packages are downloaded from the channel specified (for example, base-YYYY) from Chef Habitat Builder and uploaded to their respective on-prem builders.

## Maintenance cycles

Package version refreshes can be classified into the following maintenance cycles:

1. Single major, one minor (so)
1. Single major, multiple minor (sm)
1. Multiple major, one minor (mo)
1. Multiple major, multiple minor (mm)

## Package naming conventions

Each package is identified by a unique string containing four sub-strings separated by a forward slash (/) called a packageIdent (`origin/name/version/release`).
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
   - Note: Romantic versions appear like a SemVer in format but may introduce breaking changes as part of a "minor" update, resulting in Version X.Y having a breaking change versus X.Z.
   - Example: `core/foo3_0`, `core/foo3_1`, `core/foo3_2`, and/or `core/foo3_3`

1. **If the project doesn't use SemVer**
   - Example: builder-api, perl
   - The packages are reviewed package to package and refresh to refresh.

*Note: Even though a package name may be altered to include a major (and
minor) version suffix, package versions will never be altered from their
project’s source. For example, if the package uses a DateVer schema
where it is YYYYMMDD, this won't be reformatted to YYYY.MM.DD. This
is to ensure CVE detection process and automated build and detection
systems can refer to the exact publishers' versions.

## Support threshold

For packages that aren't dependencies for Progress Chef tools:

- There should be no published EOL date within the first two years of the base-YYYY support duration at the time of consideration.
  If the OEM drops support or doesn't provide a fix to known vulnerabilities during the timeframe, no updates are made available.
- There should be no open High or Critical CVEs for that package at the time of consideration.
  If any released package has a Critical/High CVE post-release, it's fixed as part of the next minor/directed refresh.
- It should have a valid licensing model that allows Progress Chef to distribute it as a Chef Habitat package.

## Usage threshold

A requested package is added for backlog prioritization if it belongs to one of the categories below:

- Commonly used development tools/programming languages
- High demand COTS

## Guidance for using packages from different origins and channels

- **Default channel**: While "base" becomes the default channel for core origin instead of "stable", we recommend that users point to a particular base-YYYY channel to avoid impact of breaking changes when a new base-YYYY channel is released since base points to the latest base-YYYY at any point of time.
- **Package pinning**: When applications have multiple dependencies, avoid pinning some dependencies to specific versions.
  This can introduce conflicting versions and cause the build to fail due to each package having a fixed dependency tree.
- **Applications with cross-origin dependencies**: For users developing applications with cross-origin dependencies, the following recommendations ensure compatibility.
  (This guidance is based on examples involving Chef and Core origins, but it's also applicable to Chef-Platform and Core, as well as Habitat and Core):

  - **If using latest chef origin package**: Use the "base-YYYY" channel to build and run your application without any compatibility issues.
  - **If using older chef origin package**: Use point-in-time channels, such as "base-YYYY-timestamp" channels, to build and run your application without any compatibility issues.

- **Custom origins for custom packages**: Progress Chef recommends that users use their own origins for custom packages within on-prem Builder instead of using Progress Chef owned origins (core, chef, chef-platform, habitat) to ensure that those packages aren't lost when syncing their on-prem Builder with sync scripts.
