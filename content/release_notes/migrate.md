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

## Chef Migrate 1.2.29

Release date: March 26, 2026

### Bug fixes

- After installing the Habitat-based Chef Infra Client with Chef Migrate, the `chef-client -v` command now correctly points to the new version instead of an older Omnibus-based version.
- Fixed Chef Infra Client 19 installation failures on multi-drive (for example, `C:`, `D:`, `E:`) Windows servers:
  - Chef Migrate now looks for and cleans up the Omnibus Chef Infra Client MSI if it's installed on a non-default drive. Previously, Chef Migrate only looked for Omnibus files in `C:\opscode\`, and it would fail to find or clean up an installation in other drives.
  - Chef Migrate now correctly resolves the drive that Windows and Habitat are installed on. Previously it assumed they were installed on the `C:\` drive. If they were installed on another drive, the installation failed to install Chef Infra Client in the correct location.
- The Chef Migrate no longer deletes an existing Chef Automate installation when installing Chef Infra Client 19.x.

### Legal

- Updated `NOTICE.txt` with the latest third-party attribution content received from the legal team

### Dependencies

- Upgraded Go toolchain from 1.24.12 to 1.26.1 to address known CVEs:
  - CVE-2026-27142
  - CVE-2025-68121
  - CVE-2025-61732
