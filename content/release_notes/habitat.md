+++
title = "Chef Habitat release notes"
draft = false
product = ["habitat"]
linkTitle = "Chef Habitat"
summary = "Chef Habitat release notes"

[menu]
  [menu.release_notes]
    title = "Chef Habitat"
    identifier = "release_notes/Chef Habitat"
    parent = "release_notes"
    weight = 40
+++

<!-- markdownlint-disable-file -->
<!-- cSpell:disable  -->
<!-- vale off -->

## Chef Habitat 1.6.1245

Release date: September 9, 2025

### Improvements

- The `hab pkg export tar` command has two new flags that give you more control over what gets included in the exported tar file:

  - The `--no-hab-bin` option excludes the `/hab/bin` (or `C:\hab\bin` on Windows) directory from the exported tar file.
  - The `--no-hab-sup` option excludes the `core/hab-sup` (Supervisor) and `core/hab-launcher` packages.

- We updated the embedded PowerShell runtime used to execute Habitat Supervisor hooks on Windows platforms to version 7.2.24.

- We updated the `windows-service` package so it uses version 8 of the .NET runtime.

### Bug fixes

- We added retry logic to the `hab pkg install` command to prevent `ACCESS DENIED` errors on Windows when antivirus software scans new packages.

- We fixed a bug in `hab pkg uninstall` where the dependencies of a "skipped" package currently running under a supervisor could be uninstalled thereby breaking that running service if it's restarted. All dependencies of any running service won't be uninstalled.

## Chef Habitat 1.6.1244

Release date: August 6, 2025

### Bug fixes

- We fixed a bug where Habitat packages installed on hardened systems with umask 0077 restrict file access to root only, causing permission issues for non-root users. This fix ensures that the directories `/hab/svc`, `/hab/svc/hooks`, and `/hab/svc/logs` have permissions of `755` on systems when they're hardened such that umask `077` is in effect.
- We fixed a bug when building packages with the `NO_INSTALL_DEPS` environment variable was set to a truthy value.
- We fixed the `Unknown Studio Command` error when running the `hab pkg build -D` command.

## Chef Habitat 1.6.1243

Release date: January 9, 2025

### New features

- Added a `--refresh-channel` argument to `hab pkg build` and a `-f` argument to the `hab studio` commands.

  You can use these arguments to set a refresh channel that Habitat uses when downloading dependencies from the `core` origin. The current default refresh channel is `stable`. As we move forward with LTS releases, the default will become the latest LTS channel.

  Use the `--refresh-channel` argument to build a Chef Habitat plan against an older refresh channel. For example, if you needed to build your plan against the `stable` channel after the LTS channel becomes the default, then you would set `--refresh-channel` to `stable`.

### Bug fixes

- When installing packages, Habitat now explicitly changes the access permissions (chmod) of the package directory to 0755. This fixes a bug where systems with a umask of 0077 would install packages that service users can't execute.

- Chef Habitat can now handle a node that restarts during a leader election and misses the rumor that the election has finished. Habitat now sends an election rumor to inform it that its election term has finished so it doesn't wait forever for the election to complete.

- Chef Habitat now verifies that a member is dead when it receives a rumor that the member is confirmed dead but was previously considered alive. Habitat sends a probe ping to validate that it truly is confirmed. This fixes a scenario where a node loses network connectivity and thinks all members are dead, then propagates false rumors after reconnecting to the network.

### Backward incompatibilities

- Chef Habitat no longer includes support for Windows 7. Habitat uses a variety of open-source, low-level libraries and some of these libraries no longer call the outdated Win32 API functions that Windows 7 expects. To keep Chef Habitat up to date and secure, we need to keep these open-source dependencies up to date.

- The Chef Habitat Builder public SAAS no longer hosts package builds and all `hab bldr job` commands are no longer supported.

## Chef Habitat 1.6.1041

Release date: April 22, 2024

### Bug fixes

