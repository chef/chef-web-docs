+++
title = "auditd resource"
draft = false

platform = "linux"

[menu.inspec_7_3]
    title = "auditd"
    identifier = "resources/core/auditd.md auditd resource"
    parent = "resources/core"
+++

Use the `auditd` Chef InSpec audit resource to test the rules for logging that exist on the system. The audit.rules file is typically located under /etc/audit/ and contains the list of rules that define what's captured in log files. These rules are output using the `auditctl -l` command. This resource supports versions of `audit` >= 2.3.

## Availability

### Install

{{< readfile file="content/inspec/7.3/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.38.8 of InSpec.

## Syntax

An `auditd` resource block declares one (or more) rules to be tested, and then what that rule should do:

```ruby
describe auditd do
  its('lines') { should include %r(-w /etc/ssh/sshd_config) }
end
```

or test that multiple individual rules are defined:

```ruby
describe auditd do
  its('lines') { should include %r(-a always,exit -F arch=.* -S init_module,delete_module -F key=modules) }
  its('lines') { should include %r(-a always,exit -F arch=.* -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=-1 -F key=.+) }
end
```

where each test must declare one (or more) rules to be tested.

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test if a rule contains a matching element that's identified by a regular expression

For `audit` >= 2.3:

```ruby
describe auditd do
  its('lines') { should include %r(-a always,exit -F arch=.* -S chown.* -F auid>=1000 -F auid!=-1 -F key=perm_mod) }
end
```

### Query the audit daemon status

```ruby
describe auditd.status('backlog') do
  it { should cmp 0 }
end
```

### Query properties of rules targeting specific system calls or files - uniq is used to handle multiple rules for the same system call with redundant field values

```ruby
describe auditd.syscall('open') do
  its('action.uniq') { should eq ['always'] }
  its('list.uniq') { should eq ['exit'] }
end

describe auditd.file('/etc/sudoers') do
  its('permissions') { should include ['x'] }
end
```

The where accessor can be used to filter on fields. For example:

```ruby
describe auditd.syscall('chown').where { arch == "b32" } do
  its('action') { should eq ['always'] }
  its('list') { should eq ['exit'] }
  its('exit') { should include ['-EACCES'] }
  its('exit') { should include ['-EPERM'] }
end
```

The key filter may be useful in evaluating rules with particular key values:

```ruby
describe auditd.where { key == "privileged" } do
  its('permissions') { should include ['x'] }
end
```

## Matchers

{{< readfile file="content/inspec/7.3/reusable/md/inspec_matchers_link.md" >}}
