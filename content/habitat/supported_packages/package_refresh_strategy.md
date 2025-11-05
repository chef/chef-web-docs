+++
title = "Chef Habitat package refresh strategy"

[menu.habitat]
  title = "Habitat package refresh strategy"
  identifier = "habitat/packages/refresh strategy"
  parent = "habitat/packages"
  weight = 10
+++

A Habitat package is an artifact that contains the built application
artifacts lifecycle configurations and a manifest which included a olan
file that defines thebuild and runtime dependencies of the application.
The package is bundled into a Habitat Artifact (`.HART`) file, which is a
binary distribution of a given package built with Chef Habitat. The
package is immutable and cryptographically signed with a key so you can
verify that the artifact came from where you expected it to come from.
Artifacts can be exported to run in a variety of runtimes with zero
refactoring or rewriting.

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

### Current Approach and Limitations

All Habitat packages in the core origin are regularly refreshed and
released to the stable channel on Habitat SaaS Builder. Users are
encouraged to use packages from the stable channel as best practice.
Initially, the stable channel was designed for consistent stability
across packages. However, this model is less effective for core
libraries, which require specific lifecycle policies. No packages are
removed, those that can’t be refreshed due to incompatibility or build
issues are simply skipped.

- Deprecation or relegation of packages and major version upgrades can
  cause potential disruption to existing applications or
  installations

- Security fixes that have a **minor** impact can be included only. The
  current model prevents the deprecation or removal of outdated
  packages and limits the inclusion of significant security fixes or
  major version updates. This could lead to risks when using pinned
  packages, as they might not upgrade to more secure versions.

For example, PostgreSQL 9.3 is still rebuilt in the core channel
despite being out of support, as removing it could disrupt existing
applications. A shift to a multi-channel approach is suggested to
better manage foundational components.

### Multi-Channel package Refresh Approach

The new multi-channel approach for Habitat packages introduces base-YYYY
channels to manage package updates and lifecycles more effectively.

- **Multiple Channels for different Origins maintained by Progress
  Chef**: The base-YYYY channels where YYYY indicates the year of
  release, are designed to provide a stable environment with the latest
  refreshed packages that will be supported for three years. The initial
  base-YYYY release involves breaking changes due to major upgrades and
  the removal of end-of-life packages. However, subsequent releases
  within the channel will maintain stability and compatibility.Overall,
  the base-YYYY channels provide a reliable and consistent environment
  for users, ensuring long-term support and stability for their
  applications and deployments.For example : We will have channels
  base-2025, base-2028, base-2031 etc released every 3 years

- **Update Strategy:** The multi-channel approach allows updating
  packages by major versions in the new base-YYYY channels ,
  minimizing disruption for users who continue to point to the
  previous base-YYYY channel

- **Deprecation Strategy**: The multi-channel approach allows
  EOL/deprecated packages to be excluded from new base-YYYY releases
  but will remain in the existing base-YYYY channels, minimizing
  disruption for users.

- **Impact on Existing Channels**: The stable channel in the core origin
  will be deprecated due to the presence of legacy and unsupported
  packages.

- **Channel Compatibility** : packages in a particular channel will
  always be compatible with all other packages within a channel . This
  is applicable even for Cross origin packages.

- **Changes to Habitat Tools**:
  Updates to Habitat will allow users to specify the channel from
  where a package build should happen with a flag --refresh-channel or
  HAB_REFRESH_CHANNEL environment variable

- **Sync Scripts:** Sync Scripts to sync packages from core, chef and
  chef-platform origins from base-YYYY channels from Habitat SaaS
  Builder to On-Prem Builder

- **Maintenance Cycles**: Each packagewill have an associated
  maintenance cycle during a package refresh to help identify whether
  or not multiple majors or minors for that project are available.

- **package Naming Conventions**: packages will follow specific naming
  conventions based on their versioning schema, ensuring consistency
  and reliability in updates

- **package Intake Process :** If a Habitat user wishes to have a new
  package added to the core origin, they will

- Need to be requested in the form of an Aha Idea

