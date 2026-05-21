+++
title = "Chef Migrate release notes"
draft = false
swiftype_search_products = []
linkTitle = "Chef Migrate"
summary = "Chef Migrate release notes"

[menu]
  [menu.release_notes]
    title = "Chef Migrate"
    identifier = "release_notes/release_notes_migrate.md Chef Migrate"
    parent = "release_notes"
    weight = 110
+++

## Chef Migrate 1.2.33

Release date: May 21, 2026

### Bug fixes

- Fixed an issue where Chef Infra Client 19 (ICE) couldn't be installed on Windows drives other than `C:\`.
  Habitat-related paths now respect the `SYSTEMDRIVE` environment variable (for example, `D:\hab`, `E:\hab`), allowing you to install Chef ICE on any drive.
  Omnibus-related paths remain hardcoded to `C:\opscode` to maintain backward compatibility with legacy Omnibus installations.

## Chef Migrate 1.2.32

Release date: May 20, 2026

### Bug fixes

- Fixed an issue where Chef Migrate could fail and corrupt the Chef Infra Client installation if Chef Infra Client is running during migration.
  Chef Migrate now detects running Chef Infra Client processes and waits up to five minutes for them to complete before proceeding.
- Fixed an issue where migration failed on systems running legacy Chef Infra Client versions 13 or 14.
  The Omnibus uninstall scripts for these versions deleted binaries from `/usr/bin` during package removal.
  Chef Migrate now automatically restores these binaries after Omnibus uninstall using `hab pkg binlink`.

### New features

- Adds support for Linux ARM distributions.
- Adds the `--set-chef-schedule-task` flag to create a Windows scheduled task that runs Chef Infra Client every 30 minutes.
- Adds support for both new (`hab/pkgs/chef/hab/`) and legacy (`hab/pkgs/core/hab/`) Habitat package path formats, ensuring compatibility with all Chef ICE package versions.
- Package removal writes a log file to a platform-specific location, including timestamps, removal status, binlink restoration events, and exit codes:
  - Linux and macOS: `/var/log/chef-package-removal.log`
  - Windows: `%TEMP%\chef-package-removal.log`

### Legal

- Updated `NOTICE.txt` with the latest third-party attribution content received from the legal team.

### Dependencies

- Upgraded Go toolchain from 1.26.1 to 1.26.3 to address CVEs.

## Chef Migrate 1.2.30

Release date: March 26, 2026

### Bug fixes

- The `chef-client -v` command now correctly points to the new Habitat-based Chef Infra Client install when it's installed with Chef Migrate and a previous Omnibus-based Chef Infra Client version is preserved with the  `--preserve-omnibus` flag.
- Fixed Chef Infra Client 19 installation failures on multi-drive (for example, `C:`, `D:`, `E:`) Windows servers.
- Chef Migrate no longer fails when installing Chef Infra Client 19.x on a system with an existing Chef Automate installation. Previously, the install would fail and Chef Migrate would delete files related to Automate, for example `/hab`.

### Known issues

- Don't install Chef Infra Client 19.x on a system that already has Chef Automate running on it.

### Legal

- Updated `NOTICE.txt` with the latest third-party attribution content received from the legal team.

### Dependencies

- Upgraded Go toolchain from 1.24.12 to 1.26.1 to address known CVEs:
  - CVE-2026-27142
  - CVE-2025-68121
  - CVE-2025-61732
