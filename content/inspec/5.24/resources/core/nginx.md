+++
title = "nginx resource"
draft = false

platform = "linux"

[menu.inspec_5_24]
    title = "nginx"
    identifier = "resources/core/nginx.md nginx resource"
    parent = "resources/core"
+++

Use the `nginx` Chef InSpec audit resource to test the fields and validity of nginx.

Nginx resource extracts and exposes data reported by the command 'nginx -V'

## Availability

### Install

{{< readfile file="content/inspec/5.24/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.37.6 of InSpec.

## Syntax

An `nginx` Chef InSpec audit resource block extracts configuration settings that should be tested:

```ruby
describe nginx do
  its('attribute') { should eq 'value' }
end

describe nginx('path to nginx') do
  its('attribute') { should eq 'value' }
end
```

where:

- `'attribute'` is a configuration parsed from result of the command 'nginx -V'
- `'value'` is the value that's expected of the attribute

## Properties

- `compiler_info`, `error_log_path`, `http_client_body_temp_path`, `http_fastcgi_temp_path`, `http_log_path`, `http_proxy_temp_path`, `http_scgi_temp_path`, `http_uwsgi_temp_path`, `lock_path`, `modules`, `modules_path`, `openssl_version`, `prefix`, `sbin_path`, `service`, `support_info`, `version`

## Property Examples

### version(String)

`version` returns a string of the version of the running nginx instance

```ruby
describe nginx do
  its('version') { should eq '1.12.0' }
end
```

### modules(String)

`modules` returns a array modules in the running nginx instance

```ruby
describe nginx do
  its('modules') { should include 'my_module' }
end
```

### openssl_version(Hash)

`openssl_version` returns a hash with 'version' and 'date' as keys

```ruby
describe nginx do
  its('openssl_version.date') { should eq '11 Feb 2013' }
end
```

### compiler_info(Hash)

`compiler_info` returns a hash with 'compiler' , version' and 'date' as keys

```ruby
describe nginx do
  its('compiler_info.compiler') { should eq 'gcc' }
end
```

### support_info(String)

`support_info` returns a string containing supported protocols

```ruby
describe nginx do
  its('support_info') { should match /TLS/ }
end
```
