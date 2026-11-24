+++
title = "package resource"
draft = false

platform = "os"

[menu.inspec_5_24]
    title = "package"
    identifier = "resources/core/package.md package resource"
    parent = "resources/core"
+++

Use the `package` Chef InSpec audit resource to test if the named package and/or package version is installed on the system.

## Availability

### Install

{{< readfile file="content/inspec/5.24/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `package` resource block declares a package and (optionally) a package version:

```ruby
describe package('name') do
  it { should be_installed }
end
```

where:

- `('name')` must specify the name of a package, such as `'nginx'`
- `be_installed` is a valid matcher for this resource

## Properties

### version

The `version` property tests if the named package version is on the system:

```ruby
its('version') { should eq '1.2.3' }
```

You can also use the `cmp` matcher to perform comparisons using the version attribute:

```ruby
its('version') { should cmp >= '7.35.0-1ubuntu3.10' }
```

`cmp` understands version numbers using Gem::Version, and can use the operators `==, <, <=, >=, and >`. It compares versions by each segment, not as a string, so `7.4` is smaller than `7.30`.

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test if NGINX version 1.9.5 is installed

```ruby
describe package('nginx') do
  it { should be_installed }
  its('version') { should eq '1.9.5' }
end
```

### Test that a package isn't installed

```ruby
describe package('some_package') do
  it { should_not be_installed }
end
```

### Test that telnet isn't installed

```ruby
describe package('telnetd') do
  it { should_not be_installed }
end

describe inetd_conf do
  its('telnet') { should eq nil }
end
```

### Test if ClamAV (an antivirus engine) is installed, latest and running

```ruby
describe package('clamav') do
  it { should be_installed }
  its('version') { should eq '0.98.7' }
end

describe service('clamd') do
  it { should be_enabled }
  it { should be_installed }
  it { should be_latest }
  it { should be_running }
end
```

### Verify if a package is installed according to my rpm database

```ruby
describe package('some_package', rpm_dbpath: '/var/lib/my_rpmdb') do
  it { should be_installed }
end
```

### Verify if Memcached is installed, latest, enabled, and running

Memcached is an in-memory key-value store that helps improve the performance of database-driven websites and can be installed, maintained, and tested using the `memcached` cookbook (maintained by Chef). The following example is from the `memcached` cookbook and shows how to use a combination of the `package`, `service`, and `port` Chef InSpec audit resources to test if Memcached is installed, enabled, and running:

```ruby
describe package('memcached') do
  it { should be_installed }
end

describe service('memcached') do
  it { should be_installed }
  it { should be_latest }
  it { should be_enabled }
  it { should be_running }
end

describe port(11_211) do
  it { should be_listening }
end
```

## Matchers

{{< readfile file="content/inspec/5.24/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### be_held

The `be_held` matcher tests if the named package is held. On dpkg platforms, a held package
won't be upgraded to a later version.

```ruby
it { should be_held }
```

### be_installed

The `be_installed` matcher tests if the named package is installed on the system:

```ruby
it { should be_installed }
```

### be_latest

The `be_latest` matcher tests if the named installed package is latest on the system. It isn't supported in Oracle Solaris, IBM AIX and HP UX operating systems.

```ruby
it { should be_latest }
```
