+++
title = "Compliance Phase Configuration"
draft = false

[menu]
  [menu.infra]
    title = "Compliance Phase Configuration"
    identifier = "chef_infra/compliance_phase_config.md Compliance Phase"
    parent = "chef_infra"
    weight = 10
+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/chef_compliance_phase.md)

Compliance Phase runs on any node in your system that is set up--or "bootstrapped"--for a `chef-client` run. Just as you defined the configuration for each node with attributes in your cookbooks, you'll also need to define which Chef InSpec compliance profiles to run on each node with attributes in your cookbooks. In the simplest form, specifying one or more Chef InSpec profiles in your attributes enables the compliance phase in a Chef Infra Client run. This simple configuration causes the Chef Infra Client to fetch and execute the specific Chef InSpec profiles and write the results to disk using the default `json-file` reporter.

You can fetch [Chef InSpec profiles]({{< relref "inspec/profiles/" >}}) from several different locations using the `node['audit']['profiles']` attribute.
For example:
{{< foundation_tabs tabs-id="compliance-phase-profile-panel" >}}
  {{< foundation_tab active="true" panel-link="automate-panel" tab-text="Automate">}}
  {{< foundation_tab panel-link="supermarket-panel" tab-text="Supermarket" >}}
  {{< foundation_tab panel-link="local-path-panel" tab-text="local path" >}}
  {{< foundation_tab panel-link="git-panel" tab-text="Git" >}}
  {{< foundation_tab panel-link="http-panel" tab-text="HTTP" >}}
{{< /foundation_tabs >}}
{{< foundation_tabs_panels tabs-id="compliance-phase-profile-panel" >}}
  {{< foundation_tabs_panel active="true" panel-id="automate-panel" >}}
  ```ruby
  default['audit']['profiles']['linux-baseline'] = {
    'compliance': 'user/linux-baseline',
    'version': '2.1.0'
  }
  ```
  **Note**: Fetching InSpec profiles from a Chef Automate server will require additional setup for authorization and authentication.
  {{< /foundation_tabs_panel >}}
  {{< foundation_tabs_panel panel-id="supermarket-panel" >}}
  ```ruby
  default['audit']['profiles']['ssh'] = {
    'supermarket': 'hardening/ssh-hardening'
  }
  ```
  {{< /foundation_tabs_panel >}}
  {{< foundation_tabs_panel panel-id="local-path-panel" >}}
  ```ruby
  default['audit']['profiles']['brewinc/win2012_audit'] = {
    'path': 'E:/profiles/win2012_audit'
  }
  ```
  {{< /foundation_tabs_panel >}}
  {{< foundation_tabs_panel panel-id="git-panel" >}}
  ```ruby
  default['audit']['profiles']['ssl'] = {
    'git': 'https://github.com/dev-sec/ssl-benchmark.git'
  }
  ```
  {{< /foundation_tabs_panel >}}
  {{< foundation_tabs_panel panel-id="http-panel" >}}
  ```ruby
  default['audit']['profiles']['ssh2'] = {
    'url': 'https://github.com/dev-sec/tests-ssh-hardening/archive/master.zip'
  }
  ```
  {{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}


## External Data in the Compliance Phase

[Input](https://docs.chef.io/inspec/inputs/) let you customize the behavior of Chef InSpec profiles. If a profile supports inputs, you can set the inputs in a variety of ways, allowing flexibility.

You can pass [Chef InSpec inputs](https://docs.chef.io/inspec/inputs/) to the Chef InSpec runner. The attribute key is confusingly called 'attributes' for backward compatibility reasons.

  ```ruby
  default['audit']['attributes'] = {
    first_input: 'some value',
    second_input: 'another value',
  }
  ```

### Chef Node Data

While it is recommended that InSpec profiles should be self-contained and not rely on external data unless necessary, there are valid use cases where a profile's test may exhibit different behavior depending on aspects of the node under test.

There are two primary ways to pass Chef Infra node data to Chef InSpec run during the compliance phase.

### Explicitly pass necessary data (recommended)

Any data added to the `node['audit']['attributes']` hash will be passed as individual Chef InSpec attributes.
This provides a clean interface between the Chef Infra client run and Chef InSpec profile, allowing for easy assignment
of default values in the InSpec profile. This method is especially recommended if the Chef InSpec profile is expected to be used outside of the context of Compliance Phase so it's made explicit to profile consumers what attributes are necessary.

In a wrapper cookbook or similar, set your Chef Infra attributes:

```ruby
node.normal['audit']['attributes']['key1'] = 'value1'
node.normal['audit']['attributes']['debug_enabled'] = node['my_cookbook']['debug_enabled']
node.normal['audit']['attributes']['environment'] = node.chef_environment
```

... and then use them in your Chef InSpec profile:

```ruby
environment = attribute('environment', description: 'The Chef Infra environment for the node', default: 'dev')

control 'debug-disabled-in-production' do
  title 'Debug logs disabled in production'
  desc 'Debug logs contain potentially sensitive information and should not be on in production.'
  impact 1.0

  describe file('/path/to/my/app/config') do
    its('content') { should_not include "debug=true" }
  end

  only_if { environment == 'production' }
end
```

### Use the Chef Infra Node Object

In the event that it is not practical to opt-in to pass attributes and data, Compliance Phase can be configured to
pass the Chef Infra node object as a Chef InSpec attribute named `chef_node`.

While this provides the ability to write more flexible profiles, it makes it more difficult to reuse profiles
outside of Compliance Phase, requiring the Chef InSpec profile user to know how to pass in a single attribute containing
Chef Infra-like data. Therefore, it is recommended to use Option 1 whenever possible.

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

## Fetchers

Fetchers control if Chef InSpec profiles should be fetched from Chef Automate or Chef Infra Server in addition to the default fetch locations provided by Chef Inspec. Set this attribute with `default['audit']['fetcher']`. Accepted values: 'chef-server' or 'chef-automate'. With nothing specified for this attribute the [fetchers included in Chef InSpec](https://docs.chef.io/inspec/profiles/#profile-dependencies) are used. The fetchers included with Chef Infra are mutually exclusive so only one value can be specified for this attribute.

### Fetcher Attributes

#### chef-automate

Fetches Chef InSpec profiles from a Chef Automate instance. Enabled by setting the attribute `default['audit']['fetcher']` to `chef-automate`. Requires that the `data_collector.server_url` and `data_collector.token` options are set in `client.rb`, [described in more detail in the Chef Automate data collector documentation](https://docs.chef.io/ingest_data_chef_automate.html). More information on using the Chef Automate fetcher can be found in the [section on integrating Compliance Phase with Chef Automate](#fetch-profiles-directly-from-chef-automate).

#### chef-server

Fetches Chef InSpec profiles from a Chef Automate instance proxied with Chef Infra Server. Enabled by setting the attribute `default['audit']['fetcher']` to `chef-server`. Requires that the `chef_server_url` option is set in `client.rb`. More information on using the Chef Infra Server fetcher can be found in the [section on integrating Compliance Phase with Chef Automate via Chef Infra Server](#fetch-profiles-from-chef-automate-via-chef-infra-server).

### Fetch profiles from Chef Automate via Chef Infra Server

To enable reporting to Chef Automate with profiles from Chef Automate, you need to have Chef Infra Server integrated with [Chef Automate](https://docs.chef.io/automate/data_collection/#configure-your-chef-infra-server-to-send-data-to-chef-automate). You can then set the `fetcher` attribute to 'chef-server'.

This allows Compliance Phase to fetch profiles stored in Chef Automate. For example:

```ruby
default['audit']['reporter'] = 'chef-server-automate'
default['audit']['fetcher'] = 'chef-server'
default['audit']['profiles']['ssh'] = {
  'compliance': 'base/ssh'
}
```

### Fetch profiles directly from Chef Automate

This method fetches Chef InSpec profiles using the `data_collector.server_url` and `data_collector.token` options defined in `client.rb`. Further information is available in the [Chef Automate data collection documentation](https://docs.chef.io/automate/data_collection/#configure-your-chef-infra-client-to-send-data-to-chef-automate-without-chef-infra-server).

```ruby
default['audit']['reporter'] = 'chef-automate'
default['audit']['fetcher'] = 'chef-automate'
default['audit']['profiles']['ssh'] = {
  'name': 'ssh',
}
```

## Reporters

Reporters control what is done with the resulting report after the Chef InSpec run. Either a single value or a list of multiple values is supported. The default is the `json-file` reporter.

### Reporter Attributes

#### chef-automate

Sends the results to a Chef Automate instance. Example: `default['audit']['reporter'] = 'chef-automate'`. See the instructions on [using Chef Infra Server with Compliance Phase](#reporting-to-chef-automate-via-chef-infra-server) for more details.

#### chef-server-automate

Sends the results to a Chef Automate proxied by a Chef Infra Server instance. Example: `default['audit']['reporter'] = 'chef-server-automate'`. See the instructions on [using Chef Infra Server with Compliance Phase](#reporting-to-chef-automate-via-chef-infra-server) for more details.

#### json-file

Writes the results to disk in the location specified by the `json-file` attribute. Set this attribute with `default['audit']['json-file']['location']`. Example: (reporter) default['audit']['reporter'] = 'json-file'; (attribute) default['audit']['json_file']['location'] = 'custom/file/path/report.json'). Defaults to: `<chef_cache_path>/compliance_reports/compliance-<timestamp>.json`.

### Send Reports to Chef Automate

This method sends the report using the `data_collector.server_url` and `data_collector.token` options defined in `client.rb`. Further information is available in the [Chef Automate data collection documentation](https://docs.chef.io/automate/data_collection/#configure-your-chef-infra-client-to-send-data-to-chef-automate-without-chef-infra-server).

This is an example of attributes configuring Compliance Phase to fetch a Chef InSpec profile from GitHub and send reports to Chef Automate:

```ruby
default['audit']['reporter'] = 'chef-automate'
default['audit']['profiles']['tmp_compliance_profile'] = {
  'url': 'https://github.com/nathenharvey/tmp_compliance_profile'
}
```

### Send Reports to Chef Automate via Chef Infra Server

This requires Chef Infra Server version 12.11.1 and Chef Automate 0.6.6 or newer, as well as [integration between the Chef Infra Server and Chef Automate](https://docs.chef.io/automate/data_collection/#configure-your-chef-infra-server-to-send-data-to-chef-automate).

To upload profiles, you can use the [Chef Automate API](https://docs.chef.io/automate/api/#operation/Create) or the `inspec compliance` subcommands.

This is an example of attributes configuring Compliance Phase to fetch Chef InSpec profiles from Chef Automate and send reports to Chef Automate both via Chef Infra Server:

```ruby
default['audit']['reporter'] = 'chef-server-automate'
default['audit']['fetcher'] = 'chef-server'
default['audit']['profiles']['my-profile'] = {
  'compliance': 'john/my-profile'
}
```

### Save Report to File on Disk

To write the report to a file on disk, set the `reporter` to 'json-file' like so:

```ruby
default['audit']['reporter'] = 'json-file'
default['audit']['profiles']['ssh2'] = {
  'path': '/some/base_ssh.tar.gz'
}
```

The resulting file will be written to `node['audit']['json_file']['location']` which defaults to
`<chef_cache_path>/compliance_reports/compliance-<YYYYMMDDHHMMSS>.json`.
The path will also be output to Chef Infra's log:

```
[2017-08-29T00:22:10+00:00] INFO: Reporting to json-file
[2017-08-29T00:22:10+00:00] INFO: Writing report to /opt/kitchen/cache/compliance-reports/compliance-20170829002210.json
[2017-08-29T00:22:10+00:00] INFO: Report handlers complete
```

## Waivers

[Waivers](https://docs.chef.io/inspec/waivers/) mark individual failing controls as administratively accepted, either on a temporary or permanent basis. To use waivers, prepare a waiver file and deliver it to the node in a [cookbook_file](https://docs.chef.io/resources/cookbook_file/) or [remote_file](https://docs.chef.io/resources/remote_file/) and set the `waiver_file` attribute for the compliance phase to that location. Example:

```ruby
default['audit']['waiver_file'] = "waivers.yaml"
```
