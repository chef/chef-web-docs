+++
title = "Compliance Phase"
draft = false

[menu]
  [menu.infra]
    title = "Compliance Phase"
    identifier = "chef_infra/compliance_phase/chef_compliance_phase.md Compliance Phase"
    parent = "chef_infra/compliance_phase"
    weight = 10
+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/chef_compliance_phase.md)

The compliance phase is the third part of a Chef Infra Client run. First, the configuration phase gathers and organizes your infrastructure settings that you described in your cookbooks. Second, the converge phase applies your configuration to the devices, or "nodes", in your infrastructure. Third, the compliance phase scans your infrastructure settings to check that they meet the security standards that you defined as Chef InSpec profiles in your cookbooks.

During the compliance phase, the Chef Infra Client:

* downloads profiles from Chef Automate, Chef Supermarket, GitHub, or your local system
* scans the settings for each node object
* reports the results to Chef Automate or saves them locally.

The compliance phase is the next evolution of the [audit cookbook](https://github.com/chef-cookbooks/audit). You should be able to remove the audit cookbook from your node runlists and get the same results as you did previously.

## Compliance Phase Configuration

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