- If the requested package meets the **Support** and **Usage**
  Threshold, these requests will be considered alongside other feature
  requests during planning periods

## Multiple Channels in different Origins:

- core: contains packages for common dependencies and compilers
  maintained by Progress Chef

  - **base** channel that always point to the latest base-YYYY. This
    will become the default channel when building, downloading,
    installing packages from core origin.

  - **base-YYYY** channel that will have the latest versions of core
    origin packages in the base-YYYY’s supported period.

  - **Point in Time** versions of core packages in
    **base-YYYY-timestamp** whenever a package is updated

  - **Intermediate support channel named as LTS-2024** for supporting
    bug fixes/CVE fixes in core origin packages required for building
    existing releases of Chef Products. This channel will be EOL once
    existing releases of Chef Products are EOL.

- chef: contains packages of Chef Products like Chef Infra Client, Chef
  Inspec , Chef Habitat, Chef Automate

  - **stable** channel will have all releases of Chef products. This
    will become the default channel when building, downloading,
    installing packages from chef origin.

  - **base-YYYY** channel will have the releases of Chef Products built
    with the core origin dependencies from the corresponding base-yyyy
    channel. base-YYYY Channel in Chef origin will be supported as long
    as Chef Products in those channels are supported.

  - **Point in Time** releases and versions of Chef products
    **base-YYYY-timestamp**

  - **Intermediate support channel named as LTS-2024** for supporting
    bug fixes/CVE fixes in existing releases of Chef Products. This
    channel will be EOL once existing releases of Chef Products are EOL.

Note:

- *With Hab 2.0, hab binary packages will be moved from core to chef
  origin to align with the practice of making all Chef product packages
  available in a single origin, ie chef.*

- *Subsequent major releases of Chef products like Infra Client 19,
  inspec 7 will follow the new multi-channel approach ie releases will
  be published in stable, base-yyyy, point-in-time channels*

  - chef-platform: contains packages of Chef 360 skills

    - **stable** channel will have all releases of chef 360 skills. This
      will become the default channel when building, downloading,
      installing packages from chef origin.

    - **base-YYYY** channel will have the releases of chef 360 skills
      that will be built with the core origin dependencies from the
      corresponding base-yyyy channel. base-YYYY Channel in
      chef-platform origin will be supported as long as Chef 360 skills
      in those channels are supported.

    - **Point in Time** releases and versions of chef 360 skills in
      **base-YYYY-timestamp**

Note: *The changes to chef-platform origin will be rolled out in the
next phase where Chef 360 skills will also follow the multi channel
approach.*

- habitat: contains packages required for an on-prem Builder setup

  - **stable** channel will have all releases of on-prem Builder related
    packages

  - **base-YYYY** channel will have the releases of on-prem Builder
    related packages that will be built with the core origin
    dependencies from the corresponding base-yyyy channel

  - **Point in Time** releases and versions of on-prem Builder related
    packages in **base-YYYY-timestamp**

## Intermediate Support Channel for supporting existing Chef product releases

