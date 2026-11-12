+++
title = "oracledb_session resource"
draft = false

platform = "os"

[menu.inspec_7_1]
    title = "oracledb_session"
    identifier = "resources/core/oracledb_session.md oracledb_session resource"
    parent = "resources/core"
+++

Use the `oracledb_session` Chef InSpec audit resource to test SQL commands run against an Oracle database.

## Availability

### Install

{{< readfile file="content/inspec/7.1/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

An `oracledb_session` resource block declares the session username and password, an optional service to connect to, and the command to run. For example:

```ruby
describe oracledb_session(user: '<USERNAME>', PASSWORD: '<PASSWORD>', service: '<ORACLE_SERVICE>').query('<QUERY>').row(<NUMBER>).column('<COLUMN_NAME>') do
  its('<VALUE>') { should eq('<EXPECTED_VALUE>') }
end
```

where:

- `oracledb_session` resource declares a username and password with permission to run the query (required), and an optional Oracle service name or SID.
- `query` declares the Oracle session query you are testing.
- `column` and `row` filter the query results.
- `its('<VALUE>') { should eq('<EXPECTED_VALUE>') }` compares the results of the query against the expected result in the test.

## Properties

You can use the following properties to query an Oracle database:

- `user`: The user to query the database.
- `password`: The user's password.
- `service`: The Oracle service name or SID.
- `host`: The hostname or IP address of the Oracle database server. Default: `localhost`.
- `port`: The port number for the Oracle database listener. Default: `1521`.
- `tns_alias`: The Transparent Network Substrate (TNS) alias from `tnsnames.ora`. This is recommended for TCPS/SSL connections.
- `env`: A hash of environment variables, for example, `TNS_ADMIN`, `LD_LIBRARY_PATH`, and `ORACLE_HOME`.
- `as_db_role`: The database role. For example, `sysasm`, `sysdba`, or `sysoper`. See the examples for more information.
- `as_os_user`: The OS user to switch to before running queries. This is available on Unix or Linux only.
- `sqlplus_bin`: The path to the `sqlplus` binary. Default: `sqlplus`.
- `sqlcl_bin`: The path to the `sqlcl` binary if you're using SQLcl instead of `sqlplus`.

Use the following query method properties to access and filter query results:

- `rows`: The query result as an array of hashes.
- `row(number)`: The selected row from the query result, where `number` is a row number in the query result.
- `column(name)`: An array with values from the selected column.

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test for matching databases

```ruby
sql = oracledb_session(user: 'USERNAME', pass: 'PASSWORD')

describe sql.query('SELECT NAME AS VALUE FROM v$database;').row(0).column('value') do
  its('value') { should cmp 'ORCL' }
end
```

### Test for matching databases with custom host, SID, and sqlplus binary location

```ruby
sql = oracledb_session(user: 'USERNAME', pass: 'PASSWORD', host: 'ORACLE_HOST', sid: 'ORACLE_SID', sqlplus_bin: '/u01/app/oracle/product/12.1.0/dbhome_1/bin/sqlplus')

describe sql.query('SELECT NAME FROM v$database;').row(0).column('name') do
  its('value') { should cmp 'ORCL' }
end
```

### Test that a table contains a specified value in any row for the given column name

```ruby
sql = oracledb_session(user: 'USERNAME', pass: 'PASSWORD', service: 'ORACLE_SID')

describe sql.query('SELECT * FROM table_name;').column('column') do
  it { should include 'value' }
end
```

### Test that a tablespace exists as sysdba

This test changes the user (with `su`) to the specified user and runs `sqlplus / as sysdba` (or `sysoper`, `sysasm`).

```ruby
sql = oracledb_session(as_os_user: 'oracle', as_db_role: 'sysdba', service: 'ORACLE_SID')

describe sql.query('SELECT tablespace_name AS name FROM dba_tablespaces;').column('name') do
  it { should include 'TABLE_SPACE' }
end
```

The `as_os_user` option is available only on Unix-like systems and isn't supported on Windows. This option also requires that you're running InSpec as `root` or with `--sudo`.

### Test the number of rows in the query result

```ruby
sql = oracledb_session(user: 'USERNAME', pass: 'PASSWORD')

describe sql.query('SELECT * FROM my_table;').rows do
  its('count') { should eq 20 }
end
```

### Use data from a remote database query to build other tests

```ruby
sql = oracledb_session(
  user: 'USERNAME',
  password: 'PASSWORD',
  host: 'oracle.example.com',
  service: 'ORACLE_SID'
)

sql.query('SELECT * FROM files;').rows.each do |file_row|
  describe file(file_row['path']) do
    its('owner') { should eq file_row['owner'] }
  end
end
```

### Test using a Transparent Network Substrate (TNS) alias for TCPS/SSL connections

```ruby
sql = oracledb_session(
  user: 'system',
  password: 'Oracle123',
  tns_alias: 'XEPDB1_TCPS',
  env: {
    'TNS_ADMIN' => '/opt/oracle/network/admin',
    'LD_LIBRARY_PATH' => '/opt/oracle/instantclient',
    'ORACLE_HOME' => '/opt/oracle'
  }
)

describe sql.query('SELECT * FROM dual;').row(0).column('column_name') do
  its('value') { should eq 'X' }
end
```

Use the `tns_alias` option for TCPS/SSL connections as it allows proper TNS name resolution from `tnsnames.ora`.
When you use `tns_alias`, you can use the `env` hash to set required environment variables like `TNS_ADMIN` (the path to `tnsnames.ora` and wallet files).
This enables secure connections with SSL/TLS certificate validation.

## Matchers

{{< readfile file="content/inspec/7.1/reusable/md/inspec_matchers_link.md" >}}
