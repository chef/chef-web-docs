+++
title = "postgres_session resource"
draft = false

platform = "os"

[menu.inspec_7_1]
    title = "postgres_session"
    identifier = "resources/core/postgres_session.md postgres_session resource"
    parent = "resources/core"
+++

Use the `postgres_session` Chef InSpec audit resource to test SQL commands run against a PostgreSQL database.

## Availability

### Install

{{< readfile file="content/inspec/7.1/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `postgres_session` resource block declares the username and password to use for the session, and then the command to be run:

```ruby
# Create a PostgreSQL session:
sql = postgres_session('username', 'password', 'host', 'port', 'socketpath')

# default values:
#   username: 'postgres'
#   host: 'localhost'
#   port: 5432
#   socketpath (optional): nil

# Run an SQL query with an optional database to execute
sql.query('sql_query', ['database_name'])`
```

A full example is:

```ruby
sql = postgres_session('username', 'password', 'host', 'port', 'socketpath')
describe sql.query('SELECT * FROM pg_shadow WHERE passwd IS NULL;') do
  its('output') { should eq '' }
end
```

where:

- `its('output') { should eq '' }` compares the results of the query against the expected result in the test
- `socketpath` is an optional parameter. Use `socketpath` to establish a socket connection with Postgres by specifying one of the Postgres Unix domain socket paths. Only supported on Unix-based platforms.

## Properties

### output

The `output` property tests the results of the query:

```ruby
its('output') { should eq(/^0/) }
```

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test the PostgreSQL shadow password

```ruby
sql = postgres_session('my_user', 'password', '192.168.1.2', 5432)

describe sql.query('SELECT * FROM pg_shadow WHERE passwd IS NULL;', ['testdb']) do
  its('output') { should eq('') }
end
```

### Test for risky database entries

```ruby
describe postgres_session('my_user', 'password').query('SELECT count (*)
              FROM pg_language
              WHERE lanpltrusted = \'f\'
              AND lanname!=\'internal\'
              AND lanname!=\'c\';', ['postgres']) do
  its('output') { should eq '0' }
end
```

## Matchers

{{< readfile file="content/inspec/7.1/reusable/md/inspec_matchers_link.md" >}}
