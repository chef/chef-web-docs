+++
title = "xinetd_conf resource"
draft = false
platform = "linux"

[menu]
  [menu.inspec]
    title = "xinetd_conf"
    identifier = "inspec/resources/os/xinetd_conf.md xinetd_conf resource"
    parent = "inspec/resources/os"
+++

[\[edit on GitHub\]](https://github.com/inspec/inspec/blob/master/docs-chef-io/content/inspec/resources/xinetd_conf.md)

Use the `xinetd_conf` Chef InSpec audit resource to test services under `/etc/xinet.d` on Linux and Unix platforms. xinetd---the extended Internet service daemon---listens on all ports, and then loads the appropriate program based on a request. The `xinetd.conf` file is typically located at `/etc/xinetd.conf` and contains a list of Internet services associated to the ports on which that service will listen. Only enabled services may handle a request; only services that are required by the system should be enabled.

## Availability

### Installation

This resource is distributed along with Chef InSpec itself. You can use it automatically.

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

An `xinetd_conf` resource block declares settings found in a `xinetd.conf` file for the named service:

    describe xinetd_conf.services('service_name') do
      it { should be_enabled } # or be_disabled
      its('setting') { should eq 'value' }
    end

where

- `'service_name'` is a service located under `/etc/xinet.d`
- `('setting')` is a setting in the `xinetd.conf` file
- `should eq 'value'` is the value that is expected

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test a socket_type

The network socket type: `dgram` (a datagram-based service), `raw` (a service that requires direct access to an IP address), `stream` (a stream-based service), or `seqpacket` (a service that requires a sequenced packet).

    describe xinetd_conf.services('service_name') do
       its('socket_types') { should include 'dgram' }
    end

### Test a service type

The type of service: `INTERNAL` (a service provided by xinetd), `RPC` (an RPC-based service), `TCPMUX` (a service that is started on a well-known TCPMUX port), or `UNLISTED` (a service that is not listed in a standard system file location).

    describe xinetd_conf.services('service_name') do
       its('type') { should include 'RPC' }
    end

### Test the telnet service

For example, a `telnet` file under `/etc/xinet.d` contains the following settings:

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

Some examples of tests that can be run against that file include:

    describe xinetd_conf.services('telnet') do
      it { should be_disabled }
    end

and

    describe xinetd_conf.services('telnet') do
      its('socket_type') { should include 'stream' }
    end

and

    describe xinetd_conf.services('telnet') do
      its('wait') { should eq 'no' }
    end

All three settings can be tested in the same block as well:

    describe xinetd_conf.services('telnet') do
      it { should be_disabled }
      its('socket_type') { should include 'stream' }
      its('wait') { should eq 'no' }
    end

## Matchers

For a full list of available matchers, please visit our [matchers page](/inspec/matchers/).

### be_enabled

The `be_enabled` matcher tests if a service listed under `/etc/xinet.d` is enabled:

    it { should be_enabled }

### ids

The `ids` matcher tests if the named service is located under `/etc/xinet.d`:

    its('ids') { should include 'service_name' }

For example:

    its('ids') { should include 'chargen-stream chargen-dgram'}

### services

The `services` matcher tests if the named service is listed under `/etc/xinet.d`:

    its('services') { should include 'service_name' }

### socket_types

The `socket_types` matcher tests if a service listed under `/etc/xinet.d` is configured to use the named socket type:

    its('socket_types') { should eq 'socket' }

where `socket` is one of `dgram`, `raw`, or `stream`. For a UDP-based service:

    its('socket_types') { should eq 'dgram' }

For a raw socket (such as a service using a non-standard protocol or a service that requires direct access to IP):

    its('socket_types') { should eq 'raw' }

For a TCP-based service:

    its('socket_types') { should eq 'stream' }

### types

The `types` matcher tests the service type:

    its('type') { should eq 'TYPE' }

where `'TYPE'` is `INTERNAL` (for a service provided by xinetd), `RPC` (for a service based on remote procedure call), or `UNLISTED` (for services not under `/etc/services` or `/etc/rpc`).

### wait

The `wait` matcher tests how a service handles incoming connections.

For UDP (`dgram`) socket types the `wait` matcher should test for `yes`:

    its('socket_types') { should eq 'dgram' }
    its('wait') { should eq 'yes' }

For TCP (`stream`) socket types the `wait` matcher should test for `no`:

    its('socket_types') { should eq 'stream' }
    its('wait') { should eq 'no' }
