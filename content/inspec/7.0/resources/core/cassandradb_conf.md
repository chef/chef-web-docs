+++
title = "cassandradb_conf resource"
draft = false

platform = "os"

[menu.inspec_7_0]
    title = "cassandradb_conf"
    identifier = "resources/core/cassandradb_conf.md cassandradb_conf resource"
    parent = "resources/core"
+++

Use the `cassandradb_conf` Chef InSpec audit resource to test the configuration of a Cassandra database, which is typically located at `$CASSANDRA_HOME/cassandra.yaml` or `$CASSANDRA_HOME\conf\cassandra.yaml` depending upon the platform.

## Installation

{{< readfile file="content/inspec/7.0/reusable/md/inspec_installation.md" >}}

## Requirements

- The value of the `CASSANDRA_HOME` environment variable must be set in the system.

## Syntax

A `cassandradb_conf` resource block fetches configurations in the `cassandra.yaml` file, and then compares them with the value stated in the test:

```ruby
describe cassandradb_conf do
  its('config item') { should eq 'value' }
end
```

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test parameters set within the configuration file

```ruby
describe cassandradb_conf do
  its('listen_address') { should eq 'localhost' }
  its('num_tokens') { should eq 16 }
end
```

## Matchers

{{< readfile file="content/inspec/7.0/reusable/md/inspec_matchers_link.md" >}}
