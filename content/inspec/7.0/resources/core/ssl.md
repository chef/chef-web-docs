+++
title = "ssl resource"
draft = false

platform = "os"

[menu.inspec_7_0]
    title = "ssl"
    identifier = "resources/core/ssl.md ssl resource"
    parent = "resources/core"
+++

Use the `ssl` Chef InSpec audit resource to test SSL settings for the named port.

## Availability

### Install

{{< readfile file="content/inspec/7.0/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

An `ssl` resource block declares an SSL port, and then other properties of the test like cipher and/or protocol:

```ruby
describe ssl(port: #) do
  it { should be_enabled }
end
```

or:

```ruby
describe ssl(port: #).filter('value') do
  it { should be_enabled }
end
```

where:

- `ssl(port: #)` is the port number, such as `ssl(port: 443)`
- `filter` may take any of the following arguments: `ciphers`, `protocols`, and `handshake`

## Properties

### ciphers

The `ciphers` property tests the named cipher:

```ruby
its('ciphers') { should_not eq '/rc4/i' }
```

or:

```ruby
describe ssl(port: 443).ciphers(/rc4/i) do
  it { should_not be_enabled }
end
```

### protocols

The `protocols` property tests what protocol versions (SSLv3, TLSv1.1, etc) are enabled:

```ruby
its('protocols') { should eq 'ssl2' }
```

or:

```ruby
describe ssl(port: 443).protocols('ssl2') do
  it { should_not be_enabled }
end
```

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Run the ssl-baseline example profile

The following shows how to use the `ssl` Chef InSpec audit resource to find all TCP ports on the system, including IPv4 and IPv6. (This is a partial example based on the `ssl_text.rb` file in the `ssl-baseline` profile on GitHub.)

```ruby
control 'tls1.2' do
  title 'Run TLS 1.2 whenever SSL is active on a port'
  impact 0.5

  sslports.each do |socket|
    proc_desc = "on node == #{command('hostname').stdout.strip} running #{socket.process.inspect} (#{socket.pid})"
    describe ssl(port: socket.port).protocols('tls1.2') do
      it(proc_desc) { should be_enabled }
      it { should be_enabled }
    end
  end
end

...

control 'rc4' do
  title 'Disable RC4 ciphers from all exposed SSL/TLS ports and versions.'
  impact 0.5

  sslports.each do |socket|
    proc_desc = "on node == #{command('hostname').stdout.strip} running #{socket.process.inspect} (#{socket.pid})"
    describe ssl(port: socket.port).ciphers(/rc4/i) do
      it(proc_desc) { should_not be_enabled }
      it { should_not be_enabled }
    end
  end
end
```

You can run the `ssl-baseline` example profile to test SSL using the following methods:

Clone the profile:

```sh
git clone https://github.com/dev-sec/ssl-baseline
```

and then run:

```sh
inspec exec ssl-baseline
```

Or execute the profile directly from a URL:

```sh
inspec exec https://github.com/dev-sec/ssl-baseline
```

## Matchers

{{< readfile file="content/inspec/7.0/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### be_enabled

The `be_enabled` matcher tests if SSL is enabled:

```ruby
it { should be_enabled }
```

### ciphers

The `ciphers` matcher tests the named cipher:

```ruby
its('ciphers') { should_not eq '/rc4/i' }
```

or:

```ruby
describe ssl(port: 443).ciphers(/rc4/i) do
  it { should_not be_enabled }
end
```

### protocols

The `protocols` matcher tests what protocol versions (SSLv3, TLSv1.1, etc) are enabled:

```ruby
its('protocols') { should eq 'ssl2' }
```

or:

```ruby
describe ssl(port: 443).protocols('ssl2') do
  it { should_not be_enabled }
end
```

Supported protocols:

- `ssl2`
- `ssl3`
- `tls1.0`
- `tls1.1`
- `tls1.2`
- `tls1.3`
