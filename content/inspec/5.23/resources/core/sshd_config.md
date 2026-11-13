+++
title = "sshd_config resource"
draft = false

platform = "linux"

[menu.inspec_5_23]
    title = "sshd_config"
    identifier = "resources/core/sshd_config.md sshd_config resource"
    parent = "resources/core"
+++

Use the `sshd_config` Chef InSpec audit resource to test configuration data for the OpenSSH daemon located at `/etc/ssh/sshd_config` on Linux and Unix platforms. sshd---the OpenSSH daemon---listens on dedicated ports, starts a daemon for each incoming connection, and then handles encryption, authentication, key exchanges, command execution, and data exchanges.

## Availability

### Install

{{< readfile file="content/inspec/5.23/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

An `sshd_config` resource block declares the OpenSSH daemon configuration data to be tested:

```ruby
describe sshd_config('path') do
  its('name') { should include('foo') }
end
```

where:

- `name` is a configuration setting in `sshd_config`
- `('path')` is the non-default `/path/to/sshd_config`
- `{ should include('foo') }` tests the value of `name` as read from `sshd_config` versus the value declared in the test

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test which variables may be sent to the server

```ruby
describe sshd_config do
  its('AcceptEnv') { should include('CI_ENABLE_COVERAGE') }
end
```

### Test for IPv6-only addresses

```ruby
describe sshd_config do
  its('AddressFamily') { should cmp 'inet6' }
end
```

### Test the Protocol setting

```ruby
describe sshd_config do
  its('Protocol') { should cmp 2 }
end
```

### Test for approved, strong ciphers

```ruby
describe sshd_config do
  its('Ciphers') { should cmp('chacha20-poly1305@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr') }
end
```

### Test SSH protocols

```ruby
describe sshd_config do
  its('Port') { should cmp  22 }
  its('UsePAM') { should eq 'yes' }
  its('ListenAddress') { should eq nil }
  its('HostKey') do
    should eq [
      '/etc/ssh/ssh_host_rsa_key',
      '/etc/ssh/ssh_host_dsa_key',
      '/etc/ssh/ssh_host_ecdsa_key',
    ]
  end
end
```

## Matchers

{{< readfile file="content/inspec/5.23/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### name

The `name` matcher tests the value of `name` as read from `sshd_config` versus the value declared in the test:

```ruby
its('name') { should cmp 'foo' }
```

or:

```ruby
its('name') {should include('bar') }
```
