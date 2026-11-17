+++
title = "The Chef way of database config management"
description = "Configure the servers that run your databases with Chef: write the database settings and host settings as code, converge servers on a schedule, correct drift, and apply changes with the reload or restart that each setting needs."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/infra_management/database_config"
  parent = "overview/solutions/infra_management"
  title = "Database config management"
  weight = 20
+++

<!-- cspell:ignore postmaster sighup postgresql mysqld includedir redisio daemonsets -->

A database is only as dependable as its configuration.
Connection limits, memory settings, logging thresholds, and the operating system settings under them decide how a database behaves under load.
When those are set by hand, two servers that should match don't.
A setting is raised during an incident and never lowered.
A replica is built from last year's notes, and the difference only shows up as a slow query on one server.

You need one reviewed definition of how a database server should be configured, and a way to keep every server matching it.
Chef does this by letting you describe the configuration as code, and by running an agent, Chef Infra Client, on each server that makes the server match that code, again and again.
The agent changes only what has drifted, so a hand-made change doesn't survive for long, and every change is reported.

This page covers the database server host: the packages, the configuration files, and the service.
It's honest about the rest: Chef Infra Client doesn't create your databases, run your schema migrations, or move your data.
See [Where Chef fits](#where-chef-fits).

## Who this page is for

**If you're accountable for the outcome**, such as a database or platform owner, read this section and [Where Chef fits](#where-chef-fits).
You'll learn what Chef gives you for the servers under your databases, what it doesn't, and why a configuration change can need a restart that you have to plan.

**If you run the database servers**, work through the rest of the page.
It builds a small cookbook that installs PostgreSQL and manages its settings, converges a server, shows a manual change being corrected, shows the difference between a reload and a restart, and tests the result.
If you haven't used Chef before, you don't need to read anything else first.

### What you get

- **Consistency.** Every server of a given type is built from the same code, so two servers can't quietly diverge.
- **Drift correction.** A change made by hand is reverted at the next run, and the run reports what it changed.
- **Different values where you need them.** A reporting server can have more connections than a small one, without copying the cookbook.
- **Controlled change.** A change is tested on a workstation, promoted through groups of servers, and rolled out a group at a time.
- **A record.** Each run reports which resources it changed, so you can see when a server's configuration changed.

### What you don't get

Chef Infra Client configures the server.
It doesn't know what a safe moment to restart your database is, it doesn't fail over to a replica for you, and it doesn't back anything up.
A server is in a known state only for the settings you wrote code for, and only as of its last successful run.

## Where Chef fits

Database configuration spans several layers.
Chef Infra Client covers the first two, and the rest of the Chef platform helps you check the result.

| Layer | What it means | Chef piece | On this page |
| --- | --- | --- | --- |
| The server host | Packages, kernel parameters, resource limits, and the service | [Chef Infra Client](/client/latest/) resources such as `package`, `sysctl`, and `service` | Yes |
| The database server's configuration | The files the database reads, such as `postgresql.conf` or `my.cnf` | The `template` and `file` resources | Yes |
| Credentials | Passwords and keys that your configuration needs | The [`secret` helper](/client/latest/infra_language/secrets/) and the `sensitive` property | See [Handle credentials](#handle-credentials) |
| Inside the database | Databases, roles, schemas, extensions, replication, and data | Not built into Chef Infra Client. Community cookbooks provide resources for some of it | See [Community cookbooks](#community-cookbooks) |
| Assessment | Checking that a running database meets your requirements | [Chef InSpec](/inspec/latest/) | See [Database compliance](/solutions/compliance/databases/) |

Chef Infra Client has no built-in resources for databases.
There are no `mysql_*` or `postgresql_*` resources in the bundled resource list, so this page doesn't use any.
The page builds on `package`, `template`, and `service`, which work the same way for every database.

The pieces that make up the Chef way for the database server layer:

| Idea | What it means | Chef piece |
| --- | --- | --- |
| Describe the state you want | You write what a server should look like, not the steps to get there. A `template` resource says what a file should contain, and Chef works out how. | Chef Infra cookbooks, recipes, and resources |
| Converge, don't script | An agent on each server compares the server with the code and changes only what doesn't match. Running it twice changes nothing the second time. | Chef Infra Client |
| Keep the code in one place | Servers ask a central service for the cookbooks and policy that apply to them. | Chef Declarative State Management (DSM) in [Chef 360 Platform](/360/latest/), the direct replacement for Chef Infra Server |
| Test before you ship, and roll out in groups | You test on a workstation first, then promote the same code through groups of servers. | [Chef Workstation](/workstation/latest/) and [Policyfiles](/policyfile/) |

## What you'll build

A Chef Infra cookbook, `postgres_baseline`, that does these things on a Linux server:

- Installs the PostgreSQL package and starts the service.
- Writes a drop-in configuration file that sets `max_connections`, `shared_buffers`, and `log_min_duration_statement`.
- Applies a change with a reload, or with a restart if you ask for one.

It's a small stand-in for real work.
The same pattern applies to MySQL, MariaDB, and other databases, because it relies on a package, a file, and a service, and not on anything that's specific to one product.
You'll run it on a Linux test machine, change the file by hand, and watch Chef correct it.
Then you'll change three settings and see that a reload applies only some of them.

## Before you begin

You need:

- [Chef Workstation](/workstation/latest/install/) on the machine where you write and test code.
  It includes the `chef` and `chef-client` commands and the testing tools.
- A Linux test machine, such as a disposable virtual machine, where you can run commands as `root`.
  The example installs PostgreSQL with `apt`, so it targets Ubuntu or Debian, and it writes files under `/etc`.
  Don't run it on a server that holds data you care about.
- A Progress Chef license, for bootstrapping nodes and for commercial downloads.
  Chef Infra Client might ask you to accept the license terms the first time you run it.

The output on this page comes from Chef Infra Client 18.10 running on an Ubuntu 24.04 machine with systemd, which installed PostgreSQL 16.
Output from a later release or another distribution might differ slightly.

## Write the cookbook

To create a cookbook that manages your database configuration, follow these steps:

1. Create a repository and a cookbook inside it:

   ```shell
   chef generate repo chef-repo
   cd chef-repo
   chef generate cookbook cookbooks/postgres_baseline
   ```

   The cookbook contains a `recipes/default.rb` for your recipe, a `metadata.rb`, a `Policyfile.rb`, a `kitchen.yml` for testing, and a `test` directory.
   See [cookbooks](/client/latest/cookbooks/) for what each part is for.

1. Create `cookbooks/postgres_baseline/attributes/default.rb`:

   ```ruby
   # The PostgreSQL major version and cluster name that your distribution's package creates.
   default['postgres_baseline']['version'] = '16'
   default['postgres_baseline']['cluster'] = 'main'

   default['postgres_baseline']['settings'] = {
     'max_connections' => 100,
     'shared_buffers' => '128MB',
     'log_min_duration_statement' => 250,
   }

   # Restart PostgreSQL when the settings change. The default is a reload.
   default['postgres_baseline']['restart_on_change'] = false
   ```

   An attribute holds a value that changes between servers or server groups, so the recipe doesn't have to.
   The `restart_on_change` attribute is off by default, because restarting a database needs planning.
   See [Reload or restart](#reload-or-restart).

1. Create `cookbooks/postgres_baseline/templates/postgresql-chef.conf.erb`:

   ```erb
   # Managed by Chef. Local edits are replaced on the next Chef Infra Client run.
   <% @settings.sort.each do |name, value| -%>
   <%= name %> = <%= value.is_a?(String) ? "'#{value}'" : value %>
   <% end -%>
   ```

   This is a PostgreSQL configuration drop-in file.
   The PostgreSQL documentation says `postgresql.conf` can contain `include_dir` directives, and that only files whose names end in `.conf` are included.
   The Ubuntu package turns this on for a `conf.d` directory.
   Using a drop-in means Chef owns one small file and doesn't overwrite the main configuration file that the package installs.
   Other distributions lay out their files differently, so check where your package expects drop-in files.

1. Replace `cookbooks/postgres_baseline/recipes/default.rb` with:

   ```ruby
   settings = node['postgres_baseline']
   version = settings['version']
   unit = "postgresql@#{version}-#{settings['cluster']}"
   conf_dir = "/etc/postgresql/#{version}/#{settings['cluster']}/conf.d"

   apt_update 'postgres_baseline'

   package "postgresql-#{version}"

   service unit do
     action [:enable, :start]
   end

   template "#{conf_dir}/99-chef.conf" do
     source 'postgresql-chef.conf.erb'
     owner 'postgres'
     group 'postgres'
     mode '0644'
     variables(settings: settings['settings'])
     notifies settings['restart_on_change'] ? :restart : :reload, "service[#{unit}]", :delayed
   end
   ```

   Each block is a [resource](/client/latest/resources/bundled/).
   [`apt_update`](/client/latest/resources/bundled/apt_update/) refreshes the package lists, and [`package`](/client/latest/resources/bundled/package/) installs PostgreSQL.
   [`service`](/client/latest/resources/bundled/service/) enables and starts it.
   The [`template`](/client/latest/resources/bundled/template/) writes the drop-in file, and asks the service to reload, or restart, at the end of the run, but only if the file changed.
   The resources state what should be true and don't say how to do it, because Chef Infra Client works that out for the platform it's running on.

   On Ubuntu and Debian, the unit that runs a cluster is `postgresql@16-main`, not `postgresql`.
   On the test machine, the `postgresql` unit is a wrapper whose reload command does nothing, so a `reload` aimed at it wouldn't reload anything.
   Check which unit your distribution uses.

## Converge a server and correct drift

To see Chef Infra Client apply the cookbook and then undo a manual change, follow these steps on your Linux test machine:

1. Run the recipe in local mode, which runs a lightweight Chef Infra Server on the machine for the length of the run:

   ```shell
   chef-client -z -o 'recipe[postgres_baseline]'
   ```

   Accept the license prompt if you see one.
   On a new server, the package is installed and the file is created:

   ```text
   Converging 4 resources
   Recipe: postgres_baseline::default
     * apt_update[postgres_baseline] action periodic
       * execute[apt-get -q update] action run
         - execute ["apt-get", "-q", "update"]
     * apt_package[postgresql-16] action install
       - install version 16.15-0ubuntu0.24.04.1 of package postgresql-16
     * service[postgresql@16-main] action enable
       - enable service service[postgresql@16-main]
     * service[postgresql@16-main] action start
       - start service service[postgresql@16-main]
     * template[/etc/postgresql/16/main/conf.d/99-chef.conf] action create
       - create new file /etc/postgresql/16/main/conf.d/99-chef.conf
       @@ -1,4 +1,8 @@
       +# Managed by Chef. Local edits are replaced on the next Chef Infra Client run.
       +log_min_duration_statement = 250
       +max_connections = 100
       +shared_buffers = '128MB'
       - change owner from '' to 'postgres'
     * service[postgresql@16-main] action reload
       - reload service service[postgresql@16-main]
   Infra Phase complete, 8/10 resources updated in 30 seconds
   ```

1. Run it again.
   Nothing has drifted, so nothing changes, and the `template` resource reports `(up to date)`.
   The service isn't reloaded, because the file didn't change.
   This is idempotence, and it's why you can run Chef on a schedule without worrying about what it will do to a server that's already correct.

1. Make a change by hand, as an administrator might during an incident:

   ```shell
   sed -i 's/max_connections = 100/max_connections = 500/' /etc/postgresql/16/main/conf.d/99-chef.conf
   ```

1. Run the recipe again:

   ```shell
   chef-client -z -o 'recipe[postgres_baseline]'
   ```

   Chef Infra Client finds the difference, reverts it, reloads the service, and shows exactly what it changed:

   ```text
   * template[/etc/postgresql/16/main/conf.d/99-chef.conf] action create
     - update content in file /etc/postgresql/16/main/conf.d/99-chef.conf from 9cadbe to 76e7cb
       @@ -1,5 +1,5 @@
        # Managed by Chef. Local edits are replaced on the next Chef Infra Client run.
        log_min_duration_statement = 250
       -max_connections = 500
       +max_connections = 100
        shared_buffers = '128MB'
   * service[postgresql@16-main] action reload
     - reload service service[postgresql@16-main]
   ```

The output here is from a test run, trimmed, with timings shortened.
Your checksums and timings differ.

For the full sequence of steps in a run, see [the Chef Infra Client run](/client/latest/#the-chef-infra-client-run).

## Reload or restart

Not every database setting takes effect the same way.
This is the part of database configuration that surprises people most, and it decides how you roll a change out.

The PostgreSQL documentation says the configuration is reread when the server receives a reload signal, and that some parameters can only be set at server start.
For those parameters, changes in the file are ignored until the server restarts.
The `pg_settings` view shows which is which: its `context` column tells you how a setting changes, and `pending_restart` is true when a value in the file needs a restart to take effect.

To see this with Chef, change three settings and let the cookbook reload PostgreSQL.
This first-boot JSON file, `pool.json`, sets new values for one run:

```json
{
  "postgres_baseline": {
    "settings": {
      "max_connections": 200,
      "shared_buffers": "256MB",
      "log_min_duration_statement": 500
    }
  }
}
```

```shell
chef-client -z -o 'recipe[postgres_baseline]' -j pool.json
```

Chef rewrites the file and reloads the service.
Then compare what the database reports with what the file says, using a query like this one:

```sql
SELECT name, setting, context, pending_restart
FROM pg_settings
WHERE name IN ('max_connections', 'shared_buffers', 'log_min_duration_statement')
ORDER BY name;
```

Before the change, and then after the reload:

```text
-- Before
log_min_duration_statement | 250   | superuser  | f
max_connections            | 100   | postmaster | f
shared_buffers             | 16384 | postmaster | f

-- After the reload
log_min_duration_statement | 500   | superuser  | f
max_connections            | 100   | postmaster | t
shared_buffers             | 16384 | postmaster | t
```

The reload applied `log_min_duration_statement`.
The other two settings are in the file, but the server is still running with the old values, and `pending_restart` says so.
The `shared_buffers` value is in 8 kB blocks, so 16384 is 128MB.

After a restart of `postgresql@16-main`, all three take effect:

```text
-- After the restart
log_min_duration_statement | 500   | superuser  | f
max_connections            | 200   | postmaster | f
shared_buffers             | 32768 | postmaster | f
```

This is why `restart_on_change` is an attribute, and why it's off by default.
A reload is safe to do on every change.
A restart interrupts connections, so decide when it happens.

| If the change affects | Chef can | You decide |
| --- | --- | --- |
| A setting that applies on reload | Reload the service at the end of the run | Nothing more, in most cases |
| A setting that needs a restart | Write the file, and with `restart_on_change` on, restart the service | When the restart happens, and what happens to connections and replicas |

Chef can't tell you which of your settings need a restart, and it can't pick a safe moment.
Use `pending_restart` to find servers that are waiting for a restart, and read the PostgreSQL documentation for each parameter you manage:

- [Setting parameters](https://www.postgresql.org/docs/current/config-setting.html) covers `include_dir`, reloading, and settings that need a restart.
- [The `pg_settings` view](https://www.postgresql.org/docs/current/view-pg-settings.html) covers `context` and `pending_restart`.

MySQL has similar rules.
Its option files support `!includedir`, the files in that directory must end in `.cnf`, and MySQL makes no guarantee about the order in which it reads them.
`SET PERSIST` writes a separate file, `mysqld-auto.cnf`, and the MySQL documentation says to leave the management of that file to the server.
If you use `SET PERSIST`, decide which of the two, your cookbook or the database, owns each variable.
See [option files](https://dev.mysql.com/doc/refman/8.4/en/option-files.html) and [persisted system variables](https://dev.mysql.com/doc/refman/8.4/en/persisted-system-variables.html).

## Use different settings for different servers

Database servers aren't all the same: a reporting server, a small service database, and a replica need different values.
Keep the logic in the cookbook the same, and change only the attributes.

For a fleet, set the attributes in a Policyfile for each group of servers, instead of a JSON file.
A Policyfile locks a run list and cookbook versions into one versioned revision, and it can carry attributes:

```ruby
name 'postgres-reporting'
default_source :supermarket
run_list 'postgres_baseline::default'
cookbook 'postgres_baseline', path: 'cookbooks/postgres_baseline'
default['postgres_baseline']['settings'] = {
  'max_connections' => 200,
  'shared_buffers' => '256MB',
  'log_min_duration_statement' => 500,
}
```

Running `chef install` in the repository evaluates this file and writes `Policyfile.lock.json`, which records the run list, the cookbook, and the attributes.
See [Policyfiles](/policyfile/) for the full syntax.

The settings in a cookbook are the ones that you manage.
Settings that you don't manage keep their defaults, or whatever the package or an administrator set.
If you want a setting to be the same everywhere, put it in the cookbook.

## Handle credentials

Database configuration often needs a password or a key.
Don't write one into a recipe, an attribute file, or a template.
The Chef documentation describes these options:

- **The `secret` helper.** It reads a secret from AWS Secrets Manager, Akeyless Vault, Azure Key Vault, or HashiCorp Vault. It was a beta feature in Chef Infra Client 17.5 and is fully supported in Chef Infra Client 18. See [the `secret` helper](/client/latest/infra_language/secrets/).
- **Encrypted data bags and Chef Vault.** See [data bags](/client/latest/policy/data_bags/) and [Chef Vault](/workstation/latest/tools/chef_vault/). Both depend on the Chef Infra Server. The Chef documentation doesn't say whether they're supported on DSM, so check before you build on them.

The documented minimum for the `secret` helper looks like this.
This snippet is from the documentation, and it isn't part of the tested example:

```ruby
file '/etc/myapp/db-credentials' do
  content secret(name: 'db-password', service: :aws_secrets_manager)
  mode '0600'
  sensitive true
end
```

The `sensitive` property tells Chef Infra Client not to log the resource's data.
Set it on any resource that handles a credential.
The Chef documentation doesn't recommend one of these options over the others for database passwords, so choose by where your secrets already live.

## Test before you ship

A cookbook that changes database servers needs testing before it runs on them.
Chef Workstation includes the tools for that, so a change can be checked on your workstation or in a disposable machine first.

| Tool | What it checks |
| --- | --- |
| Cookstyle | Style and common mistakes in your Chef Infra code |
| [ChefSpec](/workstation/latest/tools/chefspec/) | What a recipe would do, without running it on a system |
| [Test Kitchen](/workstation/latest/tools/kitchen/) | Whether the cookbook converges on a real, throwaway machine, and whether the result passes your tests |
| [Chef InSpec](/inspec/latest/) | Whether the finished system meets requirements, including queries to the database itself |

Here's a ChefSpec test for this cookbook.
Create `cookbooks/postgres_baseline/spec/unit/recipes/default_spec.rb`:

```ruby
require 'chefspec'

describe 'postgres_baseline::default' do
  platform 'ubuntu'

  it 'installs the PostgreSQL package' do
    expect(chef_run).to install_package('postgresql-16')
  end

  it 'writes the drop-in file with the settings' do
    expect(chef_run).to render_file('/etc/postgresql/16/main/conf.d/99-chef.conf')
      .with_content(/max_connections = 100/)
  end

  it 'reloads PostgreSQL when the drop-in changes' do
    template = chef_run.template('/etc/postgresql/16/main/conf.d/99-chef.conf')
    expect(template).to notify('service[postgresql@16-main]').to(:reload).delayed
  end

  context 'when restart_on_change is true' do
    override_attributes['postgres_baseline'] = { 'restart_on_change' => true }

    it 'restarts PostgreSQL instead' do
      template = chef_run.template('/etc/postgresql/16/main/conf.d/99-chef.conf')
      expect(template).to notify('service[postgresql@16-main]').to(:restart).delayed
    end
  end
end
```

Run it from the cookbook directory:

```shell
chef exec rspec spec
```

```text
....

4 examples, 0 failures
```

ChefSpec runs the recipe in memory, so you can run this test on a laptop without installing a database.
It checks what the recipe declares, such as the file and the notification, but it doesn't start a database.
Use Test Kitchen to converge the cookbook on a real Linux machine before you roll it out.
The `kitchen.yml` that `chef generate cookbook` creates is the starting point.

To check the database itself after a converge, Chef InSpec has resources that run queries, including [`postgres_session`](/inspec/resources/postgres_session/) and [`mysql_session`](/inspec/resources/mysql_session/).
The [Database compliance](/solutions/compliance/databases/) page lists the database benchmarks that Chef Compliance covers.

## Roll changes out safely

Changing the configuration of a running database carries more risk than changing a stateless server, because other systems depend on it.
Chef gives you ways to control which servers change and when.
The decisions about the data and the applications are yours, and the Chef documentation doesn't cover them.

**Promote through policy groups.**
A Policyfile locks a run list and cookbook versions together into one versioned revision.
A policy group binds a set of servers to a specific revision.
Use a small group of non-production or low-risk servers to try a change first, and promote the same revision to the next group when it's healthy.
Servers in the later groups don't see the change until you promote it.
Chef Workstation's `chef push` uploads a revision to a policy group:

```shell
chef install
chef push canary Policyfile.lock.json
```

See [Policyfiles](/policyfile/) and [policy groups in DSM](/360/latest/use/operators/dsm_operations/#policy-groups).

**Decide how each change is applied.**
Use the table in [Reload or restart](#reload-or-restart).
A change to a setting that applies on reload can go out with every run.
A change to a setting that needs a restart should go out with a plan for the restart.

**Plan for the databases that depend on each other.**
If you run replicas or a cluster, changing every server at once can take them all down together.
Chef doesn't coordinate that, and the Chef documentation doesn't describe maintenance periods or restarting database services.
Use separate policy groups for servers that can't change at the same time.

**Don't let a schedule surprise you.**
A server that runs Chef every 30 minutes applies a change at its next run after you promote it.
For servers where a restart isn't acceptable at any time, keep `restart_on_change` off and restart them yourself.

## Run Chef on a schedule

A server stays in a known state only if Chef runs regularly.
The `chef_client_systemd_timer` resource sets up Chef Infra Client to run as a systemd timer, which is how you manage the schedule with Chef itself:

```ruby
chef_client_systemd_timer 'Run Chef Infra Client every hour' do
  interval '1hr'
end
```

By default, the timer runs every 30 minutes with a 5-minute random delay (`splay`), so Chef Infra Client runs on your servers don't all start at the same time.
See [`chef_client_systemd_timer`](/client/latest/resources/bundled/chef_client_systemd_timer/) for every property, and [`chef_client_cron`](/client/latest/resources/bundled/chef_client_cron/) for the cron equivalent.

This snippet is from the resource reference and isn't part of the tested example.

Pick an interval that matches how fast you need drift corrected.
If `restart_on_change` is on for a group, remember that a configuration change can restart the database at any run.

## Bring servers under management

A node is any machine Chef manages.
Database servers enroll the same way as any other Linux server, and they get their cookbooks and policy from the same central service.

| Method | How it works |
| --- | --- |
| `knife bootstrap` | Installs Chef Infra Client on a node over SSH and registers it. Add `--policy-name` and `--policy-group` to apply a policy on the first run. See [bootstrap a node](/client/latest/install/bootstrap/). |
| Chef 360 enrollment | Enroll nodes into Node Management with a self-enrollment key or script, a cookbook, or a CSV file. See [node enrollment](/360/latest/use/operators/node_enrollment/). |
| First-boot scripts | Install Chef Infra Client with user data or another post-deployment script when a machine is created. See [unattended bootstrapping](/client/latest/install/bootstrap/#unattended-bootstrapping). |

The central service is Chef Declarative State Management (DSM) in Chef 360 Platform, which is the direct replacement for Chef Infra Server.
All of the capabilities of Chef Infra Server are available in DSM.
If you run Chef Infra Server today, see [Migrate from Chef Infra Server](/360/latest/migrate/on_prem_to_self_managed/).

## See the state of your servers

After each run, Chef Infra Client reports a summary of what it did.
Chef Automate collects those reports and shows the status of your nodes and their Chef Infra Client runs.
See [client runs](/automate/client_runs/).
In Chef 360 Platform, the Nodes page shows each node's enrollment level and health, and Chef Courier keeps the history of every job run.

Configuration and compliance answer different questions.
Chef Infra Client makes the server match your code.
Chef InSpec checks that the result, and the database itself, meets a requirement, such as a CIS benchmark or an STIG.
See [Database compliance](/solutions/compliance/databases/) for the benchmarks that Chef covers.

## Community cookbooks

Chef Infra Client has no built-in database resources, but the community does.
The Sous Chefs project maintains cookbooks on Supermarket for several databases, and they add resources for the things inside a database that this page doesn't cover.
This table is from Supermarket and the cookbooks' own READMEs.
It isn't Chef documentation, and Chef doesn't support or test these cookbooks.

| Cookbook | What it covers | Notes |
| --- | --- | --- |
| [`postgresql`](https://supermarket.chef.io/cookbooks/postgresql) | PostgreSQL install, service, configuration, access, databases, roles, and extensions | Maintained by Sous Chefs |
| [`mysql`](https://supermarket.chef.io/cookbooks/mysql) | MySQL service, client, configuration, databases, and users | Maintained by Sous Chefs. Check its README for the supported MySQL version and breaking changes between releases |
| [`mariadb`](https://supermarket.chef.io/cookbooks/mariadb) | MariaDB | Maintained by Sous Chefs |
| [`sql_server`](https://supermarket.chef.io/cookbooks/sql_server) | Microsoft SQL Server | Maintained by Sous Chefs |
| [`redisio`](https://supermarket.chef.io/cookbooks/redisio) | Redis | Maintained by Sous Chefs |

Some older cookbooks are deprecated or haven't been updated in years, and the Supermarket `database` and `mongodb` cookbooks are marked deprecated.
Check a cookbook's maintainer, its last update, and whether it's deprecated before you use it, and read its source.

## What the documentation doesn't say

This page sticks to what the Chef documentation states and what the example proved.
A few things that people often assume aren't covered, so confirm them before you rely on them:

- **Database resources.** Chef Infra Client has no built-in resources for databases, schemas, roles, or replication.
- **Restarts and maintenance periods.** The Chef documentation doesn't describe restarting a database service safely, or running Chef on database servers during a maintenance period.
- **Failover and backups.** Chef doesn't manage failover, replication, or backups, and the documentation doesn't describe them.
- **Credentials.** The Chef documentation doesn't recommend one method for database passwords, and doesn't say whether data bags or Chef Vault work on DSM.
- **Other databases and versions.** The example is PostgreSQL 16 on Ubuntu. The settings come from the PostgreSQL documentation, so check them for the version you run.
- **Other platforms.** The service and file layout on Red Hat Enterprise Linux, Windows, and other platforms differ from this example.

## Where to start

If you're new to Chef, start with the example on this page, and then read [the Chef Infra Client run](/client/latest/#the-chef-infra-client-run).
Before you scale up:

- Pick the settings that must be identical on every database server, and put them in a cookbook.
- Learn which of those settings need a restart, and write down who restarts the database and when.
- Keep values that differ between servers in attributes, not in recipes, and test every branch.
- Give each group of servers its own policy group, and try every change on a small group first.
- Keep credentials out of cookbooks, and mark resources that handle them as sensitive.
- Run Chef on a schedule, and use Chef Automate to watch the run reports.
- Check the database itself with Chef InSpec.

## Related documentation

- [Chef Infra Client](/client/latest/)
- [Chef Workstation](/workstation/latest/)
- [Chef 360 Platform](/360/latest/)
- [Declarative State Management](/360/latest/understand/dsm/)
- [Policyfiles](/policyfile/)
- [The `secret` helper](/client/latest/infra_language/secrets/)
- [Database compliance](/solutions/compliance/databases/)
- [PostgreSQL documentation: Setting parameters](https://www.postgresql.org/docs/current/config-setting.html)
- [MySQL documentation: Option files](https://dev.mysql.com/doc/refman/8.4/en/option-files.html)
