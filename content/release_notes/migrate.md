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


### Chef Migrate 1.2.32

Release date: TBD

### Bug fixes

- Migration tool fails and corrupts install if chef-client is running
- Chef Client migration tool not working with legacy chef-client version (13,14)

### New Features

- Support for arm/linux
- Chef Client GUI Installer Missing Scheduler Options
- Habitat path compatibility with Chef ICE packages: Migration tool now automatically supports both new (`hab/pkgs/chef/hab/`) and legacy (`hab/pkgs/core/hab/`) package path formats for seamless compatibility with all Chef ICE package versions


### Known issues

- None

### Legal

- Updated NOTICE.txt with the latest third-party attribution content received from the legal team.

### Dependencies

- Upgraded Go toolchain from 1.26.1 to 1.26.3 to address known CVEs:
  - CVE-2026-39820
  - CVE-2026-27143
  - CVE-2026-42499
  - CVE-2026-32281
  - CVE-2026-33814
  - CVE-2026-32280
  - CVE-2026-32283
  - CVE-2026-33811
  - CVE-2026-39836
  - CVE-2026-27140
  - CVE-2026-42501
  - CVE-2026-39817
  - CVE-2026-33810
  - CVE-2026-39826
  - CVE-2026-39823
  - CVE-2026-39825
  - CVE-2026-32289
  - CVE-2026-32282
  - CVE-2026-27144
  - CVE-2026-39819
  - CVE-2026-32288
 

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
