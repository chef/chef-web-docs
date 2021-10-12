+++
title = "About the Compliance Phase"
draft = false

[menu]
  [menu.infra]
    title = "Compliance Phase"
    identifier = "chef_infra/features/chef_compliance_phase.md Compliance Phase"
    parent = "chef_infra/features"
    weight = 15

+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/main/content/chef_compliance_phase.md)

Chef Infra Client's Compliance Phase lets you automatically execute compliance audits and view the results as part of any Chef Infra Client run. The Compliance Phase of the Chef Infra Client run replaces the legacy [audit cookbook](https://supermarket.chef.io/cookbooks/audit) and works with your existing audit cookbook attributes, and you can also set it up for new cookbooks. This additional phase gives you the latest compliance capabilities without having to manage cookbook dependencies or juggle versions during Chef Infra Client updates.

Existing audit cookbook users can migrate to the new Compliance Phase by removing the audit cookbook from their run_list and setting the `node['audit']['compliance_phase']` attribute to `true`.

The Compliance Phase replaces the `audit cookbook` by integrating InSpec compliance checks into the [Chef Infra Client run]({{< relref "chef_client_overview.md" >}})
The Compliance Phase is designed to run on any node in your system that is set up--or ["bootstrapped"]({{< relref "install_bootstrap" >}})--for a `chef-client` run.

## Upgrade to Compliance Phase from Audit Cookbook

The Compliance Phase requires Chef Infra Client 17 or higher.

If your system is configured to use the `audit cookbook`, make these changes to switch to the Compliance Phase:

1. Set the `node['audit']['compliance_phase']` attribute to `true` through a Policyfile or cookbook attributes file.
1. Remove the `audit cookbook` from your ['run-list']({{< relref "run_lists.md" >}}).

1. On your next Chef Infra Client run, you should see the Compliance Phase results.

## Set up the Compliance Phase in new Cookbooks

### Enable the Compliance Phase

The Compliance Phase is enabled by setting the `node['audit']['compliance_phase']` attribute to `true` through cookbook attributes or Policyfiles. To enable Compliance Phase using cookbook atttributes add the following line to the `attributes/default.rb` file in your cookbook.

```ruby
default['audit']['compliance_phase'] = true
```

### Set InSpec Profiles

Setting one or more Chef InSpec profiles enables the compliance phase in a Chef Infra Client run. The presence of this configuration in your attributes file instructs Chef Infra Client to fetch and execute the specific Chef InSpec profiles and write the results to disk using the default `cli` and `json-file` reporters.

Retrieve ['Chef InSpec profiles']({{< relref "inspec/profiles/" >}}) from Chef Automate, Supermarket, a local file, GitHub, or over HTTP with the `node['audit']['profiles']` attribute.

The following examples:

- Retrieve profiles from Chef Automate, Supermarket, a local file, GitHub, or over HTTP.
- Display the results on the command line using the default `cli` reporter.
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
  # Invoke the Compliance Phase
  default['audit']['compliance_phase'] = true
  # Set profile locations
  default['audit']['profiles']['linux-baseline'] = {
    'compliance': 'user/linux-baseline',
    'version': '2.1.0'
  }
  ```
  {{< warning >}}
  Fetching profiles from Automate requires setting `data_collector.server_url` and `data_collector.token` in your `client.rb` to fetch profiles from Chef Automate. This configuration is described in more detail in the Chef Automate [data collector documentation]({{< relref "automate/data_collection/" >}}).
  {{< /warning >}}
  {{< /foundation_tabs_panel >}}
  {{< foundation_tabs_panel panel-id="supermarket-panel" >}}
  ```ruby
  # Invoke the Compliance Phase
  default['audit']['compliance_phase'] = true
  # Set profile locations
  default['audit']['profiles']['ssh'] = {
    'supermarket': 'hardening/ssh-hardening'
  }
  ```
  {{< /foundation_tabs_panel >}}
  {{< foundation_tabs_panel panel-id="local-path-panel" >}}
  ```ruby
  # Invoke the Compliance Phase
  default['audit']['compliance_phase'] = true
  # Set profile locations
  default['audit']['profiles']['4thcafe/win2012_audit'] = {
    'path': 'E:/profiles/win2012_audit'
  }
  ```
  {{< /foundation_tabs_panel >}}
  {{< foundation_tabs_panel panel-id="git-panel" >}}
  ```ruby
  # Invoke the Compliance Phase
  default['audit']['compliance_phase'] = true
  # Set profile locations
  default['audit']['profiles']['ssl'] = {
    'git': 'https://github.com/dev-sec/ssl-benchmark.git'
  }
  ```
  {{< /foundation_tabs_panel >}}
  {{< foundation_tabs_panel panel-id="http-panel" >}}
  ```ruby
  # Invoke the Compliance Phase
  default['audit']['compliance_phase'] = true
  # Set profile locations
  default['audit']['profiles']['ssh2'] = {
    'url': 'https://github.com/dev-sec/tests-ssh-hardening/archive/master.zip'
  }
  ```
  {{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}

<!-- markdownlint-enable blanks-around-fences -->

### Fetch Profiles

Set the fetcher attribute with `default['audit']['fetcher']` to retrieve InSpec compliance profiles from either Chef Automate or Chef Infra Server in addition to the location defined by `default ['audit']['profile']`. Left unset, the Compliance Phase defaults to the [fetchers included in Chef InSpec](https://docs.chef.io/inspec/profiles/#profile-dependencies). Chef Infra and Chef InSpec fetchers are mutually exclusive so, you can only use one of these configurations.

The following examples:

- Retrieve the 'ssh' profile from Chef Supermarket.
- Fetch additional profiles from Chef Automate or Chef Server.
- Display the results on the command line using the default `cli` reporter.
- Write the results to disk using the default `json-file` reporter to `<chef_cache_path>/compliance_reports/compliance-<timestamp>.json`.

<!-- markdownlint-disable blanks-around-fences -->

{{< foundation_tabs tabs-id="compliance-phase-fetcher-panel" >}}
  {{< foundation_tab active="true" panel-link="automate-fetcher" tab-text="Automate">}}
  {{< foundation_tab panel-link="server-fetcher" tab-text="Infra Server" >}}
{{< /foundation_tabs >}}
{{< foundation_tabs_panels tabs-id="compliance-phase-fetcher-panel" >}}
  {{< foundation_tabs_panel active="true" panel-id="automate-fetcher" >}}
  ```ruby
  # Invoke the Compliance Phase
  default['audit']['compliance_phase'] = true
  # Set profile location
  default['audit']['profiles']['ssh'] = {
  'supermarket': 'hardening/ssh-hardening'
  }
  # Fetch additional profiles
  default['audit']['fetcher'] = 'chef-automate'
  ```
  {{< warning >}}
  Fetching profiles from Automate requires setting `data_collector.server_url` and `data_collector.token` in your `client.rb` to fetch profiles from Chef Automate. This configuration is described in more detail in the Chef Automate [data collector documentation]({{< relref "automate/data_collection/" >}}).
  {{< /warning >}}
  {{< /foundation_tabs_panel >}}
  {{< foundation_tabs_panel panel-id="server-fetcher" >}}
  ```ruby
  # Invoke the Compliance Phase
  default['audit']['compliance_phase'] = true
  # Set profile location
  default['audit']['profiles']['ssh'] = {
  'supermarket': 'hardening/ssh-hardening'
  }
  # Fetch additional profiles
  default['audit']['fetcher'] = 'chef-server'
  ```
  {{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}

<!-- markdownlint-enable blanks-around-fences -->

### Reporters

Reporters control what is done with the resulting report after the Chef InSpec run. Either a single value or a list of multiple values is supported. The default is the `cli` and `json-file` reporters.

Reporters can send Compliance Phase results to:

- Chef Automate proxied by Chef Infra Server.
- Directly to Chef Automate (requires additional authentication).
- The terminal if Chef Infra Client is run interactively by a user.
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
  # Invoke the Compliance Phase
  default['audit']['compliance_phase'] = true
  # Set profile location
  default['audit']['profiles']['ssh'] = {
  'supermarket': 'hardening/ssh-hardening'
  }
  # Fetch additional profiles
  default['audit']['fetcher'] = 'chef-automate'
  # Set reporter
  default['audit']['reporter'] = 'chef-automate'
  ```
  {{< warning >}}
  Reporting Compliance Phase results directly to Chef Automate requires setting `data_collector.server_url` and `data_collector.token` in your `client.rb` to fetch profiles from Chef Automate. This configuration is described in more detail in the Chef Automate ['data collector documentation']({{< relref "automate/data_collection/" >}}).
  {{< /warning >}}
  {{< /foundation_tabs_panel >}}
  {{< foundation_tabs_panel panel-id="server-reporter" >}}
  ```ruby
  # Invoke the Compliance Phase
  default['audit']['compliance_phase'] = true
  # Set profile location
  default['audit']['profiles']['ssh'] = {
  'supermarket': 'hardening/ssh-hardening'
  }
  # Fetch additional profiles
  default['audit']['fetcher'] = 'chef-automate'
  # Set reporter
  default['audit']['reporter'] = 'chef-server-automate'
  ```

  {{< warning >}}

  This requires Chef Infra Server version 12.11.1 and Chef Automate 0.6.6 or newer, as well as ['integration between the Chef Infra Server and Chef Automate'](https://docs.chef.io/automate/data_collection/#configure-your-chef-infra-server-to-send-data-to-chef-automate).

  {{</ warning >}}
  {{< /foundation_tabs_panel >}}
    {{< foundation_tabs_panel panel-id="local-reporter" >}}
  ```ruby
  # Invoke the Compliance Phase
  default['audit']['compliance_phase'] = true
  # Set profile location
  default['audit']['profiles']['ssh'] = {
  'supermarket': 'hardening/ssh-hardening'
  }
  # Fetch additional profiles
  default['audit']['fetcher'] = 'chef-automate'
  # Set two reporters
  default['audit']['reporter'] = 'json-file', 'cli'
  # Set the location of the json-file output
  # Note that the location attribute uses json_file
  default['audit']['json_file']['location'] = '/file/path/report.json'
  ```

  The default `json-file` path is: `<chef_cache_path>/compliance_reports/compliance-<timestamp>.json`.

  The path will also be output to the Chef Infra Client log:

  ```bash
  ['2017-08-29T00:22:10+00:00'] INFO: Reporting to json-file
  ['2017-08-29T00:22:10+00:00'] INFO: Writing report to /opt/kitchen/cache/compliance-reports/compliance-20170829002210.json
  ['2017-08-29T00:22:10+00:00'] INFO: Report handlers complete
  ```

  {{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}

<!-- markdownlint-enable blanks-around-fences -->

## Customize Profiles

You can upload profiles to Chef Automate using the ['Chef Automate API'](https://docs.chef.io/automate/api/#operation/Create) or the `inspec compliance` command.

### Waivers

Use ['waivers'](https://docs.chef.io/inspec/waivers/) to mark individual failing controls as administratively accepted, either on a temporary or permanent basis.

To use waivers:

1. Prepare a YAML waiver file.
1. Deliver the waiver file to the node in a ['cookbook_file'](https://docs.chef.io/resources/cookbook_file/) or ['remote_file'](https://docs.chef.io/resources/remote_file/).
1. Set the `waiver_file` attribute for the compliance phase to that location. For example:

```ruby
default['audit']['waiver_file'] = "waivers.yaml"
```

### External Data

InSpec profiles should be self-contained and independent from external data. In some cases, a profile's test may exhibit different behavior depending on aspects of the node being tested and in these cases, you may want to use external data. Chef InSpec profiles accept ['inputs'](https://docs.chef.io/inspec/inputs/) that let you customize the test.

#### InSpec Input

You can pass ['Chef InSpec inputs'](https://docs.chef.io/inspec/inputs/) to the Chef InSpec runner. Chef InSpec inputs were previously called `attributes` and you will set them in an `['audit']['attributes']` hash in your attributes file.
Any data added to `['audit']['attributes']` as a hash is passed to Chef InSpec as individual attributes.

  ```ruby
  default['audit']['attributes'] = {
    first_input: 'some value',
    second_input: 'another value',
  }
  ```

#### Chef Node Data

There are two primary ways to pass Chef Infra node data to Chef InSpec run during the compliance phase.

##### Explicitly pass necessary data (recommended)

Any data added to the `node['audit']['attributes']` hash will be passed as individual Chef InSpec attributes. This provides a clean interface between the Chef Infra client run and Chef InSpec profile, allowing for easy assignment of default values in the InSpec profile. This method is especially recommended if the Chef InSpec profile is expected to be used outside of the context of Compliance Phase so it's made explicit to profile consumers what attributes are necessary. Set the attributes in your cookbook attributes file and then use them in your InSpec profile.

Set the attributes in a cookbook attributes file:

```ruby
node['audit']['attributes']{
  'key1' = 'value1',
  'debug_enabled' = node['my_cookbook']['debug_enabled'],
  'environment' = node.chef_environment
}
```

Use the attributes in an InSpec profile:

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

Compliance Phase can be configured to pass the Chef Infra node object as a Chef InSpec attribute named `chef_node`.

While using the `chef_node` object provides the ability to write more flexible profiles, it is very difficult to reuse these profiles outside of the Compliance Phase. To reuse these profiles, you will need to understand how to pass in a single attribute containing Chef Infra-like data. We recommend passing external data explicitly whenever possible.

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

## Useful Compliance Phase Attributes

### audit-enforcer

A special reporter that causes the compliance run to raise an error and immediately terminates the Chef Infra Client run if any control of any Chef InSpec profile fails. If you specify multiple reporters, place the `audit-enforcer` at the end of the list, allowing the other reporters to generate their output prior to run termination. Example:

```ruby
# fail on error
default['audit']['reporter'] = 'audit-enforcer'.
```

### chef_node_attribute_enabled

If enabled, a hash representation of the Chef Infra node object will be sent to an input named `chef_node`. Default: false

```ruby
# enable sending a hash representation of the Chef Infra node object
default['audit']['chef_node_attribute_enabled'] = true
```

### compliance_phase

Enable the built-in compliance phase run. Possible values: true, false, nil

```ruby
# Turn on Compliance Phase
default['audit']['compliance_phase] = true
```

### control_results_limit

The list of results per control will be truncated to this amount to reduce the size of reports. A summary of removed results will be sent with each impacted control. Defaults to `50`.

```ruby
# allow 100 results
 default['audit']['control_results_limit'] = 100
```

### fetcher

Controls the location for additional profile locations for Chef InSpec profiles default fetch locations provided through the `[audit][profiles]` attribute. Accepted values: nil, 'chef-server', 'chef-automate'.

```ruby
# fetch additional profiles from Chef Server
default[audit][fetcher] = 'chef-server'
```

### insecure

Setting the attribute `default['audit']['insecure']` to `true` will skip SSL certificate verification for the `chef-automate` and `chef-server-automate` reporters. This allows connections to HTTPS endpoints with self-signed ssl certificates. Default is `false`

```ruby
# allow self-signed certificates
default['audit']['insecure'] = true
```

### json_file

The location on disk that Chef InSpec's json reports are saved to when using the 'json-file' reporter. Defaults to: `<chef_cache_path>/compliance_reports/compliance-<timestamp>.json`

```ruby
default['audit']['reporter'] = 'json-file'
default['audit']['json_file']['location'] = '/path/to/file.json'
```

### inspec_backend_cache

Chef InSpec caches the results of commands executed on the node during the compliance phase. Caching improves the compliance phase performance when slower-running commands are executed multiple times during a Chef Infra Client run. Disable this feature if your Chef InSpec profile runs a command multiple times expecting different output during the run. Default: true. Example:

```ruby
# Disable caching of commands
default['audit']['inspec_backend_cache'] = false
```

### profiles

Chef InSpec Compliance profiles to be used for scanning nodes.

```ruby
# use the ssh-hardening profile from Supermarket
default['audit']['profiles']['ssh'] = {
  'supermarket': 'hardening/ssh-hardening'
  }
```

### quiet

Controls verbosity of the Chef InSpec runner. Defaults to `true`. To turn this off, set the attribute `default['audit']['quiet']` to `false`.

```ruby
# verbose
default['audit']['quiet'] = false
```

### reporter

Controls what is done with the resulting report after the Chef InSpec run. Accepts a single string value or an array of multiple values. The 'cli' reporter mimics the InSpec command line output in your terminal, which lets you see your system's compliance status at the end of the Compliance Phase. Accepted values: 'chef-server-automate', 'chef-automate', 'json-file', 'audit-enforcer', 'cli'

```ruby
# set the reporter to Chef Automate
default['audit']['reporter'] = 'chef-automate', 'cli'
```

### run_time_limit

Control results that have a `run_time` below this limit will be stripped of the `start_time` and `run_time` fields to reduce the size of reports. Defaults to `1.0`. Set this attribute with `default['audit']['run_time_limit']`.

```ruby
# allow 5 minutes run time
default['audit']['run_time_limit'] = 5.0
```

### result_include_backtrace

When a Chef InSpec resource throws an exception, results contain a short error message and a detailed ruby stacktrace of the error. Default: false (does not send backtrace). Example:

```ruby
# include backtrace
default['audit']['result_include_backtrace'] = true
```

### result_message_limit

Truncates any control result messages exceeding this character limit. Chef Automate has a 4 MB report size limit and cannot ingest reports exceeding this limitation. Chef InSpec will append this text at the end of any truncated messages: `[Truncated to 10000 characters]` Default: 10000.

```ruby
default['audit']['result_message_limit] = 10000
```

### server

When reporting to a Chef Automate instance proxied via Chef Infra Server, the Compliance Phase can be configured to use a different URL than the `chef_server_url` configured in `client.rb`. This is enabled with the attribute `default['audit']['server']`.

```ruby
default['audit']['server'] = 'https://server.4thcafe.com'.
```

### waiver_file

A string path or an array of paths to Chef InSpec waiver files.

```ruby
default['audit']['waiver_file'] = 'path/to/waiver.yml'.
```

## Errors and Troubleshooting

### Cache Results

Chef InSpec caches the results of commands executed on the node during the compliance phase. Caching improves the compliance phase performance when slower-running commands are executed multiple times during a Chef Infra Client run. Disable this feature if your Chef InSpec profile runs a command multiple times expecting different output during the run. Default: true. Example:

```ruby
# Disable caching of commands
default['audit']['inspec_backend_cache'] = false
```

### Chef InSpec Report Size Limits

The size of the report being generated from running the Compliance Phase is influenced by a few factors like:

- number of controls and tests in a profile
- number of profile failures for the node
- controls metadata (title, description, tags, etc)
- number of resources (users, processes, etc) that are being tested

Depending on your setup, there are some limits you need to be aware of. A common one is Chef Infra Server default (1MB) request size. Exceeding this limit will reject the report with `ERROR: 413 "Request Entity Too Large"`. For more details about these limits, please refer to ['the documentation on troubleshooting 413 errors'](#413-request-entity-too-large).

### HTTP Errors

#### 401, 403 Unauthorized - bad clock

Occasionally, the system date/time will drift between client and server. If this drift is greater than a couple of minutes, the Chef Infra Server will throw a 401 unauthorized and the request will not be forwarded to the Chef Automate server.

On the Chef Infra Server you can see this in the following logs:

```text
# chef-server-ctl tail

==> /var/log/opscode/nginx/access.log <==
192.168.200.102 - - ['28/Aug/2016:14:57:36 +0000']  "GET /organizations/4thcafe/nodes/vagrant-c0971990 HTTP/1.1" 401 "0.004" 93 "-" "Chef Client/12.14.38 (ruby-2.3.1-p112; ohai-8.19.2; x86_64-linux; +https://chef.io)" "127.0.0.1:8000" "401" "0.003" "12.14.38" "algorithm=sha1;version=1.1;" "vagrant-c0971990" "2013-09-25T15:00:14Z" "2jmj7l5rSw0yVb/vlWAYkK/YBwk=" 1060

==> /var/log/opscode/opscode-erchef/crash.log <==
2016-08-28 14:57:36 =ERROR REPORT====
{<<"method=GET; path=/organizations/4thcafe/nodes/vagrant-c0971990; status=401; ">>,"Unauthorized"}

==> /var/log/opscode/opscode-erchef/erchef.log <==
2016-08-28 14:57:36.521 ['error'] {<<"method=GET; path=/organizations/4thcafe/nodes/vagrant-c0971990; status=401; ">>,"Unauthorized"}

==> /var/log/opscode/opscode-erchef/current <==
2016-08-28_14:57:36.52659 ['error'] {<<"method=GET; path=/organizations/4thcafe/nodes/vagrant-c0971990; status=401; ">>,"Unauthorized"}

==> /var/log/opscode/opscode-erchef/requests.log.1 <==
2016-08-28T14:57:36Z erchef@127.0.0.1 method=GET; path=/organizations/4thcafe/nodes/vagrant-c0971990; status=401; req_id=g3IAA2QAEGVyY2hlZkAxMjcuMC4wLjEBAAOFrgAAAAAAAAAA; org_name=4thcafe; msg=bad_clock; couchdb_groups=false; couchdb_organizations=false; couchdb_containers=false; couchdb_acls=false; 503_mode=false; couchdb_associations=false; couchdb_association_requests=false; req_time=1; user=vagrant-c0971990; req_api_version=1;
```

Additionally, the chef_gate log will contain a similar message:

```text
# /var/log/opscode/chef_gate/current
2016-08-28_15:01:34.88702 ['GIN'] 2016/08/28 - 15:01:34 | 401 |   13.650403ms | 192.168.200.102 |   POST    /compliance/organizations/4thcafe/inspec
2016-08-28_15:01:34.88704 Error #01: Authentication failed. Please check your system's clock.
```

#### 401 Token and Refresh Token Authentication

In the event of a malformed or unset token, the Chef Automate server will log the token error:

```text
==> /var/log/chef-compliance/core/current <==
2016-08-28_20:41:46.17496 20:41:46.174 ERR => Token authentication: %!(EXTRA *errors.errorString=malformed JWS, only 1 segments)
2016-08-28_20:41:46.17498 ['GIN'] 2016/08/28 - 20:41:46 | 401 |      53.824us | 192.168.200.102 |   GET     /owners/base/compliance/linux/tar

==> /var/log/chef-compliance/nginx/compliance.access.log <==
192.168.200.102 - - ['28/Aug/2016:21:23:46 +0000'] "GET /api/owners/base/compliance/linux/tar HTTP/1.1" 401 0 "-" "Ruby"
```

#### 413 Request Entity Too Large

This error indicates that you have exceeded limit the `erchef` request size in Chef Infra Server. The default for versions before 13.0  was 1MB. Starting with version 13.0 the default is 2MB.

To resolve this error, set the `opscode_erchef['max_request_size']` in Chef Infra Server's `/etc/opscode/chef-server.rb` to a larger amount. This example sets the limit to 3MB:

```ruby
opscode_erchef['max_request_size'] = 3000000
```

Then run `chef-server-ctl reconfigure` to apply this change.

##### 413 Error Logs

The 413 "Request Entity Too Large" error appears in both the stacktrace and the Chef Infra Server Nginx logs.

<!-- markdownlint-disable blanks-around-fences -->

{{< foundation_tabs tabs-id="compliance-413-panel" >}}
  {{< foundation_tab active="true" panel-link="413-stacktrace" tab-text="Stacktrace">}}
  {{< foundation_tab panel-link="413-server-nginx" tab-text="Nginx logs" >}}
{{< /foundation_tabs >}}
{{< foundation_tabs_panels tabs-id="compliance-413-panel" >}}
  {{< foundation_tabs_panel active="true" panel-id="413-stacktrace" >}}
  The stacktrace shows the 413 error:
  ```text
  Running handlers:
  ['2017-12-21T16:21:15+00:00'] WARN: Compliance report size is 1.71 MB.
  ['2017-12-21T16:21:15+00:00'] ERROR: 413 "Request Entity Too Large" (Net::HTTPServerException)
  /opt/chef/embedded/lib/ruby/2.4.0/net/http/response.rb:122:in `error!'
  /opt/chef/embedded/lib/ruby/gems/2.4.0/gems/chef-13.6.4/lib/chef/http.rb:152:in `request'
  /opt/chef/embedded/lib/ruby/gems/2.4.0/gems/chef-13.6.4/lib/chef/http.rb:131:in `post'
  /var/chef/cache/cookbooks/audit/libraries/reporters/cs_automate.rb:37:in `block in send_report'
  ...
  ```
  {{< /foundation_tabs_panel >}}
  {{< foundation_tabs_panel panel-id="413-server-nginx" >}}
  The Chef Infra Server Nginx log confirms the `413` error:
  ```text
  ==> /var/log/opscode/nginx/access.log <==
  192.168.56.40 - - ['21/Dec/2017:11:35:30 +0000']  "POST /organizations/eu_org/data-collector HTTP/1.1" 413 "0.803" 64 "-" "Chef Client/13.6.4 (ruby-2.4.2-p198; ohai-13.6.0; x86_64-linux; +https://chef.io)" "-" "-" "-" "13.6.4" "algorithm=sha1;version=1.1;" "bootstrapped-node" "2017-12-21T11:35:31Z" "GR6RyPvKkZDaGyQDYCPfoQGS8G4=" 1793064
  ```
  {{< /foundation_tabs_panel >}}

{{< /foundation_tabs_panels >}}

<!-- markdownlint-enable blanks-around-fences -->

## Chef Automate Backend Errors

Chef Automate sets the `logstash` limit to 10% of the system memory automatically as part of the `automate-ctl reconfigure` command execution. You have reached the java heap size(`-Xmx`) limit of `logstash` if a Chef InSpec report does not become available in Chef Automate and this error is in the `logstash` logs:

```text
/var/log/delivery/logstash/current
2017-12-21_13:59:54.69949 DEBUG: Ruby filter is processing an 'inspec_profile' event
2017-12-21_14:00:16.51553 java.lang.OutOfMemoryError: Java heap space
2017-12-21_14:00:16.51556 Dumping heap to /opt/delivery/embedded/logstash/heapdump.hprof ...
2017-12-21_14:00:16.51556 Unable to create /opt/delivery/embedded/logstash/heapdump.hprof: File exists
2017-12-21_14:00:18.50676 Error: Your application used more memory than the safety cap of 383M.
2017-12-21_14:00:18.50694 Specify -J-Xmx####m to increase it (#### = cap size in MB).
2017-12-21_14:00:18.50703 Specify -w for full OutOfMemoryError stack trace
```