- Fixed Habitat Supervisor when a Supervisor is started and peers are added with `--peer-watch-file`. Supervisor now reads all peers in the file at startup. ([#9208](https://github.com/habitat-sh/habitat/pull/9208))
- Fixed a bug where `hab pkg install` wouldn't verify if dependencies have been removed when reinstalling a package. Habitat now reinstalls missing dependencies when reinstalling a package. ([#9082](https://github.com/habitat-sh/habitat/pull/9082))
- Fixed a bug with the `toToml` helper when rendering values rather than TOML objects. ([#9081](https://github.com/habitat-sh/habitat/pull/9081))

## Chef Habitat 1.6.826

Release date: August 10, 2023

### Bug fixes

- Fixed service health data inconsistencies in the Supervisor HTTP APIs.
- Fixed a bug with license checking when starting a chroot studio on Linux.

## Chef Habitat 1.6.652

Release date: February, 7, 2023

### Bug fixes

- Updated IPC-Channel code to use older Windows API so that the Supervisor maintains compatibility with Windows 7.
- Fixed a bug in the rolling update process that could prevent a rolling update follower from updating or rolling back.

## Chef Habitat 1.6.607

Release date: November 14, 2022

### Bug fixes

- Fixes some erratic behavior in the Windows Docker studio on Windows 11 and Windows Server 2022.

### New experimental feature

- Studio-less builds. See documentation [here](https://github.com/habitat-sh/habitat/tree/main/components/hab/src/command/studio).

## Chef Habitat 1.6.568

Release date: August 31, 2022

We're announcing the release of Habitat 1.6.568. This release includes several updates to habitat's dependencies. It also includes some [significant fixes 2](https://github.com/habitat-sh/habitat/pull/8564) to rolling updates.

Please read on for the changelog details.
Thanks for using Habitat!

[1.6.568](https://github.com/habitat-sh/habitat/tree/1.6.568)

### Merged pull requests

- Bump httparse from 1.7.1 to 1.8.0 [#8619](https://github.com/habitat-sh/habitat/pull/8619) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump anyhow from 1.0.62 to 1.0.63 [#8618](https://github.com/habitat-sh/habitat/pull/8618) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump paste from 1.0.8 to 1.0.9 [#8616](https://github.com/habitat-sh/habitat/pull/8616) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- handle UnexpectedEof in the case of speaking to an older supervisor [#8613](https://github.com/habitat-sh/habitat/pull/8613) ([mwrock](https://github.com/mwrock))

- this removes the criticaly vulnerable nix dependency by updating ctrlc [#8617](https://github.com/habitat-sh/habitat/pull/8617) ([mwrock](https://github.com/mwrock))

- Bump thiserror from 1.0.32 to 1.0.33 [#8614](https://github.com/habitat-sh/habitat/pull/8614) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- cleanly close ctl\_gateway server stream after message is sent [#8611](https://github.com/habitat-sh/habitat/pull/8611) ([mwrock](https://github.com/mwrock))

- Bump futures from 0.3.23 to 0.3.24 [#8612](https://github.com/habitat-sh/habitat/pull/8612) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde\_json from 1.0.83 to 1.0.85 [#8610](https://github.com/habitat-sh/habitat/pull/8610) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde from 1.0.143 to 1.0.144 [#8608](https://github.com/habitat-sh/habitat/pull/8608) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde\_test from 1.0.143 to 1.0.144 [#8609](https://github.com/habitat-sh/habitat/pull/8609) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- fix hung rolling update if leader dies while waiting for an update [#8607](https://github.com/habitat-sh/habitat/pull/8607) ([mwrock](https://github.com/mwrock))

- remove priviliged in the right job dummy [#8605](https://github.com/habitat-sh/habitat/pull/8605) ([mwrock](https://github.com/mwrock))

- update hab install to not require admin rights [#8604](https://github.com/habitat-sh/habitat/pull/8604) ([mwrock](https://github.com/mwrock))

- Bump pin-project from 1.0.11 to 1.0.12 [#8601](https://github.com/habitat-sh/habitat/pull/8601) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- run docker build in privileged mode [#8602](https://github.com/habitat-sh/habitat/pull/8602) ([mwrock](https://github.com/mwrock))

- Bump paste from 1.0.7 to 1.0.8 [#8598](https://github.com/habitat-sh/habitat/pull/8598) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump nix from 0.24.2 to 0.25.0 [#8591](https://github.com/habitat-sh/habitat/pull/8591) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- try running install script from repo [#8600](https://github.com/habitat-sh/habitat/pull/8600) ([mwrock](https://github.com/mwrock))

- fix docker build script [#8599](https://github.com/habitat-sh/habitat/pull/8599) ([mwrock](https://github.com/mwrock))

- Bump semver from 1.0.12 to 1.0.13 [#8595](https://github.com/habitat-sh/habitat/pull/8595) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde from 1.0.140 to 1.0.143 [#8594](https://github.com/habitat-sh/habitat/pull/8594) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- ensure hab is installed when building docker images [#8596](https://github.com/habitat-sh/habitat/pull/8596) ([mwrock](https://github.com/mwrock))

- Bump libc from 0.2.126 to 0.2.132 [#8593](https://github.com/habitat-sh/habitat/pull/8593) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump async-trait from 0.1.56 to 0.1.57 [#8592](https://github.com/habitat-sh/habitat/pull/8592) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump thiserror from 1.0.31 to 1.0.32 [#8590](https://github.com/habitat-sh/habitat/pull/8590) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde\_test from 1.0.140 to 1.0.143 [#8588](https://github.com/habitat-sh/habitat/pull/8588) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde\_json from 1.0.81 to 1.0.83 [#8581](https://github.com/habitat-sh/habitat/pull/8581) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump futures from 0.3.21 to 0.3.23 [#8589](https://github.com/habitat-sh/habitat/pull/8589) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump rustls-pemfile from 1.0.0 to 1.0.1 [#8587](https://github.com/habitat-sh/habitat/pull/8587) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump bytes from 1.1.0 to 1.2.1 [#8579](https://github.com/habitat-sh/habitat/pull/8579) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump anyhow from 1.0.58 to 1.0.62 [#8586](https://github.com/habitat-sh/habitat/pull/8586) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Fixes several Rolling Update bugs [#8564 2](https://github.com/habitat-sh/habitat/pull/8564) ([mwrock](https://github.com/mwrock))

- Bump crates and pin the crate versions for rants [#8576](https://github.com/habitat-sh/habitat/pull/8576) ([sajjaphani](https://github.com/sajjaphani))

- More crate updates [#8571](https://github.com/habitat-sh/habitat/pull/8571) ([sajjaphani](https://github.com/sajjaphani))

- Remove warning [#8562](https://github.com/habitat-sh/habitat/pull/8562) ([kagarmoe](https://github.com/kagarmoe))

- bump crates [#8565](https://github.com/habitat-sh/habitat/pull/8565) ([sajjaphani](https://github.com/sajjaphani))

- SockerAddressProxy type support [#8559](https://github.com/habitat-sh/habitat/pull/8559) ([dikshagupta1](https://github.com/dikshagupta1))

- Correct the channels response parsing [#8548](https://github.com/habitat-sh/habitat/pull/8548) ([sajjaphani](https://github.com/sajjaphani))

- Trigger Build Pipeline Rebuild [#8555](https://github.com/habitat-sh/habitat/pull/8555) ([atrniv](https://github.com/atrniv))

- fixes supervisor - launcher backward compatibility [#8552](https://github.com/habitat-sh/habitat/pull/8552) ([atrniv](https://github.com/atrniv))

- fix infinite loop in ipc error [#8551](https://github.com/habitat-sh/habitat/pull/8551) ([atrniv](https://github.com/atrniv))

- fix launcher exit e2e failure [#8550](https://github.com/habitat-sh/habitat/pull/8550) ([atrniv](https://github.com/atrniv))

- Update Launcher IPC communication [#8494](https://github.com/habitat-sh/habitat/pull/8494) ([atrniv](https://github.com/atrniv))

- README: fix master->main img src [#8545](https://github.com/habitat-sh/habitat/pull/8545) ([dacoffey](https://github.com/dacoffey))

- Bump async-trait from 0.1.53 to 0.1.56 [#8543](https://github.com/habitat-sh/habitat/pull/8543) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump prost from 0.10.3 to 0.10.4 [#8542](https://github.com/habitat-sh/habitat/pull/8542) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump flate2 from 1.0.23 to 1.0.24 [#8541](https://github.com/habitat-sh/habitat/pull/8541) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump xz2 from 0.1.6 to 0.1.7 [#8540](https://github.com/habitat-sh/habitat/pull/8540) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump petgraph from 0.6.0 to 0.6.2 [#8538](https://github.com/habitat-sh/habitat/pull/8538) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- fix shellcheck violation [#8539](https://github.com/habitat-sh/habitat/pull/8539) ([mwrock](https://github.com/mwrock))

- Release Notes [#8526](https://github.com/habitat-sh/habitat/pull/8526) ([IanMadd](https://github.com/IanMadd))

- Bump openssl-src from 111.15.0+1.1.1k to 111.20.0+1.1.1o [#8535](https://github.com/habitat-sh/habitat/pull/8535) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump regex from 1.5.5 to 1.5.6 [#8522](https://github.com/habitat-sh/habitat/pull/8522) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump libc from 0.2.125 to 0.2.126 [#8518](https://github.com/habitat-sh/habitat/pull/8518) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Rustfmt and Nightly Rust Bump to nightly-2022-06-07 [#8536](https://github.com/habitat-sh/habitat/pull/8536) ([chef-expeditor\[bot\]](https://github.com/chef-expeditor%5Bbot%5D))

- updating changelog for 1.6.521 [#8537](https://github.com/habitat-sh/habitat/pull/8537) ([mwrock](https://github.com/mwrock))

## Chef Habitat 1.6.521

We're announcing the release of Habitat 1.6.521. This release contains two important fixes:

- Removes a potential deadlock in the main supervisor loop that can make a supervisor unresponsive to requests to load/unload or stop/start services. It may also prevent the supervisor from a clean shutdown and from gossiping service information to other peers.
- Reverts a change introduced in 1.6.500 that added argument validation to `hab sup run` and intentionally failing the command if it included service specific arguments without providing a package identifier. This may result in supervisor auto update failures if the original `hab sup run` includes such args with no package identifier.

Especially due to the first bug mentioned above, we strongly recommend that customers skip updating to 1.6.513 in favor of this release.

Please read on for the changelog details.
Thanks for using Habitat!

[1.6.521](https://github.com/habitat-sh/habitat/tree/1.6.521) (2022-06-03)

### Merged pull requests

- removing jemalloc and memory stats [#8533](https://github.com/habitat-sh/habitat/pull/8533) ([mwrock](https://github.com/mwrock))

- Revert "Hab-sup-run arguments modified." [#8532](https://github.com/habitat-sh/habitat/pull/8532) ([mwrock](https://github.com/mwrock))

- fix release yaml [#8531](https://github.com/habitat-sh/habitat/pull/8531) ([mwrock](https://github.com/mwrock))

- set UPLOAD\_AND\_PROMOTE var in builds to force upload and promote in release\_habitat pipeline [#8530](https://github.com/habitat-sh/habitat/pull/8530) ([mwrock](https://github.com/mwrock))

- bump the jemalloc crates to fix hang in epoch advancement [#8527](https://github.com/habitat-sh/habitat/pull/8527) ([mwrock](https://github.com/mwrock))

- fix clippy with refreshed packages [#8529](https://github.com/habitat-sh/habitat/pull/8529) ([mwrock](https://github.com/mwrock))

- Remove Hugo and go versions from netlify config [#8523](https://github.com/habitat-sh/habitat/pull/8523) ([IanMadd](https://github.com/IanMadd))

- updated changelog for 1.6.513 [#8521](https://github.com/habitat-sh/habitat/pull/8521) ([mwrock](https://github.com/mwrock))

## Chef Habitat 1.6.513

We're announcing the release of Habitat 1.6.513. This release is largely just a follow up to last week's core package refresh. All components included in the 1.6.513 Habitat release were built against the refreshed core packages and the 1.6.513 studio includes a full set of refreshed packages.

Please read on for the changelog details.
Thanks for using Habitat!

### Merged pull requests

- going back to latest ubuntu images [#8514](https://github.com/habitat-sh/habitat/pull/8514) ([mwrock](https://github.com/mwrock))

- Bump nix from 0.23.1 to 0.24.1 [#8509](https://github.com/habitat-sh/habitat/pull/8509) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump prost from 0.10.1 to 0.10.3 [#8510](https://github.com/habitat-sh/habitat/pull/8510) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde from 1.0.136 to 1.0.137 [#8511](https://github.com/habitat-sh/habitat/pull/8511) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump semver from 1.0.7 to 1.0.9 [#8507](https://github.com/habitat-sh/habitat/pull/8507) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump httparse from 1.7.0 to 1.7.1 [#8508](https://github.com/habitat-sh/habitat/pull/8508) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde\_yaml from 0.8.23 to 0.8.24 [#8506](https://github.com/habitat-sh/habitat/pull/8506) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump libc from 0.2.124 to 0.2.125 [#8505](https://github.com/habitat-sh/habitat/pull/8505) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump prost-derive from 0.10.0 to 0.10.1 [#8485](https://github.com/habitat-sh/habitat/pull/8485) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde\_test from 1.0.136 to 1.0.137 [#8497](https://github.com/habitat-sh/habitat/pull/8497) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Update rust-zmq to 0.9.2 [#8498](https://github.com/habitat-sh/habitat/pull/8498) ([atrniv](https://github.com/atrniv))

- Bump serde\_json from 1.0.79 to 1.0.81 [#8504](https://github.com/habitat-sh/habitat/pull/8504) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump thiserror from 1.0.30 to 1.0.31 [#8496](https://github.com/habitat-sh/habitat/pull/8496) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Rustfmt and Nightly Rust Bump to nightly-2022-05-10 [#8502](https://github.com/habitat-sh/habitat/pull/8502) ([chef-expeditor\[bot\]](https://github.com/chef-expeditor%5Bbot%5D))

- update changelog [#8503](https://github.com/habitat-sh/habitat/pull/8503) ([sajjaphani](https://github.com/sajjaphani))

## Chef Habitat 1.6.500

We're announcing the release of Habitat 1.6.500. This release provides the following fixes and enhancements:

- We've added validation to `hab sup run` to reject service specific arguments if you aren't starting a service with `hab sup run`. For example, `hab sup run --strategy at-once` will fail because no service is provided. However, `hab sup run core/nginx --strategy at-once` will succeed because you have provided a service (`nginx`) to run.
- More sophisticated backoff delay periods governing service restarts for failed `init` and `run` hooks. See [the docs](https://docs.chef.io/habitat/service_restarts/) for a complete explanation on how to use this feature.

Please read on for all the details.
Thanks for using Habitat!

### Merged pull requests

- temp fix for multi e2e failures [#8500](https://github.com/habitat-sh/habitat/pull/8500) ([mwrock](https://github.com/mwrock))
- chore: Included githubactions in the dependabot config [#8499](https://github.com/habitat-sh/habitat/pull/8499) ([naveensrinivasan](https://github.com/naveensrinivasan))
- Bump prost from 0.10.0 to 0.10.1 [#8486](https://github.com/habitat-sh/habitat/pull/8486) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))
- Bump prost-types from 0.10.0 to 0.10.1 [#8487](https://github.com/habitat-sh/habitat/pull/8487) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))
- Update Hugo docs build script [#8495](https://github.com/habitat-sh/habitat/pull/8495) ([IanMadd](https://github.com/IanMadd))
- add documentation for updating a supervisor [#8493](https://github.com/habitat-sh/habitat/pull/8493) ([mwrock](https://github.com/mwrock))
- Docs updates reflecting hook retry/backoff changes [#8490](https://github.com/habitat-sh/habitat/pull/8490) ([mwrock](https://github.com/mwrock))
- Bump toml from 0.5.8 to 0.5.9 [#8488](https://github.com/habitat-sh/habitat/pull/8488) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))
- Bump libc from 0.2.123 to 0.2.124 [#8489](https://github.com/habitat-sh/habitat/pull/8489) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))
- Implement advanced behavior for init and run hooks [#8454](https://github.com/habitat-sh/habitat/pull/8454) ([atrniv](https://github.com/atrniv))
- Bump libc from 0.2.122 to 0.2.123 [#8484](https://github.com/habitat-sh/habitat/pull/8484) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))
- Set permissions for GitHub actions [#8481](https://github.com/habitat-sh/habitat/pull/8481) ([nathannaveen](https://github.com/nathannaveen))
- Bump httparse from 1.6.0 to 1.7.0 [#8483](https://github.com/habitat-sh/habitat/pull/8483) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))
- Bump flate2 from 1.0.22 to 1.0.23 [#8482](https://github.com/habitat-sh/habitat/pull/8482) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))
- Bump libc from 0.2.121 to 0.2.122 [#8480](https://github.com/habitat-sh/habitat/pull/8480) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))
- Update Habitat Supervisor API Docs - 20220323155103 [#8467](https://github.com/habitat-sh/habitat/pull/8467) ([chef-ci](https://github.com/chef-ci))
- Hab-sup-run arguments modified. [#8464](https://github.com/habitat-sh/habitat/pull/8464) ([dikshagupta1](https://github.com/dikshagupta1))
- Rustfmt and Nightly Rust Bump to nightly-2022-03-23 [#8468](https://github.com/habitat-sh/habitat/pull/8468) ([chef-expeditor\[bot\]](https://github.com/chef-expeditor%5Bbot%5D))
- Bump log from 0.4.14 to 0.4.16 [#8466](https://github.com/habitat-sh/habitat/pull/8466) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))
- update prost crates [#8478](https://github.com/habitat-sh/habitat/pull/8478) ([mwrock](https://github.com/mwrock))
- Bump prost-derive from 0.9.0 to 0.10.0 [#8474](https://github.com/habitat-sh/habitat/pull/8474) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))
- Bump paste from 1.0.6 to 1.0.7 [#8472](https://github.com/habitat-sh/habitat/pull/8472) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))
- Bump semver from 1.0.6 to 1.0.7 [#8473](https://github.com/habitat-sh/habitat/pull/8473) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))
- Bump async-trait from 0.1.52 to 0.1.53 [#8471](https://github.com/habitat-sh/habitat/pull/8471) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))
- update changelog [#8469](https://github.com/habitat-sh/habitat/pull/8469) ([atrniv](https://github.com/atrniv))

## Chef Habitat 1.6.477

We're announcing the release of Habitat 1.6.477. This release provides the following fixes and enhancements:

- Fixes an issue where the supervisor failed to run in a docker studio on Mac M1 hardware
- Adds a `--sandbox` argument to `hab bldr channel list` allowing all channels including hidden sandbox channels to be shown. This can be helpful when trying to delete all channels in an origin.
- Ensure the version of powershell that's used by habitat hooks sits in the front of the `PSModulePath` so that the correct modules will be imported by the hook.

Please read on for all the details.

Thanks for using Habitat!

**[1.6.477](https://github.com/habitat-sh/habitat/tree/1.6.477)** **(2022-03-21)**

### Merged pull requests

- Bump libc from 0.2.120 to 0.2.121 [#8465](https://github.com/habitat-sh/habitat/pull/8465) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump libc from 0.2.119 to 0.2.120 [#8463](https://github.com/habitat-sh/habitat/pull/8463) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Add poll watcher support to spec watcher for M1 [#8449](https://github.com/habitat-sh/habitat/pull/8449) ([pozsgaic](https://github.com/pozsgaic))

- Bump regex from 1.5.4 to 1.5.5 [#8459](https://github.com/habitat-sh/habitat/pull/8459) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- remove deadlock detection from Linux butterfly tests [#8461](https://github.com/habitat-sh/habitat/pull/8461) ([mwrock](https://github.com/mwrock))

- comma separate multiple test features [#8460](https://github.com/habitat-sh/habitat/pull/8460) ([mwrock](https://github.com/mwrock))

- Update Habitat Builder API Docs - 20220302181210 [#8458](https://github.com/habitat-sh/habitat/pull/8458) ([chef-expeditor\[bot\]](https://github.com/chef-expeditor%5Bbot%5D))

- Minor doc fix: use systemd, not SystemD [#8456](https://github.com/habitat-sh/habitat/pull/8456) ([kenmacleod](https://github.com/kenmacleod))

- Fixed Broken Links [#8442](https://github.com/habitat-sh/habitat/pull/8442) ([dishanktiwari2501](https://github.com/dishanktiwari2501))

- Add Sandbox flag to hab bldr channel list command [#8452](https://github.com/habitat-sh/habitat/pull/8452) ([dikshagupta1](https://github.com/dikshagupta1))

- Bump semver from 1.0.5 to 1.0.6 [#8451](https://github.com/habitat-sh/habitat/pull/8451) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump libc from 0.2.118 to 0.2.119 [#8450](https://github.com/habitat-sh/habitat/pull/8450) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump cc from 1.0.72 to 1.0.73 [#8447](https://github.com/habitat-sh/habitat/pull/8447) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Added support for rust version 1.58.1 [#8437](https://github.com/habitat-sh/habitat/pull/8437) ([dikshagupta1](https://github.com/dikshagupta1))

- Bump libc from 0.2.117 to 0.2.118 [#8446](https://github.com/habitat-sh/habitat/pull/8446) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump rand from 0.8.4 to 0.8.5 [#8445](https://github.com/habitat-sh/habitat/pull/8445) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde\_json from 1.0.78 to 1.0.79 [#8444](https://github.com/habitat-sh/habitat/pull/8444) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Fix headings in builder\_origins.md [#8438](https://github.com/habitat-sh/habitat/pull/8438) ([IanMadd](https://github.com/IanMadd))

- Update Habitat Builder API Docs - 20220210140148 [#8443](https://github.com/habitat-sh/habitat/pull/8443) ([chef-expeditor\[bot\]](https://github.com/chef-expeditor%5Bbot%5D))

- Bump httparse from 1.5.1 to 1.6.0 [#8439](https://github.com/habitat-sh/habitat/pull/8439) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump semver from 1.0.4 to 1.0.5 [#8436](https://github.com/habitat-sh/habitat/pull/8436) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump futures from 0.3.19 to 0.3.21 [#8435](https://github.com/habitat-sh/habitat/pull/8435) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Update Dockerfile to fix wget problem [#8433](https://github.com/habitat-sh/habitat/pull/8433) ([pozsgaic](https://github.com/pozsgaic))

- Update release pipeline to generate API docs [#8418](https://github.com/habitat-sh/habitat/pull/8418) ([pozsgaic](https://github.com/pozsgaic))

- Bump libc from 0.2.116 to 0.2.117 [#8431](https://github.com/habitat-sh/habitat/pull/8431) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde from 1.0.133 to 1.0.136 [#8421](https://github.com/habitat-sh/habitat/pull/8421) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde\_test from 1.0.133 to 1.0.136 [#8422](https://github.com/habitat-sh/habitat/pull/8422) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde\_json from 1.0.75 to 1.0.78 [#8415](https://github.com/habitat-sh/habitat/pull/8415) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Fix downloads links [#8399](https://github.com/habitat-sh/habitat/pull/8399) ([IanMadd](https://github.com/IanMadd))

- Bump bimap from 0.6.1 to 0.6.2 [#8414](https://github.com/habitat-sh/habitat/pull/8414) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump libc from 0.2.112 to 0.2.116 [#8425](https://github.com/habitat-sh/habitat/pull/8425) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Add a data directory for docs [#8410](https://github.com/habitat-sh/habitat/pull/8410) ([kagarmoe](https://github.com/kagarmoe))

- Bump serde\_json from 1.0.74 to 1.0.75 [#8409](https://github.com/habitat-sh/habitat/pull/8409) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- clarify habitat configuration templates docs #8407 [#8408](https://github.com/habitat-sh/habitat/pull/8408) ([moutons](https://github.com/moutons))

- Bump pin-project from 1.0.9 to 1.0.10 [#8401](https://github.com/habitat-sh/habitat/pull/8401) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde\_test from 1.0.132 to 1.0.133 [#8403](https://github.com/habitat-sh/habitat/pull/8403) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde\_json from 1.0.73 to 1.0.74 [#8402](https://github.com/habitat-sh/habitat/pull/8402) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde from 1.0.132 to 1.0.133 [#8400](https://github.com/habitat-sh/habitat/pull/8400) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump pem from 1.0.1 to 1.0.2 [#8404](https://github.com/habitat-sh/habitat/pull/8404) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump hugo to 0.91.2 [#8398](https://github.com/habitat-sh/habitat/pull/8398) ([IanMadd](https://github.com/IanMadd))

- Bump pin-project from 1.0.8 to 1.0.9 [#8397](https://github.com/habitat-sh/habitat/pull/8397) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump num\_cpus from 1.13.0 to 1.13.1 [#8396](https://github.com/habitat-sh/habitat/pull/8396) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump futures from 0.3.18 to 0.3.19 [#8395](https://github.com/habitat-sh/habitat/pull/8395) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde from 1.0.131 to 1.0.132 [#8394](https://github.com/habitat-sh/habitat/pull/8394) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde\_test from 1.0.131 to 1.0.132 [#8393](https://github.com/habitat-sh/habitat/pull/8393) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump nix from 0.23.0 to 0.23.1 [#8392](https://github.com/habitat-sh/habitat/pull/8392) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde\_json from 1.0.72 to 1.0.73 [#8390](https://github.com/habitat-sh/habitat/pull/8390) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde\_yaml from 0.8.21 to 0.8.23 [#8391](https://github.com/habitat-sh/habitat/pull/8391) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump libc from 0.2.109 to 0.2.112 [#8389](https://github.com/habitat-sh/habitat/pull/8389) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump async-trait from 0.1.51 to 0.1.52 [#8385](https://github.com/habitat-sh/habitat/pull/8385) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde from 1.0.130 to 1.0.131 [#8383](https://github.com/habitat-sh/habitat/pull/8383) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde\_test from 1.0.130 to 1.0.131 [#8384](https://github.com/habitat-sh/habitat/pull/8384) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- ensure hook interpreter ps module path is always before windows ps module path [#8380](https://github.com/habitat-sh/habitat/pull/8380) ([mwrock](https://github.com/mwrock))

- Bump libc from 0.2.108 to 0.2.109 [#8381](https://github.com/habitat-sh/habitat/pull/8381) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- bump macos 10.14 to 10.15 [#8382](https://github.com/habitat-sh/habitat/pull/8382) ([mwrock](https://github.com/mwrock))

- bump rust to 1.56.1 [#8378](https://github.com/habitat-sh/habitat/pull/8378) ([pozsgaic](https://github.com/pozsgaic))

- Bump serde\_json from 1.0.71 to 1.0.72 [#8379](https://github.com/habitat-sh/habitat/pull/8379) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump futures from 0.3.17 to 0.3.18 [#8375](https://github.com/habitat-sh/habitat/pull/8375) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Docs Labeler [#8372](https://github.com/habitat-sh/habitat/pull/8372) ([kagarmoe](https://github.com/kagarmoe))

- Bump blake2b\_simd from 0.5.11 to 1.0.0 [#8374](https://github.com/habitat-sh/habitat/pull/8374) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump libc from 0.2.107 to 0.2.108 [#8373](https://github.com/habitat-sh/habitat/pull/8373) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- Bump serde\_json from 1.0.69 to 1.0.71 [#8369](https://github.com/habitat-sh/habitat/pull/8369) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- use macos 10.15 when verifying the install [#8357](https://github.com/habitat-sh/habitat/pull/8357) ([mwrock](https://github.com/mwrock))

- Bump libc from 0.2.105 to 0.2.106 [#8352](https://github.com/habitat-sh/habitat/pull/8352) ([dependabot\[bot\]](https://github.com/dependabot%5Bbot%5D))

- revert rants e2e test change [#8355](https://github.com/habitat-sh/habitat/pull/8355) ([mwrock](https://github.com/mwrock))

- Rustfmt and Nightly Rust Bump to nightly-2021-11-01 [#8354](https://github.com/habitat-sh/habitat/pull/8354) ([chef-expeditor\[bot\]](https://github.com/chef-expeditor%5Bbot%5D))

- updating changelog for 1.6.420 [#8356](https://github.com/habitat-sh/habitat/pull/8356) ([mwrock](https://github.com/mwrock))

## Chef Habitat 1.6.420

### Merged pull requests

- Revert "replace rants dependency with nats.io crate" [#8353](https://github.com/habitat-sh/habitat/pull/8353) ([mwrock](https://github.com/mwrock)) <!-- 1.6.420 -->
- Minor updates to script to generate CLI docs [#8348](https://github.com/habitat-sh/habitat/pull/8348) ([IanMadd](https://github.com/IanMadd)) <!-- 1.6.419 -->
- Rustfmt and Nightly Rust Bump to nightly-2021-10-28 [#8347](https://github.com/habitat-sh/habitat/pull/8347) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.419 -->
- updated 1.6.416 changelog [#8350](https://github.com/habitat-sh/habitat/pull/8350) ([mwrock](https://github.com/mwrock)) <!-- 1.6.418 -->

## Chef Habitat 1.6.416

### Merged pull requests

- add aarch64-darwin (M1) to release pipeline and curlbash install [#8346](https://github.com/habitat-sh/habitat/pull/8346) ([mwrock](https://github.com/mwrock)) <!-- 1.6.416 -->
- whitespace change to force release [#8345](https://github.com/habitat-sh/habitat/pull/8345) ([mwrock](https://github.com/mwrock)) <!-- 1.6.415 -->
- mac release root path should fall back to /hab [#8344](https://github.com/habitat-sh/habitat/pull/8344) ([mwrock](https://github.com/mwrock)) <!-- 1.6.414 -->
- search for nginx* process in e2e [#8343](https://github.com/habitat-sh/habitat/pull/8343) ([mwrock](https://github.com/mwrock)) <!-- 1.6.413 -->
- Bump pem from 1.0.0 to 1.0.1 [#8342](https://github.com/habitat-sh/habitat/pull/8342) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.412 -->
- update e2e test to fix text mismatch [#8341](https://github.com/habitat-sh/habitat/pull/8341) ([pozsgaic](https://github.com/pozsgaic)) <!-- 1.6.411 -->
- Bump widestring from 0.5.0 to 0.5.1 [#8339](https://github.com/habitat-sh/habitat/pull/8339) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.410 -->
- Enabling macos M1 hab cli build [#8334](https://github.com/habitat-sh/habitat/pull/8334) ([mwrock](https://github.com/mwrock)) <!-- 1.6.409 -->
- Bump libc from 0.2.104 to 0.2.105 [#8340](https://github.com/habitat-sh/habitat/pull/8340) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.408 -->
- Bump libc from 0.2.103 to 0.2.104 [#8336](https://github.com/habitat-sh/habitat/pull/8336) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.407 -->
- replace rants dependency with nats.io crate [#8293](https://github.com/habitat-sh/habitat/pull/8293) ([pozsgaic](https://github.com/pozsgaic)) <!-- 1.6.406 -->
- bump prost and friends [#8333](https://github.com/habitat-sh/habitat/pull/8333) ([mwrock](https://github.com/mwrock)) <!-- 1.6.405 -->
- Bump prost-derive from 0.8.0 to 0.9.0 [#8330](https://github.com/habitat-sh/habitat/pull/8330) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.404 -->
- Bump pem from 0.8.3 to 1.0.0 [#8318](https://github.com/habitat-sh/habitat/pull/8318) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.404 -->
- Bump widestring from 0.4.3 to 0.5.0 [#8329](https://github.com/habitat-sh/habitat/pull/8329) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.403 -->
- Rustfmt and Nightly Rust Bump to nightly-2021-10-12 [#8327](https://github.com/habitat-sh/habitat/pull/8327) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.402 -->
- update changelog for 1.6.400 [#8328](https://github.com/habitat-sh/habitat/pull/8328) ([mwrock](https://github.com/mwrock)) <!-- 1.6.401 -->

## Chef Habitat 1.6.415

This release doesn't have any release notes.

## Chef Habitat 1.6.400

### Merged pull requests

- whitespace change to force pipeline [#8326](https://github.com/habitat-sh/habitat/pull/8326) ([mwrock](https://github.com/mwrock)) <!-- 1.6.400 -->
- Bump thiserror from 1.0.29 to 1.0.30 [#8325](https://github.com/habitat-sh/habitat/pull/8325) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.399 -->
- Bump cc from 1.0.70 to 1.0.71 [#8322](https://github.com/habitat-sh/habitat/pull/8322) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.398 -->
- another whitespace change to force release [#8321](https://github.com/habitat-sh/habitat/pull/8321) ([mwrock](https://github.com/mwrock)) <!-- 1.6.397 -->
- whitespace change to force release [#8320](https://github.com/habitat-sh/habitat/pull/8320) ([mwrock](https://github.com/mwrock)) <!-- 1.6.396 -->
- restore windows 2016 studio image in release pipeline [#8316](https://github.com/habitat-sh/habitat/pull/8316) ([mwrock](https://github.com/mwrock)) <!-- 1.6.395 -->
- Bump libc from 0.2.102 to 0.2.103 [#8313](https://github.com/habitat-sh/habitat/pull/8313) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.394 -->
- Bump nix from 0.22.1 to 0.23.0 [#8315](https://github.com/habitat-sh/habitat/pull/8315) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.393 -->
- Update /main/ from /master/ [#8314](https://github.com/habitat-sh/habitat/pull/8314) ([dishanktiwari2501](https://github.com/dishanktiwari2501)) <!-- 1.6.392 -->
- temporarily removing 2016 studio from release [#8311](https://github.com/habitat-sh/habitat/pull/8311) ([mwrock](https://github.com/mwrock)) <!-- 1.6.391 -->
- Bump flate2 from 1.0.21 to 1.0.22 [#8304](https://github.com/habitat-sh/habitat/pull/8304) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.391 -->
- Bump libc from 0.2.101 to 0.2.102 [#8308](https://github.com/habitat-sh/habitat/pull/8308) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.391 -->
- Bump serde_json from 1.0.67 to 1.0.68 [#8306](https://github.com/habitat-sh/habitat/pull/8306) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.391 -->
- fix verify pipeline [#8305](https://github.com/habitat-sh/habitat/pull/8305) ([mwrock](https://github.com/mwrock)) <!-- 1.6.390 -->
- Fixed a typographical error in upload. [#8307](https://github.com/habitat-sh/habitat/pull/8307) ([TheDarkula](https://github.com/TheDarkula)) <!-- 1.6.389 -->
- Bump serde_yaml from 0.8.20 to 0.8.21 [#8303](https://github.com/habitat-sh/habitat/pull/8303) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.388 -->
- Bump thiserror from 1.0.28 to 1.0.29 [#8302](https://github.com/habitat-sh/habitat/pull/8302) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.387 -->
- Bump flate2 from 1.0.20 to 1.0.21 [#8300](https://github.com/habitat-sh/habitat/pull/8300) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.386 -->
- Bump cc from 1.0.69 to 1.0.70 [#8299](https://github.com/habitat-sh/habitat/pull/8299) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.386 -->
- Bump serde from 1.0.129 to 1.0.130 [#8296](https://github.com/habitat-sh/habitat/pull/8296) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.385 -->
- Bump serde_json from 1.0.66 to 1.0.67 [#8297](https://github.com/habitat-sh/habitat/pull/8297) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.384 -->
- Bump futures from 0.3.16 to 0.3.17 [#8298](https://github.com/habitat-sh/habitat/pull/8298) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.384 -->
- Bump thiserror from 1.0.26 to 1.0.28 [#8294](https://github.com/habitat-sh/habitat/pull/8294) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.384 -->
- Bump serde_test from 1.0.129 to 1.0.130 [#8295](https://github.com/habitat-sh/habitat/pull/8295) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.383 -->
- Bump serde_yaml from 0.8.19 to 0.8.20 [#8292](https://github.com/habitat-sh/habitat/pull/8292) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.382 -->
- Bump bytes from 1.0.1 to 1.1.0 [#8288](https://github.com/habitat-sh/habitat/pull/8288) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.381 -->
- Bump libc from 0.2.100 to 0.2.101 [#8289](https://github.com/habitat-sh/habitat/pull/8289) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.381 -->
- fix windows download url typo [#8290](https://github.com/habitat-sh/habitat/pull/8290) ([mwrock](https://github.com/mwrock)) <!-- 1.6.380 -->
- Bump serde_test from 1.0.127 to 1.0.129 [#8285](https://github.com/habitat-sh/habitat/pull/8285) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.379 -->
- Bump serde from 1.0.127 to 1.0.129 [#8286](https://github.com/habitat-sh/habitat/pull/8286) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.378 -->
- Bump libc from 0.2.99 to 0.2.100 [#8284](https://github.com/habitat-sh/habitat/pull/8284) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.377 -->
- Bump serde_yaml from 0.8.18 to 0.8.19 [#8281](https://github.com/habitat-sh/habitat/pull/8281) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.376 -->
- Bump httparse from 1.4.1 to 1.5.1 [#8280](https://github.com/habitat-sh/habitat/pull/8280) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.375 -->
- use the main branch for ci installs [#8287](https://github.com/habitat-sh/habitat/pull/8287) ([mwrock](https://github.com/mwrock)) <!-- 1.6.374 -->
- Bump serde_yaml from 0.8.17 to 0.8.18 [#8277](https://github.com/habitat-sh/habitat/pull/8277) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.373 -->
- Bump nix from 0.22.0 to 0.22.1 [#8275](https://github.com/habitat-sh/habitat/pull/8275) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.372 -->
- Bump bitflags from 1.2.1 to 1.3.1 [#8274](https://github.com/habitat-sh/habitat/pull/8274) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.371 -->
- add referenced images to repo [#8269](https://github.com/habitat-sh/habitat/pull/8269) ([pozsgaic](https://github.com/pozsgaic)) <!-- 1.6.371 -->
- Update readme to fix or remove invalid links [#8268](https://github.com/habitat-sh/habitat/pull/8268) ([pozsgaic](https://github.com/pozsgaic)) <!-- 1.6.371 -->
- bump cargo deps [#8273](https://github.com/habitat-sh/habitat/pull/8273) ([mwrock](https://github.com/mwrock)) <!-- 1.6.370 -->
- adding some pins to core so that crates in builder resolve correctly [#8267](https://github.com/habitat-sh/habitat/pull/8267) ([mwrock](https://github.com/mwrock)) <!-- 1.6.369 -->
- fix the days until close to be number of days since stale [#8266](https://github.com/habitat-sh/habitat/pull/8266) ([mwrock](https://github.com/mwrock)) <!-- 1.6.368 -->
- Rust54 [#8265](https://github.com/habitat-sh/habitat/pull/8265) ([mwrock](https://github.com/mwrock)) <!-- 1.6.367 -->
- Bump serde from 1.0.126 to 1.0.127 [#8262](https://github.com/habitat-sh/habitat/pull/8262) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.366 -->
- Bump serde_test from 1.0.126 to 1.0.127 [#8263](https://github.com/habitat-sh/habitat/pull/8263) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.365 -->
- fork rants with updated crate deps [#8261](https://github.com/habitat-sh/habitat/pull/8261) ([mwrock](https://github.com/mwrock)) <!-- 1.6.364 -->
- fix builder uploads with FuturesAsyncReadCompatExt and AllowStdIo from futures [#8255](https://github.com/habitat-sh/habitat/pull/8255) ([mwrock](https://github.com/mwrock)) <!-- 1.6.363 -->
- adding whitespace to readme so i can trigger a release build [#8253](https://github.com/habitat-sh/habitat/pull/8253) ([mwrock](https://github.com/mwrock)) <!-- 1.6.362 -->
- Cargo update [#8252](https://github.com/habitat-sh/habitat/pull/8252) ([mwrock](https://github.com/mwrock)) <!-- 1.6.361 -->
- Bump dns-lookup from 1.0.7 to 1.0.8 [#8251](https://github.com/habitat-sh/habitat/pull/8251) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.360 -->
- Bump env_logger from 0.8.4 to 0.9.0 [#8250](https://github.com/habitat-sh/habitat/pull/8250) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.359 -->
- Bump cc from 1.0.68 to 1.0.69 [#8248](https://github.com/habitat-sh/habitat/pull/8248) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.358 -->
- Bump nix from 0.21.0 to 0.22.0 [#8247](https://github.com/habitat-sh/habitat/pull/8247) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.358 -->
- Bump serde-transcode from 1.1.0 to 1.1.1 [#8246](https://github.com/habitat-sh/habitat/pull/8246) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.358 -->
- remove dependency on rust-crypto [#8249](https://github.com/habitat-sh/habitat/pull/8249) ([sajjaphani](https://github.com/sajjaphani)) <!-- 1.6.357 -->
- Bump libc from 0.2.97 to 0.2.98 [#8241](https://github.com/habitat-sh/habitat/pull/8241) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.356 -->
- Rustfmt and Nightly Rust Bump to nightly-2021-07-07 [#8239](https://github.com/habitat-sh/habitat/pull/8239) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.355 -->
- update changelog for 1.6.351 [#8240](https://github.com/habitat-sh/habitat/pull/8240) ([mwrock](https://github.com/mwrock)) <!-- 1.6.354 -->
- minor docs fix [#8238](https://github.com/habitat-sh/habitat/pull/8238) ([IanMadd](https://github.com/IanMadd)) <!-- 1.6.353 -->
- Fix headings in install CLI page [#8236](https://github.com/habitat-sh/habitat/pull/8236) ([IanMadd](https://github.com/IanMadd)) <!-- 1.6.352 -->

## Chef Habitat 1.6.351

- bump powershell to 7.1.3 [#8237](https://github.com/habitat-sh/habitat/pull/8237) ([mwrock](https://github.com/mwrock)) <!-- 1.6.351 -->
- opt out of pwsh telemetry to avoid shell startup issues [#8233](https://github.com/habitat-sh/habitat/pull/8233) ([mwrock](https://github.com/mwrock)) <!-- 1.6.350 -->
- Bump petgraph from 0.5.1 to 0.6.0 [#8234](https://github.com/habitat-sh/habitat/pull/8234) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.349 -->
- Bump thiserror from 1.0.25 to 1.0.26 [#8235](https://github.com/habitat-sh/habitat/pull/8235) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.348 -->
- Updating expeditor configuration [#8232](https://github.com/habitat-sh/habitat/pull/8232) ([jayashrig158](https://github.com/jayashrig158)) <!-- 1.6.347 -->
- Bump sodiumoxide from 0.2.6 to 0.2.7 [#8231](https://github.com/habitat-sh/habitat/pull/8231) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.346 -->
- update rust to 1.52.1 [#8230](https://github.com/habitat-sh/habitat/pull/8230) ([mwrock](https://github.com/mwrock)) <!-- 1.6.345 -->
- Bump state from 0.5.1 to 0.5.2 [#8227](https://github.com/habitat-sh/habitat/pull/8227) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.344 -->
- exclude libressl install in rootless studio build [#8228](https://github.com/habitat-sh/habitat/pull/8228) ([mwrock](https://github.com/mwrock)) <!-- 1.6.343 -->
- Bump rand from 0.8.3 to 0.8.4 [#8225](https://github.com/habitat-sh/habitat/pull/8225) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.342 -->
- Bump state from 0.4.2 to 0.5.1 [#8220](https://github.com/habitat-sh/habitat/pull/8220) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.341 -->
- bump rust to 1.50.0 [#8224](https://github.com/habitat-sh/habitat/pull/8224) ([mwrock](https://github.com/mwrock)) <!-- 1.6.340 -->
- Bump libc from 0.2.96 to 0.2.97 [#8222](https://github.com/habitat-sh/habitat/pull/8222) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.339 -->
- Bump env_logger from 0.8.3 to 0.8.4 [#8223](https://github.com/habitat-sh/habitat/pull/8223) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.338 -->
- Bump libc from 0.2.95 to 0.2.96 [#8221](https://github.com/habitat-sh/habitat/pull/8221) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.337 -->
- Bump dns-lookup from 1.0.6 to 1.0.7 [#8219](https://github.com/habitat-sh/habitat/pull/8219) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.336 -->
- Bump semver from 1.0.0 to 1.0.3 [#8218](https://github.com/habitat-sh/habitat/pull/8218) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.335 -->
- Bump nix from 0.20.0 to 0.21.0 [#8216](https://github.com/habitat-sh/habitat/pull/8216) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.334 -->
- Bump tar from 0.4.33 to 0.4.35 [#8213](https://github.com/habitat-sh/habitat/pull/8213) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.333 -->
- Bump semver from 0.11.0 to 1.0.0 [#8212](https://github.com/habitat-sh/habitat/pull/8212) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.332 -->
- Bump cc from 1.0.67 to 1.0.68 [#8210](https://github.com/habitat-sh/habitat/pull/8210) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.331 -->
- Bump libc from 0.2.94 to 0.2.95 [#8211](https://github.com/habitat-sh/habitat/pull/8211) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.330 -->
- Bump winreg from 0.8.0 to 0.9.0 [#8209](https://github.com/habitat-sh/habitat/pull/8209) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.330 -->
- Bump thiserror from 1.0.24 to 1.0.25 [#8208](https://github.com/habitat-sh/habitat/pull/8208) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.329 -->
- Fix bad link [#8198](https://github.com/habitat-sh/habitat/pull/8198) ([IanMadd](https://github.com/IanMadd)) <!-- 1.6.328 -->
- Update Hugo and fix docs build command [#8190](https://github.com/habitat-sh/habitat/pull/8190) ([IanMadd](https://github.com/IanMadd)) <!-- 1.6.327 -->
- Bump os_info from 3.0.5 to 3.0.6 [#8207](https://github.com/habitat-sh/habitat/pull/8207) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.326 -->
- Bump serde from 1.0.125 to 1.0.126 [#8202](https://github.com/habitat-sh/habitat/pull/8202) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.325 -->
- Bump notify from 4.0.16 to 4.0.17 [#8203](https://github.com/habitat-sh/habitat/pull/8203) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.324 -->
- Bump serde_test from 1.0.125 to 1.0.126 [#8201](https://github.com/habitat-sh/habitat/pull/8201) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.323 -->
- Bump os_info from 3.0.4 to 3.0.5 [#8204](https://github.com/habitat-sh/habitat/pull/8204) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.322 -->
- Rustfmt and Nightly Rust Bump to nightly-2021-05-12 [#8199](https://github.com/habitat-sh/habitat/pull/8199) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.321 -->
- update changelog for 1.6.319 [#8200](https://github.com/habitat-sh/habitat/pull/8200) ([mwrock](https://github.com/mwrock)) <!-- 1.6.320 -->

<!-- latest_stable_release 1.6.319 -->

## Chef Habitat 1.6.319

### Merged pull requests

- gossip after service is updated [#8197](https://github.com/habitat-sh/habitat/pull/8197) ([mwrock](https://github.com/mwrock)) <!-- 1.6.319 -->
- Add descriptions to API pages [#8191](https://github.com/habitat-sh/habitat/pull/8191) ([IanMadd](https://github.com/IanMadd)) <!-- 1.6.318 -->
- Bump caps from 0.5.1 to 0.5.2 [#8196](https://github.com/habitat-sh/habitat/pull/8196) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.317 -->
- Bump httparse from 1.4.0 to 1.4.1 [#8195](https://github.com/habitat-sh/habitat/pull/8195) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.316 -->
- gossip service rumor after update [#8194](https://github.com/habitat-sh/habitat/pull/8194) ([mwrock](https://github.com/mwrock)) <!-- 1.6.315 -->
- Bump url from 2.2.1 to 2.2.2 [#8193](https://github.com/habitat-sh/habitat/pull/8193) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.314 -->
- Bump regex from 1.5.3 to 1.5.4 [#8192](https://github.com/habitat-sh/habitat/pull/8192) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.313 -->
- Bump regex from 1.4.6 to 1.5.3 [#8189](https://github.com/habitat-sh/habitat/pull/8189) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.312 -->
- Bump rcgen from 0.8.10 to 0.8.11 [#8187](https://github.com/habitat-sh/habitat/pull/8187) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.311 -->
- Bump os_info from 3.0.3 to 3.0.4 [#8188](https://github.com/habitat-sh/habitat/pull/8188) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.311 -->
- Bump libc from 0.2.93 to 0.2.94 [#8185](https://github.com/habitat-sh/habitat/pull/8185) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.310 -->
- Bump os_info from 3.0.2 to 3.0.3 [#8186](https://github.com/habitat-sh/habitat/pull/8186) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.309 -->
- Bump dirs from 3.0.1 to 3.0.2 [#8184](https://github.com/habitat-sh/habitat/pull/8184) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.308 -->
- Add the uninstall hook to the docs [#8175](https://github.com/habitat-sh/habitat/pull/8175) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.307 -->
- Bump regex from 1.4.5 to 1.4.6 [#8182](https://github.com/habitat-sh/habitat/pull/8182) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.306 -->
- &#39;Use&#39; not &#39;utilize&#39; [#8183](https://github.com/habitat-sh/habitat/pull/8183) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.305 -->
- Update plan_settings.md - "Add a note for pkg_version on semver" [#8181](https://github.com/habitat-sh/habitat/pull/8181) ([hhodzic](https://github.com/hhodzic)) <!-- 1.6.304 -->
- Fix search typo [#8180](https://github.com/habitat-sh/habitat/pull/8180) ([sajjaphani](https://github.com/sajjaphani)) <!-- 1.6.303 -->
- Bump httparse from 1.3.6 to 1.4.0 [#8177](https://github.com/habitat-sh/habitat/pull/8177) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.302 -->
- Bump notify from 4.0.15 to 4.0.16 [#8176](https://github.com/habitat-sh/habitat/pull/8176) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.302 -->
- Bump async-trait from 0.1.49 to 0.1.50 [#8178](https://github.com/habitat-sh/habitat/pull/8178) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.302 -->
- Fix sup content. [#8174](https://github.com/habitat-sh/habitat/pull/8174) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.301 -->
- Bump rcgen from 0.8.9 to 0.8.10 [#8172](https://github.com/habitat-sh/habitat/pull/8172) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.300 -->
- Bump ctrlc from 3.1.8 to 3.1.9 [#8171](https://github.com/habitat-sh/habitat/pull/8171) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.299 -->
- Bump async-trait from 0.1.48 to 0.1.49 [#8170](https://github.com/habitat-sh/habitat/pull/8170) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.298 -->
- Bump byteorder from 1.3.4 to 1.4.3 [#8169](https://github.com/habitat-sh/habitat/pull/8169) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.297 -->
- Bump webpki from 0.21.4 to 0.22.0 [#8165](https://github.com/habitat-sh/habitat/pull/8165) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.296 -->
- Bump bincode from 1.3.2 to 1.3.3 [#8164](https://github.com/habitat-sh/habitat/pull/8164) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.295 -->
- Bump bimap from 0.6.0 to 0.6.1 [#8162](https://github.com/habitat-sh/habitat/pull/8162) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.294 -->
- Bump httparse from 1.3.5 to 1.3.6 [#8163](https://github.com/habitat-sh/habitat/pull/8163) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.293 -->
- Bump os_info from 3.0.1 to 3.0.2 [#8160](https://github.com/habitat-sh/habitat/pull/8160) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.292 -->
- Bump libc from 0.2.92 to 0.2.93 [#8161](https://github.com/habitat-sh/habitat/pull/8161) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.291 -->
- Rustfmt and Nightly Rust Bump to nightly-2021-03-25 [#8158](https://github.com/habitat-sh/habitat/pull/8158) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.290 -->
- update changelog [#8159](https://github.com/habitat-sh/habitat/pull/8159) ([mwrock](https://github.com/mwrock)) <!-- 1.6.289 -->

## Chef Habitat 1.6.288

### Merged pull requests

- explicily remove iconv library from mac-bootstrapper path [#8157](https://github.com/habitat-sh/habitat/pull/8157) ([mwrock](https://github.com/mwrock)) <!-- 1.6.288 -->
- Bump libc from 0.2.91 to 0.2.92 [#8156](https://github.com/habitat-sh/habitat/pull/8156) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.287 -->
- Bump dns-lookup from 1.0.5 to 1.0.6 [#8155](https://github.com/habitat-sh/habitat/pull/8155) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.286 -->
- Bump walkdir from 2.3.1 to 2.3.2 [#8152](https://github.com/habitat-sh/habitat/pull/8152) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.285 -->
- Bump serde_test from 1.0.124 to 1.0.125 [#8153](https://github.com/habitat-sh/habitat/pull/8153) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.285 -->
- Bump libc from 0.2.90 to 0.2.91 [#8151](https://github.com/habitat-sh/habitat/pull/8151) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.285 -->
- Bump serde from 1.0.124 to 1.0.125 [#8154](https://github.com/habitat-sh/habitat/pull/8154) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.284 -->
- Bump libc from 0.2.89 to 0.2.90 [#8149](https://github.com/habitat-sh/habitat/pull/8149) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.283 -->
- Bump linked-hash-map from 0.5.3 to 0.5.4 [#8146](https://github.com/habitat-sh/habitat/pull/8146) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.282 -->
- Bump native-tls from 0.2.6 to 0.2.7 [#8142](https://github.com/habitat-sh/habitat/pull/8142) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.281 -->
- Bump valico from 3.5.0 to 3.6.0 [#8143](https://github.com/habitat-sh/habitat/pull/8143) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.281 -->
- Bump url from 2.2.0 to 2.2.1 [#8145](https://github.com/habitat-sh/habitat/pull/8145) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.281 -->
- Bump cc from 1.0.66 to 1.0.67 [#8141](https://github.com/habitat-sh/habitat/pull/8141) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.280 -->
- Bump prometheus from 0.11.0 to 0.12.0 [#8139](https://github.com/habitat-sh/habitat/pull/8139) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.279 -->
- Bump windows-acl from 0.2.2 to 0.3.0 [#8133](https://github.com/habitat-sh/habitat/pull/8133) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.279 -->
- Bump derivative from 2.1.1 to 2.2.0 [#8131](https://github.com/habitat-sh/habitat/pull/8131) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.279 -->
- Bump mktemp from 0.4.0 to 0.4.1 [#8129](https://github.com/habitat-sh/habitat/pull/8129) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.279 -->
- Bump libc from 0.2.87 to 0.2.89 [#8137](https://github.com/habitat-sh/habitat/pull/8137) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.279 -->
- Bump paste from 1.0.4 to 1.0.5 [#8140](https://github.com/habitat-sh/habitat/pull/8140) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.279 -->
- Bump bimap from 0.5.2 to 0.6.0 [#8138](https://github.com/habitat-sh/habitat/pull/8138) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.279 -->
- Bump tar from 0.4.30 to 0.4.33 [#8136](https://github.com/habitat-sh/habitat/pull/8136) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.279 -->
- Bump regex from 1.4.2 to 1.4.5 [#8134](https://github.com/habitat-sh/habitat/pull/8134) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.278 -->
- fix segmentation faults of musl binaries with static relocation-model [#8135](https://github.com/habitat-sh/habitat/pull/8135) ([mwrock](https://github.com/mwrock)) <!-- 1.6.277 -->
- Bump async-trait from 0.1.42 to 0.1.48 [#8125](https://github.com/habitat-sh/habitat/pull/8125) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.276 -->
- Bump hex from 0.4.2 to 0.4.3 [#8127](https://github.com/habitat-sh/habitat/pull/8127) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.276 -->
- Bump serde_test from 1.0.123 to 1.0.124 [#8124](https://github.com/habitat-sh/habitat/pull/8124) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.276 -->
- Bump env_logger from 0.8.2 to 0.8.3 [#8126](https://github.com/habitat-sh/habitat/pull/8126) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.276 -->
- Bump caps from 0.4.0 to 0.5.1 [#8128](https://github.com/habitat-sh/habitat/pull/8128) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.275 -->
- Bump rusoto_ecr from 0.45.0 to 0.46.0 [#8120](https://github.com/habitat-sh/habitat/pull/8120) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.274 -->
- Bump serde from 1.0.115 to 1.0.124 [#8118](https://github.com/habitat-sh/habitat/pull/8118) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.273 -->
- Bump log from 0.4.11 to 0.4.14 [#8117](https://github.com/habitat-sh/habitat/pull/8117) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.273 -->
- Bump pem from 0.8.2 to 0.8.3 [#8121](https://github.com/habitat-sh/habitat/pull/8121) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.273 -->
- pin bytes in butterfly [#8123](https://github.com/habitat-sh/habitat/pull/8123) ([mwrock](https://github.com/mwrock)) <!-- 1.6.272 -->
- pin bytes crate [#8122](https://github.com/habitat-sh/habitat/pull/8122) ([mwrock](https://github.com/mwrock)) <!-- 1.6.271 -->
- Bump serde_json from 1.0.59 to 1.0.64 [#8110](https://github.com/habitat-sh/habitat/pull/8110) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.270 -->
- Bump pbr from 1.0.3 to 1.0.4 [#8112](https://github.com/habitat-sh/habitat/pull/8112) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.270 -->
- Bump winreg from 0.7.0 to 0.8.0 [#8111](https://github.com/habitat-sh/habitat/pull/8111) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.270 -->
- Rustfmt and Nightly Rust Bump to nightly-2021-03-09 [#8115](https://github.com/habitat-sh/habitat/pull/8115) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.269 -->
- post release updates [#8116](https://github.com/habitat-sh/habitat/pull/8116) ([mwrock](https://github.com/mwrock)) <!-- 1.6.268 -->

## Chef Habitat 1.6.267

### Merged pull requests

- Bump paste from 1.0.3 to 1.0.4 [#8108](https://github.com/habitat-sh/habitat/pull/8108) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.267 -->
- Bump blake2b_simd from 0.5.10 to 0.5.11 [#8107](https://github.com/habitat-sh/habitat/pull/8107) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.267 -->
- Bump hyper from 0.13.9 to 0.14.4 [#8106](https://github.com/habitat-sh/habitat/pull/8106) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.266 -->
- Bump termcolor from 1.1.0 to 1.1.2 [#8104](https://github.com/habitat-sh/habitat/pull/8104) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.265 -->
- Bump uuid from 0.8.1 to 0.8.2 [#8103](https://github.com/habitat-sh/habitat/pull/8103) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.265 -->
- serialized package shutdown_timeout should reflect effective timeout [#8099](https://github.com/habitat-sh/habitat/pull/8099) ([mwrock](https://github.com/mwrock)) <!-- 1.6.264 -->
- Bump toml from 0.5.7 to 0.5.8 [#8101](https://github.com/habitat-sh/habitat/pull/8101) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.264 -->
- Bump ctrlc from 3.1.7 to 3.1.8 [#8100](https://github.com/habitat-sh/habitat/pull/8100) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.263 -->
- Bump serde_yaml from 0.8.13 to 0.8.17 [#8093](https://github.com/habitat-sh/habitat/pull/8093) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.262 -->
- Bump libc from 0.2.81 to 0.2.87 [#8097](https://github.com/habitat-sh/habitat/pull/8097) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.261 -->
- Bump bincode from 1.3.1 to 1.3.2 [#8096](https://github.com/habitat-sh/habitat/pull/8096) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.261 -->
- Bump flate2 from 1.0.19 to 1.0.20 [#8095](https://github.com/habitat-sh/habitat/pull/8095) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.260 -->
- bump rand to 0.8.3 [#8098](https://github.com/habitat-sh/habitat/pull/8098) ([mwrock](https://github.com/mwrock)) <!-- 1.6.259 -->
- Bump thiserror from 1.0.22 to 1.0.24 [#8092](https://github.com/habitat-sh/habitat/pull/8092) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.258 -->
- Bump tempfile from 3.1.0 to 3.2.0 [#8091](https://github.com/habitat-sh/habitat/pull/8091) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.257 -->
- Revert "Bump actix-rt from 1.1.1 to 2.1.0" [#8089](https://github.com/habitat-sh/habitat/pull/8089) ([mwrock](https://github.com/mwrock)) <!-- 1.6.256 -->
- Bump serde_test from 1.0.117 to 1.0.123 [#8087](https://github.com/habitat-sh/habitat/pull/8087) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.255 -->
- Bump actix-rt from 1.1.1 to 2.1.0 [#8086](https://github.com/habitat-sh/habitat/pull/8086) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.254 -->
- Bump httparse from 1.3.4 to 1.3.5 [#8085](https://github.com/habitat-sh/habitat/pull/8085) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.253 -->
- Bump log4rs from 0.13.0 to 1.0.0 [#8046](https://github.com/habitat-sh/habitat/pull/8046) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.252 -->
- Bump log4net from 2.0.8 to 2.0.10 in /components/windows-service [#8076](https://github.com/habitat-sh/habitat/pull/8076) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.251 -->
- Page metadata [#8081](https://github.com/habitat-sh/habitat/pull/8081) ([IanMadd](https://github.com/IanMadd)) <!-- 1.6.250 -->
- use eprintln! to output specific error messages in pre_exec [#8082](https://github.com/habitat-sh/habitat/pull/8082) ([mwrock](https://github.com/mwrock)) <!-- 1.6.249 -->
- use error log_level when querying supervisor version [#8080](https://github.com/habitat-sh/habitat/pull/8080) ([mwrock](https://github.com/mwrock)) <!-- 1.6.248 -->
- emit hab-sup --version output to debug if parsing version fails [#8074](https://github.com/habitat-sh/habitat/pull/8074) ([mwrock](https://github.com/mwrock)) <!-- 1.6.247 -->
- Bump valico from 3.4.0 to 3.5.0 [#8072](https://github.com/habitat-sh/habitat/pull/8072) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.246 -->
- Bump nix from 0.18.0 to 0.19.1 [#8047](https://github.com/habitat-sh/habitat/pull/8047) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.245 -->
- set groups with primary group if unable to retrieve supplemental groups [#8069](https://github.com/habitat-sh/habitat/pull/8069) ([mwrock](https://github.com/mwrock)) <!-- 1.6.244 -->
- remove some unnecessary aliases [#8071](https://github.com/habitat-sh/habitat/pull/8071) ([mwrock](https://github.com/mwrock)) <!-- 1.6.243 -->
- Remove christophermaier as code owner [#8066](https://github.com/habitat-sh/habitat/pull/8066) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.242 -->
- Update release announcement instructions [#8065](https://github.com/habitat-sh/habitat/pull/8065) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.241 -->
- [CI] Small pipeline tweaks, documentation changes [#8064](https://github.com/habitat-sh/habitat/pull/8064) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.240 -->
- Fix some minor errors in the generate-cli-docs script [#8062](https://github.com/habitat-sh/habitat/pull/8062) ([IanMadd](https://github.com/IanMadd)) <!-- 1.6.239 -->
- Update kernel2 evaluation VM to Centos 6.10 [#8060](https://github.com/habitat-sh/habitat/pull/8060) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.238 -->
- Assorted release instruction updates [#8061](https://github.com/habitat-sh/habitat/pull/8061) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.238 -->
- Rustfmt and Nightly Rust Bump to nightly-2021-01-06 [#8058](https://github.com/habitat-sh/habitat/pull/8058) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.237 -->
- Update changelog for 1.6.235 release [#8059](https://github.com/habitat-sh/habitat/pull/8059) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.236 -->

## Chef Habitat 1.6.235

[Full Changelog](https://github.com/habitat-sh/habitat/compare/1.6.216..1.6.235)

### Bug fixes

- Improve handling of Supervisor LOCK file [#8036](https://github.com/habitat-sh/habitat/pull/8036) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.223 -->

### Merged pull requests

- [CI] Update to use new mac bootstrapper [#8051](https://github.com/habitat-sh/habitat/pull/8051) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.235 -->
- Remove the Hab docs website [#8055](https://github.com/habitat-sh/habitat/pull/8055) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.234 -->
- Bump rcgen from 0.8.5 to 0.8.9 [#8048](https://github.com/habitat-sh/habitat/pull/8048) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.233 -->
- remove unnecessary format! from panic! in fs [#8050](https://github.com/habitat-sh/habitat/pull/8050) ([mwrock](https://github.com/mwrock)) <!-- 1.6.232 -->
- Bump ctrlc from 3.1.6 to 3.1.7 [#8044](https://github.com/habitat-sh/habitat/pull/8044) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.231 -->
- [CI] Unblock macOS workers again [#8049](https://github.com/habitat-sh/habitat/pull/8049) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.230 -->
- [CI] Add additional documentation for the CI pipeline [#8008](https://github.com/habitat-sh/habitat/pull/8008) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.229 -->
- perform configopt parsing in separate thread to avoid stack overflow in main [#8041](https://github.com/habitat-sh/habitat/pull/8041) ([mwrock](https://github.com/mwrock)) <!-- 1.6.228 -->
- Bump reqwest from 0.10.3 to 0.10.10 [#8039](https://github.com/habitat-sh/habitat/pull/8039) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.228 -->
- Bump libc from 0.2.80 to 0.2.81 [#8037](https://github.com/habitat-sh/habitat/pull/8037) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.228 -->
- Bump widestring from 0.4.2 to 0.4.3 [#8042](https://github.com/habitat-sh/habitat/pull/8042) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.227 -->
- [CI] Bump macOS builder timeouts [#8043](https://github.com/habitat-sh/habitat/pull/8043) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.226 -->
- Create the Supervisor state directories before acquiring lock [#8040](https://github.com/habitat-sh/habitat/pull/8040) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.225 -->
- Migrate cli implementation from clap to structopt [#8027](https://github.com/habitat-sh/habitat/pull/8027) ([sajjaphani](https://github.com/sajjaphani)) <!-- 1.6.224 -->
- Bump pem from 0.8.1 to 0.8.2 [#8034](https://github.com/habitat-sh/habitat/pull/8034) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.223 -->
- Bump flate2 from 1.0.17 to 1.0.19 [#8033](https://github.com/habitat-sh/habitat/pull/8033) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.223 -->
- Bump futures from 0.3.5 to 0.3.8 [#8015](https://github.com/habitat-sh/habitat/pull/8015) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.222 -->
- Bump env_logger from 0.7.1 to 0.8.2 [#8014](https://github.com/habitat-sh/habitat/pull/8014) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.221 -->
- Edit plan_variable docs for clarity [#7992](https://github.com/habitat-sh/habitat/pull/7992) ([IanMadd](https://github.com/IanMadd)) <!-- 1.6.220 -->
- Bump async-trait from 0.1.38 to 0.1.42 [#8007](https://github.com/habitat-sh/habitat/pull/8007) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.219 -->
- Bump tar from 0.4.29 to 0.4.30 [#8003](https://github.com/habitat-sh/habitat/pull/8003) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.218 -->
- Update CHANGELOG for 1.6.216 [#8012](https://github.com/habitat-sh/habitat/pull/8012) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.217 -->

## Chef Habitat 1.6.216

[Full Changelog](https://github.com/habitat-sh/habitat/compare/1.6.181..1.6.216)

### Bug fixes

- [FIX] Ensure that health check output is available via HTTP gateway [#7991](https://github.com/habitat-sh/habitat/pull/7991) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.207 -->

### Merged pull requests

- [CI] Remove `--no-modify-path` from `install_rustup` [#8009](https://github.com/habitat-sh/habitat/pull/8009) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.216 -->
- added utility function required_value_of and refactored [#7984](https://github.com/habitat-sh/habitat/pull/7984) ([sajjaphani](https://github.com/sajjaphani)) <!-- 1.6.215 -->
- Bump paste from 1.0.0 to 1.0.3 [#8004](https://github.com/habitat-sh/habitat/pull/8004) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.214 -->
- [CI] Increase service unload timeouts for test_config_files e2e test [#8005](https://github.com/habitat-sh/habitat/pull/8005) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.213 -->
- [CI] Move documentation generation to release pipeline [#7993](https://github.com/habitat-sh/habitat/pull/7993) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.212 -->
- Bump url from 2.1.1 to 2.2.0 [#7995](https://github.com/habitat-sh/habitat/pull/7995) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.211 -->
- Bump parking_lot from 0.11.0 to 0.11.1 [#7997](https://github.com/habitat-sh/habitat/pull/7997) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.210 -->
- Bump hyper from 0.13.7 to 0.13.9 [#7996](https://github.com/habitat-sh/habitat/pull/7996) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.209 -->
- [CI] Unload test-probe service after test [#8000](https://github.com/habitat-sh/habitat/pull/8000) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.208 -->
- Bump prometheus from 0.9.0 to 0.10.0 [#7987](https://github.com/habitat-sh/habitat/pull/7987) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.206 -->
- [CI] Remove old `hab` binaries on Linux containers [#7994](https://github.com/habitat-sh/habitat/pull/7994) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.205 -->
- Bump serde_json from 1.0.57 to 1.0.59 [#7988](https://github.com/habitat-sh/habitat/pull/7988) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.204 -->
- Bump errno from 0.2.6 to 0.2.7 [#7989](https://github.com/habitat-sh/habitat/pull/7989) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.203 -->
- Bump thiserror from 1.0.20 to 1.0.22 [#7986](https://github.com/habitat-sh/habitat/pull/7986) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.202 -->
- Bump semver from 0.10.0 to 0.11.0 [#7974](https://github.com/habitat-sh/habitat/pull/7974) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.201 -->
- Bump dns-lookup from 1.0.3 to 1.0.5 [#7977](https://github.com/habitat-sh/habitat/pull/7977) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.200 -->
- Lock pin-project crate to 0.4.23 for explicitness [#7985](https://github.com/habitat-sh/habitat/pull/7985) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.199 -->
- Bump actix-web from 3.0.0 to 3.2.0 [#7975](https://github.com/habitat-sh/habitat/pull/7975) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.198 -->
- Remove me as codeowner [#7983](https://github.com/habitat-sh/habitat/pull/7983) ([smacfarlane](https://github.com/smacfarlane)) <!-- 1.6.197 -->
- Lock Tokio dependencies to 0.2 line [#7982](https://github.com/habitat-sh/habitat/pull/7982) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.196 -->
- Lock lazy_static dependency [#7981](https://github.com/habitat-sh/habitat/pull/7981) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.196 -->
- Bump os_info from 2.0.8 to 3.0.1 [#7980](https://github.com/habitat-sh/habitat/pull/7980) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.195 -->
- Lock down log dependencies [#7979](https://github.com/habitat-sh/habitat/pull/7979) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.194 -->
- only test non system drive build on windows [#7978](https://github.com/habitat-sh/habitat/pull/7978) ([mwrock](https://github.com/mwrock)) <!-- 1.6.193 -->
- Update automation for CLI and Service Template Data docs [#7968](https://github.com/habitat-sh/habitat/pull/7968) ([IanMadd](https://github.com/IanMadd)) <!-- 1.6.192 -->
- Bump state from 0.4.1 to 0.4.2 [#7972](https://github.com/habitat-sh/habitat/pull/7972) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.191 -->
- Specify winapi version more tightly [#7976](https://github.com/habitat-sh/habitat/pull/7976) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.191 -->
- Rustfmt and Nightly Rust Bump to nightly-2020-10-25 [#7954](https://github.com/habitat-sh/habitat/pull/7954) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.190 -->
- Add Dependabot config for Rust [#7970](https://github.com/habitat-sh/habitat/pull/7970) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.190 -->
- fix studio failure building outside system drive [#7969](https://github.com/habitat-sh/habitat/pull/7969) ([mwrock](https://github.com/mwrock)) <!-- 1.6.189 -->
- Add redirects for api pages [#7967](https://github.com/habitat-sh/habitat/pull/7967) ([IanMadd](https://github.com/IanMadd)) <!-- 1.6.188 -->
- Edits to service docs [#7947](https://github.com/habitat-sh/habitat/pull/7947) ([IanMadd](https://github.com/IanMadd)) <!-- 1.6.187 -->
- Add Hab API docs [#7966](https://github.com/habitat-sh/habitat/pull/7966) ([IanMadd](https://github.com/IanMadd)) <!-- 1.6.186 -->
- Add About Habitat index page [#7948](https://github.com/habitat-sh/habitat/pull/7948) ([IanMadd](https://github.com/IanMadd)) <!-- 1.6.185 -->
- Delete glossary page [#7962](https://github.com/habitat-sh/habitat/pull/7962) ([IanMadd](https://github.com/IanMadd)) <!-- 1.6.184 -->
- Update page names and page links [#7961](https://github.com/habitat-sh/habitat/pull/7961) ([IanMadd](https://github.com/IanMadd)) <!-- 1.6.184 -->
- WIP - Chef Habitat Resources structural edits [#7959](https://github.com/habitat-sh/habitat/pull/7959) ([mjingle](https://github.com/mjingle)) <!-- 1.6.183 -->
- Automated update of Habitat Documentation [#7963](https://github.com/habitat-sh/habitat/pull/7963) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.183 -->
- 1.6.181 Changelog [#7964](https://github.com/habitat-sh/habitat/pull/7964) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.182 -->

## Chef Habitat 1.6.181

[Full Changelog](https://github.com/habitat-sh/habitat/compare/1.6.175..1.6.181)

### Bug fixes

- [FIX] Minimal change to enable non-root containers again [#7960](https://github.com/habitat-sh/habitat/pull/7960) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.181 -->

### Merged pull requests

- 1.6.175 Documentation, plus docs generation script update [#7957](https://github.com/habitat-sh/habitat/pull/7957) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.180 -->
- [FIX] Fix a bad environment variable lookup in hab-plan-bulid [#7958](https://github.com/habitat-sh/habitat/pull/7958) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.179 -->
- Update Changelog for 1.6.175 [#7956](https://github.com/habitat-sh/habitat/pull/7956) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.178 -->
- Update pages, weights, and edit on GH links [#7953](https://github.com/habitat-sh/habitat/pull/7953) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.177 -->
- Curate docs images in docs-chef-io [#7916](https://github.com/habitat-sh/habitat/pull/7916) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.176 -->

## Chef Habitat 1.6.175

[Full Changelog](https://github.com/habitat-sh/habitat/compare/1.6.139..1.6.175)

### Behavioral changes

- an API retry pattern [#7874](https://github.com/habitat-sh/habitat/pull/7874) ([jeremymv2](https://github.com/jeremymv2)) <!-- 1.6.150 -->

### Merged pull requests

- Expose HAB_FALLBACK_CHANNEL in plan build [#7951](https://github.com/habitat-sh/habitat/pull/7951) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.175 -->
- [BUG] Update actix-web calling conventions [#7950](https://github.com/habitat-sh/habitat/pull/7950) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.174 -->
- Revert "Merge pull request #7943 from habitat-sh/cm/revert-tls" [#7949](https://github.com/habitat-sh/habitat/pull/7949) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.173 -->
- [CI] Capture Supervisor logs from e2e tests  [#7942](https://github.com/habitat-sh/habitat/pull/7942) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.172 -->
- Monday module update [#7945](https://github.com/habitat-sh/habitat/pull/7945) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.171 -->
- adds docs component &amp; team as codeowners [#7946](https://github.com/habitat-sh/habitat/pull/7946) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.170 -->
- updating codeowners due to team departures [#7944](https://github.com/habitat-sh/habitat/pull/7944) ([jeremymv2](https://github.com/jeremymv2)) <!-- 1.6.169 -->
- Revert "Merge pull request #7923 from habitat-sh/dmcneil/ctl-gateway-... [#7943](https://github.com/habitat-sh/habitat/pull/7943) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.168 -->
- Make shorter Builder pages [#7939](https://github.com/habitat-sh/habitat/pull/7939) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.167 -->
- Add TLS support to the ctl gateway [#7923](https://github.com/habitat-sh/habitat/pull/7923) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.166 -->
- Updates Hugo, Node modules [#7941](https://github.com/habitat-sh/habitat/pull/7941) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.165 -->
- Temporarily disable website deploy triggers [#7904](https://github.com/habitat-sh/habitat/pull/7904) ([smacfarlane](https://github.com/smacfarlane)) <!-- 1.6.165 -->
- add patents notification to `hab` cli [#7937](https://github.com/habitat-sh/habitat/pull/7937) ([sdelano](https://github.com/sdelano)) <!-- 1.6.164 -->
- eliminate usages of `hab install` alias in plan-build-ps1 [#7938](https://github.com/habitat-sh/habitat/pull/7938) ([mwrock](https://github.com/mwrock)) <!-- 1.6.164 -->
- Update env_proxy to 0.4.1 [#7933](https://github.com/habitat-sh/habitat/pull/7933) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.163 -->
- Fix e2e tests [#7934](https://github.com/habitat-sh/habitat/pull/7934) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.162 -->
- Cleanup the CLI config file [#7931](https://github.com/habitat-sh/habitat/pull/7931) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.161 -->
- fix prompting to stop launcher when closing windows docker studio [#7930](https://github.com/habitat-sh/habitat/pull/7930) ([mwrock](https://github.com/mwrock)) <!-- 1.6.160 -->
- [REFACTOR] Utilize the `Origin` type more broadly [#7919](https://github.com/habitat-sh/habitat/pull/7919) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.159 -->
- [REFACTOR] Simplify Blake2b hash implementation [#7918](https://github.com/habitat-sh/habitat/pull/7918) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.158 -->
- Temp Netlify configuration [#7924](https://github.com/habitat-sh/habitat/pull/7924) ([IanMadd](https://github.com/IanMadd)) <!-- 1.6.157 -->
- Update changelog [#7886](https://github.com/habitat-sh/habitat/pull/7886) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.156 -->
- Add deprecation message for `hab sup status` [#7896](https://github.com/habitat-sh/habitat/pull/7896) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.155 -->
- Organize the Hugo Docs [#7920](https://github.com/habitat-sh/habitat/pull/7920) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.154 -->
- Docs is coming! [#7914](https://github.com/habitat-sh/habitat/pull/7914) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.153 -->
- skip remote download when present in cache or offline [#7915](https://github.com/habitat-sh/habitat/pull/7915) ([jeremymv2](https://github.com/jeremymv2)) <!-- 1.6.152 -->
- re-add removed else condition logic for hab pkg download [#7913](https://github.com/habitat-sh/habitat/pull/7913) ([jeremymv2](https://github.com/jeremymv2)) <!-- 1.6.151 -->
- Overhaul and refactoring of Keys [#7887](https://github.com/habitat-sh/habitat/pull/7887) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.149 -->
- Rename dev docs directory "dev-docs" [#7909](https://github.com/habitat-sh/habitat/pull/7909) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.148 -->
- Quick fixes for the Builder page [#7907](https://github.com/habitat-sh/habitat/pull/7907) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.147 -->
- Check if license exists for current user during license acceptance [#7906](https://github.com/habitat-sh/habitat/pull/7906) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.146 -->
- Keep the code inside of the window [#7894](https://github.com/habitat-sh/habitat/pull/7894) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.145 -->
- Update Builder Documentation [#7581](https://github.com/habitat-sh/habitat/pull/7581) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.144 -->
- Automated update of Habitat Documentation [#7898](https://github.com/habitat-sh/habitat/pull/7898) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.143 -->
- Cargo Update [#7899](https://github.com/habitat-sh/habitat/pull/7899) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.143 -->
- Rustfmt and Nightly Rust Bump to nightly-2020-08-28 [#7897](https://github.com/habitat-sh/habitat/pull/7897) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.142 -->
- Fix update documentation pipeline [#7895](https://github.com/habitat-sh/habitat/pull/7895) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.141 -->
- Rustfmt and Nightly Rust Bump to nightly-2020-08-24 [#7889](https://github.com/habitat-sh/habitat/pull/7889) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.140 -->

<!-- latest_stable_release 1.6.139 -->

## Chef Habitat 1.6.139

Release date: August 25, 2020

[Full Changelog](https://github.com/habitat-sh/habitat/compare/1.6.115..1.6.139)

### New features and enhancements

- Add `hab sup restart` command [#7878](https://github.com/habitat-sh/habitat/pull/7878) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.134 -->
- builder origin rbac subcommand [#7841](https://github.com/habitat-sh/habitat/pull/7841) ([jeremymv2](https://github.com/jeremymv2)) <!-- 1.6.123 -->

### Behavioral changes

- Pull packages from the `--channel` argument on `hab sup run` [#7871](https://github.com/habitat-sh/habitat/pull/7871) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.131 -->
- Deprecate CLI aliases [#7872](https://github.com/habitat-sh/habitat/pull/7872) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.129 -->
- Add splay to health check execution [#7850](https://github.com/habitat-sh/habitat/pull/7850) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.121 -->

### Merged pull requests

- Fix text in e2e test [#7883](https://github.com/habitat-sh/habitat/pull/7883) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.139 -->
- Replace `hab install` with `hab pkg install` in plan-build [#7882](https://github.com/habitat-sh/habitat/pull/7882) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.138 -->
- Fix CLI deprecation when generating completions [#7881](https://github.com/habitat-sh/habitat/pull/7881) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.137 -->
- Report errors when getting user and group [#7879](https://github.com/habitat-sh/habitat/pull/7879) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.136 -->
- Update dependencies [#7875](https://github.com/habitat-sh/habitat/pull/7875) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.135 -->
- Remove the `hab pkg export cf` command from windows [#7877](https://github.com/habitat-sh/habitat/pull/7877) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.133 -->
- don't add c:/hab/bin to persistent path in ci [#7876](https://github.com/habitat-sh/habitat/pull/7876) ([mwrock](https://github.com/mwrock)) <!-- 1.6.132 -->
- Fix `hab sup --version` after `structopt` refactoring [#7873](https://github.com/habitat-sh/habitat/pull/7873) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.130 -->
- fix path to VERSION file in windows plans [#7868](https://github.com/habitat-sh/habitat/pull/7868) ([mwrock](https://github.com/mwrock)) <!-- 1.6.128 -->
- Remove custom cli parsing [#7870](https://github.com/habitat-sh/habitat/pull/7870) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.127 -->
- Improve error message when installing internal packages [#7869](https://github.com/habitat-sh/habitat/pull/7869) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.126 -->
- Improve parsing of `hab pkg export` [#7865](https://github.com/habitat-sh/habitat/pull/7865) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.125 -->
- Add some e2e tests around crypto functionality [#7867](https://github.com/habitat-sh/habitat/pull/7867) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.124 -->
- Automated update of Habitat Documentation [#7861](https://github.com/habitat-sh/habitat/pull/7861) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.122 -->
- modernize windows tutorial [#7820](https://github.com/habitat-sh/habitat/pull/7820) ([mwrock](https://github.com/mwrock)) <!-- 1.6.120 -->
- Update Changelog for 1.6.115 [#7864](https://github.com/habitat-sh/habitat/pull/7864) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.119 -->
- make bind timeout configurable and add debug output around startup [#7858](https://github.com/habitat-sh/habitat/pull/7858) ([mwrock](https://github.com/mwrock)) <!-- 1.6.117 -->
- Cleanup `hab pkg export` subcommand [#7857](https://github.com/habitat-sh/habitat/pull/7857) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.116 -->
<!-- latest_stable_release -->

## Chef Habitat 1.6.115

[Full Changelog](https://github.com/habitat-sh/habitat/compare/1.6.56..1.6.115)

### New features and enhancements

- hab pkg info extended metadata [#7814](https://github.com/habitat-sh/habitat/pull/7814) ([jeremymv2](https://github.com/jeremymv2)) <!-- 1.6.99 -->
- Add command line completion to powershell studio [#7831](https://github.com/habitat-sh/habitat/pull/7831) ([mwrock](https://github.com/mwrock)) <!-- 1.6.98 -->
- Add HAB_STUDIO_SUP support to Windows studio [#7791](https://github.com/habitat-sh/habitat/pull/7791) ([mwrock](https://github.com/mwrock)) <!-- 1.6.83 -->
- Add `hab svc update` command [#7781](https://github.com/habitat-sh/habitat/pull/7781) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.75 -->
- Service bootstrap [#7765](https://github.com/habitat-sh/habitat/pull/7765) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.73 -->
- add uninstall hook [#7764](https://github.com/habitat-sh/habitat/pull/7764) ([mwrock](https://github.com/mwrock)) <!-- 1.6.68 -->
- Allow dynamic changes to updater-related config for services  [#7770](https://github.com/habitat-sh/habitat/pull/7770) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.65 -->
- always promote package on upload if a user specifies a channel [#7768](https://github.com/habitat-sh/habitat/pull/7768) ([jeremymv2](https://github.com/jeremymv2)) <!-- 1.6.65 -->

### Bug fixes

- Allow version check without license [#7834](https://github.com/habitat-sh/habitat/pull/7834) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.112 -->
- fallback to superuser root if home path can't be found during license search [#7853](https://github.com/habitat-sh/habitat/pull/7853) ([mwrock](https://github.com/mwrock)) <!-- 1.6.110 -->
- refactor account/sid/win_perms to not need to contact a domian controller [#7844](https://github.com/habitat-sh/habitat/pull/7844) ([mwrock](https://github.com/mwrock)) <!-- 1.6.104 -->
- Add supplemental groups to Linux hook processes [#7823](https://github.com/habitat-sh/habitat/pull/7823) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.100 -->
- Ignore unreadable keys when exporting (among other uses) [#7832](https://github.com/habitat-sh/habitat/pull/7832) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.99 -->
- [Fix] Cli completions by conditionally hiding bulkload subcommand [#7827](https://github.com/habitat-sh/habitat/pull/7827) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.96 -->
- Fix hab svc load argument parsing [#7822](https://github.com/habitat-sh/habitat/pull/7822) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.96 -->
- fix builds consuming runtime environment of build deps [#7828](https://github.com/habitat-sh/habitat/pull/7828) ([mwrock](https://github.com/mwrock)) <!-- 1.6.96 -->
- fix ctrlc in local windows studio [#7808](https://github.com/habitat-sh/habitat/pull/7808) ([mwrock](https://github.com/mwrock)) <!-- 1.6.90 -->
- unify bash and powershell pwd locations for build, check, prepare and install [#7796](https://github.com/habitat-sh/habitat/pull/7796) ([mwrock](https://github.com/mwrock)) <!-- 1.6.83 -->
- Write all service files when a service is loaded  [#7799](https://github.com/habitat-sh/habitat/pull/7799) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.83 -->
- symlink artifact cache in windows native studio [#7786](https://github.com/habitat-sh/habitat/pull/7786) ([mwrock](https://github.com/mwrock)) <!-- 1.6.82 -->
- ensure tdeps file is built with lower level deps at the bottom of the list [#7776](https://github.com/habitat-sh/habitat/pull/7776) ([mwrock](https://github.com/mwrock)) <!-- 1.6.70 -->
- hab-plan-build: don&#39;t fail on empty hooks dir [#7775](https://github.com/habitat-sh/habitat/pull/7775) ([stevendanna](https://github.com/stevendanna)) <!-- 1.6.67 -->
- Fix reading root certs [#7778](https://github.com/habitat-sh/habitat/pull/7778) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.66 -->
- Explicit permissions on keys [#7739](https://github.com/habitat-sh/habitat/pull/7739) ([stevendanna](https://github.com/stevendanna)) <!-- 1.6.64 -->
- [FIX] Ensure `toToml` helper works properly for tables [#7772](https://github.com/habitat-sh/habitat/pull/7772) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.63 -->

### Merged pull requests

- Rustfmt and Nightly Rust Bump to nightly-2020-07-27 [#7862](https://github.com/habitat-sh/habitat/pull/7862) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.118 -->
- make bind timeout configurable and add debug output around startup [#7858](https://github.com/habitat-sh/habitat/pull/7858) ([mwrock](https://github.com/mwrock)) <!-- 1.6.117 -->
- Cleanup `hab pkg export` subcommand [#7857](https://github.com/habitat-sh/habitat/pull/7857) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.116 -->
- fix license environment injection in container exporter [#7860](https://github.com/habitat-sh/habitat/pull/7860) ([mwrock](https://github.com/mwrock)) <!-- 1.6.115 -->
- fix e2e test_license test [#7859](https://github.com/habitat-sh/habitat/pull/7859) ([mwrock](https://github.com/mwrock)) <!-- 1.6.114 -->
- fix e2e test with older launcher [#7856](https://github.com/habitat-sh/habitat/pull/7856) ([mwrock](https://github.com/mwrock)) <!-- 1.6.113 -->
- fix launcher version parsing [#7855](https://github.com/habitat-sh/habitat/pull/7855) ([mwrock](https://github.com/mwrock)) <!-- 1.6.111 -->
- [CI] Ensure that kernel2 packages get build appropriately [#7854](https://github.com/habitat-sh/habitat/pull/7854) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.109 -->
- Add channel promotion datadog event [#7848](https://github.com/habitat-sh/habitat/pull/7848) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.108 -->
- use win32 api and not env var for determining current user name [#7840](https://github.com/habitat-sh/habitat/pull/7840) ([mwrock](https://github.com/mwrock)) <!-- 1.6.107 -->
- [CI] Pull Chef GPG key from Vault instead of S3 [#7852](https://github.com/habitat-sh/habitat/pull/7852) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.106 -->
- [CI] Ensure GPG keys are imported before verifying manifest [#7851](https://github.com/habitat-sh/habitat/pull/7851) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.105 -->
- [CI] Fixed some stupid bugs in the supplemental groups test [#7839](https://github.com/habitat-sh/habitat/pull/7839) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.103 -->
- [CI] Update changelog management labels in Expeditor config [#7837](https://github.com/habitat-sh/habitat/pull/7837) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.102 -->
- [CI] Binlink `hab` earlier in the path for e2e tests [#7835](https://github.com/habitat-sh/habitat/pull/7835) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.101 -->
- delete old objects in S3 bucket that don't exist in local website build [#7829](https://github.com/habitat-sh/habitat/pull/7829) ([jeremymv2](https://github.com/jeremymv2)) <!-- 1.6.98 -->
- Update configopt version [#7830](https://github.com/habitat-sh/habitat/pull/7830) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.97 -->
- Use the new downloads site where appropriate. [#7824](https://github.com/habitat-sh/habitat/pull/7824) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.95 -->
- fixes clippy [#7826](https://github.com/habitat-sh/habitat/pull/7826) ([mwrock](https://github.com/mwrock)) <!-- 1.6.94 -->
- [Chore] Update rust to 1.44.1 [#7825](https://github.com/habitat-sh/habitat/pull/7825) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.93 -->
- remove link to kubernetes operator and cloud foundary exporter [#7821](https://github.com/habitat-sh/habitat/pull/7821) ([mwrock](https://github.com/mwrock)) <!-- 1.6.92 -->
- A PR to preview what habitat.sh will look like with branding from community.chef.io [#7762](https://github.com/habitat-sh/habitat/pull/7762) ([chefjiajia](https://github.com/chefjiajia)) <!-- 1.6.91 -->
- [CI] Fix service update e2e test [#7813](https://github.com/habitat-sh/habitat/pull/7813) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.89 -->
- Fix e2e failures [#7807](https://github.com/habitat-sh/habitat/pull/7807) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.88 -->
- [CI] Bump macOS stage retry limits [#7806](https://github.com/habitat-sh/habitat/pull/7806) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.87 -->
- [REFACTOR] A handful of minor tweaks [#7801](https://github.com/habitat-sh/habitat/pull/7801) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.86 -->
- [CI] Fix a forgotten renaming [#7805](https://github.com/habitat-sh/habitat/pull/7805) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.85 -->
- output SRC_PATH in hab-plan-puild.ps1 results [#7802](https://github.com/habitat-sh/habitat/pull/7802) ([mwrock](https://github.com/mwrock)) <!-- 1.6.84 -->
- Make rust compiler warnings errors [#7800](https://github.com/habitat-sh/habitat/pull/7800) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.84 -->
- Add packages for health check performance tests [#7797](https://github.com/habitat-sh/habitat/pull/7797) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.81 -->
- use a single env var lock in tests to improve consistency [#7795](https://github.com/habitat-sh/habitat/pull/7795) ([mwrock](https://github.com/mwrock)) <!-- 1.6.80 -->
- Update `structopt` [#7793](https://github.com/habitat-sh/habitat/pull/7793) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.79 -->
- increase rumor file atomicity and durability [#7783](https://github.com/habitat-sh/habitat/pull/7783) ([jeremymv2](https://github.com/jeremymv2)) <!-- 1.6.78 -->
- [CI] Bump macOS timeout in release pipeline [#7789](https://github.com/habitat-sh/habitat/pull/7789) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.77 -->
- [FIX] Ensure --remote-sup option is parsed properly [#7788](https://github.com/habitat-sh/habitat/pull/7788) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.76 -->
- Propagate install and uninstall hook exit codes [#7782](https://github.com/habitat-sh/habitat/pull/7782) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.74 -->
- start gossip listener before spawning services [#7784](https://github.com/habitat-sh/habitat/pull/7784) ([mwrock](https://github.com/mwrock)) <!-- 1.6.72 -->
- [CI] Increase macOS timeouts [#7785](https://github.com/habitat-sh/habitat/pull/7785) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.71 -->
- compile windows-service package version into binary and log version at start of log [#7779](https://github.com/habitat-sh/habitat/pull/7779) ([mwrock](https://github.com/mwrock)) <!-- 1.6.69 -->
- adding documentation on the HAB_SUP_UPDATE_MS environment variable [#7717](https://github.com/habitat-sh/habitat/pull/7717) ([jeremymv2](https://github.com/jeremymv2)) <!-- 1.6.65 -->
- [REFACTOR] Clean up and streamline spec reconciliation [#7766](https://github.com/habitat-sh/habitat/pull/7766) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.62 -->
- correcting multi-target package plan layout example [#7763](https://github.com/habitat-sh/habitat/pull/7763) ([jeremymv2](https://github.com/jeremymv2)) <!-- 1.6.61 -->
- [CI] Simplify PKG_CONFIG_PATH for cargo_update.sh [#7761](https://github.com/habitat-sh/habitat/pull/7761) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.60 -->
- Automated update of Habitat Documentation [#7758](https://github.com/habitat-sh/habitat/pull/7758) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.59 -->
- Rustfmt and Nightly Rust Bump to nightly-2020-06-22 [#7759](https://github.com/habitat-sh/habitat/pull/7759) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.58 -->
- Update changelog for 1.6.56 release [#7760](https://github.com/habitat-sh/habitat/pull/7760) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.57 -->

## Chef Habitat 1.6.56

[Full Changelog](https://github.com/habitat-sh/habitat/compare/1.6.39..1.6.56)

### Bug fixes

- CtlGateway handshake fix [#7755](https://github.com/habitat-sh/habitat/pull/7755) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.53 -->
- read hook stdout/err allowing for lossy utf8 strings [#7724](https://github.com/habitat-sh/habitat/pull/7724) ([mwrock](https://github.com/mwrock)) <!-- 1.6.46 -->

### New features and enhancements

- Use the cli.toml auth_token during package install [#7735](https://github.com/habitat-sh/habitat/pull/7735) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.51 -->
- allow hook extentions in plan [#7740](https://github.com/habitat-sh/habitat/pull/7740) ([mwrock](https://github.com/mwrock)) <!-- 1.6.49 -->

### Merged pull requests

- [CI] Bump timeout to 45 minutes [#7757](https://github.com/habitat-sh/habitat/pull/7757) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.56 -->
- [REFACTOR] Store service spec in Service struct [#7752](https://github.com/habitat-sh/habitat/pull/7752) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.55 -->
- Restore and deprecate update period env vars [#7756](https://github.com/habitat-sh/habitat/pull/7756) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.54 -->
- Improve serde usage [#7732](https://github.com/habitat-sh/habitat/pull/7732) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.52 -->
- fix e2e failures [#7742](https://github.com/habitat-sh/habitat/pull/7742) ([mwrock](https://github.com/mwrock)) <!-- 1.6.50 -->
- Supervisor update config [#7733](https://github.com/habitat-sh/habitat/pull/7733) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.48 -->
- use powershell 7.0.1 [#7730](https://github.com/habitat-sh/habitat/pull/7730) ([mwrock](https://github.com/mwrock)) <!-- 1.6.47 -->
- Update rust to 1.43.1 [#7728](https://github.com/habitat-sh/habitat/pull/7728) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.45 -->
- Remove libarchive and Vendor openssl [#7710](https://github.com/habitat-sh/habitat/pull/7710) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.44 -->
- Fix typos and refresh in cli help [#7718](https://github.com/habitat-sh/habitat/pull/7718) ([jsirex](https://github.com/jsirex)) <!-- 1.6.43 -->
- [CI] Re-enable skipped verify builds affected by core-plans refresh  [#7649](https://github.com/habitat-sh/habitat/pull/7649) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.42 -->
- Rustfmt and Nightly Rust Bump to nightly-2020-05-15 [#7713](https://github.com/habitat-sh/habitat/pull/7713) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.42 -->
- Cargo Update [#7715](https://github.com/habitat-sh/habitat/pull/7715) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.41 -->
- Automated update of Habitat Documentation [#7714](https://github.com/habitat-sh/habitat/pull/7714) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.41 -->
- Update Changelog [#7716](https://github.com/habitat-sh/habitat/pull/7716) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.40 -->

## Chef Habitat 1.6.39

[Full Changelog](https://github.com/habitat-sh/habitat/compare/1.6.0..1.6.39)

### Behavioral changes

- `hab pkg export docker` is now `hab pkg export container` [#7674](https://github.com/habitat-sh/habitat/pull/7674) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.21 -->

### New features and enhancements

- Add Bulidah as an engine for unprivileged container builds [#7685](https://github.com/habitat-sh/habitat/pull/7685) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.28 -->
- Config file support for `hab sup run` [#7658](https://github.com/habitat-sh/habitat/pull/7658) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.15 -->

### Merged pull requests

- Add a signature policy file for Buildah exports [#7711](https://github.com/habitat-sh/habitat/pull/7711) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.39 -->
- Revert "Merge pull request #7688 from habitat-sh/cm/static-launcher" [#7709](https://github.com/habitat-sh/habitat/pull/7709) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.38 -->
- Use docker executor for kernel2 verify [#7707](https://github.com/habitat-sh/habitat/pull/7707) ([smacfarlane](https://github.com/smacfarlane)) <!-- 1.6.37 -->
- Feature/windows logging [#7691](https://github.com/habitat-sh/habitat/pull/7691) ([collinmcneese](https://github.com/collinmcneese)) <!-- 1.6.36 -->
- [CI] Build kernel2 packages in verify stage [#7706](https://github.com/habitat-sh/habitat/pull/7706) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.35 -->
- Update rust and dependencies [#7575](https://github.com/habitat-sh/habitat/pull/7575) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.34 -->
- Add several `ok_***` macros for each logging level [#7700](https://github.com/habitat-sh/habitat/pull/7700) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.33 -->
- Revert ZMQ Update [#7701](https://github.com/habitat-sh/habitat/pull/7701) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.32 -->
- supervisor config doc [#7675](https://github.com/habitat-sh/habitat/pull/7675) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.31 -->
- core: move from users to nix crate [#7620](https://github.com/habitat-sh/habitat/pull/7620) ([stevendanna](https://github.com/stevendanna)) <!-- 1.6.30 -->
- Statically compile the Launcher on Linux [#7688](https://github.com/habitat-sh/habitat/pull/7688) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.29 -->
- Upgrade ZMQ dependency off of our fork  [#7681](https://github.com/habitat-sh/habitat/pull/7681) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.27 -->
- Fix minimum health check interval [#7683](https://github.com/habitat-sh/habitat/pull/7683) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.26 -->
- Update sodiumoxide dependency [#7680](https://github.com/habitat-sh/habitat/pull/7680) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.25 -->
- REFACTOR: Remove ImageBuilder struct [#7682](https://github.com/habitat-sh/habitat/pull/7682) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.24 -->
- [REFACTOR] Introduce "Engine" abstraction to `hab pkg export container` [#7677](https://github.com/habitat-sh/habitat/pull/7677) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.23 -->
- Cleanup health checking [#7676](https://github.com/habitat-sh/habitat/pull/7676) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.22 -->
- Remove duplicated serialization logic in SvcMember [#7673](https://github.com/habitat-sh/habitat/pull/7673) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.20 -->
- [REFACTOR] Use TryFrom for BuildSpec [#7669](https://github.com/habitat-sh/habitat/pull/7669) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.19 -->
- [REFACTOR]  Factor out an Identified trait for DockerBuilder and DockerImage [#7668](https://github.com/habitat-sh/habitat/pull/7668) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.18 -->
- [REFACTOR] Extract and consolidate naming data for Docker exporter [#7659](https://github.com/habitat-sh/habitat/pull/7659) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.17 -->
- [REFACTOR] Remove some lifetimes to simplify Docker exporter [#7660](https://github.com/habitat-sh/habitat/pull/7660) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.16 -->
- Correct bootstrap typo [#7665](https://github.com/habitat-sh/habitat/pull/7665) ([smacfarlane](https://github.com/smacfarlane)) <!-- 1.6.14 -->
- Update MacOS Bootstrapper version [#7663](https://github.com/habitat-sh/habitat/pull/7663) ([smacfarlane](https://github.com/smacfarlane)) <!-- 1.6.13 -->
- Bump jquery from 3.4.1 to 3.5.0 in /components/habitat-chef-io/themes/docs-new [#7656](https://github.com/habitat-sh/habitat/pull/7656) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.6.12 -->
- [CI] Fix e2e test that broke after the core plans refresh [#7661](https://github.com/habitat-sh/habitat/pull/7661) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.11 -->
- [REFACTOR] Use FullyQualifiedPackageIdent in Docker exporter [#7657](https://github.com/habitat-sh/habitat/pull/7657) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.10 -->
- [REFACTOR] Docker Exporter CLI consolidation, cleanup [#7654](https://github.com/habitat-sh/habitat/pull/7654) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.10 -->
- [REFACTOR] Push Windows Docker Engine check earlier [#7655](https://github.com/habitat-sh/habitat/pull/7655) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.10 -->
- [TYPO] Gigabytes are "gb", not "bg" [#7652](https://github.com/habitat-sh/habitat/pull/7652) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.9 -->
- Cleanup `FS_ROOT` [#7642](https://github.com/habitat-sh/habitat/pull/7642) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.8 -->
- Cargo Update [#7633](https://github.com/habitat-sh/habitat/pull/7633) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.7 -->
- [CI] Ensure release pipeline isn't poisoned by old dependencies [#7650](https://github.com/habitat-sh/habitat/pull/7650) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.6 -->
- Post-refresh cleanup [#7648](https://github.com/habitat-sh/habitat/pull/7648) ([christophermaier](https://github.com/christophermaier)) <!-- 1.6.5 -->
- Update configopt [#7600](https://github.com/habitat-sh/habitat/pull/7600) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.4 -->
- Automated update of Habitat Documentation [#7632](https://github.com/habitat-sh/habitat/pull/7632) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.4 -->
- Rustfmt and Nightly Rust Bump to nightly-2020-04-21 [#7631](https://github.com/habitat-sh/habitat/pull/7631) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.6.3 -->
- New Documentation Component [#7544](https://github.com/habitat-sh/habitat/pull/7544) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.6.2 -->
- Update changelog post 1.6.0 [#7630](https://github.com/habitat-sh/habitat/pull/7630) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.1 -->

## Chef Habitat 1.6.0

[Full Changelog](https://github.com/habitat-sh/habitat/compare/1.5.86...1.6.0)

### New features and enhancements

- Source studio_profile.ps1 in studio enter if present [#7618](https://github.com/habitat-sh/habitat/pull/7618) ([mwrock](https://github.com/mwrock)) <!-- 1.5.99 -->
- Layered images from `hab pkg export docker` [#7596](https://github.com/habitat-sh/habitat/pull/7596) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.98 -->

### Bug fixes

- Prevent infinite loop on Windows after losing connection to Automate [#7616](https://github.com/habitat-sh/habitat/pull/7616) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.95 -->

### Merged pull requests

- Bump version to 1.6.0 [#7629](https://github.com/habitat-sh/habitat/pull/7629) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.6.0 -->
- fix profile e2e tests [#7625](https://github.com/habitat-sh/habitat/pull/7625) ([mwrock](https://github.com/mwrock)) <!-- 1.5.100 -->
- sync stable acceptance packages with prod after release [#7617](https://github.com/habitat-sh/habitat/pull/7617) ([mwrock](https://github.com/mwrock)) <!-- 1.5.97 -->
- append existing path to package path in hab pkg exec [#7615](https://github.com/habitat-sh/habitat/pull/7615) ([mwrock](https://github.com/mwrock)) <!-- 1.5.96 -->
- dont need to put gh release link in forum post [#7614](https://github.com/habitat-sh/habitat/pull/7614) ([mwrock](https://github.com/mwrock)) <!-- 1.5.94 -->
- cleanup adding interpreter paths and make it configurable [#7601](https://github.com/habitat-sh/habitat/pull/7601) ([mwrock](https://github.com/mwrock)) <!-- 1.5.93 -->
- Cargo Update [#7609](https://github.com/habitat-sh/habitat/pull/7609) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.5.92 -->
- Prepare e2e tests for powershell 7.0 [#7588](https://github.com/habitat-sh/habitat/pull/7588) ([mwrock](https://github.com/mwrock)) <!-- 1.5.91 -->
- update changelog for 1.5.86 [#7610](https://github.com/habitat-sh/habitat/pull/7610) ([mwrock](https://github.com/mwrock)) <!-- 1.5.90 -->

## Chef Habitat 1.5.86

[Full Changelog](https://github.com/habitat-sh/habitat/compare/1.5.71...1.5.86)

### New features and enhancements

- Add `--keep-latest` to `hab pkg uninstall` [#7595](https://github.com/habitat-sh/habitat/pull/7595) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.5.84 -->
- Automatic package cleanup with the `--keep-latest-packages` flag [#7582](https://github.com/habitat-sh/habitat/pull/7582) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.5.80 -->

### Merged pull requests

- [Docs] Emphasize the necessity of TCP for Supervisor function [#7611](https://github.com/habitat-sh/habitat/pull/7611) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.89 -->
- Rustfmt and Nightly Rust Bump to nightly-2020-04-08 [#7608](https://github.com/habitat-sh/habitat/pull/7608) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.5.88 -->
- Automated update of Habitat Documentation [#7607](https://github.com/habitat-sh/habitat/pull/7607) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.5.87 -->
- extend windows launcher build timeout to 45 minutes [#7606](https://github.com/habitat-sh/habitat/pull/7606) ([mwrock](https://github.com/mwrock)) <!-- 1.5.86 -->
- tag windows 2019 studio image with latest [#7605](https://github.com/habitat-sh/habitat/pull/7605) ([mwrock](https://github.com/mwrock)) <!-- 1.5.85 -->
- fix 2016 studio image [#7603](https://github.com/habitat-sh/habitat/pull/7603) ([mwrock](https://github.com/mwrock)) <!-- 1.5.83 -->
- Fixes truncated CLI spaces [#7589](https://github.com/habitat-sh/habitat/pull/7589) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.5.82 -->
- fix UDP port remaining open after supervisor terminates when a hook is still executing [#7597](https://github.com/habitat-sh/habitat/pull/7597) ([mwrock](https://github.com/mwrock)) <!-- 1.5.81 -->
- Add Homebrew PR merge to post-release activities [#7587](https://github.com/habitat-sh/habitat/pull/7587) ([smacfarlane](https://github.com/smacfarlane)) <!-- 1.5.79 -->
- fix Linux test_pkg_install e2e test [#7586](https://github.com/habitat-sh/habitat/pull/7586) ([mwrock](https://github.com/mwrock)) <!-- 1.5.78 -->
- Error if using `-d` when entering Windows studio [#7585](https://github.com/habitat-sh/habitat/pull/7585) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.5.77 -->
- Move builder-worker post release step higher in the release readme [#7577](https://github.com/habitat-sh/habitat/pull/7577) ([mwrock](https://github.com/mwrock)) <!-- 1.5.76 -->
- Update changelog post 1.5.71 [#7566](https://github.com/habitat-sh/habitat/pull/7566) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.5.75 -->

## Chef Habitat 1.5.71

[Full Changelog](https://github.com/habitat-sh/habitat/compare/1.5.50...1.5.71)

### Bug fixes

- Make better use of `Instant::elapsed()` for safer timing operations [#7533](https://github.com/habitat-sh/habitat/pull/7533) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.58 -->

### New features and enhancements

- Add service `--update-condition` enabling service rollback [#7513](https://github.com/habitat-sh/habitat/pull/7513) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.5.56 -->

### Behavioral changes

- When follower services restart during a rolling update all packages newer than the package the leader updated to are automatically uninstalled. This ensures that the leader and followers are running the same package. [#7556](https://github.com/habitat-sh/habitat/pull/7556) ([davidMcneil](https://github.com/davidMcneil))

### Merged pull requests

- Correct some e2e behavior [#7564](https://github.com/habitat-sh/habitat/pull/7564) ([smacfarlane](https://github.com/smacfarlane)) <!-- 1.5.74 -->
- Use unique container name to bats unit tests [#7567](https://github.com/habitat-sh/habitat/pull/7567) ([smacfarlane](https://github.com/smacfarlane)) <!-- 1.5.74 -->
- Add testing steps for core-plans refresh [#7565](https://github.com/habitat-sh/habitat/pull/7565) ([smacfarlane](https://github.com/smacfarlane)) <!-- 1.5.73 -->
- Update links to docs.chef.io [#7559](https://github.com/habitat-sh/habitat/pull/7559) ([IanMadd](https://github.com/IanMadd)) <!-- 1.5.72 -->
- Update CODEOWNERS [#7562](https://github.com/habitat-sh/habitat/pull/7562) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.5.71 -->
- Update changelog with new rolling update logic [#7561](https://github.com/habitat-sh/habitat/pull/7561) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.5.70 -->
- Fix rolling update when using track-channel update condition [#7556](https://github.com/habitat-sh/habitat/pull/7556) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.5.69 -->
- only stop the studio container at the end of the docker studio supervisor test [#7560](https://github.com/habitat-sh/habitat/pull/7560) ([mwrock](https://github.com/mwrock)) <!-- 1.5.68 -->
- fix failing test where windows and Linux expect different error codes [#7557](https://github.com/habitat-sh/habitat/pull/7557) ([mwrock](https://github.com/mwrock)) <!-- 1.5.67 -->
- fix powershell builds when giving a path not ending in a slash [#7553](https://github.com/habitat-sh/habitat/pull/7553) ([mwrock](https://github.com/mwrock)) <!-- 1.5.66 -->
- Habitat API docs [#6729](https://github.com/habitat-sh/habitat/pull/6729) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.5.65 -->
- allow plan context to be rooted in target folder [#7548](https://github.com/habitat-sh/habitat/pull/7548) ([mwrock](https://github.com/mwrock)) <!-- 1.5.64 -->
- Remove one-off release tool [#7546](https://github.com/habitat-sh/habitat/pull/7546) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.5.63 -->
- Fix at-once update test [#7543](https://github.com/habitat-sh/habitat/pull/7543) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.5.62 -->
- Fix pwsh binlink dir for e2e tests [#7542](https://github.com/habitat-sh/habitat/pull/7542) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.5.61 -->
- http-client: use env_proxy from git [#7532](https://github.com/habitat-sh/habitat/pull/7532) ([stevendanna](https://github.com/stevendanna)) <!-- 1.5.60 -->
- Miscellaneous Butterfly timing refactorings [#7540](https://github.com/habitat-sh/habitat/pull/7540) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.59 -->
- [CI] Silently continue on errors to remove the Habitat cache [#7539](https://github.com/habitat-sh/habitat/pull/7539) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.57 -->
- Always write out service PID files [#7526](https://github.com/habitat-sh/habitat/pull/7526) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.55 -->
- Update changelog post 1.5.50 [#7521](https://github.com/habitat-sh/habitat/pull/7521) ([smacfarlane](https://github.com/smacfarlane)) <!-- 1.5.54 -->
- Cargo Update [#7519](https://github.com/habitat-sh/habitat/pull/7519) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.5.53 -->
- Rustfmt and Nightly Rust Bump to nightly-2020-03-03 [#7518](https://github.com/habitat-sh/habitat/pull/7518) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.5.52 -->
- Automated update of Habitat Documentation [#7517](https://github.com/habitat-sh/habitat/pull/7517) ([chef-expeditor[bot]](https://github.com/chef-expeditor[bot])) <!-- 1.5.51 -->

## Chef Habitat 1.5.50

[Full Changelog](https://github.com/habitat-sh/habitat/compare/1.5.29...1.5.50)

### Bug fixes

- Allow dev environment setup script to work locally or in Vagrant [#7500](https://github.com/habitat-sh/habitat/pull/7500) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.38 -->

### New features and enhancements

- adds hab origin info subcommand [#7445](https://github.com/habitat-sh/habitat/pull/7445) ([jeremymv2](https://github.com/jeremymv2)) <!-- 1.5.33 -->
- Add flag to ignore missing packages in seed lists [#7512](https://github.com/habitat-sh/habitat/pull/7512) ([smacfarlane](https://github.com/smacfarlane)) <!-- 1.5.50 -->
- Get-HabPackagePath accepts any valid ident like pkg_path_for [#7505](https://github.com/habitat-sh/habitat/pull/7505) ([mwrock](https://github.com/mwrock)) <!-- 1.5.42 -->
- add NO_NAMED_PIPE_HEALTH_CHECK feature flag to suppress named pipe on windows [#7474](https://github.com/habitat-sh/habitat/pull/7474) ([mwrock](https://github.com/mwrock)) <!-- 1.5.39 -->
- provide guidance on 409 conflict [#7473](https://github.com/habitat-sh/habitat/pull/7473) ([jeremymv2](https://github.com/jeremymv2)) <!-- 1.5.33 -->
- windows-service improvements [#7422](https://github.com/habitat-sh/habitat/pull/7422) ([mwrock](https://github.com/mwrock)) <!-- 1.5.30 -->

### Behavioral changes

- Remove ACI exporter [#7462](https://github.com/habitat-sh/habitat/pull/7462) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.33 -->
- Remove Kubernetes and Helm exporters [#7463](https://github.com/habitat-sh/habitat/pull/7463) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.33 -->
- modification to hab setup defaults and language [#7480](https://github.com/habitat-sh/habitat/pull/7480) ([jeremymv2](https://github.com/jeremymv2)) <!-- 1.5.34 -->

### Merged pull requests

- Add flag to ignore missing packages in seed lists [#7512](https://github.com/habitat-sh/habitat/pull/7512) ([smacfarlane](https://github.com/smacfarlane)) <!-- 1.5.50 -->
- ensure that studio image builder runs the windows-service install hook [#7516](https://github.com/habitat-sh/habitat/pull/7516) ([mwrock](https://github.com/mwrock)) <!-- 1.5.49 -->
- [CI] Add HAB_AUTH_TOKEN to at-once update test [#7511](https://github.com/habitat-sh/habitat/pull/7511) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.48 -->
- Remove time crate from almost everything [#7499](https://github.com/habitat-sh/habitat/pull/7499) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.47 -->
- Make FullyQualifiedPackageIdent public and use it in Pkg [#7507](https://github.com/habitat-sh/habitat/pull/7507) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.5.46 -->
- [CI] Swap command and if blocks for Windows 2016 container step [#7509](https://github.com/habitat-sh/habitat/pull/7509) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.45 -->
- Better test for comparing structopt to clap_app [#7503](https://github.com/habitat-sh/habitat/pull/7503) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.5.44 -->
- Simplify our protobuf generation logic [#7506](https://github.com/habitat-sh/habitat/pull/7506) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.43 -->
- Bump nokogiri from 1.10.4 to 1.10.8 in /www [#7502](https://github.com/habitat-sh/habitat/pull/7502) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 1.5.41 -->
- sup: set PID file mode to 0644  [#7489](https://github.com/habitat-sh/habitat/pull/7489) ([stevendanna](https://github.com/stevendanna)) <!-- 1.5.40 -->
- Refactor service updater [#7455](https://github.com/habitat-sh/habitat/pull/7455) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.5.36 -->
- [CI] Restrict certain release pipeline steps to "real" runs only [#7491](https://github.com/habitat-sh/habitat/pull/7491) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.35 -->
- make the ltsc2019 docker image the default for studio and exporter ifa hyper-v host supports it [#7488](https://github.com/habitat-sh/habitat/pull/7488) ([mwrock](https://github.com/mwrock)) <!-- 1.5.34 -->
- Use stable mac-bootstrapper repo with latest package [#7490](https://github.com/habitat-sh/habitat/pull/7490) ([jaymalasinha](https://github.com/jaymalasinha)) <!-- 1.5.34 -->
- Remove mention of ACI exporter in CLI help [#7485](https://github.com/habitat-sh/habitat/pull/7485) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.33 -->
- Bump nightly and rustfmt versions [#7450](https://github.com/habitat-sh/habitat/pull/7450) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.33 -->
- [CI] Purge caches when promoting from acceptance-&gt;staging [#7451](https://github.com/habitat-sh/habitat/pull/7451) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.33 -->
- add e2e tests for hab sup term [#7441](https://github.com/habitat-sh/habitat/pull/7441) ([mwrock](https://github.com/mwrock)) <!-- 1.5.33 -->
- increase sleep time while waiting for connections to named pipe health check server [#7452](https://github.com/habitat-sh/habitat/pull/7452) ([mwrock](https://github.com/mwrock)) <!-- 1.5.33 -->
- [CI] Skip some Github-related pipeline steps for now [#7461](https://github.com/habitat-sh/habitat/pull/7461) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.33 -->
- Add structopt implmentation of CLI [#7453](https://github.com/habitat-sh/habitat/pull/7453) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.5.33 -->
- [Docs] Fix up missing / erroneous hook documentation [#7466](https://github.com/habitat-sh/habitat/pull/7466) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.33 -->
- [Docs] Add basic `hab pkg download` file docs [#7457](https://github.com/habitat-sh/habitat/pull/7457) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.33 -->
- Add in a check for a "latest" version specification to not set an ide... [#7460](https://github.com/habitat-sh/habitat/pull/7460) ([jschripsema](https://github.com/jschripsema)) <!-- 1.5.33 -->
- Update to Rust 1.41.0 [#7458](https://github.com/habitat-sh/habitat/pull/7458) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.5.33 -->
- [CI, Docs] Update release instructions [#7465](https://github.com/habitat-sh/habitat/pull/7465) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.33 -->
- [CI] Allow CI pipeline to create Github PRs, releases [#7479](https://github.com/habitat-sh/habitat/pull/7479) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.33 -->
- [CI] Automate documentation bump after a release [#7484](https://github.com/habitat-sh/habitat/pull/7484) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.33 -->
- Update docs for 1.5.29 release [#7449](https://github.com/habitat-sh/habitat/pull/7449) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.32 -->
- Update changelog following 1.5.29 release [#7447](https://github.com/habitat-sh/habitat/pull/7447) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.31 -->

## Chef Habitat 1.5.29

[Full Changelog](https://github.com/habitat-sh/habitat/compare/1.5.0...1.5.29)

### New features and enhancements

- Experimental config file support behind `HAB_FEAT_CONFIG_FILE` feature flag [#7360](https://github.com/habitat-sh/habitat/pull/7360) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.5.25 -->
- hab origin invitations subcommand [#7349](https://github.com/habitat-sh/habitat/pull/7349) ([jeremymv2](https://github.com/jeremymv2)) <!-- 1.5.4 -->

### Merged pull requests

- [CI] Retry all Windows E2E test stages one time on failure [#7443](https://github.com/habitat-sh/habitat/pull/7443) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.29 -->
- add missing ArgRequiredElseHelp clap setting [#7440](https://github.com/habitat-sh/habitat/pull/7440) ([jeremymv2](https://github.com/jeremymv2)) <!-- 1.5.28 -->
- close atomic writer temp file before rename [#7431](https://github.com/habitat-sh/habitat/pull/7431) ([mwrock](https://github.com/mwrock)) <!-- 1.5.27 -->
- Use 1.0.8 of mac bootstrapper [#7433](https://github.com/habitat-sh/habitat/pull/7433) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.26 -->
- Enable updater threads to work with tokio::time [#7430](https://github.com/habitat-sh/habitat/pull/7430) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.24 -->
- Habitat Pattern Library [#7344](https://github.com/habitat-sh/habitat/pull/7344) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.5.23 -->
- Change split to second set so it pulls pkg name [#7425](https://github.com/habitat-sh/habitat/pull/7425) ([TheLunaticScripter](https://github.com/TheLunaticScripter)) <!-- 1.5.22 -->
- Add LCR Button [#7419](https://github.com/habitat-sh/habitat/pull/7419) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.5.21 -->
- terminate launcher on hab sup term on windows [#7418](https://github.com/habitat-sh/habitat/pull/7418) ([mwrock](https://github.com/mwrock)) <!-- 1.5.20 -->
- Convert all reqwest usage to async [#7409](https://github.com/habitat-sh/habitat/pull/7409) ([davidMcneil](https://github.com/davidMcneil)) <!-- 1.5.19 -->
- add Invoke-AfterSuccess and Invoke-AfterFailure callbacks for powershell plans [#7413](https://github.com/habitat-sh/habitat/pull/7413) ([mwrock](https://github.com/mwrock)) <!-- 1.5.18 -->
- Correct Middleman file structure [#7406](https://github.com/habitat-sh/habitat/pull/7406) ([kagarmoe](https://github.com/kagarmoe)) <!-- 1.5.17 -->
- Allow ad-hoc deployments of acceptance environment website changes [#7410](https://github.com/habitat-sh/habitat/pull/7410) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.16 -->
- Update docs for 1.5.0 [#7396](https://github.com/habitat-sh/habitat/pull/7396) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.15 -->
- Use packages.chef.io for installation of all versions [#7387](https://github.com/habitat-sh/habitat/pull/7387) ([smacfarlane](https://github.com/smacfarlane)) <!-- 1.5.14 -->
- Run cargo-update as part of post-release activities [#7394](https://github.com/habitat-sh/habitat/pull/7394) ([smacfarlane](https://github.com/smacfarlane)) <!-- 1.5.13 -->
- Remove a debug log message from the service updater [#7404](https://github.com/habitat-sh/habitat/pull/7404) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.12 -->
- Adds client command for departing from an origin [#7401](https://github.com/habitat-sh/habitat/pull/7401) ([eeyun](https://github.com/eeyun)) <!-- 1.5.11 -->
- start windows service on install if it was running when the hook was invoked [#7399](https://github.com/habitat-sh/habitat/pull/7399) ([mwrock](https://github.com/mwrock)) <!-- 1.5.10 -->
- Update Changelog for 1.5.0 release [#7395](https://github.com/habitat-sh/habitat/pull/7395) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.9 -->
- "Bump nightly toolchain to nightly-2020-01-29" [#7393](https://github.com/habitat-sh/habitat/pull/7393) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.9 -->
- [CI] Update Github Release automation [#7391](https://github.com/habitat-sh/habitat/pull/7391) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.8 -->
- add end to end tests to cover release validation [#7398](https://github.com/habitat-sh/habitat/pull/7398) ([mwrock](https://github.com/mwrock)) <!-- 1.5.7 -->
- Assorted service updater tweaks [#7390](https://github.com/habitat-sh/habitat/pull/7390) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.6 -->
- Add token and warning to rdeps usage [#7368](https://github.com/habitat-sh/habitat/pull/7368) ([chefsalim](https://github.com/chefsalim)) <!-- 1.5.5 -->
- Update manual validation docs [#7365](https://github.com/habitat-sh/habitat/pull/7365) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.3 -->
- Stop committing the results of a promotion command [#7366](https://github.com/habitat-sh/habitat/pull/7366) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.2 -->
- Lint powershell with PSScriptAnalyzer [#7337](https://github.com/habitat-sh/habitat/pull/7337) ([mwrock](https://github.com/mwrock)) <!-- 1.5.1 -->

## Chef Habitat 1.5.0

[Full Changelog](https://github.com/habitat-sh/habitat/compare/0.90.6...1.5.0)

### Behavioral changes

- Remove the `HAB_FEAT_EVENT_STREAM` feature flag. The event stream is now enabled with `--event-stream-url`. [#7335](https://github.com/habitat-sh/habitat/pull/7335) ([davidMcneil](https://github.com/davidMcneil))
- Deprecate and ignore the `--application` and `--environment` flags from `hab svc load` and `hab sup run` commands. [#7335](https://github.com/habitat-sh/habitat/pull/7335) ([davidMcneil](https://github.com/davidMcneil))
- The initial event stream connection attempt no longer blocks by default. Set --event-stream-connect-timeout if blocking is desired. [#7293](https://github.com/habitat-sh/habitat/pull/7293) ([davidMcneil](https://github.com/davidMcneil))

### New features and enhancements

- origin ownership transfer subcommand [#7331](https://github.com/habitat-sh/habitat/pull/7331) ([jeremymv2](https://github.com/jeremymv2)) <!-- 0.90.69 -->
- Event stream connection backoff strategy [#7293](https://github.com/habitat-sh/habitat/pull/7293) ([davidMcneil](https://github.com/davidMcneil))
- bulkupload: discover origins from signing keys [#7279](https://github.com/habitat-sh/habitat/pull/7279) ([jeremymv2](https://github.com/jeremymv2)) <!-- 0.90.48 -->
- Add PIDS_FROM_LAUNCHER feature to eliminate service PID files [#7214](https://github.com/habitat-sh/habitat/pull/7214) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.22 -->

### Bug fixes

- Ensure that signal handlers are installed first [#7356](https://github.com/habitat-sh/habitat/pull/7356) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.78 -->
- Fix rolling updates after the death of group members [#7167](https://github.com/habitat-sh/habitat/pull/7167) ([mwrock](https://github.com/mwrock)) <!-- 0.90.65 -->
- The initial event stream connect attempt won't block the main thread when --event-stream-connect-timeout=0 [#7293](https://github.com/habitat-sh/habitat/pull/7293) ([davidMcneil](https://github.com/davidMcneil))
- Event stream messages are always immediately processed (even when disconnected). This prevents a "thundering herd" of messages on reconnect. [#7293](https://github.com/habitat-sh/habitat/pull/7293) ([davidMcneil](https://github.com/davidMcneil))
- don't attempt to set binlink path if not in an elevated console [#7319](https://github.com/habitat-sh/habitat/pull/7319) ([mwrock](https://github.com/mwrock)) <!-- 0.90.58 -->
- Fix lock when spawning windows processes [#7213](https://github.com/habitat-sh/habitat/pull/7213) ([davidMcneil](https://github.com/davidMcneil)) <!-- 0.90.19 -->

### Merged pull requests

- Bump version to 1.5.0 [#7359](https://github.com/habitat-sh/habitat/pull/7359) ([christophermaier](https://github.com/christophermaier)) <!-- 1.5.0 -->
- Update to Windows Server 2012 [#7342](https://github.com/habitat-sh/habitat/pull/7342) ([kagarmoe](https://github.com/kagarmoe)) <!-- 0.90.79 -->
- hab: only print header once in hab svc status [#7358](https://github.com/habitat-sh/habitat/pull/7358) ([stevendanna](https://github.com/stevendanna)) <!-- 0.90.77 -->
- Fix a few more e2e tests [#7355](https://github.com/habitat-sh/habitat/pull/7355) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.76 -->
- Update dependencies [#7354](https://github.com/habitat-sh/habitat/pull/7354) ([davidMcneil](https://github.com/davidMcneil)) <!-- 0.90.75 -->
- Fix a few end-to-end test failures [#7346](https://github.com/habitat-sh/habitat/pull/7346) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.74 -->
- Fix broken studio e2e tests [#7343](https://github.com/habitat-sh/habitat/pull/7343) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.90.73 -->
- Remove the event stream feature flag [#7335](https://github.com/habitat-sh/habitat/pull/7335) ([davidMcneil](https://github.com/davidMcneil)) <!-- 0.90.72 -->
- Remove PIDS_FROM_LAUNCHER feature flag [#7341](https://github.com/habitat-sh/habitat/pull/7341) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.71 -->
- Add a "test-probe" service [#7283](https://github.com/habitat-sh/habitat/pull/7283) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.70 -->
- Update to 1.40.0 [#7325](https://github.com/habitat-sh/habitat/pull/7325) ([davidMcneil](https://github.com/davidMcneil)) <!-- 0.90.68 -->
- Adds issue template for features that redirects to aha [#7062](https://github.com/habitat-sh/habitat/pull/7062) ([eeyun](https://github.com/eeyun)) <!-- 0.90.67 -->
- Bump excon from 0.66.0 to 0.71.1 in /www [#7334](https://github.com/habitat-sh/habitat/pull/7334) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 0.90.66 -->
- Fix setting SSL_CERT_FILE in studio when the cert isn&#39;t cached [#7259](https://github.com/habitat-sh/habitat/pull/7259) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.90.65 -->
- Disable brew cleanup for mac builds [#7333](https://github.com/habitat-sh/habitat/pull/7333) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.90.64 -->
- Ignore &#39;release&#39; component of version if downloading from packages.chef.io [#7299](https://github.com/habitat-sh/habitat/pull/7299) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.90.63 -->
- Catch choco pack n publish errors [#7330](https://github.com/habitat-sh/habitat/pull/7330) ([mwrock](https://github.com/mwrock)) <!-- 0.90.62 -->
- Update event stream to use rants client library [#7293](https://github.com/habitat-sh/habitat/pull/7293) ([davidMcneil](https://github.com/davidMcneil)) <!-- 0.90.61 -->
- Deploy the web site with expeditor [#7273](https://github.com/habitat-sh/habitat/pull/7273) ([raskchanky](https://github.com/raskchanky)) <!-- 0.90.60 -->
- ensure dep variables are properly scoped for scaffolding access [#7329](https://github.com/habitat-sh/habitat/pull/7329) ([mwrock](https://github.com/mwrock)) <!-- 0.90.59 -->
- Update futures ecosystem [#7256](https://github.com/habitat-sh/habitat/pull/7256) ([davidMcneil](https://github.com/davidMcneil)) <!-- 0.90.58 -->
- command with extension takes precedence over extensionless [#7322](https://github.com/habitat-sh/habitat/pull/7322) ([mwrock](https://github.com/mwrock)) <!-- 0.90.58 -->
- fix erroneous client output when API response is HTTP 200 [#7321](https://github.com/habitat-sh/habitat/pull/7321) ([jeremymv2](https://github.com/jeremymv2)) <!-- 0.90.58 -->
- fixes #6992 building windows plans with pkg_version function and environment setup [#7318](https://github.com/habitat-sh/habitat/pull/7318) ([mwrock](https://github.com/mwrock)) <!-- 0.90.58 -->
- Migrates e2e bash tests to powershell [#7310](https://github.com/habitat-sh/habitat/pull/7310) ([mwrock](https://github.com/mwrock)) <!-- 0.90.58 -->
- fix broken find_command unit test [#7323](https://github.com/habitat-sh/habitat/pull/7323) ([mwrock](https://github.com/mwrock)) <!-- 0.90.58 -->
- Add some additional logging around update elections [#7288](https://github.com/habitat-sh/habitat/pull/7288) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.58 -->
- Remove @raskchanky as code owner [#7326](https://github.com/habitat-sh/habitat/pull/7326) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.58 -->
- emit helpful and actionable output when keys/origins aren't found creating a studio [#7320](https://github.com/habitat-sh/habitat/pull/7320) ([mwrock](https://github.com/mwrock)) <!-- 0.90.57 -->
- force msvc toolchain on windows to fix clippy [#7316](https://github.com/habitat-sh/habitat/pull/7316) ([mwrock](https://github.com/mwrock)) <!-- 0.90.56 -->
- Revert "Updated Foundation &amp; JQuery" [#7315](https://github.com/habitat-sh/habitat/pull/7315) ([mwrock](https://github.com/mwrock)) <!-- 0.90.55 -->
- Updated Foundation &amp; JQuery [#7302](https://github.com/habitat-sh/habitat/pull/7302) ([kagarmoe](https://github.com/kagarmoe)) <!-- 0.90.54 -->
- Bump rack from 2.0.7 to 2.0.8 in /www [#7300](https://github.com/habitat-sh/habitat/pull/7300) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 0.90.53 -->
- Add health check interval to event stream [#7266](https://github.com/habitat-sh/habitat/pull/7266) ([nellshamrell](https://github.com/nellshamrell)) <!-- 0.90.52 -->
- Remove TOCs [#7292](https://github.com/habitat-sh/habitat/pull/7292) ([kagarmoe](https://github.com/kagarmoe)) <!-- 0.90.51 -->
- TWO: Makes docs subdirs and moves pages [#7284](https://github.com/habitat-sh/habitat/pull/7284) ([kagarmoe](https://github.com/kagarmoe)) <!-- 0.90.50 -->
- ONE: Normalize markdown [#7289](https://github.com/habitat-sh/habitat/pull/7289) ([kagarmoe](https://github.com/kagarmoe)) <!-- 0.90.49 -->
- Update release documentation [#7263](https://github.com/habitat-sh/habitat/pull/7263) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.47 -->
- Unpin reqwest [#7277](https://github.com/habitat-sh/habitat/pull/7277) ([chefsalim](https://github.com/chefsalim)) <!-- 0.90.46 -->
- mirror RUSTFMT_VERSION in RUST_NIGHTLY_VERSION [#7274](https://github.com/habitat-sh/habitat/pull/7274) ([jeremymv2](https://github.com/jeremymv2)) <!-- 0.90.45 -->
- Retry installation of rustup in CI for Windows [#7262](https://github.com/habitat-sh/habitat/pull/7262) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.90.44 -->
- auto bump rustfmt version post release [#7258](https://github.com/habitat-sh/habitat/pull/7258) ([jeremymv2](https://github.com/jeremymv2)) <!-- 0.90.43 -->
- [web] Update links to point to packages.chef.io instead of Bintray [#7255](https://github.com/habitat-sh/habitat/pull/7255) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.42 -->
- [chore] Remove some old TravisCI cruft [#7257](https://github.com/habitat-sh/habitat/pull/7257) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.41 -->
- some minor windows service improvements [#7251](https://github.com/habitat-sh/habitat/pull/7251) ([mwrock](https://github.com/mwrock)) <!-- 0.90.40 -->
- avoid ctl_gateway panic on peer_addr().expect() [#7244](https://github.com/habitat-sh/habitat/pull/7244) ([jeremymv2](https://github.com/jeremymv2)) <!-- 0.90.39 -->
- [CI] Clean up some Expeditor cruft [#7249](https://github.com/habitat-sh/habitat/pull/7249) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.38 -->
- [Chore] Update CODEOWNERS for new CI infrastructure [#7250](https://github.com/habitat-sh/habitat/pull/7250) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.38 -->
- Remove me from codeowners :( [#7248](https://github.com/habitat-sh/habitat/pull/7248) ([scotthain](https://github.com/scotthain)) <!-- 0.90.37 -->
- Use well known SIDs when looking up administrator and system accounts [#7224](https://github.com/habitat-sh/habitat/pull/7224) ([davidMcneil](https://github.com/davidMcneil)) <!-- 0.90.36 -->
- [Chore] Clean up libbuild.rs [#7238](https://github.com/habitat-sh/habitat/pull/7238) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.35 -->
- Use current commit to determine launcher version for Windows [#7235](https://github.com/habitat-sh/habitat/pull/7235) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.90.35 -->
- Use current commit to determine launcher version [#7234](https://github.com/habitat-sh/habitat/pull/7234) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.90.34 -->
- [CI] Fix failing macOS build [#7233](https://github.com/habitat-sh/habitat/pull/7233) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.33 -->
- Bye Travis [#7232](https://github.com/habitat-sh/habitat/pull/7232) ([raskchanky](https://github.com/raskchanky)) <!-- 0.90.32 -->
- Implement toml based file format [#7176](https://github.com/habitat-sh/habitat/pull/7176) ([markan](https://github.com/markan)) <!-- 0.90.31 -->
- restores Swiftype [#7075](https://github.com/habitat-sh/habitat/pull/7075) ([kagarmoe](https://github.com/kagarmoe)) <!-- 0.90.30 -->
- H2 anchors stay in view [#7212](https://github.com/habitat-sh/habitat/pull/7212) ([kagarmoe](https://github.com/kagarmoe)) <!-- 0.90.30 -->
- Fixes formatting for hooks section [#7222](https://github.com/habitat-sh/habitat/pull/7222) ([kagarmoe](https://github.com/kagarmoe)) <!-- 0.90.29 -->
- [CI] Fix PIDS_FROM_LAUNCHER e2e tests [#7220](https://github.com/habitat-sh/habitat/pull/7220) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.28 -->
- Smaller  margins on code element [#7223](https://github.com/habitat-sh/habitat/pull/7223) ([kagarmoe](https://github.com/kagarmoe)) <!-- 0.90.27 -->
- Adds docs people to www [#7218](https://github.com/habitat-sh/habitat/pull/7218) ([kagarmoe](https://github.com/kagarmoe)) <!-- 0.90.26 -->
- Kg/frontmatter [#7171](https://github.com/habitat-sh/habitat/pull/7171) ([kagarmoe](https://github.com/kagarmoe)) <!-- 0.90.25 -->
- Fix e2e_local scripts [#7221](https://github.com/habitat-sh/habitat/pull/7221) ([davidMcneil](https://github.com/davidMcneil)) <!-- 0.90.24 -->
- Update the README for www deploys [#7216](https://github.com/habitat-sh/habitat/pull/7216) ([raskchanky](https://github.com/raskchanky)) <!-- 0.90.23 -->
- Add some automated networked tests [#6983](https://github.com/habitat-sh/habitat/pull/6983) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.21 -->
- Make `run_e2e_test.ps1` and `shared.ps1` script work on powershell core [#7148](https://github.com/habitat-sh/habitat/pull/7148) ([davidMcneil](https://github.com/davidMcneil)) <!-- 0.90.20 -->
- [CI] Don&#39;t install `core/rust` in Windows test steps [#7210](https://github.com/habitat-sh/habitat/pull/7210) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.18 -->
- Update CLI docs for 0.90.6 [#7206](https://github.com/habitat-sh/habitat/pull/7206) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.18 -->
- Update rustfmt to nightly-2019-11-14 [#7208](https://github.com/habitat-sh/habitat/pull/7208) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.18 -->
- Update Rust nightly version to 2019-11-15 [#7207](https://github.com/habitat-sh/habitat/pull/7207) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.18 -->
- remove acceptance env references for bulkupload test [#7203](https://github.com/habitat-sh/habitat/pull/7203) ([jeremymv2](https://github.com/jeremymv2)) <!-- 0.90.17 -->
- [CI] Fix Github release script [#7192](https://github.com/habitat-sh/habitat/pull/7192) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.16 -->
- [CI] Sign files using `gpg --yes` [#7201](https://github.com/habitat-sh/habitat/pull/7201) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.15 -->
- refactor bulkupload end-to-end tests for habitat-testing origin [#7182](https://github.com/habitat-sh/habitat/pull/7182) ([jeremymv2](https://github.com/jeremymv2)) <!-- 0.90.14 -->
- [CI] Update changelog [#7193](https://github.com/habitat-sh/habitat/pull/7193) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.13 -->
- [CI] Remove changelog rollover automation [#7191](https://github.com/habitat-sh/habitat/pull/7191) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.11 -->
- Use HAB_BLDR_URL in hab pkg download [#7187](https://github.com/habitat-sh/habitat/pull/7187) ([davidMcneil](https://github.com/davidMcneil)) <!-- 0.90.10 -->
- Rust 1.39.0 [#7177](https://github.com/habitat-sh/habitat/pull/7177) ([raskchanky](https://github.com/raskchanky)) <!-- 0.90.9 -->
- [CI] Remove `ignore_labels` from Expeditor config [#7188](https://github.com/habitat-sh/habitat/pull/7188) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.8 -->
- Update changelog [#7186](https://github.com/habitat-sh/habitat/pull/7186) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.7 -->
- [CI] Add "staging" area into our promotion scheme for manual testing [#7185](https://github.com/habitat-sh/habitat/pull/7185) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.7 -->
- sup: remove palaver dependency [#7178](https://github.com/habitat-sh/habitat/pull/7178) ([stevendanna](https://github.com/stevendanna)) <!-- 0.90.7 -->
- make: fix fmt target [#7179](https://github.com/habitat-sh/habitat/pull/7179) ([stevendanna](https://github.com/stevendanna)) <!-- 0.90.7 -->
- Fix studio tests [#7174](https://github.com/habitat-sh/habitat/pull/7174) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.90.7 -->

### Behavioral changes

- Update install scripts to pull from packages.chef.io for new releases [#7119](https://github.com/habitat-sh/habitat/pull/7119) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.90.12 -->

## Chef Habitat 0.90.6

[Full Changelog](https://github.com/habitat-sh/habitat/compare/0.88.0...0.90.6)

### New features and enhancements

- Allow event stream server TLS connection to use habitat cache/ssl [#7120](https://github.com/habitat-sh/habitat/pull/7120) ([davidMcneil](https://github.com/davidMcneil)) <!-- 0.89.47 -->
- Make the init hook async [#7111](https://github.com/habitat-sh/habitat/pull/7111) ([davidMcneil](https://github.com/davidMcneil)) <!-- 0.89.40 -->
- Add TLS to event stream [#7092](https://github.com/habitat-sh/habitat/pull/7092) ([davidMcneil](https://github.com/davidMcneil)) <!-- 0.89.36 -->
- core: use synchronous signal handling on unix [#7050](https://github.com/habitat-sh/habitat/pull/7050) ([stevendanna](https://github.com/stevendanna)) <!-- 0.89.13 -->
- hab pkg download file can have comments, whitespace [#7064](https://github.com/habitat-sh/habitat/pull/7064) ([markan](https://github.com/markan)) <!-- 0.89.12 -->

### Bug fixes

- remove IGNORE_SIGNALS feature [#7140](https://github.com/habitat-sh/habitat/pull/7140) ([mwrock](https://github.com/mwrock)) <!-- 0.89.56 -->
- fix version checks in windows tar exporter [#7125](https://github.com/habitat-sh/habitat/pull/7125) ([mwrock](https://github.com/mwrock)) <!-- 0.89.50 -->
- sup: immediately set initialization_state if no init hook exists [#7117](https://github.com/habitat-sh/habitat/pull/7117) ([stevendanna](https://github.com/stevendanna)) <!-- 0.89.46 -->
- Fully qualified package names download irrespective of channel [#7108](https://github.com/habitat-sh/habitat/pull/7108) ([markan](https://github.com/markan)) <!-- 0.89.43 -->
- fix tar exporter on windows [#7116](https://github.com/habitat-sh/habitat/pull/7116) ([mwrock](https://github.com/mwrock)) <!-- 0.89.42 -->
- stop windows service if launcher exits [#7099](https://github.com/habitat-sh/habitat/pull/7099) ([mwrock](https://github.com/mwrock)) <!-- 0.89.35 -->
- Initialize health check gateway state to Unknown [#7087](https://github.com/habitat-sh/habitat/pull/7087) ([stevendanna](https://github.com/stevendanna)) <!-- 0.89.32 -->
- add windows system paths to environment PATH variable if included [#7073](https://github.com/habitat-sh/habitat/pull/7073) ([mwrock](https://github.com/mwrock)) <!-- 0.89.26 -->
- make pkg download fail when zero packages [#7068](https://github.com/habitat-sh/habitat/pull/7068) ([markan](https://github.com/markan)) <!-- 0.89.11 -->
- don't use hab as default user on windows [#7059](https://github.com/habitat-sh/habitat/pull/7059) ([mwrock](https://github.com/mwrock)) <!-- 0.89.9 -->
- Order objects used for template data [#7031](https://github.com/habitat-sh/habitat/pull/7031) ([raskchanky](https://github.com/raskchanky)) <!-- 0.89.8 -->
- fixes using a svc_user on windows [#7049](https://github.com/habitat-sh/habitat/pull/7049) ([mwrock](https://github.com/mwrock)) <!-- 0.89.6 -->

### Merged pull requests

- hab pkg bulkupload origin creation option [#7133](https://github.com/habitat-sh/habitat/pull/7133) ([jeremymv2](https://github.com/jeremymv2)) <!-- 0.90.6 -->
- Trigger finish release pipeline as post_commit action of promotion to current [#7164](https://github.com/habitat-sh/habitat/pull/7164) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.90.5 -->
- Kubernetes docs update, removing references to the Operator and replacing with the Bastion pattern [#7144](https://github.com/habitat-sh/habitat/pull/7144) ([irvingpop](https://github.com/irvingpop)) <!-- 0.90.5 -->
- [CI] Purge Fastly cache on promotion to stable only [#7172](https://github.com/habitat-sh/habitat/pull/7172) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.4 -->
- [CI] Remove old CI pipeline code [#7169](https://github.com/habitat-sh/habitat/pull/7169) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.3 -->
- [CI] Make purge_cdn.sh script executable [#7170](https://github.com/habitat-sh/habitat/pull/7170) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.3 -->
- [CI] Temporarily skip the bulkupload e2e test pending some refactoring [#7168](https://github.com/habitat-sh/habitat/pull/7168) ([christophermaier](https://github.com/christophermaier)) <!-- 0.90.2 -->
- Move changelog update back to staged_workload_released [#7166](https://github.com/habitat-sh/habitat/pull/7166) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.90.1 -->
- [CI] Add Studio Image creation to release pipeline [#7141](https://github.com/habitat-sh/habitat/pull/7141) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.61 -->
- Purge CDN on channel promote [#7134](https://github.com/habitat-sh/habitat/pull/7134) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.89.60 -->
- Migrate choco_push into new finish-release process [#7142](https://github.com/habitat-sh/habitat/pull/7142) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.89.59 -->
- Disable build-on-upload for packages in the release pipeline [#7147](https://github.com/habitat-sh/habitat/pull/7147) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.89.58 -->
- Create  GitHub release in post-release pipeline [#7143](https://github.com/habitat-sh/habitat/pull/7143) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.89.57 -->
- e2e tests for hab pkg bulkupload, wired up into expeditor [#7113](https://github.com/habitat-sh/habitat/pull/7113) ([jeremymv2](https://github.com/jeremymv2)) <!-- 0.89.55 -->
- [CI] Always clean up release channels [#7130](https://github.com/habitat-sh/habitat/pull/7130) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.54 -->
- [CI] Tweak the promotion action [#7129](https://github.com/habitat-sh/habitat/pull/7129) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.53 -->
- [CI] Add some unit testing around some of our CI code [#7124](https://github.com/habitat-sh/habitat/pull/7124) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.52 -->
- set BUILD_PKG_TARGET Env variable to fix failed pkg download tests [#7127](https://github.com/habitat-sh/habitat/pull/7127) ([jeremymv2](https://github.com/jeremymv2)) <!-- 0.89.51 -->
- poll for service startup in windows e2e tests [#7123](https://github.com/habitat-sh/habitat/pull/7123) ([mwrock](https://github.com/mwrock)) <!-- 0.89.49 -->
- [CI] DEV -&gt; dev [#7122](https://github.com/habitat-sh/habitat/pull/7122) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.48 -->
- Sign sha256sum for compatibility with existing bintray releases [#7121](https://github.com/habitat-sh/habitat/pull/7121) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.89.47 -->
- wire up e2e hab pkg download tests into expeditor [#7104](https://github.com/habitat-sh/habitat/pull/7104) ([jeremymv2](https://github.com/jeremymv2)) <!-- 0.89.45 -->
- [CI] Initial Expeditor Promotion trigger [#7115](https://github.com/habitat-sh/habitat/pull/7115) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.44 -->
- Add tests to validate SSL behavior on Windows [#7114](https://github.com/habitat-sh/habitat/pull/7114) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.89.41 -->
- Add additionl e2e tests validating SSL cert functionality [#7038](https://github.com/habitat-sh/habitat/pull/7038) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.89.39 -->
- [CI] Add the correct AWS account to the e2e pipeline [#7110](https://github.com/habitat-sh/habitat/pull/7110) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.38 -->
- don't fail e2e test if unable to start service with bogus args [#7107](https://github.com/habitat-sh/habitat/pull/7107) ([mwrock](https://github.com/mwrock)) <!-- 0.89.37 -->
- [CI] Fix spuriously-failing end-to-end test [#7103](https://github.com/habitat-sh/habitat/pull/7103) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.34 -->
- Noindex/nofollow blog pages [#7074](https://github.com/habitat-sh/habitat/pull/7074) ([kagarmoe](https://github.com/kagarmoe)) <!-- 0.89.33 -->
- [CI] Pull from "dev" channel for e2e tests, not "DEV" [#7100](https://github.com/habitat-sh/habitat/pull/7100) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.31 -->
- [CI] Need to have an auth token to promote in Builder [#7098](https://github.com/habitat-sh/habitat/pull/7098) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.30 -->
- [CI] Import GPG keys for signing S3 uploads [#7096](https://github.com/habitat-sh/habitat/pull/7096) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.29 -->
- [CI] Use full path to create_manifest.rb [#7094](https://github.com/habitat-sh/habitat/pull/7094) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.28 -->
- [CI] Actually use the correct function to get the version [#7093](https://github.com/habitat-sh/habitat/pull/7093) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.27 -->
- [CI] Use proper S3 URIs for uploads [#7091](https://github.com/habitat-sh/habitat/pull/7091) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.25 -->
- Fix compiler warnings [#7088](https://github.com/habitat-sh/habitat/pull/7088) ([davidMcneil](https://github.com/davidMcneil)) <!-- 0.89.24 -->
- [CI] Ensure version file can be properly sourced [#7089](https://github.com/habitat-sh/habitat/pull/7089) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.23 -->
- Add Windows studios e2e tests to verify SSL_CERT_FILE behavior [#7047](https://github.com/habitat-sh/habitat/pull/7047) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.89.22 -->
- Correct a Buildkite emoji I missed earlier [#7083](https://github.com/habitat-sh/habitat/pull/7083) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.21 -->
- [CI Pipeline] Explicitly specify --url argument to hab pkg download [#7082](https://github.com/habitat-sh/habitat/pull/7082) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.20 -->
- Use proper Buildkite emojis in release pipeline [#7080](https://github.com/habitat-sh/habitat/pull/7080) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.19 -->
- Install Buildkite Agent in Windows container again [#7081](https://github.com/habitat-sh/habitat/pull/7081) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.18 -->
- Add HAB_AUTH_TOKEN and BUILDKITE_AGENT_TOKEN back on Windows [#7079](https://github.com/habitat-sh/habitat/pull/7079) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.17 -->
- Move install_rustup to top-level shared Bash library [#7078](https://github.com/habitat-sh/habitat/pull/7078) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.16 -->
- Reorder pipeline stages for maximum parallelism [#7077](https://github.com/habitat-sh/habitat/pull/7077) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.15 -->
- Wire up promotion logic between new CI pipeline stages [#7043](https://github.com/habitat-sh/habitat/pull/7043) ([scotthain](https://github.com/scotthain)) <!-- 0.89.14 -->
- Install Rust using the "minimal" profile [#7072](https://github.com/habitat-sh/habitat/pull/7072) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.11 -->
- Ma/hab 7056/message cleanup [#7069](https://github.com/habitat-sh/habitat/pull/7069) ([markan](https://github.com/markan)) <!-- 0.89.10 -->
- Create initial shape of finish_release pipeline [#7053](https://github.com/habitat-sh/habitat/pull/7053) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.89.7 -->
- Auto assign prs if opened by a Habitat team member [#7052](https://github.com/habitat-sh/habitat/pull/7052) ([smacfarlane](https://github.com/smacfarlane)) <!-- 0.89.5 -->
- fix windows-service pipeline build with powershell interpreter [#7051](https://github.com/habitat-sh/habitat/pull/7051) ([mwrock](https://github.com/mwrock)) <!-- 0.89.4 -->
- Adds version note to foundation.min.js [#7042](https://github.com/habitat-sh/habitat/pull/7042) ([kagarmoe](https://github.com/kagarmoe)) <!-- 0.89.4 -->
- Update nightly rust to 2019-10-15 [#7048](https://github.com/habitat-sh/habitat/pull/7048) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.3 -->
- Build windows-service in new release pipeline [#7029](https://github.com/habitat-sh/habitat/pull/7029) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.3 -->
- Bump cargo dependencies [#7045](https://github.com/habitat-sh/habitat/pull/7045) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.2 -->
- Update rustfmt to 2019-10-15 [#7046](https://github.com/habitat-sh/habitat/pull/7046) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.1 -->
- Prep for 0.90.0 [#7041](https://github.com/habitat-sh/habitat/pull/7041) ([christophermaier](https://github.com/christophermaier)) <!-- 0.89.0 -->

## Chef Habitat 0.88.0

[Full Changelog](https://github.com/habitat-sh/habitat/compare/0.85.0...0.88.0)

### New features and enhancements

- Add some "PID 0" protections [#6990](https://github.com/habitat-sh/habitat/pull/6990) ([christophermaier](https://github.com/christophermaier))
- Allow user to specify `sys.ip` address [#6960](https://github.com/habitat-sh/habitat/pull/6960) ([davidMcneil](https://github.com/davidMcneil))
- Ma/hab 6878/pkg download [#6945](https://github.com/habitat-sh/habitat/pull/6945) ([markan](https://github.com/markan))
- `hab pkg bulkupload` packages from a directory [#6958](https://github.com/habitat-sh/habitat/pull/6958) ([jeremymv2](https://github.com/jeremymv2))
- Add auth option to tar exporter [#6982](https://github.com/habitat-sh/habitat/pull/6982) ([chefsalim](https://github.com/chefsalim))
- windows health checks run from a single powershell instance [#6947](https://github.com/habitat-sh/habitat/pull/6947) ([mwrock](https://github.com/mwrock))
- Add conditional compliation flags for unsupported targets [#6862](https://github.com/habitat-sh/habitat/pull/6862) ([davidMcneil](https://github.com/davidMcneil))

### Bug fixes

- HTTP 200 indicates successful response from `hab bldr channel delete` [#7002](https://github.com/habitat-sh/habitat/pull/7002) ([jeremymv2](https://github.com/jeremymv2))
- pass supervisor pid to named pipe server instead of querying it from server to fix win7 [#6998](https://github.com/habitat-sh/habitat/pull/6998) ([mwrock](https://github.com/mwrock))
- set connection header to close on all ApiClient requests [#6993](https://github.com/habitat-sh/habitat/pull/6993) ([mwrock](https://github.com/mwrock))
- don't inject studio environment with ctl_secret from cli.toml [#6988](https://github.com/habitat-sh/habitat/pull/6988) ([mwrock](https://github.com/mwrock))
- use -file instead of -command when forwarding args to hab-studio.ps1 so that args are passed as individual args and not as a single string [#6985](https://github.com/habitat-sh/habitat/pull/6985) ([mwrock](https://github.com/mwrock))

### Merged pull requests

- add # to correctly comment out redirect stderr in run hook example [#7003](https://github.com/habitat-sh/habitat/pull/7003) ([ericcalabretta](https://github.com/ericcalabretta))
- Remove HAB_STUDIO_SECRET_HAB_LICENSE which shouldn&#39;t be needed any more [#6994](https://github.com/habitat-sh/habitat/pull/6994) ([raskchanky](https://github.com/raskchanky))
- Upgrade to rust 1.38.0 [#6984](https://github.com/habitat-sh/habitat/pull/6984) ([raskchanky](https://github.com/raskchanky))
- Add e2e scripts for powershell [#6952](https://github.com/habitat-sh/habitat/pull/6952) ([smacfarlane](https://github.com/smacfarlane))
- Add e2e tests to validate SSL_CERT_FILE behavior in studio [#6944](https://github.com/habitat-sh/habitat/pull/6944) ([smacfarlane](https://github.com/smacfarlane))
- Migrate to executors and windows 2019 across the board pt 1 [#6999](https://github.com/habitat-sh/habitat/pull/6999) ([scotthain](https://github.com/scotthain))
- Update the fake release process [#6995](https://github.com/habitat-sh/habitat/pull/6995) ([raskchanky](https://github.com/raskchanky))
- Remove baumanj from CODEOWNERS [#6997](https://github.com/habitat-sh/habitat/pull/6997) ([baumanj](https://github.com/baumanj))
- Fix the text around job demotion [#6996](https://github.com/habitat-sh/habitat/pull/6996) ([raskchanky](https://github.com/raskchanky))
- Remove tarball that got inadvertently added [#6989](https://github.com/habitat-sh/habitat/pull/6989) ([christophermaier](https://github.com/christophermaier))
- Remove redundant hook reference partial, update docs [#6979](https://github.com/habitat-sh/habitat/pull/6979) ([christophermaier](https://github.com/christophermaier))
- copy choco build files to temp directory [#6980](https://github.com/habitat-sh/habitat/pull/6980) ([mwrock](https://github.com/mwrock))
- Add script to repackage binaries and push to our S3 bucket [#6908](https://github.com/habitat-sh/habitat/pull/6908) ([scotthain](https://github.com/scotthain))
- Update docs for new cert handling [#6959](https://github.com/habitat-sh/habitat/pull/6959) ([chefsalim](https://github.com/chefsalim))
- Update Rust nightly version [#6975](https://github.com/habitat-sh/habitat/pull/6975) ([christophermaier](https://github.com/christophermaier))
- Update docs for 0.85.0 release [#6971](https://github.com/habitat-sh/habitat/pull/6971) ([christophermaier](https://github.com/christophermaier))
- Fix end-to-end tests [#6948](https://github.com/habitat-sh/habitat/pull/6948) ([christophermaier](https://github.com/christophermaier))
- Update dependencies [#6973](https://github.com/habitat-sh/habitat/pull/6973) ([christophermaier](https://github.com/christophermaier))
- Bump `rustfmt` to 2019-09-18 [#6974](https://github.com/habitat-sh/habitat/pull/6974) ([christophermaier](https://github.com/christophermaier))
- Allow Windows studio tests to soft-fail [#6970](https://github.com/habitat-sh/habitat/pull/6970) ([smacfarlane](https://github.com/smacfarlane))
- Remove automated Homebrew release script [#6969](https://github.com/habitat-sh/habitat/pull/6969) ([christophermaier](https://github.com/christophermaier))
- Audit `habitat_sup::manager::ManagerServices` locking [#6956](https://github.com/habitat-sh/habitat/pull/6956) ([baumanj](https://github.com/baumanj))
- Bump VERSION to 0.87.0-dev [#6968](https://github.com/habitat-sh/habitat/pull/6968) ([smacfarlane](https://github.com/smacfarlane))
- Convert RwLocks in the rumor::heat module to habitat_common::sync::Lock [#6957](https://github.com/habitat-sh/habitat/pull/6957) ([raskchanky](https://github.com/raskchanky))
- Error when sys.ip can't be determined [#6953](https://github.com/habitat-sh/habitat/pull/6953) ([davidMcneil](https://github.com/davidMcneil))
- Cleanup errors [#6949](https://github.com/habitat-sh/habitat/pull/6949) ([davidMcneil](https://github.com/davidMcneil))
- Audit `habitat_sup::manager::Manager` locking [#6940](https://github.com/habitat-sh/habitat/pull/6940) ([baumanj](https://github.com/baumanj))
- Fix the rustfmt instructions and add helper script [#6946](https://github.com/habitat-sh/habitat/pull/6946) ([davidMcneil](https://github.com/davidMcneil))
- Redo the locks inside the butterfly::server module. [#6941](https://github.com/habitat-sh/habitat/pull/6941) ([raskchanky](https://github.com/raskchanky))

## Chef Habitat 0.85.0

[Full Changelog](https://github.com/habitat-sh/habitat/compare/0.83.0...0.85.0)

### Behavioral changes

- Cleanup lifecycle restarts and remove reload hook [#6668](https://github.com/habitat-sh/habitat/pull/6668) ([davidMcneil](https://github.com/davidMcneil))

### Bug fixes

- Fix config gossip [#6910](https://github.com/habitat-sh/habitat/pull/6910) ([davidMcneil](https://github.com/davidMcneil))
- Properly root SetupEnvironment variables with file system paths at run time [#6850](https://github.com/habitat-sh/habitat/pull/6850) ([mwrock](https://github.com/mwrock))
- handle chunked encoding responses that lack content length header [#6891](https://github.com/habitat-sh/habitat/pull/6891) ([mwrock](https://github.com/mwrock))
- Be more explicit about connection refused errors. [#6755](https://github.com/habitat-sh/habitat/pull/6755) ([raskchanky](https://github.com/raskchanky))
- Ensure studio is installed [#6772](https://github.com/habitat-sh/habitat/pull/6772) ([smacfarlane](https://github.com/smacfarlane))

### New features and enhancements

- Add healthcheck results to event stream [#6905](https://github.com/habitat-sh/habitat/pull/6905) ([davidMcneil](https://github.com/davidMcneil))
- Copy SSL_CERT_FILE to studio internal and persist env var [#6909](https://github.com/habitat-sh/habitat/pull/6909) ([smacfarlane](https://github.com/smacfarlane))
- Adds channel-to-channel promotion to bldr subcommand [#6911](https://github.com/habitat-sh/habitat/pull/6911) ([eeyun](https://github.com/eeyun))
- Copy SSL certs into Windows studio [#6844](https://github.com/habitat-sh/habitat/pull/6844) ([chefsalim](https://github.com/chefsalim))
- Add ability to disable job group creation from the cli [#6843](https://github.com/habitat-sh/habitat/pull/6843) ([smacfarlane](https://github.com/smacfarlane))
- Update event stream [#6853](https://github.com/habitat-sh/habitat/pull/6853) ([davidMcneil](https://github.com/davidMcneil))
- Add environment to windows binstubs [#6826](https://github.com/habitat-sh/habitat/pull/6826) ([mwrock](https://github.com/mwrock))
- Assorted health-check tweaks [#6727](https://github.com/habitat-sh/habitat/pull/6727) ([christophermaier](https://github.com/christophermaier))

### Merged pull requests

- Fix typo in &#39;type&#39; parameter for command &#39;hab origin key export&#39; [#6934](https://github.com/habitat-sh/habitat/pull/6934) ([sirajrauff](https://github.com/sirajrauff))
- Add e2e test to ensure studio auto-installs [#6781](https://github.com/habitat-sh/habitat/pull/6781) ([smacfarlane](https://github.com/smacfarlane))
- Remove the trace_it! macro and associated functionality. [#6936](https://github.com/habitat-sh/habitat/pull/6936) ([raskchanky](https://github.com/raskchanky))
- Removes artifactory module from cli [#6931](https://github.com/habitat-sh/habitat/pull/6931) ([eeyun](https://github.com/eeyun))
- Always build the Launcher and Windows Service packages [#6916](https://github.com/habitat-sh/habitat/pull/6916) ([christophermaier](https://github.com/christophermaier))
- Remove unused locks and consolidate test helpers. [#6928](https://github.com/habitat-sh/habitat/pull/6928) ([raskchanky](https://github.com/raskchanky))
- Redo departial PR [#6925](https://github.com/habitat-sh/habitat/pull/6925) ([kagarmoe](https://github.com/kagarmoe))
- Correct Cargo.lock for new zmq branch [#6919](https://github.com/habitat-sh/habitat/pull/6919) ([raskchanky](https://github.com/raskchanky))
- Add one-off release tool [#6885](https://github.com/habitat-sh/habitat/pull/6885) ([davidMcneil](https://github.com/davidMcneil))
- Remove PID file error message [#6915](https://github.com/habitat-sh/habitat/pull/6915) ([davidMcneil](https://github.com/davidMcneil))
- mention earlier there&#39;s a debug option for PS plans [#6912](https://github.com/habitat-sh/habitat/pull/6912) ([robbkidd](https://github.com/robbkidd))
- fixes supervisor connection failure test [#6860](https://github.com/habitat-sh/habitat/pull/6860) ([nellshamrell](https://github.com/nellshamrell))
- fixing permission error in release [#6886](https://github.com/habitat-sh/habitat/pull/6886) ([mwrock](https://github.com/mwrock))
- increase timeout for mac and windows releases [#6888](https://github.com/habitat-sh/habitat/pull/6888) ([mwrock](https://github.com/mwrock))
- extend release timeouts [#6889](https://github.com/habitat-sh/habitat/pull/6889) ([mwrock](https://github.com/mwrock))
- report last error after all failed pkg download attempts [#6890](https://github.com/habitat-sh/habitat/pull/6890) ([mwrock](https://github.com/mwrock))
- Add hab bldr url for env variable [#6898](https://github.com/habitat-sh/habitat/pull/6898) ([scotthain](https://github.com/scotthain))
- Bump nokogiri from 1.10.3 to 1.10.4 in /www [#6877](https://github.com/habitat-sh/habitat/pull/6877) ([dependabot[bot]](https://github.com/dependabot[bot]))
- Begin cleaning up scripts and locations of things [#6846](https://github.com/habitat-sh/habitat/pull/6846) ([scotthain](https://github.com/scotthain))
- Upgrade to rust 1.37.0 [#6861](https://github.com/habitat-sh/habitat/pull/6861) ([raskchanky](https://github.com/raskchanky))
- Fixing up some End-to-End Supervisor Tests [#6780](https://github.com/habitat-sh/habitat/pull/6780) ([christophermaier](https://github.com/christophermaier))
- End to end tests: hab-svc-load and hup-does-not-abandon-services [#6849](https://github.com/habitat-sh/habitat/pull/6849) ([baumanj](https://github.com/baumanj))
- Add support for running e2e tests locally, for rapid iteration [#6855](https://github.com/habitat-sh/habitat/pull/6855) ([christophermaier](https://github.com/christophermaier))
- Add job to run all `#[ignore]`d tests [#6845](https://github.com/habitat-sh/habitat/pull/6845) ([baumanj](https://github.com/baumanj))
- Add mac hab build to release process [#6802](https://github.com/habitat-sh/habitat/pull/6802) ([scotthain](https://github.com/scotthain))
- Fix cargo update scheduled task [#6840](https://github.com/habitat-sh/habitat/pull/6840) ([smacfarlane](https://github.com/smacfarlane))
- publish both 2016 and 2019 studio images in release [#6842](https://github.com/habitat-sh/habitat/pull/6842) ([mwrock](https://github.com/mwrock))
- Remove spec file of failed services [#6794](https://github.com/habitat-sh/habitat/pull/6794) ([davidMcneil](https://github.com/davidMcneil))
- Audit RumorStore locking [#6674](https://github.com/habitat-sh/habitat/pull/6674) ([baumanj](https://github.com/baumanj))
- Update http-client and builder-api-client from hyper to reqwest. [#6759](https://github.com/habitat-sh/habitat/pull/6759) ([chefsalim](https://github.com/chefsalim))
- Always use Linux for cleanup build channel [#6804](https://github.com/habitat-sh/habitat/pull/6804) ([scotthain](https://github.com/scotthain))
- Revert "redux: cross platform binstubs with package environment" [#6796](https://github.com/habitat-sh/habitat/pull/6796) ([smacfarlane](https://github.com/smacfarlane))
- Update rustfmt [#6776](https://github.com/habitat-sh/habitat/pull/6776) ([christophermaier](https://github.com/christophermaier))
- Extract a curlbash_hab function [#6789](https://github.com/habitat-sh/habitat/pull/6789) ([christophermaier](https://github.com/christophermaier))
- Clean up a few extra analytics code paths [#6787](https://github.com/habitat-sh/habitat/pull/6787) ([christophermaier](https://github.com/christophermaier))
- links to central Chef Community CoC [#6785](https://github.com/habitat-sh/habitat/pull/6785) ([nellshamrell](https://github.com/nellshamrell))
- Promote release candidates to builder-acceptance [#6725](https://github.com/habitat-sh/habitat/pull/6725) ([christophermaier](https://github.com/christophermaier))
- Work around 0.83.0 studio not installing bug [#6775](https://github.com/habitat-sh/habitat/pull/6775) ([scotthain](https://github.com/scotthain))
- Update Docs for 0.83.0 [#6768](https://github.com/habitat-sh/habitat/pull/6768) ([christophermaier](https://github.com/christophermaier))
- Convert all our manual whitespace splitting to use split_whitespace() [#6751](https://github.com/habitat-sh/habitat/pull/6751) ([raskchanky](https://github.com/raskchanky))
- Fixing typo public-&gt;secret in origin secret key download [#6753](https://github.com/habitat-sh/habitat/pull/6753) ([sirajrauff](https://github.com/sirajrauff))
- [hab] Allow flexible whitespace in HAB_DOCKER_OPTS [#6749](https://github.com/habitat-sh/habitat/pull/6749) ([stevendanna](https://github.com/stevendanna))
- [hab-plan-build] Normalize file checksums before comparison [#6748](https://github.com/habitat-sh/habitat/pull/6748) ([stevendanna](https://github.com/stevendanna))
- Fix javascript generation in the web site [#6742](https://github.com/habitat-sh/habitat/pull/6742) ([raskchanky](https://github.com/raskchanky))
- Make PID file handling a little more robust. [#6738](https://github.com/habitat-sh/habitat/pull/6738) ([raskchanky](https://github.com/raskchanky))
- Updating reference hooks document... [#6716](https://github.com/habitat-sh/habitat/pull/6716) ([mike10010100](https://github.com/mike10010100))
- Add license acceptance to kernel2 Vagrant file [#6733](https://github.com/habitat-sh/habitat/pull/6733) ([christophermaier](https://github.com/christophermaier))
- Upgrade to Rust 1.36.0 [#6708](https://github.com/habitat-sh/habitat/pull/6708) ([raskchanky](https://github.com/raskchanky))

## Chef Habitat 0.83.0

[Full Changelog](https://github.com/habitat-sh/habitat/compare/0.82.0...0.83.0)

### Behavioral changes

- Add rst-reader back again [#6619](https://github.com/habitat-sh/habitat/pull/6619) ([raskchanky](https://github.com/raskchanky))

### Bug fixes

- Improve liveliness checker [#6714](https://github.com/habitat-sh/habitat/pull/6714) ([baumanj](https://github.com/baumanj))
- Stop health check futures when upgrading the Supervisor [#6717](https://github.com/habitat-sh/habitat/pull/6717) ([christophermaier](https://github.com/christophermaier))
- don't overwrite PSModulePath when setting up build environment [#6697](https://github.com/habitat-sh/habitat/pull/6697) ([mwrock](https://github.com/mwrock))
- provide a better error when no value is passed to Set-BuildtimeEnv or Set-RuntimeEnv [#6684](https://github.com/habitat-sh/habitat/pull/6684) ([mwrock](https://github.com/mwrock))
- Remove recusive memberlist locking [#6662](https://github.com/habitat-sh/habitat/pull/6662) ([baumanj](https://github.com/baumanj))
- allow windows service to set arbitrary environment variables [#6648](https://github.com/habitat-sh/habitat/pull/6648) ([mwrock](https://github.com/mwrock))

### New features and enhancements

- add a invoke-after function for powershell plans [#6685](https://github.com/habitat-sh/habitat/pull/6685) ([mwrock](https://github.com/mwrock))
- allow windows docker studio and exported images to run on kernels later than 2016ltsc [#6643](https://github.com/habitat-sh/habitat/pull/6643) ([mwrock](https://github.com/mwrock))
- Switch to log4rs in the Supervisor [#6622](https://github.com/habitat-sh/habitat/pull/6622) ([christophermaier](https://github.com/christophermaier))
- Store configurable shutdown parameters [#6539](https://github.com/habitat-sh/habitat/pull/6539) ([davidMcneil](https://github.com/davidMcneil))

### Merged pull requests

- Migrate Mac Builds to new pipeline [#6726](https://github.com/habitat-sh/habitat/pull/6726) ([scotthain](https://github.com/scotthain))
- Explicitly use windows 2016 queues [#6720](https://github.com/habitat-sh/habitat/pull/6720) ([scotthain](https://github.com/scotthain))
- Accept habitat license [#6710](https://github.com/habitat-sh/habitat/pull/6710) ([davidMcneil](https://github.com/davidMcneil))
- Refactor DatFile, again [#6703](https://github.com/habitat-sh/habitat/pull/6703) ([raskchanky](https://github.com/raskchanky))
- fail build on docker push failures [#6702](https://github.com/habitat-sh/habitat/pull/6702) ([mwrock](https://github.com/mwrock))
- powershell based install script [#6691](https://github.com/habitat-sh/habitat/pull/6691) ([mwrock](https://github.com/mwrock))
- Add docs for installing the kernel2 CLI [#6692](https://github.com/habitat-sh/habitat/pull/6692) ([raskchanky](https://github.com/raskchanky))
- Fix a crash when starting butterfly with no rumor file [#6690](https://github.com/habitat-sh/habitat/pull/6690) ([raskchanky](https://github.com/raskchanky))
- Make the plans&#39; build use rust-toolchain version [#6680](https://github.com/habitat-sh/habitat/pull/6680) ([baumanj](https://github.com/baumanj))
- resolve build deps before run deps [#6683](https://github.com/habitat-sh/habitat/pull/6683) ([mwrock](https://github.com/mwrock))
- Changed &#39;Habitat&#39; to &#39;Chef Habitat&#39; in documentation &amp; blog. [#6667](https://github.com/habitat-sh/habitat/pull/6667) ([IanMadd](https://github.com/IanMadd))
- Upgrade to actix 1.0 [#6677](https://github.com/habitat-sh/habitat/pull/6677) ([davidMcneil](https://github.com/davidMcneil))
- update widestring crate [#6679](https://github.com/habitat-sh/habitat/pull/6679) ([mwrock](https://github.com/mwrock))
- remove deprecated -w/--windows arg for studio [#6678](https://github.com/habitat-sh/habitat/pull/6678) ([mwrock](https://github.com/mwrock))
- use explicit version of powershell [#6676](https://github.com/habitat-sh/habitat/pull/6676) ([mwrock](https://github.com/mwrock))
- Disable artifactory mirror for choco [#6673](https://github.com/habitat-sh/habitat/pull/6673) ([scotthain](https://github.com/scotthain))
- fix cargo check in windows build script [#6672](https://github.com/habitat-sh/habitat/pull/6672) ([mwrock](https://github.com/mwrock))
- Fix --scaffolding flag [#6666](https://github.com/habitat-sh/habitat/pull/6666) ([davidMcneil](https://github.com/davidMcneil))
- bump travis ruby and build www in a pr [#6663](https://github.com/habitat-sh/habitat/pull/6663) ([mwrock](https://github.com/mwrock))
- Qubitrenegade 6644 [#6655](https://github.com/habitat-sh/habitat/pull/6655) ([baumanj](https://github.com/baumanj))
- Load config variables from cli.toml when entering hab-studio [#6644](https://github.com/habitat-sh/habitat/pull/6644) ([qubitrenegade](https://github.com/qubitrenegade))
- Remove duplication in BuilderAPI create [#6660](https://github.com/habitat-sh/habitat/pull/6660) ([davidMcneil](https://github.com/davidMcneil))
- Fix conflict in search interface [#6659](https://github.com/habitat-sh/habitat/pull/6659) ([chefsalim](https://github.com/chefsalim))
- correct documentation to reflect removal of --windows arg from plan init [#6641](https://github.com/habitat-sh/habitat/pull/6641) ([mwrock](https://github.com/mwrock))
- Replace `busybox mount` with direct read of /proc/mounts [#6608](https://github.com/habitat-sh/habitat/pull/6608) ([smacfarlane](https://github.com/smacfarlane))
- 6345 danielhertenstein [#6656](https://github.com/habitat-sh/habitat/pull/6656) ([baumanj](https://github.com/baumanj))
- Check for missing cache key path when entering dockerized studio [#6345](https://github.com/habitat-sh/habitat/pull/6345) ([danielhertenstein](https://github.com/danielhertenstein))
- Add Artifactory as BuilderAPIProvider [#6653](https://github.com/habitat-sh/habitat/pull/6653) ([chefsalim](https://github.com/chefsalim))
- remove assert for no events in spec watcher tests after adding files to be watched [#6651](https://github.com/habitat-sh/habitat/pull/6651) ([mwrock](https://github.com/mwrock))
- Update README.md for serving docs [#6652](https://github.com/habitat-sh/habitat/pull/6652) ([kagarmoe](https://github.com/kagarmoe))
- spell check [#6654](https://github.com/habitat-sh/habitat/pull/6654) ([kagarmoe](https://github.com/kagarmoe))
- Add limit option to hab pkg search [#6581](https://github.com/habitat-sh/habitat/pull/6581) ([davidMcneil](https://github.com/davidMcneil))
- Make studio backline dependency explicit [#6549](https://github.com/habitat-sh/habitat/pull/6549) ([smacfarlane](https://github.com/smacfarlane))
- Update bldr.toml to reflect changes to the repository [#6595](https://github.com/habitat-sh/habitat/pull/6595) ([smacfarlane](https://github.com/smacfarlane))
- [Studio][Tests] Use absolute drive path for windows studio name [#6645](https://github.com/habitat-sh/habitat/pull/6645) ([smacfarlane](https://github.com/smacfarlane))
- adds rustfmt instructions to supported dev env [#6570](https://github.com/habitat-sh/habitat/pull/6570) ([nellshamrell](https://github.com/nellshamrell))
- updates ruby version [#6631](https://github.com/habitat-sh/habitat/pull/6631) ([nellshamrell](https://github.com/nellshamrell))
- use chocolatey mirror on buildkite [#6638](https://github.com/habitat-sh/habitat/pull/6638) ([mwrock](https://github.com/mwrock))
- Update to Rust 1.35.0 [#6615](https://github.com/habitat-sh/habitat/pull/6615) ([raskchanky](https://github.com/raskchanky))
- Add Builder provider interface [#6626](https://github.com/habitat-sh/habitat/pull/6626) ([chefsalim](https://github.com/chefsalim))
- Swap windows jobs to docker (as much as possible) [#6603](https://github.com/habitat-sh/habitat/pull/6603) ([scotthain](https://github.com/scotthain))
- Adds service update started event [#6611](https://github.com/habitat-sh/habitat/pull/6611) ([gpeers](https://github.com/gpeers))
- Update docs for 0.82.0 [#6627](https://github.com/habitat-sh/habitat/pull/6627) ([smacfarlane](https://github.com/smacfarlane))
- Decouple logging concerns from Supervisor errors [#6590](https://github.com/habitat-sh/habitat/pull/6590) ([christophermaier](https://github.com/christophermaier))
- Generate a unique NATS client id for event msgs [#6623](https://github.com/habitat-sh/habitat/pull/6623) ([afiune](https://github.com/afiune))
- update kubernetes and helm exporter docs to include information about license acceptance [#6573](https://github.com/habitat-sh/habitat/pull/6573) ([nellshamrell](https://github.com/nellshamrell))

## Chef Habitat 0.82.0

[0.82.0](https://github.com/habitat-sh/habitat/tree/0.82.0) (2019-06-06)

[Full Changelog](https://github.com/habitat-sh/habitat/compare/0.81.0...0.82.0)

### Behavioral changes

- Add `--binlink-dir` argument to `hab pkg install` [#6597](https://github.com/habitat-sh/habitat/pull/6597) ([baumanj](https://github.com/baumanj))

### New features and enhancements

- Run health checks asynchronously [#6482](https://github.com/habitat-sh/habitat/pull/6482) ([christophermaier](https://github.com/christophermaier))
- Be more liberal in our license acceptance checking. [#6574](https://github.com/habitat-sh/habitat/pull/6574) ([raskchanky](https://github.com/raskchanky))
- Update error handling for origin deletion [#6467](https://github.com/habitat-sh/habitat/pull/6467) ([chefsalim](https://github.com/chefsalim))

### Bug fixes

- remove trailing space from env vars set in export docker build [#6540](https://github.com/habitat-sh/habitat/pull/6540) ([mwrock](https://github.com/mwrock))

### Merged pull requests

- Use previous release to build Release Candidate [#6601](https://github.com/habitat-sh/habitat/pull/6601) ([smacfarlane](https://github.com/smacfarlane))
- Move deadlock error to trace - stop spam [#6609](https://github.com/habitat-sh/habitat/pull/6609) ([chefsalim](https://github.com/chefsalim))
- Add a tool for simulating a supervisor network [#6596](https://github.com/habitat-sh/habitat/pull/6596) ([raskchanky](https://github.com/raskchanky))
- Two minor fixes for vagrant based bootstrap [#6589](https://github.com/habitat-sh/habitat/pull/6589) ([markan](https://github.com/markan))
- First pass at test framework to validate studio changes [#6528](https://github.com/habitat-sh/habitat/pull/6528) ([smacfarlane](https://github.com/smacfarlane))
- Adding info on accepting license via environment vars [#6526](https://github.com/habitat-sh/habitat/pull/6526) ([tyler-ball](https://github.com/tyler-ball))
- Initial protobufs for events [#6344](https://github.com/habitat-sh/habitat/pull/6344) ([christophermaier](https://github.com/christophermaier))
- Fixing a corrupt Gemfile.lock [#6561](https://github.com/habitat-sh/habitat/pull/6561) ([raskchanky](https://github.com/raskchanky))
- Update tutorials with license acceptance information [#6535](https://github.com/habitat-sh/habitat/pull/6535) ([smacfarlane](https://github.com/smacfarlane))
- Temporarily fix actix version [#6562](https://github.com/habitat-sh/habitat/pull/6562) ([davidMcneil](https://github.com/davidMcneil))
- Document habitat license acceptance [#6552](https://github.com/habitat-sh/habitat/pull/6552) ([raskchanky](https://github.com/raskchanky))
- 0.81.0 Cargo update [#6542](https://github.com/habitat-sh/habitat/pull/6542) ([raskchanky](https://github.com/raskchanky))
- Fix shellcheck ignores [#6554](https://github.com/habitat-sh/habitat/pull/6554) ([davidMcneil](https://github.com/davidMcneil))
- make sure all build prereqs exist on windows, run cargo test against core/rust and use a local studio for builds [#6547](https://github.com/habitat-sh/habitat/pull/6547) ([mwrock](https://github.com/mwrock))
- Update docs for 0.81.0 release [#6548](https://github.com/habitat-sh/habitat/pull/6548) ([raskchanky](https://github.com/raskchanky))
- Update to install for Windows [#6478](https://github.com/habitat-sh/habitat/pull/6478) ([kagarmoe](https://github.com/kagarmoe))
- Streamline plan initialization [#6495](https://github.com/habitat-sh/habitat/pull/6495) ([davidMcneil](https://github.com/davidMcneil))
- Update rustfmt version [#6543](https://github.com/habitat-sh/habitat/pull/6543) ([raskchanky](https://github.com/raskchanky))
- A handful of fixes [#6537](https://github.com/habitat-sh/habitat/pull/6537) ([raskchanky](https://github.com/raskchanky))
- Adjust changelog for 0.81.0 [#6530](https://github.com/habitat-sh/habitat/pull/6530) ([raskchanky](https://github.com/raskchanky))

## Chef Habitat 0.81.0

[0.81.0](https://github.com/habitat-sh/habitat/tree/0.81.0) (2019-05-06)

[Full Changelog](https://github.com/habitat-sh/habitat/compare/0.80.0...0.81.0)

### Bug fixes

- Add habitat_common::sync::Lock type for recursive read locking [#6436](https://github.com/habitat-sh/habitat/pull/6436) ([baumanj](https://github.com/baumanj))
- Add HAB_LICENSE to 2 more spots in our release automation [#6497](https://github.com/habitat-sh/habitat/pull/6497) ([raskchanky](https://github.com/raskchanky))
- Ensure the install script has accepted the license [#6503](https://github.com/habitat-sh/habitat/pull/6503) ([raskchanky](https://github.com/raskchanky))

### Merged pull requests

- Update docs and Makefile for 0.81.0 [#6529](https://github.com/habitat-sh/habitat/pull/6529) ([raskchanky](https://github.com/raskchanky))
- adds working code and test for altering a package name to make it val... [#6524](https://github.com/habitat-sh/habitat/pull/6524) ([nellshamrell](https://github.com/nellshamrell))
- Update the docker exporter docs to include HAB_LICENSE instructions [#6525](https://github.com/habitat-sh/habitat/pull/6525) ([raskchanky](https://github.com/raskchanky))
- Propagate host license acceptance into docker containers [#6522](https://github.com/habitat-sh/habitat/pull/6522) ([raskchanky](https://github.com/raskchanky))
- Sets project status and SLA [#6473](https://github.com/habitat-sh/habitat/pull/6473) ([dmccown](https://github.com/dmccown))
- Revert "Switch to parking_lot's RwLock and add CI deadlock detection" [#6513](https://github.com/habitat-sh/habitat/pull/6513) ([raskchanky](https://github.com/raskchanky))

## Chef Habitat 0.80.0

[0.80.0](https://github.com/habitat-sh/habitat/tree/0.80.0) (2019-04-30)

[Full Changelog](https://github.com/habitat-sh/habitat/compare/0.79.1...0.80.0)

### New features and enhancements

- Configurable Shutdown, Part 1 [#6450](https://github.com/habitat-sh/habitat/pull/6450) ([christophermaier](https://github.com/christophermaier))
- Manually trigger an election (exploratory, unfinshed feature in development) [#6474](https://github.com/habitat-sh/habitat/pull/6474) ([christophermaier](https://github.com/christophermaier))
- Auto detect ttys for docker studios [#6404](https://github.com/habitat-sh/habitat/pull/6404) ([raskchanky](https://github.com/raskchanky))

### Bug fixes

- add ltsc2016 tag for windowsservercore base images [#6470](https://github.com/habitat-sh/habitat/pull/6470) ([mwrock](https://github.com/mwrock))
- Fix detection of emacs in studio [#6390](https://github.com/habitat-sh/habitat/pull/6390) ([smacfarlane](https://github.com/smacfarlane))
- build_component.ps1 should enter a non interactive container and forward exit code [#6476](https://github.com/habitat-sh/habitat/pull/6476) ([mwrock](https://github.com/mwrock))

### Behavioral changes

- Make --binlink take an value (or env var) for `hab pkg install` [#6423](https://github.com/habitat-sh/habitat/pull/6423) ([baumanj](https://github.com/baumanj))
- Add a license agreement prompt to hab [#6364](https://github.com/habitat-sh/habitat/pull/6364) ([raskchanky](https://github.com/raskchanky))

### Merged pull requests

- set machine scoped HAB_LICENSE variable for windows docker studio supervisor [#6491](https://github.com/habitat-sh/habitat/pull/6491) ([mwrock](https://github.com/mwrock))
- Add the license env var in the old way for now [#6489](https://github.com/habitat-sh/habitat/pull/6489) ([raskchanky](https://github.com/raskchanky))
- Accept the hab license on all our pipelines [#6488](https://github.com/habitat-sh/habitat/pull/6488) ([raskchanky](https://github.com/raskchanky))
- make install_hook a permanent feature [#6475](https://github.com/habitat-sh/habitat/pull/6475) ([mwrock](https://github.com/mwrock))
- modernize build.ps1 [#6466](https://github.com/habitat-sh/habitat/pull/6466) ([mwrock](https://github.com/mwrock))
- Use "default files" rather than embedded strings [#6319](https://github.com/habitat-sh/habitat/pull/6319) ([christophermaier](https://github.com/christophermaier))
- Rebuild pipeline with the correct name [#6449](https://github.com/habitat-sh/habitat/pull/6449) ([scotthain](https://github.com/scotthain))
- remove some dead appveyor and bintray-publish code [#6439](https://github.com/habitat-sh/habitat/pull/6439) ([mwrock](https://github.com/mwrock))
- Merge the core repo back into this one [#6432](https://github.com/habitat-sh/habitat/pull/6432) ([raskchanky](https://github.com/raskchanky))
- Add temporary hab release pipeline [#6437](https://github.com/habitat-sh/habitat/pull/6437) ([scotthain](https://github.com/scotthain))
- Follow $refs in generate-template-reference [#6427](https://github.com/habitat-sh/habitat/pull/6427) ([mpeck](https://github.com/mpeck))
- Add test habitat pipeline [#6428](https://github.com/habitat-sh/habitat/pull/6428) ([scotthain](https://github.com/scotthain))
- move thaw after dev bump in release checklist [#6420](https://github.com/habitat-sh/habitat/pull/6420) ([mwrock](https://github.com/mwrock))
- Clarify signal behavior [#6332](https://github.com/habitat-sh/habitat/pull/6332) ([christophermaier](https://github.com/christophermaier))
- Add deprecation message to templates using the foo[bar] syntax [#6360](https://github.com/habitat-sh/habitat/pull/6360) ([mpeck](https://github.com/mpeck))
- Fix error runining install.sh/Dockerfile [#6113](https://github.com/habitat-sh/habitat/pull/6113) ([qubitrenegade](https://github.com/qubitrenegade))

## Chef Habitat 0.79.1

[0.79.1](https://github.com/habitat-sh/habitat/tree/0.79.1) (2019-04-10)

[Full Changelog](https://github.com/habitat-sh/habitat/compare/0.79.0...0.79.1)

### Bug fixes

- add studio powershell directory to path on studio creation so it's propogated to supervisor [#6400](https://github.com/habitat-sh/habitat/pull/6400) ([mwrock](https://github.com/mwrock))

### Merged pull requests

- Fix a boolean mistake that snuck in [#6397](https://github.com/habitat-sh/habitat/pull/6397) ([christophermaier](https://github.com/christophermaier))
- Consolidate feature flag operations. [#6367](https://github.com/habitat-sh/habitat/pull/6367) ([christophermaier](https://github.com/christophermaier))
- Adds blog redirect at top-level and links to each post [#6225](https://github.com/habitat-sh/habitat/pull/6225) ([eeyun](https://github.com/eeyun))


## Chef Habitat 0.79.0

[0.79.0](https://github.com/habitat-sh/habitat/tree/0.79.0) (2019-04-01)

[Full Changelog](https://github.com/habitat-sh/habitat/compare/0.78.0...0.79.0)

### New features and enhancements

- Send target query param on pkg upload [#6366](https://github.com/habitat-sh/habitat/pull/6366) ([chefsalim](https://github.com/chefsalim))
- Add target param to pkg related APIs [#6368](https://github.com/habitat-sh/habitat/pull/6368) ([chefsalim](https://github.com/chefsalim))
- Add package deletion command [#6350](https://github.com/habitat-sh/habitat/pull/6350) ([chefsalim](https://github.com/chefsalim))
- Introduce NATS Streaming eventing to the Supervisor [#6218](https://github.com/habitat-sh/habitat/pull/6218) ([christophermaier](https://github.com/christophermaier))
- Copies /etc/inputrc in studio if available [#5658](https://github.com/habitat-sh/habitat/pull/5658) ([rsertelon](https://github.com/rsertelon))
- Attempt to implement template debugging tool [#6114](https://github.com/habitat-sh/habitat/pull/6114) ([qubitrenegade](https://github.com/qubitrenegade))

### Behavioral changes

- Remove uses of default_cache_key_path [#6336](https://github.com/habitat-sh/habitat/pull/6336) ([baumanj](https://github.com/baumanj))
- Remove uses of core&#39;s default_cache_key_path [#6326](https://github.com/habitat-sh/habitat/pull/6326) ([baumanj](https://github.com/baumanj))
- Remove usage of habitat_core::binlink::default_binlink_dir [#6315](https://github.com/habitat-sh/habitat/pull/6315) ([baumanj](https://github.com/baumanj))
- macOS still needs --interactive and --tty set [#6295](https://github.com/habitat-sh/habitat/pull/6295) ([raskchanky](https://github.com/raskchanky))

### Bug fixes

- Fix positional args, tweak err handling for promote/demote/delete [#6379](https://github.com/habitat-sh/habitat/pull/6379) ([chefsalim](https://github.com/chefsalim))
- Properly pass CLI args to `hab origin key import` [#6363](https://github.com/habitat-sh/habitat/pull/6363) ([baumanj](https://github.com/baumanj))
- start supervisor outside of interactive powershell session in local windows studio [#6353](https://github.com/habitat-sh/habitat/pull/6353) ([mwrock](https://github.com/mwrock))
- Revert "remove old content" feature [#6348](https://github.com/habitat-sh/habitat/pull/6348) ([christophermaier](https://github.com/christophermaier))
- Remove offensively-named command in favor of updated version [#6343](https://github.com/habitat-sh/habitat/pull/6343) ([baumanj](https://github.com/baumanj))
- uninstall shouldn't rename to existing directory on windows [#6322](https://github.com/habitat-sh/habitat/pull/6322) ([mwrock](https://github.com/mwrock))
- Use POSIX `unset` rather than Busybox `env -u` for HAB_STUDIO_BINARY [#6318](https://github.com/habitat-sh/habitat/pull/6318) ([christophermaier](https://github.com/christophermaier))
- windows docker studio should output sup log in color and without timestamp [#6312](https://github.com/habitat-sh/habitat/pull/6312) ([mwrock](https://github.com/mwrock))
- turn off supervisor log coloring in local windows studio if ANSI isn't supported [#6306](https://github.com/habitat-sh/habitat/pull/6306) ([mwrock](https://github.com/mwrock))
- eliminate false error noise from windows launcher [#6313](https://github.com/habitat-sh/habitat/pull/6313) ([mwrock](https://github.com/mwrock))
- Use subshells and unset to actually unset environment variables [#6296](https://github.com/habitat-sh/habitat/pull/6296) ([christophermaier](https://github.com/christophermaier))
- implement platform specific UI symbols [#6290](https://github.com/habitat-sh/habitat/pull/6290) ([mwrock](https://github.com/mwrock))

### Merged pull requests

- Tweak windows butterfly test setup [#6371](https://github.com/habitat-sh/habitat/pull/6371) ([scotthain](https://github.com/scotthain))
- Add a welcome message when PRs are opened [#6356](https://github.com/habitat-sh/habitat/pull/6356) ([raskchanky](https://github.com/raskchanky))
- Use curl to upload packages rather than pkg upload [#6365](https://github.com/habitat-sh/habitat/pull/6365) ([scotthain](https://github.com/scotthain))
- Migrate to habitat rust rather than system rust [#6349](https://github.com/habitat-sh/habitat/pull/6349) ([scotthain](https://github.com/scotthain))
- Update the website bundle to fix some security jazz [#6355](https://github.com/habitat-sh/habitat/pull/6355) ([raskchanky](https://github.com/raskchanky))
- Simplify CLI definition for `hab svc load` command [#6327](https://github.com/habitat-sh/habitat/pull/6327) ([christophermaier](https://github.com/christophermaier))
- Make Linux Kernel 2 validation just a little bit easier [#6297](https://github.com/habitat-sh/habitat/pull/6297) ([christophermaier](https://github.com/christophermaier))
- Use sup-run instead of hab sup run in demo [#5746](https://github.com/habitat-sh/habitat/pull/5746) ([rsertelon](https://github.com/rsertelon))
