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

Compliance Phase runs on any node in your system that is set up--or "bootstrapped"--for a `chef-client` run.

To set up the Compliance Phase as part of your Chef Infra Client run, you'll need to define which Chef InSpec compliance profiles in your cookbooks.

## Set Profiles

Setting one or more Chef InSpec profiles enables the compliance phase in a Chef Infra Client run. The presence of this configuration in your cookbook instructs Chef Infra Client to fetch and execute the specific Chef InSpec profiles and write the results to disk using the default `json-file` reporter.

Retrieve [Chef InSpec profiles]({{< relref "inspec/profiles/" >}}) from Chef Automate, Supermarket, a local file, GitHub, or over HTTP with the `node['audit']['profiles']` attribute.

The following examples:

- Retrieve profiles from Chef Automate, Supermarket, a local file, GitHub, or over HTTP.
- Write the results to disk using the default `json-file` reporter to `<chef_cache_path>/compliance_reports/compliance-<timestamp>.json`.

<!-- markdownlint-disable blanks-around-fences -->

{{< foundation_tabs tabs-id="compliance-phase-profile-panel" >}}
  {{< foundation_tab active="true" panel-link="automate-panel" tab-text="Automate">}}
  {{< foundation_tab panel-link="supermarket-panel" tab-text="Supermarket" >}}
  {{< foundation_tab panel-link="local-path-panel" tab-text="File" >}}
  {{< foundation_tab panel-link="git-panel" tab-text="GitHub" >}}
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
  **Note**: Fetching InSpec profiles from a Chef Automate server requires additional setup for authorization and authentication.
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
  default['audit']['profiles']['4thcafe/win2012_audit'] = {
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

<!-- markdownlint-enable blanks-around-fences -->

## Fetch Profiles

Set the fetcher attribute with `default['audit']['fetcher']` to retrieve InSpec compliance profiles from either Chef Automate or Chef Infra Server in addition to the location defined by `default [audit][profile]`. Left unset, the Compliance Phase defaults to the [fetchers included in Chef InSpec](https://docs.chef.io/inspec/profiles/#profile-dependencies). Chef Infra and Chef InSpec fetchers are mutually exclusive so, you can only use one of these configurations.

The following examples:

- Retrieve the 'ssh' profile from Chef Supermarket.
- Fetch additional profiles from Chef Automate or Chef Server.
- Write the results to disk using the default `json-file` reporter to `<chef_cache_path>/compliance_reports/compliance-<timestamp>.json`.

<!-- markdownlint-disable blanks-around-fences -->

{{< foundation_tabs tabs-id="compliance-phase-fetcher-panel" >}}
  {{< foundation_tab active="true" panel-link="automate-fetcher" tab-text="Automate">}}
  {{< foundation_tab panel-link="server-fetcher" tab-text="Infra Server" >}}
{{< /foundation_tabs >}}
{{< foundation_tabs_panels tabs-id="compliance-phase-fetcher-panel" >}}
  {{< foundation_tabs_panel active="true" panel-id="automate-fetcher" >}}
  ```ruby
  default['audit']['profiles']['ssh'] = {
  'supermarket': 'hardening/ssh-hardening'
  }
  default['audit']['fetcher'] = 'chef-automate'
  ```
  {{< warning >}}
  Fetching profiles from Automate requires setting `data_collector.server_url` and `data_collector.token` in your `client.rb` to fetch profiles from Chef Automate. This configuration is described in more detail in the Chef Automate [data collector documentation](https://docs.chef.io/ingest_data_chef_automate.html).
  {{< /warning >}}
  {{< /foundation_tabs_panel >}}
  {{< foundation_tabs_panel panel-id="server-fetcher" >}}
  ```ruby
  default['audit']['profiles']['ssh'] = {
    'supermarket': 'hardening/ssh-hardening'
  }
  default['audit']['fetcher'] = 'chef-server'
  ```

  {{< warning >}}
  Fetching profiles from Chef Infra Server requires setting `chef_server_url` in your `client.rb`.
  {{< /warning >}}
  {{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}

<!-- markdownlint-enable blanks-around-fences -->

## Reporters

Reporters control what is done with the resulting report after the Chef InSpec run. Either a single value or a list of multiple values is supported. The default is the `json-file` reporter.

Reporters can send Compliance Phase results to:

- Directly to Chef Automate.
- Chef Automate proxied by Chef Infra Server.
- A file on disk.

The following examples:

- Retrieve the 'ssh' profile from Chef Supermarket
- Fetch additional profiles from Chef Automate
- Send the results to Chef Automate, Chef Automate proxied by Chef Infra Server, or to a file on disk.

<!-- markdownlint-disable blanks-around-fences -->

{{< foundation_tabs tabs-id="compliance-phase-reporter-panel" >}}
  {{< foundation_tab active="true" panel-link="automate-reporter" tab-text="Automate">}}
  {{< foundation_tab panel-link="server-reporter" tab-text="Automate via Infra Server" >}}
  {{< foundation_tab panel-link="local-reporter" tab-text="File" >}}
{{< /foundation_tabs >}}
{{< foundation_tabs_panels tabs-id="compliance-phase-reporter-panel" >}}
  {{< foundation_tabs_panel active="true" panel-id="automate-reporter" >}}
  ```ruby
  default['audit']['profiles']['ssh'] = {
  'supermarket': 'hardening/ssh-hardening'
  }
  default['audit']['fetcher'] = 'chef-automate'
  default['audit']['reporter'] = 'chef-automate'
  ```
  {{< warning >}}
  Reporting Compliance Phase results directly to Chef Automate requires setting `data_collector.server_url` and `data_collector.token` in your `client.rb` to fetch profiles from Chef Automate. This configuration is described in more detail in the Chef Automate [data collector documentation](https://docs.chef.io/ingest_data_chef_automate.html).
  {{< /warning >}}
  {{< /foundation_tabs_panel >}}
  {{< foundation_tabs_panel panel-id="server-reporter" >}}
  ```ruby
  default['audit']['profiles']['ssh'] = {
    'supermarket': 'hardening/ssh-hardening'
  }
  default['audit']['fetcher'] = 'chef-automate'
  default['audit']['reporter'] = 'chef-server-automate'
  ```

  {{< warning >}}

  This requires Chef Infra Server version 12.11.1 and Chef Automate 0.6.6 or newer, as well as [integration between the Chef Infra Server and Chef Automate](https://docs.chef.io/automate/data_collection/#configure-your-chef-infra-server-to-send-data-to-chef-automate).

  {{</ warning >}}
  {{< /foundation_tabs_panel >}}
    {{< foundation_tabs_panel panel-id="local-reporter" >}}
  ```ruby
  default['audit']['profiles']['ssh'] = {
    'supermarket': 'hardening/ssh-hardening'
  }
  default['audit']['fetcher'] = 'chef-automate'
  default['audit']['reporter'] = 'json-file'
  default['audit']['json_file']['location'] = '/file/path/report.json'
  ```

  Default `json_file` path: `<chef_cache_path>/compliance_reports/compliance-<timestamp>.json`.

  The path will also be output to the Chef Infra Client log:

  ```bash
  [2017-08-29T00:22:10+00:00] INFO: Reporting to json-file
  [2017-08-29T00:22:10+00:00] INFO: Writing report to /opt/kitchen/cache/compliance-reports/compliance-20170829002210.json
  [2017-08-29T00:22:10+00:00] INFO: Report handlers complete
  ```

  {{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}

<!-- markdownlint-enable blanks-around-fences -->

## Customize Profiles

TODO: Find a place for this line

To upload profiles to Chef Automate, use the [Chef Automate API](https://docs.chef.io/automate/api/#operation/Create) or the `inspec compliance` command.

### Waivers

[Waivers](https://docs.chef.io/inspec/waivers/) mark individual failing controls as administratively accepted, either on a temporary or permanent basis. To use waivers, prepare a waiver file and deliver it to the node in a [cookbook_file](https://docs.chef.io/resources/cookbook_file/) or [remote_file](https://docs.chef.io/resources/remote_file/) and set the `waiver_file` attribute for the compliance phase to that location. Example:

```ruby
default['audit']['waiver_file'] = "waivers.yaml"
```

### External Data

[Inputs](https://docs.chef.io/inspec/inputs/) let you customize the behavior of Chef InSpec profiles.
Chef InSpec inputs are named ['audit']['attributes'].
TODO: This next sentence may be inaccurate. Is it true for just hashes?.
Any data added to `['audit']['attributes']` is passed as individual Chef InSpec attributes.

#### InSpec Input

You can pass [Chef InSpec inputs](https://docs.chef.io/inspec/inputs/) to the Chef InSpec runner. The Chef InSpec input is named 'attributes' for backward compatibility reasons.

  ```ruby
  default['audit']['attributes'] = {
    first_input: 'some value',
    second_input: 'another value',
  }
  ```

#### Chef Node Data

While it is recommended that InSpec profiles should be self-contained and not rely on external data unless necessary, there are valid use cases where a profile's test may exhibit different behavior depending on aspects of the node under test.

There are two primary ways to pass Chef Infra node data to Chef InSpec run during the compliance phase.

#### Explicitly pass necessary data (recommended)

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

#### Use the Chef Infra Node Object

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
