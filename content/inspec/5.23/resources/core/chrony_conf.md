+++
title = "chrony_conf resource"
draft = false

platform = "linux"

[menu.inspec_5_23]
    title = "chrony_conf"
    identifier = "resources/core/chrony_conf.md chrony_conf resource"
    parent = "resources/core"
+++

Use the `chrony_conf` Chef InSpec audit resource to test the synchronization settings defined in the `chrony.conf` file. This file is typically located at `/etc/chrony.conf`.

## Availability

### Install

{{< readfile file="content/inspec/5.23/reusable/md/inspec_installation.md" >}}

<!-- TODO: needs version number -->
<!-- ### Version

This resource first became available in v of InSpec. -->

## Syntax

An `chrony_conf` resource block declares the synchronization settings that should be tested:

```ruby
describe chrony_conf('PATH') do
  its('setting_name') { should eq 'VALUE' }
end
```

where:

- `'setting_name'` is a synchronization setting defined in the `chrony.conf` file.
- `('path')` is the non-default path to the `chrony.conf` file (default path is `/etc/chrony.conf`).
- `{ should eq 'value' }` is the value that's expected.

## Examples

The following examples show how to use this Chef InSpec audit resource.

This resource matches any service listed in the `chrony.conf` file.

### Test for clock drift against named servers

```ruby
describe chrony_conf do
  its('driftfile') { should cmp '/var/lib/chrony/drift' }
  its('server') do
    should cmp [
      '0.ubuntu.pool.ntp.org',
      '1.ubuntu.pool.ntp.org',
      '2.ubuntu.pool.ntp.org'
      ]
    end
end
```

### Test that an NTP server exists and a specific subnet is specified from which NTP clients are accessible

```ruby
describe chrony_conf do
  its('server') { should_not eq nil }
  its('allow') { should include '192.168.0.0/16'}
end
```

## Matchers

 {{< readfile file="content/inspec/5.23/reusable/md/inspec_matchers_link.md" >}}
