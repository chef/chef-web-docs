+++
title = "postgres_ident_conf resource"
draft = false

platform = "linux"

[menu.inspec_5_23]
    title = "postgres_ident_conf"
    identifier = "resources/core/postgres_ident_conf.md postgres_ident_conf resource"
    parent = "resources/core"
+++

Use the `postgres_ident_conf` Chef InSpec audit resource to test the client authentication data defined in the pg_ident.conf file.

## Availability

### Install

{{< readfile file="content/inspec/5.23/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.31.0 of InSpec.

## Syntax

An `postgres_ident_conf` Chef InSpec audit resource block declares client authentication data that should be tested:

```ruby
describe postgres_ident_conf.where { pg_username == 'filter_value' } do
  its('attribute') { should eq ['value'] }
end
```

where:

- `'attribute'` is a attribute in the pg ident configuration file
- `'filter_value'` is the value that's to be filtered for
- `'value'` is the value that's to be matched expected

## Properties

### map_name([String])

`map_name` returns a an array of strings that matches the where condition of the filter table

```ruby
describe postgres_ident_conf.where { pg_username == 'name' } do
  its('map_name') { should eq ['value'] }
end
```

### pg_username([String])

`pg_username` returns a an array of strings that matches the where condition of the filter table

```ruby
describe postgres_ident_conf.where { pg_username == 'name' } do
  its('pg_username') { should eq ['value'] }
end
```

### system_username([String])

`system_username` returns a an array of strings that matches the where condition of the filter table

```ruby
describe postgres_ident_conf.where { pg_username == 'name' } do
  its('system_username') { should eq ['value'] }
end
```

## Matchers

{{< readfile file="content/inspec/5.23/reusable/md/inspec_matchers_link.md" >}}
