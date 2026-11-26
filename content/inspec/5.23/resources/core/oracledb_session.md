+++
title = "oracledb_session resource"
draft = false

platform = "os"

[menu.inspec_5_23]
    title = "oracledb_session"
    identifier = "resources/core/oracledb_session.md oracledb_session resource"
    parent = "resources/core"
+++

Use the `oracledb_session` Chef InSpec audit resource to test SQL commands run against a Oracle database.

## Availability

### Install

{{< readfile file="content/inspec/5.23/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `oracledb_session` resource block declares the username and PASSWORD to use for the session with an optional service to connect to, and then the command to be run:

```ruby
describe oracledb_session(user: 'username', PASSWORD: 'PASSWORD', service: 'ORCL.localdomain').query('QUERY').row(0).column('result') do
  its('value') { should eq('') }
end
```

where:

- `oracledb_session` declares a username and PASSWORD with permission to run the query (required), and an optional parameters for host (default: `localhost`), system identifier (SID) (default: `nil`), which uses the default SID, and path to the sqlplus binary (default: `sqlplus`).
- it's possible to run queries as sysdba/sysoper by using `as_db_role option`, see examples
- SQLcl can be used in place of sqlplus. Use the `sqlcl_bin` option to set the sqlcl binary path instead of `sqlplus_bin`.
- `query('QUERY')` contains the query to be run
- `its('value') { should eq('') }` compares the results of the query against the expected result in the test

## oracledb_session(...).query method Properties

- rows the query result as array of hashes
- row(number) selected row from query result, where number is just a row number in the query result
- column(name) array with values from selected column

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test for matching databases

```ruby
sql = oracledb_session(user: 'USERNAME', pass: 'PASSWORD')

describe sql.query('SELECT NAME AS VALUE FROM v$database;').row(0).column('value') do
  its('value') { should cmp 'ORCL' }
end
```

### Test for matching databases with custom host, SID and sqlplus binary location

```ruby
sql = oracledb_session(user: 'USERNAME', pass: 'PASSWORD', host: 'ORACLE_HOST', sid: 'ORACLE_SID', sqlplus_bin: '/u01/app/oracle/product/12.1.0/dbhome_1/bin/sqlplus')

describe sql.query('SELECT NAME FROM v$database;').row(0).column('name') do
  its('value') { should cmp 'ORCL' }
end
```

### Test for table contains a specified value in any row for the given column name

```ruby
sql = oracledb_session(user: 'USERNAME', pass: 'PASSWORD', service: 'ORACLE_SID')

describe sql.query('SELECT * FROM my_table;').column('COLUMN') do
  it { should include 'my_value' }
end
```

### Test tablespace exists as sysdba

The check will change user (with su) to specified user and run 'sqlplus / as sysdba' (sysoper, sysasm)

```ruby
sql = oracledb_session(as_os_user: 'oracle', as_db_role: 'sysdba', service: 'ORACLE_SID')

describe sql.query('SELECT tablespace_name AS name FROM dba_tablespaces;').column('name') do
  it { should include 'TABLE_SPACE' }
end
```

The option `as_os_user` is available only on unix-like systems and not supported on Windows. Also this option requires that you are running inspec as `root` or with `--sudo`

### Test number of rows in the query result

```ruby
sql = oracledb_session(user: 'USERNAME', pass: 'PASSWORD')

describe sql.query('SELECT * FROM my_table;').rows do
  its('count') { should eq 20 }
end
```

### Use data out of (remote) DB query to build other tests

```ruby
sql = oracledb_session(user: 'USERNAME', pass: 'PASSWORD', host: 'my.remote.db', service: 'ORACLE_SID')

sql.query('SELECT * FROM files;').rows.each do |file_row|
  describe file(file_row['path']) do
    its('owner') { should eq file_row['owner']}
  end
end
```

## Matchers

{{< readfile file="content/inspec/5.23/reusable/md/inspec_matchers_link.md" >}}
