+++
title = "The Chef way of database compliance"
description = "Assess a database with Chef InSpec: write controls that query a live PostgreSQL instance, run them, read the findings, fix and reassess, and record approved exceptions."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/compliance/databases"
  parent = "overview/solutions/compliance"
  title = "Database compliance"
  weight = 11
+++

<!-- cspell:ignore authid rolsuper rolname rolcanlogin rolpassword psql mysqld sqlcmd sqlplus oracledb mssql tablespace mariadb -->

A database holds the data your business runs on, and its security settings drift like any other system's.
A DBA adds a role for a one-off report and never removes it.
A parameter changes during an incident and stays changed.
An engine version reaches end of life while the application still depends on it.
Checking these settings by hand gives you an answer that's out of date by the next change, and it doesn't give an auditor evidence they can compare from one assessment to the next.

[Chef InSpec](/inspec/latest/) assesses a database the way it assesses a server.
You write controls that state your requirements, and the controls query the running database and read its configuration.
Each control reports pass, fail, or skip, and you can run the same profile again on a schedule, so a setting that drifts shows up as a failing control instead of a surprise at the next audit.

## Who this page is for

**If you're accountable for the outcome**, such as a compliance, risk, or data platform owner, read this section and [What Chef covers for databases](#what-chef-covers-for-databases).
You'll learn what [Chef Compliance](/solutions/compliance/) gives you for databases, what it doesn't, and what evidence you can hand to an auditor.

