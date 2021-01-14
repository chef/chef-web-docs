+++
title = "Compliance Phase Errors & Troubleshooting"
draft = false

[menu]
  [menu.infra]
    title = "Errors & Troubleshooting"
    identifier = "chef_infra/compliance_phase/chef_compliance_phase_errors.md HTTP Errors"
    parent = "chef_infra/compliance_phase"
    weight = 30
+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/chef_compliance_errors.md)

## Useful Compliance Phase Attributes

#### audit-enforcer

A special reporter that causes the compliance run to raise an error and immediately terminates the Chef Infra Client run if any control of any Chef InSpec profile fails. If you specify multiple reporters, place the `audit-enforcer` at the end of the list, allowing the other reporters to generate their output prior to run termination. Example:

```ruby
default['audit']['reporter'] = 'audit-enforcer'.
```

#### control_results_limit
The list of results per control will be truncated to this amount to reduce the size of reports. A summary of removed results will be sent with each impacted control. Defaults to `50`. Set this attribute with `default['audit']['control_results_limit']`.

#### insecure
Setting the attribute `default['audit']['insecure']` to `true` will skip SSL certificate verification for the `chef-automate` and `chef-server-automate` reporters. Default is `false`

#### quiet
Controls verbosity of the Chef InSpec runner. Defaults to `true`. To turn this off, set the attribute `default['audit']['quiet']` to `false`.

#### run_time_limit
Control results that have a `run_time` below this limit will be stripped of the `start_time` and `run_time` fields to reduce the size of reports. Defaults to `1.0`. Set this attribute with `default['audit']['run_time_limit']`.

#### result_include_backtrace
When a Chef InSpec resource throws an exception, results contain a short error message and a detailed ruby stacktrace of the error. Default: false (does not send backtrace). Example:

```ruby
# include backtrace
default['audit']['result_include_backtrace'] = true
```

#### server
When reporting to a Chef Automate instance proxied via Chef Infra Server, the Compliance Phase can be configured to use a different URL than the `chef_server_url` configured in `client.rb`. This is enabled with the attribute `default['audit']['server']`. Example: Example: `default['audit']['server'] = 'alternate-server-URL'`.

## Cache Results

Chef InSpec caches the results of commands executed on the node during the compliance phase. Caching improves the compliance phase performance when slower-running commands are executed multiple times during a Chef Infra Client run. Disable this feature if your Chef InSpec profile runs a command multiple times expecting different output during the run. Default: true. Example:

```ruby
# Disable caching of commands
node.normal['audit']['inspec_backend_cache'] = false
```

## Chef InSpec Report Size Limits

The size of the report being generated from running the Compliance Phase is influenced by a few factors like:

 * number of controls and tests in a profile
 * number of profile failures for the node
 * controls metadata (title, description, tags, etc)
 * number of resources (users, processes, etc) that are being tested

Depending on your setup, there are some limits you need to be aware of. A common one is Chef Infra Server default (1MB) request size. Exceeding this limit will reject the report with `ERROR: 413 "Request Entity Too Large"`. For more details about these limits, please refer to [the documentation on troubleshooting 413 errors](#413-request-entity-too-large).

## HTTP Errors

### 401, 403 Unauthorized - bad clock

Occasionally, the system date/time will drift between client and server. If this drift is greater than a couple of minutes, the Chef Infra Server will throw a 401 unauthorized and the request will not be forwarded to the Chef Automate server.

On the Chef Infra Server you can see this in the following logs:
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

### 401 Token and Refresh Token Authentication

In the event of a malformed or unset token, the Chef Automate server will log the token error:
```
==> /var/log/chef-compliance/core/current <==
2016-08-28_20:41:46.17496 20:41:46.174 ERR => Token authentication: %!(EXTRA *errors.errorString=malformed JWS, only 1 segments)
2016-08-28_20:41:46.17498 [GIN] 2016/08/28 - 20:41:46 | 401 |      53.824us | 192.168.200.102 |   GET     /owners/base/compliance/linux/tar

==> /var/log/chef-compliance/nginx/compliance.access.log <==
192.168.200.102 - - [28/Aug/2016:21:23:46 +0000] "GET /api/owners/base/compliance/linux/tar HTTP/1.1" 401 0 "-" "Ruby"
```

### 413 Request Entity Too Large

If Compliance Phase prints this stacktrace and you are using the `chef-server-automate` reporter:

```bash
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

```bash
==> /var/log/opscode/nginx/access.log <==
192.168.56.40 - - [21/Dec/2017:11:35:30 +0000]  "POST /organizations/eu_org/data-collector HTTP/1.1" 413 "0.803" 64 "-" "Chef Client/13.6.4 (ruby-2.4.2-p198; ohai-13.6.0; x86_64-linux; +https://chef.io)" "-" "-" "-" "13.6.4" "algorithm=sha1;version=1.1;" "bootstrapped-node" "2017-12-21T11:35:31Z" "GR6RyPvKkZDaGyQDYCPfoQGS8G4=" 1793064
```

you most likely hit the `erchef` request size in Chef Infra Server. Prior to Infra Server 13.0, the default was ~1MB. Infra Server 13.0 and later default to ~2MB.

As an example, to set the limit to ~3MB, add the following line in Chef Infra Server's `/etc/opscode/chef-server.rb`:

```ruby
opscode_erchef['max_request_size'] = 3000000
```

and run `chef-server-ctl reconfigure` to apply this change.

## Chef Automate Backend Errors

If a Chef InSpec report is not becoming available in the Chef Automate UI or API and this error shows up in the `logstash` logs:

```bash
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
