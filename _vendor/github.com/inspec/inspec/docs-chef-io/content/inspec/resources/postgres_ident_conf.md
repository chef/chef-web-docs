+++
title = "postgres_ident_conf resource"
draft = false
platform = "linux"

[menu]
  [menu.inspec]
    title = "postgres_ident_conf"
    identifier = "inspec/resources/os/postgres_ident_conf.md postgres_ident_conf resource"
    parent = "inspec/resources/os"
+++

[\[edit on GitHub\]](https://github.com/inspec/inspec/blob/master/docs-chef-io/content/inspec/resources/postgres_ident_conf.md)

Use the `postgres_ident_conf` Chef InSpec audit resource to test the client authentication data defined in the pg_ident.conf file.

## Availability

### Installation

This resource is distributed along with Chef InSpec itself. You can use it automatically.

### Version

This resource first became available in v1.31.0 of InSpec.

## Syntax

An `postgres_ident_conf` Chef InSpec audit resource block declares client authentication data that should be tested:

    describe postgres_ident_conf.where { pg_username == 'filter_value' } do
      its('attribute') { should eq ['value'] }
    end

where

- `'attribute'` is a attribute in the pg ident configuration file
- `'filter_value'` is the value that is to be filtered for
- `'value'` is the value that is to be matched expected

## Properties

    'conf_file', 'map_name', 'params', 'pg_username', 'system_username'

## Property Examples

### map_name([String])

`address` returns a an array of strings that matches the where condition of the filter table

    describe pg_ident_conf.where { pg_username == 'name' } do
      its('map_name') { should eq ['value'] }
    end

### pg_username([String])

`pg_username` returns a an array of strings that matches the where condition of the filter table

    describe pg_ident_conf.where { pg_username == 'name' } do
      its('pg_username') { should eq ['value'] }
    end

### system_username([String])

`system_username` returns a an array of strings that matches the where condition of the filter table

    describe pg_ident_conf.where { pg_username == 'name' } do
      its('system_username') { should eq ['value'] }
    end

## Matchers

This Chef InSpec audit resource matches any service that is listed in the pg ident configuration file. For a full list of available matchers, please visit our [matchers page](/inspec/matchers/).

    its('pg_username') { should_not eq ['peer'] }

or:

    its('map_name') { should eq ['value'] }

For example:

    describe postgres_ident_conf.where { pg_username == 'name' } do
      its('system_username') { should eq ['value'] }
      its('map_name') { should eq ['value'] }
    end
