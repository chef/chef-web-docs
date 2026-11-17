+++
title = "sys_info resource"
draft = false

platform = "os"

[menu.inspec_7_2]
    title = "sys_info"
    identifier = "resources/core/sys_info.md sys_info resource"
    parent = "resources/core"
+++

Use the `sys_info` Chef InSpec audit resource to test for operating system properties for the named host, and then returns that info as standard output.

## Availability

### Install

{{< readfile file="content/inspec/7.2/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

An `sys_info` resource block declares the hostname to be tested:

```ruby
describe sys_info do
  its('hostname') { should eq 'value' }
end
```

## Properties

### hostname

The `hostname` property tests the host for which standard output is returned:

```ruby
its('hostname') { should eq 'value' }
```

### fqdn

The `fqdn` property tests the 'fully qualified domain name' of the system:

```ruby
its('fqdn') { should eq 'value' }
```

### domain

The `domain` property tests the name of the DNS domain:

```ruby
its('domain') { should eq 'value' }
```

### ip-address

The `ip-address` property tests all network addresses of the host:

```ruby
its('ip-address') { should eq 'value' }
```

### short

The `short` property tests the host name cut at the first dot:

```ruby
its('short') { should eq 'value' }
```

### manufacturer

The `manufacturer` property tests the host for which standard output is returned:

```ruby
its('manufacturer') { should eq 'ACME Corp.' }
```

### model

The `model` property tests the host for which standard output is returned:

```ruby
its('model') { should eq 'Flux Capacitor' }
```

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Get system information for example.com

```ruby
describe sys_info do
  its('hostname') { should eq 'example.com' }
end
```

### Compare content to hostname

```ruby
describe file('/path/to/some/file') do
  its('content') { should match sys_info.hostname }
end
```

Options can be passed as arguments to hostname as well.

```ruby
describe file('/path/to/some/file') do
  its('content') { should match sys_info.hostname('full') }
end
```

Currently supported arguments to `hostname` on Linux platforms are 'full'|'f'|'fqdn'|'long', 'domain'|'d', 'ip_address'|'i', and 'short'|'s'. Mac currently supports 'full'|'f'|'fqdn'|'long' and 'short'|'s'

## Matchers

{{< readfile file="content/inspec/7.2/reusable/md/inspec_matchers_link.md" >}}
