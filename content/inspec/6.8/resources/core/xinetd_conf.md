+++
title = "xinetd_conf resource"
draft = false

platform = "linux"

[menu.inspec_6_8]
    title = "xinetd_conf"
    identifier = "resources/core/xinetd_conf.md xinetd_conf resource"
    parent = "resources/core"
+++

Use the `xinetd_conf` Chef InSpec audit resource to test services under `/etc/xinet.d` on Linux and Unix platforms. xinetd---the extended Internet service daemon---listens on all ports, and then loads the appropriate program based on a request. The `xinetd.conf` file is typically located at `/etc/xinetd.conf` and contains a list of Internet services associated to the ports on which that service will listen. Only enabled services may handle a request; only services that are required by the system should be enabled.

## Availability

### Install

{{< readfile file="content/inspec/6.8/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

An `xinetd_conf` resource block declares settings found in a `xinetd.conf` file for the named service:

```ruby
describe xinetd_conf.services('service_name') do
  it { should be_enabled } # or be_disabled
  its('setting') { should eq 'value' }
end
```

where:

- `'service_name'` is a service located under `/etc/xinet.d`
- `('setting')` is a setting in the `xinetd.conf` file
- `should eq 'value'` is the value that's expected

## Properties

### ids

The `ids` property tests if the named service is located under `/etc/xinet.d`:

```ruby
its('ids') { should include 'service_name' }
```

For example:

```ruby
its('ids') { should include 'chargen-stream chargen-dgram'}
```

### services

The `services` property tests if the named service is listed under `/etc/xinet.d`:

```ruby
its('services') { should include 'service_name' }
```

### socket_types

The `socket_types` property tests if a service listed under `/etc/xinet.d` is configured to use the named socket type.

Use `socket` if the socket type is `dgram`, `raw`, or `stream`:

```ruby
its('socket_types') { should eq 'socket' }
```

For a UDP-based service:

```ruby
its('socket_types') { should eq 'dgram' }
```

For a raw socket (such as a service using a non-standard protocol or a service that requires direct access to IP):

```ruby
its('socket_types') { should eq 'raw' }
```

For a TCP-based service:

```ruby
its('socket_types') { should eq 'stream' }
```

### types

The `types` property tests the service type:

```ruby
its('type') { should eq 'TYPE' }
```

where `'TYPE'` is `INTERNAL` (for a service provided by xinetd), `RPC` (for a service based on remote procedure call), or `UNLISTED` (for services not under `/etc/services` or `/etc/rpc`).

### wait

The `wait` property tests how a service handles incoming connections.

For UDP (`dgram`) socket types, the `wait` property should test for `yes`:

```ruby
its('socket_types') { should eq 'dgram' }
its('wait') { should eq 'yes' }
```

For TCP (`stream`) socket types, the `wait` property should test for `no`:

```ruby
its('socket_types') { should eq 'stream' }
its('wait') { should eq 'no' }
```

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test a socket_type

The network socket type: `dgram` (a datagram-based service), `raw` (a service that requires direct access to an IP address), `stream` (a stream-based service), or `seqpacket` (a service that requires a sequenced packet).

```ruby
describe xinetd_conf.services('service_name') do
   its('socket_types') { should include 'dgram' }
end
```

### Test a service type

The type of service: `INTERNAL` (a service provided by xinetd), `RPC` (an RPC-based service), `TCPMUX` (a service that's started on a well-known TCPMUX port), or `UNLISTED` (a service that's not listed in a standard system file location).

```ruby
describe xinetd_conf.services('service_name') do
   its('type') { should include 'RPC' }
end
```

### Test the telnet service

For example, a `telnet` file under `/etc/xinet.d` contains the following settings:

```plain
service telnet
{
  disable         = yes
  flags           = REUSE
  socket_type     = stream
  wait            = no
  user            = root
  server          = /usr/sbin/in.telnetd
  log_on_failure  += USERID
}
```

Some examples of tests that can be run against that file include:

```ruby
describe xinetd_conf.services('telnet') do
  it { should be_disabled }
end
```

and

```ruby
describe xinetd_conf.services('telnet') do
  its('socket_type') { should include 'stream' }
end
```

and

```ruby
describe xinetd_conf.services('telnet') do
  its('wait') { should eq 'no' }
end
```

All three settings can be tested in the same block as well:

```ruby
describe xinetd_conf.services('telnet') do
  it { should be_disabled }
  its('socket_type') { should include 'stream' }
  its('wait') { should eq 'no' }
end
```

## Matchers

{{< readfile file="content/inspec/6.8/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### be_enabled

The `be_enabled` matcher tests if a service listed under `/etc/xinet.d` is enabled:

```ruby
it { should be_enabled }
```
