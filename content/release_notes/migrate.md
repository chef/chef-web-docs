+++
title = "Chef Migrate release notes"
draft = false
product = []
linkTitle = "Chef Migrate"
summary = "Chef Migrate release notes"

[menu]
  [menu.release_notes]
    title = "Chef Migrate"
    identifier = "release_notes/release_notes_migrate.md Chef Migrate"
    parent = "release_notes"
    weight = 110
+++

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
