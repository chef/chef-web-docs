+++
title = "ntp_conf resource"
draft = false

platform = "linux"

[menu.inspec_7_2]
    title = "ntp_conf"
    identifier = "resources/core/ntp_conf.md ntp_conf resource"
    parent = "resources/core"
+++

Use the `ntp_conf` Chef InSpec audit resource to test the synchronization settings defined in the `ntp.conf` file. This file is typically located at `/etc/ntp.conf`.

## Availability

### Install

{{< readfile file="content/inspec/7.2/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

An `ntp_conf` resource block declares the synchronization settings that should be tested:

```ruby
describe ntp_conf('path') do
  its('setting_name') { should eq 'value' }
end
```

where:

- `'setting_name'` is a synchronization setting defined in the `ntp.conf` file
- `('path')` is the non-default path to the `ntp.conf` file
- `{ should eq 'value' }` is the value that's expected

## Properties

This resource supports any of the settings listed in an `ntp.conf` file as properties.

## Examples

The following examples show how to use this Chef InSpec audit resource

```ruby
describe ntp_conf do
  its('server') { should_not eq nil }
  its('restrict') { should include '-4 default kod notrap nomodify nopeer noquery'}
end
```

### Test for clock drift against named servers

```ruby
describe ntp_conf do
  its('driftfile') { should eq '/var/lib/ntp/ntp.drift' }
  its('server') do
    should eq [
      '0.ubuntu.pool.ntp.org',
      '1.ubuntu.pool.ntp.org',
      '2.ubuntu.pool.ntp.org'
    ]
  end
end
```

## Matchers

{{< readfile file="content/inspec/7.2/reusable/md/inspec_matchers_link.md" >}}