**If you run the database or write the checks**, work through the rest of the page.
It builds and runs a small profile against a live PostgreSQL instance, shows how to read the results, and explains how to fix a finding and record an exception.
The same approach applies to MySQL, Microsoft SQL Server, Oracle Database, and MongoDB, and [Other database engines](#other-database-engines) shows how the connection differs for each.
If you haven't used Chef InSpec before, you don't need to read anything else first, but [The Chef way of SSH compliance](/solutions/compliance/ssh_baseline/) explains the profile, run, and results mechanics in more detail.

### What you get

- **A repeatable check.** Requirements are controls in a profile, reviewed like code, and run the same way each time.
- **Results you can act on.** Every control reports pass, fail, or skip, with the value it found and the value it expected.
- **Evidence.** Results export as JSON, so you can show what was checked, against what, and when.
- **Recorded exceptions.** A failure you've accepted becomes a [waiver](/inspec/latest/configure/waivers/) with a justification and an expiration date, instead of an unexplained red result.

### What you don't get

Chef InSpec assesses configuration; it doesn't enforce it.
It doesn't replace database access controls, encrypt data, monitor queries at runtime, or scan application code for SQL injection.
A passing assessment describes the database at the moment it ran and says nothing about the time between runs.

## What Chef covers for databases

Chef's coverage for databases comes from three sources.
Which one you start with depends on whether you need to meet a published benchmark or write requirements of your own.

| You need to | Use | Status |
| --- | --- | --- |
| Assess a database against a published benchmark | Chef audit content for the [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) and DISA STIGs, part of [Chef Premium Content](/premium_content/) | Available for many versions of PostgreSQL, MySQL, MariaDB, Microsoft SQL Server, Oracle Database, and MongoDB. Check the [coverage table](/premium_content/databases/) for yours. |
| Correct configuration to a benchmark | Chef remediation content, delivered as [Chef Infra](/client/latest/) cookbooks | Available for a narrower set of versions than audit. Audit and remediation versions are tracked separately. |
| Check requirements no benchmark covers | Chef InSpec resources that query a database or read its configuration | Available. You write the controls, and this page shows how. |

{{< note >}}

Audit and remediation content are separate, so a benchmark can have one, the other, or both.
Check the [coverage table](/premium_content/databases/) before you plan around a specific benchmark version.
Remediation content is part of Chef Premium Content, available to enterprise users.

{{< /note >}}

The published benchmarks are built from the same Chef InSpec resources that this page uses.
That means the profile you write here works alongside them: run the benchmark for the broad baseline, and add your own controls for requirements specific to your organization.

## How Chef InSpec reaches a database

A database has three places where compliance requirements live, and Chef InSpec has a way to check each one.

| What you check | Example | How |
| --- | --- | --- |
| Engine settings and live state | Whether connection logging is on, which roles are superusers, which TLS settings are active | A session resource, such as `postgres_session`, runs a SQL query and tests the result |
| Configuration files | A setting in `postgresql.conf` or `my.cnf` | A configuration resource, such as `postgres_conf` or `mysql_conf`, reads the file |
| The host the database runs on | File permissions on the data directory, operating system hardening | Core resources such as `file`, plus the operating system benchmarks |

Prefer a query over a configuration file when you can.
A query reports the value the engine is using now, and a file reports what someone intended, and the two can differ until the next restart.
Use a configuration resource for settings that aren't visible to a query, and for checks you want to run without database credentials.

{{< note >}}

Session resources such as `postgres_session` and `mysql_session` run the database's command-line client on the target system.
The client must be installed there, and the target system must be able to reach the database.
Chef InSpec runs your control code on the machine you run it from, so a password you read from an environment variable comes from that machine.

{{< /note >}}

## What you'll build

A Chef InSpec profile with five controls that check a PostgreSQL instance:

- The server runs an approved major version.
- Connections and disconnections are logged.
- Client connections can use TLS.
- Only approved roles have the superuser attribute.
- No login role is missing a password.

These are illustrative organization-specific requirements.
They aren't a published benchmark and not a complete database assessment.
Replace the approved versions and roles with your own, and extend the profile using the resources listed in [Extend the profile](#extend-the-profile).

## Before you begin

You need:

- Chef InSpec 5 or later, and any required license configuration.
  See the [installation steps](/inspec/latest/install/).
- The PostgreSQL client (`psql`) on the machine that runs the queries.
  Run Chef InSpec on the database host, or from another machine with the target set to the database host over SSH.
- A test database, not production.
  Assess a test instance first so you know what the expected results are.
- A dedicated assessment role, and its password in your approved secret store.
  Don't assess with a shared administrator account, and don't put the password in a profile, input file, script, or command-line argument.

The last control on this page reads `pg_authid`, which only a superuser can read.
If you don't want to give the assessment role that permission, leave that control out or ask your DBA for a view that exposes the same information.
The other controls need only the ability to run `SHOW` and to read `pg_roles`.

To confirm the role can connect, run:

```shell
psql -h <host> -U <assessment-role> -d postgres -c "SELECT version();"
```

Replace the placeholders with your database host and assessment role.

{{< warning >}}

If the account can't read something a control asks for, the control can fail or return an empty result that looks like a clean pass.
Confirm the account has the permissions each control needs before you report a database as compliant, or a requirement as violated.

{{< /warning >}}

## Create the profile

To create a profile for PostgreSQL, follow these steps:

1. Generate the profile:

   ```shell
   inspec init profile postgres-compliance-profile
   ```

1. Replace `postgres-compliance-profile/inspec.yml` with:

   ```yaml
   name: postgres-compliance-profile
   title: PostgreSQL database baseline
   maintainer: Example Organization
   copyright: Example Organization
   copyright_email: compliance@example.com
   license: Apache-2.0
   summary: Check PostgreSQL version, logging, encryption, and privileged roles
   version: 0.1.0
   inspec_version: '>= 5.0'
   inputs:
     - name: approved_major_versions
       description: PostgreSQL major versions your organization approves
       type: Array
       value: ['16', '17']
     - name: approved_superusers
       description: Roles allowed to have the superuser attribute
       type: Array
       value: ['postgres']
     - name: db_user
       description: Database role the assessment connects as
       type: String
       value: postgres
     - name: db_host
       description: Database host, as seen from the machine that runs the queries
       type: String
       value: localhost
     - name: db_port
       description: Database port
       type: Numeric
       value: 5432
   ```

   The inputs hold the values that differ between environments, so the controls don't change when the approved versions or roles do.
   The password isn't an input.
   The control reads it from an environment variable, so it stays out of every file.
   See [inputs](/inspec/latest/profiles/inputs/).

1. Remove the generated example control:

   ```shell
   rm postgres-compliance-profile/controls/example.rb
   ```

1. Create `postgres-compliance-profile/controls/baseline.rb`:

   ```ruby
   sql = postgres_session(
     input('db_user'),
     ENV.fetch('PG_PASSWORD'),
     input('db_host'),
     input('db_port')
   )

   control 'pg-approved-version' do
     impact 0.7
     title 'PostgreSQL runs an approved major version'
     desc 'Unsupported major versions no longer receive security fixes.'

     describe sql.query('SHOW server_version;', ['postgres']).output do
       it { should match(/\A(#{input('approved_major_versions').join('|')})\./) }
     end
   end

   control 'pg-log-connections' do
     impact 0.5
     title 'Connections and disconnections are logged'
     desc 'Connection logs show who connected and when, which an investigation needs.'

     %w[log_connections log_disconnections].each do |setting|
       describe sql.query("SHOW #{setting};", ['postgres']) do
         its('output') { should eq 'on' }
       end
     end
   end

   control 'pg-ssl-enabled' do
     impact 0.7
     title 'Client connections can use TLS'
     desc 'Without TLS, credentials and data cross the network in clear text.'

     describe sql.query('SHOW ssl;', ['postgres']) do
       its('output') { should eq 'on' }
     end
   end

   control 'pg-superusers-approved' do
     impact 1.0
     title 'Only approved roles have the superuser attribute'
     desc 'A superuser bypasses every permission check in the database.'

     superusers = sql.query('SELECT rolname FROM pg_roles WHERE rolsuper ORDER BY rolname;', ['postgres']).output.split("\n")

     describe superusers do
       it { should match_array input('approved_superusers') }
     end
   end

   control 'pg-no-passwordless-login-roles' do
     impact 1.0
     title 'No login role is missing a password'
     desc 'A login role with no password relies entirely on pg_hba.conf rules to stop unauthenticated use.'

     describe sql.query('SELECT rolname FROM pg_authid WHERE rolcanlogin AND rolpassword IS NULL;', ['postgres']) do
       its('output') { should eq '' }
     end
   end
   ```

   The [`postgres_session`](/inspec/latest/resources/core/postgres_session/) resource takes the user, password, host, and port, and `query` runs a SQL statement in the database you name.
   The `output` property holds the text the query returns, so an empty string means the query returned no rows.
   Keep control IDs stable so you can compare results over time and apply waivers.
   Choose impact values that match your organization's risk model.

## Validate and run the assessment

To check the profile and run it against the database, follow these steps:

1. Validate the profile structure and control syntax:

   ```shell
   inspec check postgres-compliance-profile
   ```

   Validation doesn't confirm database access or that the controls produce correct results.

1. Read the password from your secret store into an environment variable, then run the profile:

   ```shell
   export PG_PASSWORD="$(<command that reads the password from your secret store>)"
   mkdir -p results
   inspec exec postgres-compliance-profile \
     --reporter cli json:results/postgres-compliance.json
   ```

   This runs the profile on the machine you're logged in to, which is correct when it's the database host or can reach it.
   To assess a database host over SSH instead, add a target:

   ```shell
   inspec exec postgres-compliance-profile -t ssh://<user>@<db-host> \
     --reporter cli json:results/postgres-compliance.json
   ```

   Chef InSpec connects over SSH and runs `psql` on the database host, so the client must be installed there.
   Use a unique results path for each database and run so later assessments don't overwrite earlier evidence.

1. Review the results:

   | Outcome | Interpretation |
   | --- | --- |
   | Passed | The collected values met the check |
   | Failed | A check wasn't met. Confirm the assessment account can read the object before you conclude the database violates the requirement. |
   | Skipped | The check wasn't evaluated. A skip isn't evidence of compliance. |
   | Waived | An approved exception changes how a failure is handled. It doesn't show the requirement is met. |

   The following output is from a test PostgreSQL 16 database with default settings and one login role that has no password.
   Your results differ, and the output here is trimmed.

   ```text
   ✔  pg-approved-version: PostgreSQL runs an approved major version
      ✔  16.15 (Debian 16.15-1.pgdg13+2) is expected to match /\A(16|17)\./
   ×  pg-log-connections: Connections and disconnections are logged (2 failed)
      ×  PostgreSQL query: SHOW log_connections; output is expected to eq "on"
      expected: "on"
           got: "off"
      ×  PostgreSQL query: SHOW log_disconnections; output is expected to eq "on"
      expected: "on"
           got: "off"
   ×  pg-ssl-enabled: Client connections can use TLS
      ×  PostgreSQL query: SHOW ssl; output is expected to eq "on"
      expected: "on"
           got: "off"
   ✔  pg-superusers-approved: Only approved roles have the superuser attribute
      ✔  ["postgres"] is expected to contain exactly "postgres"
   ×  pg-no-passwordless-login-roles: No login role is missing a password
      ×  PostgreSQL query: SELECT rolname FROM pg_authid WHERE rolcanlogin AND rolpassword IS NULL; output is expected to eq ""
      expected: ""
           got: "report_reader"

   Profile Summary: 2 successful controls, 3 control failures, 0 controls skipped
   Test Summary: 2 successful, 4 failures, 0 skipped
   ```

   Each failure names the value it found, so you can act on it without rerunning the query by hand.
   The last control names the role that has no password.

For result formats and CLI options, see [reporters](/inspec/latest/configure/reporters/) and the [CLI reference](/inspec/latest/reference/cli/).

When a run finishes, Chef InSpec exits with a code you can use in a pipeline.
In the test above, a run with failing controls exited with `100`, and a run with no failures but with skipped controls exited with `101`.
Check the [CLI reference](/inspec/latest/reference/cli/) for the full list before you build a pipeline gate around them.

## Fix a finding and reassess

When a control fails, correct the database through the process your team already uses, not by editing the profile.
In a test database, you can correct the findings above with SQL.
Run these statements as a superuser:

```sql
ALTER SYSTEM SET log_connections = 'on';
ALTER SYSTEM SET log_disconnections = 'on';
SELECT pg_reload_conf();
ALTER ROLE report_reader PASSWORD '<a strong password from your secret store>';
```

Run the same profile again and keep both results:

```shell
inspec exec postgres-compliance-profile \
  --reporter cli json:results/postgres-compliance-after-fix.json
```

The logging and password controls now pass, and the pair of files is your evidence that the gaps existed and were closed.
The TLS control still fails, because turning on TLS needs a server certificate and a restart.
That one is a planned change, not a quick fix, which is what the next section is for.
[Step 6 of SSH compliance](/solutions/compliance/ssh_baseline/#step-6-fix-the-finding-and-reassess) shows the same fix-and-reassess loop on a single control.

For benchmark settings that Chef remediation content covers, check the [coverage table](/premium_content/databases/) for your engine and version.
Test remediation content with [Chef Workstation](/workstation/latest/) before you apply it to a production database.

## Record an approved exception

Use a waiver for a reviewed, time-bound exception rather than changing a control so one database passes.
To waive the TLS check for an isolated development database, follow these steps:

1. Create `postgres-compliance-profile/waivers.yml`:

   ```yaml
   pg-ssl-enabled:
     run: false
     justification: >-
       Exception DB-1177. This is an isolated development database with no
       external network path. Approved by the data platform owner.
     expiration_date: 2027-03-31
   ```

   Replace the control ID, reference, approver, and expiration date with the approved exception, and choose a future date.

1. Run the assessment with the waiver:

   ```shell
   inspec exec postgres-compliance-profile \
     --waiver-file postgres-compliance-profile/waivers.yml \
     --reporter cli json:results/postgres-compliance-waived.json
   ```

   `run: false` skips the control, and the report shows the justification.
   An expired waiver no longer applies, and the check determines the result again.

   ```text
   ↺  pg-ssl-enabled: Client connections can use TLS
      ↺  Skipped control due to waiver condition: Exception DB-1177. This is an isolated development database ...

   Profile Summary: 4 successful controls, 0 control failures, 1 control skipped
   ```

{{< warning >}}

Chef InSpec applies a waiver by control ID, not by database.
Select the waiver file and the database together, and don't reuse a waiver file for a different database without checking that the exception still applies.

{{< /warning >}}

Report waived controls separately from controls that meet the requirement.
For supported fields, see [waivers](/inspec/latest/configure/waivers/).

## Other database engines

The approach is the same for every engine: a session resource runs a query, and a control tests the result.
What differs is how you connect and what the resource returns.

| Engine | Resource | Connection | Notes |
| --- | --- | --- | --- |
| PostgreSQL | [`postgres_session`](/inspec/latest/resources/core/postgres_session/) | User, password, host, port, and optional socket path | Returns the query text in `output` |
| MySQL | [`mysql_session`](/inspec/latest/resources/core/mysql_session/) | User, password, host, port, and optional socket | Returns `stdout`, `stderr`, and `exit_status`, as well as `output` |
| Microsoft SQL Server | [`mssql_session`](/inspec/latest/resources/core/mssql_session/) | User and password, or Windows authentication, plus host, instance, and database | Returns rows you select with `row` and `column` |
| Oracle Database | [`oracledb_session`](/inspec/latest/resources/core/oracledb_session/) | User and password, service or SID, host, and port, or a TNS alias for TLS connections | Needs `sqlplus` or SQLcl on the target |
| MongoDB | [`mongodb_session`](/inspec/resource_packs/mongodb/) in the MongoDB resource pack | See the resource pack | In Chef InSpec 7 and later, the pack is a separate gem you add as a dependency |

For MySQL, a control that checks that `LOAD DATA LOCAL` is off and that no anonymous accounts exist looks like this:

```ruby
sql = mysql_session('<assessment-user>', ENV.fetch('MYSQL_PASSWORD'), 'localhost', 3306)

control 'mysql-local-infile' do
  impact 0.5
  title 'LOAD DATA LOCAL is off'
  desc 'Client-side file loading lets a compromised server read files from a client.'

  describe sql.query('SELECT @@local_infile;') do
    its('stdout.strip') { should eq '0' }
  end
end

control 'mysql-no-anonymous-users' do
  impact 1.0
  title 'No anonymous accounts exist'
  desc 'An anonymous account lets anyone connect without a user name.'

  describe sql.query("SELECT user FROM mysql.user WHERE user = '';") do
    its('stdout.strip') { should eq '' }
  end
end
```

Replace `<assessment-user>` with your assessment account.
These two controls pass against a MySQL 8.4 test instance with default settings.

Each resource page lists the connection options, including encrypted connections, so check it before you point a profile at a production database.
For configuration files, [`postgres_conf`](/inspec/latest/resources/core/postgres_conf/) and [`mysql_conf`](/inspec/latest/resources/core/mysql_conf/) read `postgresql.conf` and `my.cnf`, and the MongoDB resource pack includes `mongodb_conf`.

## Assess a fleet of databases

A single run is a snapshot.
To cover many databases and detect drift, decide where the profile runs and how it gets credentials.

| Where the database runs | How to run the profile |
| --- | --- |
| On a node that Chef Infra Client manages | Turn on the [Compliance Phase](/client/latest/features/chef_compliance_phase/), so the profile runs as part of each Chef Infra Client run |
| On a node Chef Infra Client doesn't manage | Create a [scan job](/automate/scan_jobs/) in [Chef Automate](/automate/) with an SSH credential from [node credentials](/automate/node_credentials/) |
| A managed database service with no host you can log in to | Run Chef InSpec from a machine that has the database client and network access to the service, such as a pipeline runner |

The Compliance Phase lets you pass inputs to a profile and set a waiver file for the node.
Node attributes are stored with the node object, so pass only values that aren't secret, such as the approved versions and roles.
Keep the database password out of attributes and read it on the node from your secret store.
Scan jobs log in to the node over SSH, but they don't document how a database password reaches the profile, so confirm how your scan job supplies it before you rely on it.

Send results to [compliance reporting](/automate/reports/) to see them by node, profile, and control.
For a mixed fleet, [Common compliance scenarios](/solutions/compliance/#common-compliance-scenarios) shows how databases fit alongside servers and cloud accounts.

## Keep the evidence and detect drift

Compare runs only after accounting for changes to the profile or the inputs:

| Change between runs | Interpretation |
| --- | --- |
| Passed to failed, same profile and inputs | A new finding or drift |
| Failed to passed, same profile and inputs | A correction |
| Failed in consecutive runs | A persistent finding |
| Changed profile, inputs, or database | A scope change that needs separate interpretation |
| A waiver granted or expired | An exception change |

With each run, store the Chef InSpec version, the profile version, the inputs, the database you assessed, and the time of the run, along with the JSON results.
The JSON report records the profile and its results, so keep the other items alongside it.
Keep failed runs as well as passing ones, and keep credentials out of the stored evidence.

## Extend the profile

Good next controls include the requirements your benchmark or policy names that you haven't written yet.
For PostgreSQL, examples are `pg_hba.conf` rules that require TLS or password authentication, role membership, and extension allowlists.
Start from a published benchmark where one exists for your engine and version, and write your own controls for the rest.
To learn how resource packs and custom resources work, see [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/).

Before you expand from one database to a fleet:

- Give every database an owner and an environment tier.
- Keep policy values in inputs and stable requirements in controls.
- Select database-specific waivers explicitly.
- Use a separate, least-privilege assessment account for each engine.
- Report which databases you assessed, which you couldn't reach, and which you excluded, so a coverage figure always has a denominator.

## Related documentation

- [Databases coverage](/premium_content/databases/)
- [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [The Chef way of SSH compliance](/solutions/compliance/ssh_baseline/)
- [Profiles](/inspec/latest/profiles/)
- [Compliance reporting](/automate/reports/)
- [Compliance overview](/solutions/compliance/)
