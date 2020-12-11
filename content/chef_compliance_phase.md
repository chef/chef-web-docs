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

## Overview

Compliance Phase enables Chef Infra to run Chef InSpec profiles as part of a client run, by downloading profiles from sources like Chef Automate, Chef Supermarket, or GitHub, and reporting the results to Chef Automate or saving the results locally. Compliance Phase has been implemented to be mostly compatible with [audit cookbook](), so that users of the audit cookbook can remove it from the node's runlist and get the same behavior.

## Usage

### Configuration

Compliance Phase needs to be configured for each node where the `chef-client` runs. All node-specific configuration is done via Chef Infra attributes. Specifying one or more Chef InSpec profiles is the minimum configuration necessary to enable Compliance Phase in a Chef Infra client run. With no further configuration, this will cause a Chef Infra client run to execute the Chef InSpec profiles and write the results to disk using the default `json-file` reporter.

#### Profiles

Chef InSpec profiles are specified using the `node['audit']['profiles']` attribute.

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

You can also pass in Chef InSpec [attributes](https://www.inspec.io/docs/reference/profiles/) to your audit run.

```ruby
default['audit']['attributes'] = {
  first_attribute: 'some value',
  second_attribute: 'another value',
}
```

#### Waivers

You can use Chef InSpec's [waivers](https://www.inspec.io/docs/reference/waivers/) to mark individual failing controls as being administratively accepted, either on a temporary or permanent basis. Prepare a waiver file and use your Chef Infra cookbooks to deliver the file to your converging node (for example, using [cookbook_file](https://docs.chef.io/resource_cookbook_file.html) or [remote_file](https://docs.chef.io/resource_remote_file.html)). Then set the attribute `default['audit']['waiver_file']` to the location(s) of the waiver file(s) on the local node, and Chef InSpec will apply the waivers.

#### Insecure

Setting the attribute `default['audit'['insecure']` to `true` will skip SSL certificate verification for the `chef-automate` and `chef-server-automate` reporters. Default is `false`

#### Reporters

Reporters control what is done with the resulting report after the Chef InSpec run. Either a single value or a list of multiple values is supported. The default is the `json-file` reporter.

##### chef-automate

Sends the results to a Chef Automate instance. See the instructions on [using Chef Automate with Compliance Phase]() for more details.

##### chef-server-automate

Sends the results to a Chef Automate proxied by a Chef Infra Server instance. See the instructions on [using Chef Infra Srver with Compliance Phase]() for more details.

##### json-file

Writes the results to disk in the location specified with the [json-file location attribute]().

##### audit-enforcer

A special reporter that instead of sending the results of the Chef InSpec run somewhere instead will fail the Chef Infra run if any control of any Chef InSpec profile fails.

##### JSON File Location

The location on disk that Chef InSpec's json reports are saved to when using the 'json-file' reporter. Set this attribute with `default['audit']['json-file']['location']`. Defaults to: `<chef_cache_path>/compliance_reports/compliance-<timestamp>.json`

#### InSpec Backend Cache

Chef InSpec provides the ability to cache the result of commands executed on the node being tested. This drastically improves Chef InSpec performance when slower-running commands are run multiple times during execution. This feature is enabled by default for Compliance Phase. If your Chef InSpec profile runs a command multiple times expecting different output, you may have to disable this feature. To do so set the `inspec_backend_cache` attribute to `false`:

```ruby
node.normal['audit']['inspec_backend_cache'] = false
```

#### Fetchers

Fetchers control if Chef InSpec profiles should be fetched from Chef Automate or Chef Infra Server in addition to the default fetch locations provided by Chef Inspec. Set this attribute with `default['audit']['fetcher']. Accepted values: 'chef-server' or 'chef-automate'. With nothing specified for this attribute the [fetchers included in Chef InSpec]() are used. The fetchers included with Chef Infra are mutually exclusive so only one value can be specifed for this attribute.

##### Chef Automate

Fetches Chef InSpec profiles from a Chef Automate instance. Enabled by setting the attribute `default['audit']['fetcher']` to `chef-automate`. Requires that the `data_collector.server_url` and `data_collector.token` options are set in `client.rb`. Further information is available at Chef Docs: [Configure a Data Collector token in Chef Automate](https://docs.chef.io/ingest_data_chef_automate.html)

##### Chef Server

Fetches Chef InSpec profiles from a Chef Automate instance proxied with Chef Server. Enabled by setting the attribute `default['audit']['fetcher'] to `chef-server`. Requires that the `chef_server_url` option is set in `client.rb`.

#### Quiet

Controls verbosity of the Chef InSpec runner. Defaults to `true`. To turn this off, set the attribute `default['audit']['quiet']` to `false`.

#### Control Run Time Limit

Control results that have a `run_time` below this limit will be stripped of the `start_time` and `run_time` fields to reduce the size of reports. Defaults to `1.0`. Set this attribute with `default['audit']['run_time_limit']`.

#### Control Result Message Size Limit

A control result message that exceeds this character limit will be truncated to help reduce the size of reports. Chef InSpec will append this text at the end of any truncated messages: `[Truncated to 10000 characters]`. Defaults to `10000`. Set this attribute with `default['audit']['result_message_limit']`.

#### Control Result Include Backtrace

When a Chef InSpec resource throws an exception, results will contain a short error message and a detailed ruby stacktrace of the error. This attribute instructs Chef InSpec not to include the detailed stacktrace in order to reduce the size of reports. Defaults to `false`. Set this attribute with `default['audit']['result_include_backtrace']`.

#### Control Result Count Limit

The list of results per control will be truncated to this amount to reduce the size of reports. A summary of removed results will be sent with each impacted control. Defaults to `50`. Set this attribute with `default['audit']['control_results_limit']`.

### Reporting

#### Reporting to Chef Automate via Chef Infra Server

This requires Chef Infra Server version 12.11.1 and Chef Automate 0.6.6 or newer, as well as integration between the Chef Infra Server and Chef Automate. More details [here](https://docs.chef.io/integrate_compliance_chef_automate.html#collector-chef-server-automate).

To upload profiles, you can use the [Chef Automate API](https://docs.chef.io/api_automate.html) or the `inspec compliance` subcommands.

This is an example of attributes configuring Compliance Phase to fetch Chef InSpec profiles from Chef Automate and send reports to Chef Automate both via Chef Infra Server:

```ruby
default['audit']['reporter'] = 'chef-server-automate'
default['audit']['fetcher'] = 'chef-server'
default['audit']['profiles']['my-profile'] = {
  'compliance': 'john/my-profile'
}
```

#### Direct reporting to Chef Automate

This method sends the report using the `data_collector.server_url` and `data_collector.token` options defined in `client.rb`. Further information is available at Chef Docs: [Configure a Data Collector token in Chef Automate](https://docs.chef.io/ingest_data_chef_automate.html)

This is an example of attributes configuring Compliance Phase to fetch a Chef InSpec profile from GitHub and send reports to Chef Automate:

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

To write the report to a file on disk, set the `reporter` to 'json-file' like so:

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

The `audit-enforcer` reporter enables you to enforce compliance with executed Chef InSpec profiles. If the system under test is determined to be non-compliant, this reporter will raise an error and fail the Chef Infra Client run. To activate compliance enforcement, set the `reporter` attribute to 'audit-enforcer':

```ruby
default['audit']['reporter'] = 'audit-enforcer'
```

Note: Detection of failed controls will immediately terminate the Chef Infra Client run. If you specify multiple reporters, place the `audit-enforcer` at the end of the list, allowing the other reporters to generate their output prior to run termination.

### Profile Fetcher

#### Fetch profiles from Chef Automate via Chef Infra Server

To enable reporting to Chef Automate with profiles from Chef Automate, you need to have Chef Infra Server integrated with [Chef Automate](https://docs.chef.io/integrate_compliance_chef_automate.html#collector-chef-server-automate). You can then set the `fetcher` attribute to 'chef-server'.

This allows Compliance Phase to fetch profiles stored in Chef Automate. For example:

```ruby
default['audit']['reporter'] = 'chef-server-automate'
default['audit']['fetcher'] = 'chef-server'
default['audit']['profiles']['ssh'] = {
  'compliance': 'base/ssh'
}
```

#### Fetch profiles directly from Chef Automate

This method fetches profiles using the `data_collector.server_url` and `data_collector.token` options in `client.rb`. Further information is available at Chef Docs: [Configure a Data Collector token in Chef Automate](https://docs.chef.io/ingest_data_chef_automate.html)

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

There are two primary ways to pass Chef Infra node data to Chef InSpec run in Compliance Phase.

### Option 1: Explicitly pass necessary data (recommended)

Any data added to the `node['audit']['attributes']` hash will be passed as individual Chef InSpec attributes.
This provides a clean interface between the Chef Infra client run and Chef InSpec profile, allowing for easy assignment
of default values in the InSpec profile. This method is especially recommended if the Chef InSpec profile
is expected to be used outside of the context of Compliance Phase so it's made explicit to profile
consumers what attributes are necessary.

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

### Option 2: Use the Chef Infra node object

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

## Troubleshooting

### HTTP Errors

#### 401, 403 Unauthorized - bad clock

Occasionally, the system date/time will drift between client and server.  If this drift is greater than a couple of minutes, the Chef Server will throw a 401 unauthorized and the request will not be forwarded to the Compliance server.

On the Chef Server you can see this in the following logs:
```
# chef-server-ctl tail

==> /var/log/opscode/nginx/access.log <==
192.168.200.102 - - [28/Aug/2016:14:57:36 +0000]  "GET /organizations/brewinc/nodes/vagrant-c0971990 HTTP/1.1" 401 "0.004" 93 "-" "Chef Client/12.14.38 (ruby-2.3.1-p112; ohai-8.19.2; x86_64-linux; +https://chef.io)" "127.0.0.1:8000" "401" "0.003" "12.14.38" "algorithm=sha1;version=1.1;" "vagrant-c0971990" "2013-09-25T15:00:14Z" "2jmj7l5rSw0yVb/vlWAYkK/YBwk=" 1060

==> /var/log/opscode/opscode-erchef/crash.log <==
2016-08-28 14:57:36 =ERROR REPORT====
{<<"method=GET; path=/organizations/brewinc/nodes/vagrant-c0971990; status=401; ">>,"Unauthorized"}

==> /var/log/opscode/opscode-erchef/erchef.log <==
2016-08-28 14:57:36.521 [error] {<<"method=GET; path=/organizations/brewinc/nodes/vagrant-c0971990; status=401; ">>,"Unauthorized"}

==> /var/log/opscode/opscode-erchef/current <==
2016-08-28_14:57:36.52659 [error] {<<"method=GET; path=/organizations/brewinc/nodes/vagrant-c0971990; status=401; ">>,"Unauthorized"}

==> /var/log/opscode/opscode-erchef/requests.log.1 <==
2016-08-28T14:57:36Z erchef@127.0.0.1 method=GET; path=/organizations/brewinc/nodes/vagrant-c0971990; status=401; req_id=g3IAA2QAEGVyY2hlZkAxMjcuMC4wLjEBAAOFrgAAAAAAAAAA; org_name=brewinc; msg=bad_clock; couchdb_groups=false; couchdb_organizations=false; couchdb_containers=false; couchdb_acls=false; 503_mode=false; couchdb_associations=false; couchdb_association_requests=false; req_time=1; user=vagrant-c0971990; req_api_version=1;

```
Additionally, the chef_gate log will contain a similar message:
```
# /var/log/opscode/chef_gate/current
2016-08-28_15:01:34.88702 [GIN] 2016/08/28 - 15:01:34 | 401 |   13.650403ms | 192.168.200.102 |   POST    /compliance/organizations/brewinc/inspec
2016-08-28_15:01:34.88704 Error #01: Authentication failed. Please check your system's clock.
```

#### 401 Token and Refresh Token Authentication

In the event of a malformed or unset token, the Chef Compliance server will log the token error:
```
==> /var/log/chef-compliance/core/current <==
2016-08-28_20:41:46.17496 20:41:46.174 ERR => Token authentication: %!(EXTRA *errors.errorString=malformed JWS, only 1 segments)
2016-08-28_20:41:46.17498 [GIN] 2016/08/28 - 20:41:46 | 401 |      53.824µs | 192.168.200.102 |   GET     /owners/base/compliance/linux/tar

==> /var/log/chef-compliance/nginx/compliance.access.log <==
192.168.200.102 - - [28/Aug/2016:21:23:46 +0000] "GET /api/owners/base/compliance/linux/tar HTTP/1.1" 401 0 "-" "Ruby"
```

#### 413 Request Entity Too Large

If the `audit` cookbook report handler prints this stacktrace and you are using the `chef-server-automate` reporter:
```
Running handlers:
[2017-12-21T16:21:15+00:00] WARN: Compliance report size is 1.71 MB.
[2017-12-21T16:21:15+00:00] ERROR: 413 "Request Entity Too Large" (Net::HTTPServerException)
/opt/chef/embedded/lib/ruby/2.4.0/net/http/response.rb:122:in `error!'
/opt/chef/embedded/lib/ruby/gems/2.4.0/gems/chef-13.6.4/lib/chef/http.rb:152:in `request'
/opt/chef/embedded/lib/ruby/gems/2.4.0/gems/chef-13.6.4/lib/chef/http.rb:131:in `post'
/var/chef/cache/cookbooks/audit/libraries/reporters/cs_automate.rb:37:in `block in send_report'
...
```

and the Chef Infra Server Nginx logs confirm the `413` error:
```
==> /var/log/opscode/nginx/access.log <==
192.168.56.40 - - [21/Dec/2017:11:35:30 +0000]  "POST /organizations/eu_org/data-collector HTTP/1.1" 413 "0.803" 64 "-" "Chef Client/13.6.4 (ruby-2.4.2-p198; ohai-13.6.0; x86_64-linux; +https://chef.io)" "-" "-" "-" "13.6.4" "algorithm=sha1;version=1.1;" "bootstrapped-node" "2017-12-21T11:35:31Z" "GR6RyPvKkZDaGyQDYCPfoQGS8G4=" 1793064
```

you most likely hit the `erchef` request size in Chef Infra Server. Prior to Infra Server 13.0, the default was ~1MB. Infra Server 13.0 and later default to ~2MB.

As an example, to set the limit to ~3MB, add the following line in Chef Server's `/etc/opscode/chef-server.rb`:
```
opscode_erchef['max_request_size'] = 3000000
```
and run `chef-server-ctl reconfigure` to apply this change.

### Chef Automate Backend Errors

If a Compliance report is not becoming available in the Chef Automate UI or API and this error shows up in the `logstash` logs:
```
/var/log/delivery/logstash/current
2017-12-21_13:59:54.69949 DEBUG: Ruby filter is processing an 'inspec_profile' event
2017-12-21_14:00:16.51553 java.lang.OutOfMemoryError: Java heap space
2017-12-21_14:00:16.51556 Dumping heap to /opt/delivery/embedded/logstash/heapdump.hprof ...
2017-12-21_14:00:16.51556 Unable to create /opt/delivery/embedded/logstash/heapdump.hprof: File exists
2017-12-21_14:00:18.50676 Error: Your application used more memory than the safety cap of 383M.
2017-12-21_14:00:18.50694 Specify -J-Xmx####m to increase it (#### = cap size in MB).
2017-12-21_14:00:18.50703 Specify -w for full OutOfMemoryError stack trace
```

you have reached the java heap size(`-Xmx`) limit of `logstash`. This is automatically set during `automate-ctl reconfigure` to 10% of the system memory.
