+++
title = "Chef InSpec Azure Cloud Resource release notes"
draft = false
product = ["inspec"]
linkTitle = "Chef InSpec Azure Cloud Resource"
summary = "Chef InSpec Azure Cloud Resource release notes"

[menu]
  [menu.release_notes]
    title = "Azure Cloud Resources"
    identifier = "release_notes/inspec/InSpec Azure"
    parent = "release_notes/inspec"
+++

<!-- markdownlint-disable-file -->
<!-- cSpell:disable  -->
<!-- vale off -->

## Azure Cloud Resource 2022-01-07

### New Azure Cloud Resources

- [Virtual Network Gateway Connections](https://github.com/inspec/inspec-azure/pull/531)
- [Virtual Network Gateway](https://github.com/inspec/inspec-azure/pull/530)
- [Migrate Assessment Machines](https://github.com/inspec/inspec-azure/pull/434)
- [Sentinel Incident](https://github.com/inspec/inspec-azure/pull/459)
- [Datalake Storage Gen2 Filesystem](https://github.com/inspec/inspec-azure/pull/482)
- [PowerBI Gateway](https://github.com/inspec/inspec-azure/pull/517)
- [Managed Sql Instance](https://github.com/inspec/inspec-azure/pull/563)
- [Alert Rule Template](https://github.com/inspec/inspec-azure/pull/476)

### Bug Fixes

- [Resolved an error in the `azure_network_security_group` resource when verifying a destination port or range of destination ports](https://github.com/inspec/inspec-azure/pull/564).

## Azure Cloud Resource 2021-10-08

### New Azure Cloud Resources

- Migrate Project Machines
- Migrate Assessment
- Migrate Project Events

### Bug Fixes

- Minimum Service principal role required
