+++
title = "Compliance Phase Runners Fetchers Reporters"
draft = false

[menu]
  [menu.infra]
    title = "Fetchers, Reporters & Waivers"
    identifier = "chef_infra/compliance_phase/chef_compliance_runners.md Compliance Phase Fetchers and Reporters"
    parent = "chef_infra/compliance_phase"
    weight = 20
+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/chef_compliance_runners.md)

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
