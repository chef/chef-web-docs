+++
title = "Compliance Phase"
draft = true

aliases = ["/chef_compliance_phase.html"]

[menu]
  [menu.infra]
    title = "Compliance Phase"
    identifier = "chef_infra/features/chef_compliance_phase.md Compliance Phase"
    parent = "chef_infra/features"
    weight = 80
+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/chef_compliance_phase.md)


The Compliance Phase allows you to run Chef InSpec profiles as part of a Chef Infra client run. It downloads configured profiles from various sources like Chef Automate, Chef Supermarket or git, and reports audit runs to Chef Automate.

## Overview

### Component Architecture
```
 ┌──────────────────────┐    ┌──────────────────────┐    ┌─────────────────────┐
 │  Chef Infra Client   │    │  Chef Infra Server   │    │    Chef Automate    │
 │                      │    │      (optional)      │    │                     │
 │ ┌──────────────────┐ │    │                      │    │                     │
 │ │                  │◀┼────┼──────────────────────┼────│  Profiles           │
 │ │ Compliance Phase │ │    │                      │    │                     │
 │ │                  │─┼────┼──────────────────────┼───▶│  Reports            │
 │ └──────────────────┘ │    │                      │    │                     │
 │                      │    │                      │    │                     │
 └──────────────────────┘    └──────────────────────┘    └─────────────────────┘
```

Chef InSpec Profiles can be hosted from a variety of locations:

```
 ┌──────────────────────┐                                ┌─────────────────────┐
 │  Chef Infra Client   │     ┌───────────────────────┐  │    Chef Automate    │
 │                      │  ┌──│ Profiles(Supermarket, │  │                     │
 │ ┌──────────────────┐ │  │  │ Github, local, etc)   │  │                     │
 │ │                  │◀┼──┘  └───────────────────────┘  │                     │
 │ │ Compliance Phase │◀┼────────────────────────────────│  Profiles           │
 │ │                  │─┼───────────────────────────────▶│  Reports            │
 │ └──────────────────┘ │                                │                     │
 │                      │                                │                     │
 └──────────────────────┘                                └─────────────────────┘
```

## Usage

Compliance Phase needs to be configured for each node where the `chef-client` runs. All node-specific configuration is done via Chef Infra attributes.

### Configuration

#### Profiles

InSpec profiles are specified using the `node['audit']['profiles']` attribute.

##### Automate

```ruby
default['audit']['profiles']['linux-baseline'] = {
  'compliance': 'user/linux-baseline',
  'version': '2.1.0'
}
```

Note: Fetching InSpec profiles from a Chef Automate server will require additional setup for authorization and authentication.

##### Supermarket

```ruby
default['audit']['profiles']['ssh'] = {
  'supermarket': 'hardening/ssh-hardening'
}
```

##### Local paths

```ruby
default['audit']['profiles']['brewinc/win2012_audit'] = {
  'path': 'E:/profiles/win2012_audit'
}
```

##### Git

```ruby
default['audit']['profiles']['ssl'] = {
  'git': 'https://github.com/dev-sec/ssl-benchmark.git'
}
```

##### HTTP

```ruby
default['audit']['profiles']['ssh2'] = {
  'url': 'https://github.com/dev-sec/tests-ssh-hardening/archive/master.zip'
}
```

#### Attributes