Existing Chef product releases, such as Infra 18.x and Automate 4.x, are
built from "core origin" dependencies in the "stable" channel. However,
due to [limitations](#stable) in the "stable" channel, we cannot update
the core origin dependencies in the stable channel when providing bug
fixes or CVE fixes to these product versions.

In scenarios where we need to provide bug fixes or CVE fixes to existing
versions of Chef products, the core origin dependencies will be sourced
from the intermediate support channel "LTS-2024". While users don't
need to make any changes to receive Automate upgrades with CVE fixes,
users of the Infra 18.x habitat package will need to obtain the
chef/chef-infra-client package from the intermediate support channel
"LTS-2024" for building and running applications to avoid dependency
conflicts. To enable this, users can use the new [flag](#flag)
called--refresh-channel, which is now supported in Habitat.

## Channel Support Matrix

Availability of packages in Core Origin

|                                         | stable                                                                           | base-YYYY                                                                          | base                                                      | LTS-2024                                                                                                                                                       |
| --------------------------------------- | -------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | --------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| All core packages used by Chef Products | Old versions of core packages required for Hab 1.x, Infra Client18.x, Inspec 5.x | Latest versions of core packages required for Hab 2.x,Infra Client19.x, inspec 7.x | Default channel that mirrors the latest base-YYYY channel | Contains intermediate package updates required for providing bug fixes/CVE fixes in existing Chef Product releases Infra Client 18.x, Inspec 7.x, Automate 4.x |
| Hab 1.x and below                       | Yes                                                                              | NA                                                                                 | NA                                                        | NA                                                                                                                                                             |

Availability of Chef Product releases in Chef Origin

|                                                                                  | stable                          | base-YYYY                                                                              | LTS-2024                  | current |
| -------------------------------------------------------------------------------- | ------------------------------- | -------------------------------------------------------------------------------------- | ------------------------- | ------- |
| Infra Client 18.x and below<br><br>Inspec 5.x and below                          | Yes                             | NA                                                                                     | With latest CVE/Bug fixes | NA      |
| Hab 2.x and above<br><br>Infra Client 19.x and above<br><br>Inspec 7.x and above | Yes (all versions and releases) | Yes (release built with the core origin dependencies from the corresponding base-yyyy) | NA                        | NA      |
| Automate 4.x and below                                                           | NA                              | NA                                                                                     | NA                        | Yes     |

## Deprecated or End-of-Life (EOL) packages

- Deprecated/End-of-life (EOL) packages refer to packages that have
  reached the end of their support lifecycle. These packages are no
  longer maintained or updated, and they are excluded from new base-YYYY
  releases to minimise disruption for users.

- For example, if a package like `core/openssl11` reaches the end of its
  support lifecycle, it won't be included in the subsequent base-YYYY
  release channel. This approach allows customers to transition to the
  latest base-YYYY channel at their convenience while maintaining the
  previous base-YYYY channel, including the older packages for those who
  need them. However, the older packages won't receive support or be
  recommended for active use.

- This strategy ensures that deprecations don't adversely affect
  customers, granting the package management team the flexibility to
  implement significant changes without disrupting user workflows.

## Support Strategy for Channels

- When a new base-YYYY is released, the previous base-YYYY becomes
  deprecated, it’ll be available for a certain period of time so that
  users have sufficient time to migrate, after which it’ll be EOL.

- stable channel will be deprecated when base-2025 is released. It’ll be
  available until Chef Infra Client 18 and Hab 1.x is supported, after
  which it’ll be EOL

## Change in Workflow for Accessing packages from SaaS Builder

- **Download packages from SaaS Builder using a HAB_AUTH_TOKEN** : To
  download all new major releases of Chef Products(Hab 2.0, Infra 19
  etc) and latest core origin packages from base-YYYY channels, you’ll
  require to pass a HAB_AUTH_TOKEN generated using your License
  Key(Free, Trial, Commercial) either as a flag to the
  command(<https://docs.chef.io/habitat/habitat_cli/#hab-pkg-download> )
  or as an environment variable
  (<https://docs.chef.io/habitat/environment_variables/> )

- **Accessing Builder UI using License Key(Free, Trial, Commercial)**

***Note*** : Please find detailed instructions on how to generate
HAB_AUTH_TOKEN using a License Key from SaaS Builder UI :
<https://docs.chef.io/habitat/builder_profile/#add-a-progress-chef-license-key>

Syncing packages to On-Prem Builder

A Sync script will be provided that will

1. Perform a Pre-Flight check that returns a list of packages under
    > core origin for that channel(For example: base-YYYY,) that aren't
    > created/maintained by Progress Chef.

2. If proceeding with the script,

1. Those packages will be demoted to unstable channel

2. packages are downloaded from the channel specified (For example:
    > base-YYYY) from Public Builder and uploaded to their respective
    > on-prem builders.

## Maintenance Cycles

package version refreshes can be classified into only the following
maintenance cycles.

1. Single Major, one minor (so)

2. Single Major, multiple minor (sm)

3. Multiple Major, one minor (mo)

4. Multiple Major, multiple minor (mm)

## package Naming Conventions

Each package is identified by a unique string containing four
sub-strings separated by a forward slash (/) called a packageIdent
(origin/name/version/release). This naming convention refers to only
packages in the core origin.

When only one major version of the package is supported, the following
guidelines should be followed:

- The value of name should exactly match the name of the project it
  represents

- The plan file should be located within a directory of the same name in
  this repository

Example, a single refresh will only maintain one major version of glibc
and as such the package name will be core/glibc with no suffix.

When more than one major version of the package will be supported, and
the project uses Semantic Versioning (SemVer)

1. **If the project honors SemVer** (only breaking changes occur in
    > major releases)

- The value of name should match the name of the project it represents,
  plus the major version of the package being supported (as a suffix)

- The plan file should be located within a directory of the same name
  (including the suffix) in this repository

Example: core/postgresql16 and/or core/postgresql17

2. **If the project does not honor SemVer** (referred to as Romantic
    > Versioning or RomVer)

- The value of name should match the name of the project it represents,
  plus the **major** and **minor** version of the package being
  supported (as a suffix)

- The plan file should be located within a directory of the same name
  (including the suffix) in this repository

*Note: Romantic versions appear like a SemVer in format but
may/can/will introduce breaking changes as part of a "minor" update.
Resulting in Version X.Y having a breaking change versus X.Z*

Example: core/foo3_0, core/ foo3_1, core/ foo3_2, and/or core/foo3_3

3. **If the project doesn't use SemVer**

example : builder-api, perl

The packages will be reviewed package to package and refresh to
refresh

*Note: Even though a package name may be altered to include a major (and
minor) version suffix, package versions will never be altered from their
project’s source. For example, if the package uses a DateVer schema
where it is YYYYMMDD, this won't be reformatted to YYYY.MM.DD. This
is to ensure CVE detection process and automated build and detection
systems can refer to the exact publishers’ versions.*

## Support Threshold

For packages that aren't dependencies for Progress Chef Tools,

- There should be no published EOL date within the first 2 years of the
  base-YYYY support duration at the time of consideration. If the OEM
  drops support or doesn’t provide a fix to known vulnerabilities
  during the timeframe, no updates will be made available

- There should be no open High or Critical CVEs for that package at the
  time of consideration. If any released package has a Critical/High
  CVE post-release, it will be fixed as part of the next
  minor/directed refresh.

- It should have a valid licensing model that allows Progress Chef to
  distribute it as a Habitat package

## Usage Threshold

A requested package will be added for backlog prioritization if it
belongs to one of the categories below

- Commonly used development tools/programming languages

- High demand COTS

## Guidance for using packages from different origins and channels

- **Default channel:** While "base" becomes the default channel for core
  origin instead of "stable", it is recommended that users point to a
  particular base-YYYY channel to avoid impact of breaking changes when
  a new base-YYYY channel is released since base points to the latest
  base-YYYY at any point of time.

- **package Pinning**: When applications have multiple dependencies,
  avoid pinning some dependencies to specific versions. This can
  introduce conflicting versions and cause the build to fail due to each
  package having a fixed dependency tree.

- **Applications with Cross origin dependencies:** For users developing
  applications with cross-origin dependencies, the following
  recommendations ensure compatibility. (This guidance is based on
  examples involving Chef and Core origins, but it is also applicable to
  Chef-Platform and Core, as well as Habitat and Core):

  - **If using latest chef Origin package**: Use the "base-YYYY" channel
    to build and run your application successfully without any
    compatibility issues.

  - **If using older chef Origin package**: Use Point in Time channels,
    such as "base-YYYY-timestamp" channels, to build and run your
    application successfully without any compatibility issues.

- **Custom Origins for Custom packages:** Progress Chef recommends that users
  use their own origins for custom packages within On-Prem Builder
  instead of using Progress Chef owned origins(core, chef,chef-platform,
  habitat) to ensure that those packages aren't lost when syncing their
  On-Prem Builder with Sync Scripts.
