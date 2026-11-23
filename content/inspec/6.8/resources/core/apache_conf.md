+++
title = "apache_conf resource"
draft = false

platform = "linux"

[menu.inspec_6_8]
    title = "apache_conf"
    identifier = "resources/core/apache_conf.md apache_conf resource"
    parent = "resources/core"
+++

Use the `apache_conf` Chef InSpec audit resource to test the configuration settings for Apache. This file is typically located under `/etc/apache2` on the Debian and Ubuntu platforms and under `/etc/httpd` on the Fedora, CentOS, RedHat Enterprise Linux, and ArchLinux platforms. The configuration settings may vary significantly from platform to platform.

## Availability

### Install

{{< readfile file="content/inspec/6.8/reusable/md/inspec_installation.md" >}}

### Requirements

`ServerRoot` must be included in an Apache configuration file. If not present, the included configurations won't be accessible to the resource.

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

An `apache_conf` Chef InSpec audit resource block declares configuration settings that should be tested:

```ruby
describe apache_conf('path') do
  its('setting_name') { should eq 'value' }
end
```

where:

- `'setting_name'` is a configuration setting defined in the Apache configuration file
- `('path')` is the non-default path to the Apache configuration file
- `{ should eq 'value' }` is the value that's expected

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test for blocking .htaccess files on CentOS

```ruby
describe apache_conf do
  its('AllowOverride') { should cmp 'None' }
end
```

### Test ports for SSL

```ruby
describe apache_conf do
  its('Listen') { should cmp '443' }
end
```

### Test multiple ports are listening

```ruby
describe apache_conf do
  its('Listen') { should =~ [ '80', '443' ] }
end
```

## Matchers

{{< readfile file="content/inspec/6.8/reusable/md/inspec_matchers_link.md" >}}

This Chef InSpec audit resource matches any service that's listed in the Apache configuration file:

```ruby
its('PidFile') { should_not eq '/var/run/httpd.pid' }
```

or:

```ruby
its('Timeout') { should cmp '300' }
```

For example:

```ruby
describe apache_conf do
  its('MaxClients') { should cmp '100' }
  its('Listen') { should cmp '443' }
end
```