You can also pass in Chef InSpec [attributes](https://www.inspec.io/docs/reference/profiles/) to your audit run. Do this by defining the attributes:

```ruby
default['audit']['attributes'] = {
  first_attribute: 'some value',
  second_attribute: 'another value',
}
```

#### Waivers

You can use Chef InSpec's [waivers](https://www.inspec.io/docs/reference/waivers/) to mark individual failing controls as being administratively accepted, either on a temporary or permanent basis. Prepare a waiver file and use your Chef Infra cookbooks to deliver the file to your converging node (for example, using [cookbook_file](https://docs.chef.io/resource_cookbook_file.html) or [remote_file](https://docs.chef.io/resource_remote_file.html)). Then set the attribute `default['audit']['waiver_file']` to the location(s) of the waiver file(s) on the local node, and Chef InSpec will apply the waivers.

#### Insecure

Setting the attribute `default['audit'['waiver_file']` to `true` will skip SSL certificate verification for the `chef-automate` and `chef-server-automate` reporters. Default is `false`

#### Reporters

Add information about specifying reporters.

### Reporting

#### Reporting to Chef Automate via Chef Infra Server

To retrieve Chef InSpec profiles and report to Chef Automate through Chef Infra Server, set the `reporter` and `profiles` attributes.

This requires Chef Infra Server version 12.11.1 and Chef Automate 0.6.6 or newer, as well as integration between the Chef Infra Server and Chef Automate. More details [here](https://docs.chef.io/integrate_compliance_chef_automate.html#collector-chef-server-automate).

To upload profiles, you can use the [Chef Automate API](https://docs.chef.io/api_automate.html) or the `inspec compliance` subcommands.

Attributes example of fetching from Chef Automate, reporting to Chef Automate both via Chef Infra Server:

```ruby
default['audit']['reporter'] = 'chef-server-automate'
default['audit']['fetcher'] = 'chef-server'
default['audit']['profiles']['my-profile'] = {
  'compliance': 'john/my-profile'
}
```

#### Direct reporting to Chef Automate

To report directly to Chef Automate, set the `reporter` attribute to 'chef-automate' and specify where to fetch the `profiles` from.

This method sends the report using the `data_collector.server_url` and `data_collector.token` options defined in `client.rb`. Further information is available at Chef Docs: [Configure a Data Collector token in Chef Automate](https://docs.chef.io/ingest_data_chef_automate.html)

```ruby
default['audit']['reporter'] = 'chef-automate'
default['audit']['profiles']['tmp_compliance_profile'] = {
  'url': 'https://github.com/nathenharvey/tmp_compliance_profile'
}
```

If you are using a self-signed certificate, please also read [how to add the Chef Automate certificate to the trusted_certs directory](https://docs.chef.io/data_collection_without_server.html#add-chef-automate-certificate-to-trusted-certs-directory)

#### Chef InSpec report size limitations

The size of the report being generated from running the Compliance Phase is influenced by a few factors like:
 * number of controls and tests in a profile
 * number of profile failures for the node
 * controls metadata (title, description, tags, etc)
 * number of resources (users, processes, etc) that are being tested

Depending on your setup, there are some limits you need to be aware of. A common one is Chef Infra Server default (1MB) request size. Exceeding this limit will reject the report with `ERROR: 413 "Request Entity Too Large"`. For more details about these limits, please refer to [TROUBLESHOOTING.md](TROUBLESHOOTING.md#413-request-entity-too-large).

#### Write to file on disk

To write the report to a file on disk, simply set the `reporter` to 'json-file' like so:

```ruby
default['audit']['reporter'] = 'json-file'
default['audit']['profiles']['ssh2'] = {
  'path': '/some/base_ssh.tar.gz'
}
```

The resulting file will be written to `node['audit']['json_file']['location']` which defaults to
`<chef_cache_path>/compliance_reports/compliance-<YYYYMMDDHHMMSS>.json`. The path will also be output to
Chef Infra's log:

```
[2017-08-29T00:22:10+00:00] INFO: Reporting to json-file
[2017-08-29T00:22:10+00:00] INFO: Writing report to /opt/kitchen/cache/compliance-reports/compliance-20170829002210.json
[2017-08-29T00:22:10+00:00] INFO: Report handlers complete
```

#### Enforce compliance with executed profiles

The `audit-enforcer` enables you to enforce compliance with executed profiles. If the system under test is determined to be non-compliant, this reporter will raise an error and fail the Chef Infra Client run. To activate compliance enforcement, set the `reporter` attribute to 'audit-enforcer':

```ruby
default['audit']['reporter'] = 'audit-enforcer'
```

Note: Detection of failed controls will immediately terminate the Chef Infra Client run. If you specify multiple reporters, place the `audit-enforcer` at the end of the list, allowing the other reporters to generate their output prior to run termination.

### Profile Fetcher

#### Fetch profiles from Chef Automate via Chef Infra Server

To enable reporting to Chef Automate with profiles from Chef Automate, you need to have Chef Infra Server integrated with [Chef Automate](https://docs.chef.io/integrate_compliance_chef_automate.html#collector-chef-server-automate). You can then set the `fetcher` attribute to 'chef-server'.

This allows the audit cookbook to fetch profiles stored in Chef Automate. For example:

```ruby
default['audit']['reporter'] = 'chef-server-automate'
default['audit']['fetcher'] = 'chef-server'
default['audit']['profiles']['ssh'] = {
  'compliance': 'base/ssh'
}
```

#### Fetch profiles directly from Chef Automate

This method fetches profiles using the `data_collector.server_url` and `data_collector.token` options, in `client.rb`. Further information is available at Chef Docs: [Configure a Data Collector token in Chef Automate](https://docs.chef.io/ingest_data_chef_automate.html)

```ruby
default['audit']['reporter'] = 'chef-automate'
default['audit']['fetcher'] = 'chef-automate'
default['audit']['profiles']['ssh'] = {
  'name': 'ssh',
}
```

## Using Chef node data

While it is recommended that InSpec profiles should be self-contained and not rely on external data unless
necessary, there are valid use cases where a profile's test may exhibit different behavior depending on
aspects of the node under test.

There are two primary ways to pass Chef data to the InSpec run via the audit cookbook.

### Option 1: Explicitly pass necessary data (recommended)

Any data added to the `node['audit']['attributes']` hash will be passed as individual InSpec attributes.
This provides a clean interface between the Chef run and InSpec profile, allowing for easy assignment
of sane default values in the InSpec profile. This method is especially recommended if the InSpec profile
is expected to be used outside of the context of the audit cookbook so it's extra clear to profile
consumers what attributes are necessary.

In a wrapper cookbook or similar, set your Chef attributes:

```ruby
node.normal['audit']['attributes']['key1'] = 'value1'
node.normal['audit']['attributes']['debug_enabled'] = node['my_cookbook']['debug_enabled']
node.normal['audit']['attributes']['environment'] = node.chef_environment
```

... and then use them in your InSpec profile:

```ruby
environment = attribute('environment', description: 'The chef environment for the node', default: 'dev')

control 'debug-disabled-in-production' do
  title 'Debug logs disabled in production'
  desc 'Debug logs contain potentially sensitive information and should not be on in prod.'
  impact 1.0

  describe file('/path/to/my/app/config') do
    its('content') { should_not include "debug=true" }
  end

  only_if { environment == 'production' }
end
```

### Option 2: Use the chef node object

In the event where it is not practical to opt-in to pass certain attributes and data, the audit cookbook will
pass the Chef node object as an InSpec attribute named `chef_node`.

While this provides the ability to write more flexible profiles, it makes it more difficult to reuse profiles
outside of an audit cookbook run, requiring the profile user to know how to pass in a single attribute containing
Chef-like data. Therefore, it is recommended to use Option 1 whenever possible.

To use this option, first enable it in a wrapper cookbook or similar:

```ruby
node.override['audit']['chef_node_attribute_enabled'] = true
```

... and then use it in your profile:

```ruby
chef_node = attribute('chef_node', description: 'Chef Node')

control 'no-password-auth-in-prod' do
  title 'No Password Authentication in Production'
  desc 'Password authentication is allowed in all environments except production'
  impact 1.0

  describe sshd_config do
    its('PasswordAuthentication') { should cmp 'No' }
  end

  only_if { chef_node['chef_environment'] == 'production' }
end
```

## Using the Chef InSpec Backend Cache

InSpec provides the ability to cache the result of commands executed on the node being tested. This drastically improves Chef InSpec performance when slower-running commands are run multiple times during execution.

This feature is **enabled by default** for Compliance Phase. If your profile runs a command multiple times and expects output to be different each time, you may have to disable this feature. To do so, set the `inspec_backend_cache` attribute to `false`:

```ruby
node.normal['audit']['inspec_backend_cache'] = false
```
