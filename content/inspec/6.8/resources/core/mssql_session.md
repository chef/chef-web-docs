+++
title = "mssql_session resource"
draft = false

platform = "windows"

[menu.inspec_6_8]
    title = "mssql_session"
    identifier = "resources/core/mssql_session.md mssql_session resource"
    parent = "resources/core"
+++

Use the `mssql_session` Chef InSpec audit resource to test SQL commands run against a Microsoft SQL database.

## Availability

### Install

{{< readfile file="content/inspec/6.8/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.24.0 of InSpec.

## Syntax

A `mssql_session` resource block declares the username and password to use for the session, and then the command to be run:

```ruby
describe mssql_session(user: 'username', password: 'password').query('QUERY').row(0).column('result') do
  its('value') { should eq('') }
end
```

where:

- `mssql_session` declares a username and password with permission to run the query. Omitting the username or password parameters results in the use of Windows authentication as the user Chef InSpec is executing as. You may also optionally pass a host and instance name. If omitted, they will default to host: localhost and the default instance.
- `query('QUERY')` contains the query to be run
- `its('value') { should eq('') }` compares the results of the query against the expected result in the test

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test for matching databases

```ruby
sql = mssql_session(user: 'my_user', password: 'password')

describe sql.query("SELECT SERVERPROPERTY('ProductVersion') as result").row(0).column('result') do
  its("value") { should cmp > '12.00.4457' }
end
```

### Test using Windows authentication

```ruby
sql = mssql_session

describe sql.query("SELECT SERVERPROPERTY('ProductVersion') as result").row(0).column('result') do
  its("value") { should cmp > '12.00.4457' }
end
```

### Test a specific host and instance

```ruby
sql = mssql_session(user: 'my_user', password: 'password', host: 'ms-sql-server', instance: 'foo')

describe sql.query("SELECT SERVERPROPERTY('ProductVersion') as result").row(0).column('result') do
  its("value") { should cmp > '12.00.4457' }
end
```

### Test a specific database

```ruby
sql = mssql_session(user: 'my_user', password: 'password', db_name: 'test')

describe sql.query("SELECT Name AS result FROM Product WHERE ProductID == 1").row(0).column('result') do
  its("value") { should eq 'foo' }
end
```

## Matchers

{{< readfile file="content/inspec/6.8/reusable/md/inspec_matchers_link.md" >}}
