+++
title = "auditd_conf resource"
draft = false

platform = "linux"

[menu.inspec_6_8]
    title = "auditd_conf"
    identifier = "resources/core/auditd_conf.md auditd_conf resource"
    parent = "resources/core"
+++

Use the `auditd_conf` Chef InSpec audit resource to test the configuration settings for the audit daemon. This file is typically located under `/etc/audit/auditd.conf'` on Unix and Linux platforms.

## Availability

### Install

{{< readfile file="content/inspec/6.8/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `auditd_conf` resource block declares configuration settings that should be tested:

```ruby
describe auditd_conf('path') do
  its('keyword') { should cmp 'value' }
end
```

where:

- `'keyword'` is a configuration setting defined in the `auditd.conf` configuration file
- `('path')` is the non-default path to the `auditd.conf` configuration file
- `{ should cmp 'value' }` is the value that's expected

## Properties

This matcher will match any property listed in the `auditd.conf` configuration file. Property names and expected values are case-insensitive:

- `admin_space_left`, `admin_space_left_action`, `action_mail_acct`, `conf_path`, `content`, `disk_error_action`, `disk_full_action`, `flush`, `freq`, `log_file`, `log_format`, `max_log_file`, `max_log_file_action`, `num_logs`, `params`, `space_left`, `space_left_action`

## Property Examples

The following examples show how to use this Chef InSpec audit resource.

### Test the auditd.conf file

```ruby
describe auditd_conf do
  its('log_file') { should cmp '/full/path/to/file' }
  its('log_format') { should cmp 'raw' }
  its('flush') { should cmp 'none' }
  its('freq') { should cmp 1 }
  its('num_logs') { should cmp 0 }
  its('max_log_file') { should cmp 6 }
  its('max_log_file_action') { should cmp 'email' }
  its('space_left') { should cmp 2 }
  its('action_mail_acct') { should cmp 'root' }
  its('space_left_action') { should cmp 'email' }
  its('admin_space_left') { should cmp 1 }
  its('admin_space_left_action') { should cmp 'halt' }
  its('disk_full_action') { should cmp 'halt' }
  its('disk_error_action') { should cmp 'halt' }
end

describe file(auditd_conf.conf_path) do
  its('group') { should cmp 'root' }
end
```

## Matchers

{{< readfile file="content/inspec/6.8/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### `cmp`

The `cmp` matcher compares values across types.

```ruby
its('freq') { should cmp 1 }
```
