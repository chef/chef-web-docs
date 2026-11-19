+++
title = "The Chef way of web server and middleware config management"
description = "Configure NGINX, Apache Tomcat, and the rest of your web tier with Chef: write the configuration as code, check every change before it reaches the live file, reload instead of restart, and roll changes out one group of servers at a time."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/infra_management/web_middleware_config"
  parent = "overview/solutions/infra_management"
  title = "Web server and middleware config management"
  weight = 50
+++

<!-- cspell:ignore splay xmllint noout formedness libxml2 hsts HSTS Policyfile Policyfiles jsvc -->

A web server's configuration is a single file that a lot depends on.
One misplaced directive, and the server refuses to start or reload.
A header set at one level quietly disappears at another.
A certificate is renewed on one server and forgotten on the next.
A Tomcat instance ships with its example applications, and nobody removes them from the one that was built last.

Most of these problems come from one habit: editing the live file on the server.
It's fast, it's untested, and the next person doesn't know it happened.

You need one reviewed definition of how each web server and middleware instance is configured, a check that a change is valid before it replaces a working file, and a way to apply it to many servers without taking them down.

Chef does this by letting you describe the configuration as code and by running Chef Infra Client on each server to keep it matching.
Chef Infra Client validates a new configuration file before it replaces the live one, and it tells the service to reload only when the file changed.

This page covers the configuration of web servers and middleware you run yourself, with NGINX and Apache Tomcat as the worked examples.
It doesn't cover assessing them, which is the job of [The Chef way of configuring web servers and middleware](/solutions/compliance/web_servers_middleware/), and it doesn't cover load balancers, DNS, or the applications you deploy.
See [Where Chef fits](#where-chef-fits).

## Who this page is for

**If you're accountable for the outcome**, such as an infrastructure or platform owner, read this section and [Where Chef fits](#where-chef-fits).
You'll learn what Chef gives you for a web tier, what it doesn't, and how changes reach production without an outage.

**If you run the servers**, work through the rest of the page.
It builds a cookbook that configures NGINX and Tomcat, shows a bad change being refused, and covers testing, certificates, and rollout.
If you haven't used Chef before, start with the [Chef Infra quickstart guide](/client/latest/quickstart/).

### What you get

- **A check before every change.** A new configuration file is validated before it replaces the live one, so a typo fails the Chef Infra Client run and not the web server.
- **Reload instead of restart.** Chef tells a service to reload only when its file changed, and does so once at the end of the run, however many files changed.
- **One definition, different settings.** A public site and an internal site share one cookbook and differ only in attributes. A hand edit is replaced at the next run.
- **A baseline that the compliance checks agree with.** The cookbook sets what the Chef InSpec profile in the compliance page checks.

### What you don't get

Chef Infra Client configures the web server on the machine it runs on.
It doesn't know whether your configuration is a good one: a file can be valid and still be wrong.
It doesn't build servers, manage the load balancer in front of them, or deploy your application.
A server is in a known state only for the settings you wrote code for, and only as of its last successful run.

## Where Chef fits

A web tier has several layers.
Chef covers the configuration layer, and the rest of the Chef platform helps you check and watch the result.

| Layer | What it means | Chef piece | On this page |
| --- | --- | --- | --- |
| Provisioning | Building the server or virtual machine | Not a Chef Infra Client feature. Use your provisioning tools | No |
| Web server and middleware configuration | Configuration files, modules, virtual hosts, TLS settings, service state | [Chef Infra Client](/client/latest/) resources and [cookbooks](/client/latest/cookbooks/) | Yes |
| Certificates and keys | The certificate and private key each server presents | The [`secret` helper](/client/latest/infra_language/secrets/) and core `file` resource | Yes. See [Manage certificates and keys](#manage-certificates-and-keys) |
| Traffic management | Load balancers, DNS, and health checks | Not a Chef Infra Client feature | See [Roll changes out without an outage](#roll-changes-out-without-an-outage) |
| Compliance | Checking that the web tier meets your standard | [Chef InSpec](/inspec/latest/) and the [Compliance Phase](/client/latest/features/chef_compliance_phase/) | See [Check the result](#check-the-result) |
| Reporting | Seeing run status across servers | [Chef Automate](/automate/client_runs/) | See [See the state of your servers](#see-the-state-of-your-servers) |

Servers ask a central service for the policy that applies to them: Chef Declarative State Management (DSM) in [Chef 360 Platform](/360/latest/), the direct replacement for Chef Infra Server.
The page builds the rest of the Chef way in order: describe the file with a `template`, check it with `verify`, reload only when it changed, and put differences in attributes and [Policyfiles](/policyfile/).

## What's in core and what's from the community

Chef Infra Client includes the resources that every web server needs: `package`, `template`, `file`, `directory`, `service`, and `systemd_unit`.
It doesn't include resources for NGINX, Apache HTTP Server, Tomcat, or IIS.
Those come from community cookbooks on [Chef Supermarket](https://supermarket.chef.io/), and Chef doesn't support or test them.

| Server | Community cookbook | What it provides |
| --- | --- | --- |
| NGINX | [`nginx`](https://supermarket.chef.io/cookbooks/nginx) | The `nginx_install`, `nginx_config`, `nginx_site`, and `nginx_service` resources. `nginx_service` runs a configuration test before it acts, by default. |
| Apache HTTP Server | [`apache2`](https://supermarket.chef.io/cookbooks/apache2) | Resources for installation, configuration, modules, and the default site. |
| Apache Tomcat | [`tomcat`](https://supermarket.chef.io/cookbooks/tomcat) | The `tomcat_install` and `tomcat_service` resources. |
| Microsoft IIS | [`iis`](https://supermarket.chef.io/cookbooks/iis) | Resources such as `iis_install`, `iis_site`, and `iis_pool`. Windows only. |

These four are maintained by the Sous Chefs community, and their current versions are resource-based: you call their resources from your own cookbook, which the Apache cookbook's documentation calls a wrapper cookbook.
The IIS and Tomcat cookbooks state that they no longer ship recipes or node attributes.
Older examples that use `include_recipe 'nginx'` or node attributes to configure these cookbooks describe earlier versions.
Check each cookbook's README for the version you use.

The example on this page uses core resources only, so you can see exactly what Chef does.
When you adopt a community cookbook, the technique is the same: keep the configuration in a file or template that Chef manages, and validate it before it's installed.

## What you'll build

A Chef Infra cookbook, `web_tier`, that does these things:

- Installs NGINX and writes a complete `nginx.conf` that hides the version, accepts only TLS 1.2 and later, and sends HSTS and two other security headers.
- Checks the new `nginx.conf` with `nginx -t` before it replaces the live file, and reloads NGINX when it changes.
- Writes the certificate and private key from a secrets service, and reloads NGINX when either changes.
- Writes Tomcat's `server.xml` with the shutdown port disabled, checks that it's well-formed, and restarts Tomcat when it changes.
- Removes Tomcat's example applications.

It's a small stand-in for real work: the same pattern applies to Apache HTTP Server, to other middleware, and to any configuration file that has a checker.
The settings match the controls in the [compliance page](/solutions/compliance/web_servers_middleware/), which uses the paths `/etc/nginx/tls/server.crt` and `/opt/tomcat`, so you can run that profile against a server this cookbook configured.
You'll test the cookbook, watch a bad change get refused, and apply it to different groups of servers.

## Before you begin

You need:

- [Chef Workstation](/workstation/latest/install/) on the machine where you write and test code.
  It includes the `chef` command, ChefSpec, and Cookstyle.
- A Progress Chef license, for bootstrapping servers and for commercial downloads.
  See [Chef license key](/licensing/license_key/).
- A central service your servers can reach: [Chef 360 Platform Declarative State Management (DSM)](/360/latest/understand/dsm/) or [Chef Infra Server](/server/).
  The tests on this page don't need one.
- A Linux test server running Ubuntu 22.04 or later, where you have SSH access and `sudo`, with NGINX and Tomcat available.
  Don't run the example on a production server.
- A secret in AWS Secrets Manager for the certificate and one for the key, if you want to run the example as written.
  The `secret` helper also supports Akeyless Vault, Azure Key Vault, and HashiCorp Vault.

The cookbook was checked with Cookstyle and ChefSpec, and its Policyfiles were built with the `chef` command.
The checking behavior of `verify` was run with Apache's `httpd -t` and with `xmllint`.
NGINX itself wasn't run for this page, so `nginx -t` on your server is the first real check of that template.
Test the cookbook on a throwaway server before you roll it out.

## Write the cookbook

To create a cookbook that configures the web tier, follow these steps:

1. Create a repository, a cookbook, and a folder for the Policyfiles:

   ```shell
   chef generate repo chef-repo
   cd chef-repo
   chef generate cookbook cookbooks/web_tier
   mkdir policyfiles
   ```

1. Create `cookbooks/web_tier/attributes/default.rb`.
   These are the defaults, and each group of servers overrides the ones that differ:

   ```ruby
   default['web_tier']['server_name'] = 'www.example.com'
   default['web_tier']['tls_port'] = 443
   default['web_tier']['tls_protocols'] = 'TLSv1.2 TLSv1.3'
   default['web_tier']['hsts_max_age'] = 31536000
   default['web_tier']['certificate_path'] = '/etc/nginx/tls/server.crt'
   default['web_tier']['key_path'] = '/etc/nginx/tls/server.key'
   default['web_tier']['secrets_region'] = 'us-west-2'

   default['web_tier']['tomcat_home'] = '/opt/tomcat'
   default['web_tier']['tomcat_group'] = 'tomcat'
   default['web_tier']['tomcat_http_port'] = 8080
   default['web_tier']['tomcat_shutdown_port'] = -1
   ```

1. Create `cookbooks/web_tier/templates/nginx.conf.erb`.
   This is a complete NGINX configuration, because `nginx -t -c` checks a whole file, not a fragment:

   ```erb
   # Managed by Chef. Local edits are replaced on the next Chef Infra Client run.
   worker_processes auto;
   pid /run/nginx.pid;
   error_log /var/log/nginx/error.log;

   events {
     worker_connections 1024;
   }

   http {
     include /etc/nginx/mime.types;
     default_type application/octet-stream;
     access_log /var/log/nginx/access.log;

     server_tokens off;
     ssl_protocols <%= @tls_protocols %>;

     server {
       listen 80;
       server_name <%= @server_name %>;
       return 301 https://$host$request_uri;
     }

     server {
       listen <%= @tls_port %> ssl;
       server_name <%= @server_name %>;

       ssl_certificate <%= @certificate_path %>;
       ssl_certificate_key <%= @key_path %>;

       add_header Strict-Transport-Security "max-age=<%= @hsts_max_age %>" always;
       add_header X-Content-Type-Options nosniff always;
       add_header X-Frame-Options SAMEORIGIN always;

       location / {
         root /var/www/html;
       }
     }
   }
   ```

   Three details come from the NGINX documentation:

   - `server_tokens` defaults to `on`, so NGINX sends its version unless you turn it off.
   - The `always` parameter on `add_header` sends the header on every response code. Without it, an error page goes out without HSTS.
   - `add_header` directives are inherited from the previous level only if the current level defines none. A header added in a `location` block replaces all the headers set in its `server` block, so a page that sets one of its own can lose HSTS without any error.

1. Create `cookbooks/web_tier/recipes/nginx.rb`:

   ```ruby
   default_secret_service :aws_secrets_manager
   default_secret_config region: node['web_tier']['secrets_region']

   package 'nginx'

   directory '/etc/nginx/tls' do
     mode '0750'
   end

   file node['web_tier']['certificate_path'] do
     content secret(name: 'web-tier-certificate')
     mode '0644'
     notifies :reload, 'service[nginx]'
   end

   file node['web_tier']['key_path'] do
     content secret(name: 'web-tier-key')
     mode '0600'
     sensitive true
     notifies :reload, 'service[nginx]'
   end

   template '/etc/nginx/nginx.conf' do
     source 'nginx.conf.erb'
     mode '0644'
     variables(
       server_name: node['web_tier']['server_name'],
       tls_port: node['web_tier']['tls_port'],
       tls_protocols: node['web_tier']['tls_protocols'],
       hsts_max_age: node['web_tier']['hsts_max_age'],
       certificate_path: node['web_tier']['certificate_path'],
       key_path: node['web_tier']['key_path']
     )
     verify 'nginx -t -c %{path}'
     notifies :reload, 'service[nginx]'
   end

   service 'nginx' do
     action %i(enable start)
   end
   ```

   The important lines are `verify` and `notifies`.
   They're explained in [Check a change before it lands](#check-a-change-before-it-lands).

1. Create `cookbooks/web_tier/recipes/tomcat.rb`:

   ```ruby
   tomcat_home = node['web_tier']['tomcat_home']

   package 'libxml2-utils'

   template "#{tomcat_home}/conf/server.xml" do
     source 'server.xml.erb'
     owner 'root'
     group node['web_tier']['tomcat_group']
     mode '0640'
     variables(
       shutdown_port: node['web_tier']['tomcat_shutdown_port'],
       http_port: node['web_tier']['tomcat_http_port']
     )
     verify 'xmllint --noout %{path}'
     notifies :restart, 'service[tomcat]'
   end

   %w(examples docs manager host-manager).each do |app|
     directory "#{tomcat_home}/webapps/#{app}" do
       recursive true
       action :delete
     end
   end

   service 'tomcat' do
     action %i(enable start)
   end
   ```

   The `libxml2-utils` package provides `xmllint`.
   The recipe assumes a service named `tomcat`, so use your own unit name or the [`tomcat_service` resource](https://supermarket.chef.io/cookbooks/tomcat).

1. Create `cookbooks/web_tier/templates/server.xml.erb` from the `server.xml` your Tomcat version ships, and replace only the values that differ with template variables:

   ```erb
   <Server port="<%= @shutdown_port %>" shutdown="SHUTDOWN">
     ...
     <Connector port="<%= @http_port %>" protocol="HTTP/1.1" connectionTimeout="20000" />
   ```

   The tests on this page render a minimal file with that structure. A real instance has more elements, and `xmllint` checks all of them for well-formedness.

1. Add `include_recipe 'web_tier::nginx'` to `recipes/default.rb`, and set `chef_version '>= 18.0'` and `supports 'ubuntu', '>= 22.04'` in `metadata.rb`.
   A server that runs Tomcat gets a policy whose run-list is `web_tier::tomcat`.

## Check a change before it lands

The `verify` property on `template` and `file` runs a check against the proposed file before Chef replaces the live one.
The documentation's own example is `verify 'nginx -t -c %{path}'`: Chef writes the new content to a temporary file, substitutes its path for `%{path}`, and runs the command.
If the command fails, Chef Infra Client stops the run with an error and doesn't replace the file.

Here's what that looks like.
This is output from a test run that used Apache's checker, `httpd -t`, in the same `verify` property, because NGINX wasn't available to run.
A directive was misspelled in the template variable:

```text
Proposed content for /tmp/vt2/httpd.conf failed verification /usr/sbin/httpd -t -f %{path}
STDERR: AH00526: Syntax error on line 8 of /tmp/vt2/.chef-httpd20261119-61061-5smidn.conf:
Invalid command 'ServerTokensz', perhaps misspelled or defined by a module not included in the server configuration
```

What the test showed:

| Step | Result |
| --- | --- |
| First converge | The file was written, and the reload notification fired once. |
| Re-run with nothing changed | The resource reported `up to date`, and no reload fired. |
| Re-run with a misspelled directive | The run failed with the checker's message. The live file kept its previous contents. |
| Re-run with a valid change | The file was updated, and the reload fired once. |

Chef keeps the rejected file, so you can read what it tried to write.
The same test with `xmllint --noout %{path}` rejected a malformed Tomcat `server.xml` the same way, and left the live file untouched.

### What verification doesn't do

- **It checks the file, not your traffic.** `nginx -t` confirms the syntax and that the files the configuration refers to can be opened. It can't tell you the configuration is right.
- **It needs a complete file.** `nginx -t -c` expects a whole configuration, so a fragment in `conf.d` fails on its own because it has no `events` or `http` block. Manage the whole `nginx.conf`.
- **It needs the files the configuration refers to.** A missing `mime.types` or certificate file fails the check even when the syntax is right, so write the certificate and key before the configuration that uses them, as the recipe does.
- **`xmllint` checks that XML is well-formed, nothing more.** The Tomcat documentation doesn't describe a configuration test command, so use Test Kitchen to start Tomcat with the file.
- **A failed check fails the whole run.** That's the safe outcome, and it means you need to watch for failed runs. See [See the state of your servers](#see-the-state-of-your-servers).

## Reload instead of restart

A `restart` stops the service and starts it again, and every connection in flight is dropped.
A `reload` asks the service to re-read its configuration while it keeps serving.

NGINX documents what happens on reload.
The main NGINX process checks the syntax of the new configuration, and if applying it fails, it rolls back and keeps working with the old one.
If it succeeds, new worker processes start and the old ones shut down gracefully after they finish serving their current clients.

Chef notifications run `:delayed` by default, at the end of the run.
In a test, a certificate, a key, and a configuration file all changed in the same run and all notified the same reload, which fired once.
When none of them changed, it didn't fire.
One run can update everything a server needs and reload it a single time.

Tomcat is different.
Its documentation says to restart Tomcat after you edit `conf/server.xml` for a connector port change, and the recipe restarts it.
A restart drops in-flight requests, so the answer for Tomcat is in [Roll changes out without an outage](#roll-changes-out-without-an-outage).

{{< note >}}

The `service` resource's documentation lists `:enable`, `:disable`, `:start`, and `:stop`.
In practice, it also accepts `:reload` and `:restart`, which the page uses and the documentation shows in its notification examples.

{{< /note >}}

## Manage certificates and keys

A certificate and its private key are configuration too, and a missed renewal is an outage.
The recipe writes both from a secrets service with the [`secret` helper](/client/latest/infra_language/secrets/), so they never appear in the cookbook or in version control.

- **Set the service and its settings once.** `default_secret_service` and `default_secret_config` apply to every `secret` call in the recipe. For AWS Secrets Manager the helper requires a `region`, and without one it fails with `Missing required config for AWS secret fetcher: :region`.
- **Keep the key out of the logs.** `sensitive true` tells Chef Infra Client not to log the resource's content, and mode `0600` means only root can read the file.
- **Reload when either changes.** A renewed certificate is a changed file, so the next run writes it and reloads NGINX.
- **The server needs credentials.** With none, the helper fails with `unable to sign request without credentials set`, so give the instance an identity that can read the two secrets.

The helper also supports Akeyless Vault, Azure Key Vault, and HashiCorp Vault.
Chef Infra Client doesn't request or renew certificates from a certificate authority.
If yours come from another source, such as an ACME client, keep the same shape: something puts the file in place, and the notification reloads the server.
The compliance page's `web-04` control checks that a certificate has at least 30 days left.

## Test before you ship

A cookbook that changes web servers needs testing before it runs on them.

| Tool | What it checks |
| --- | --- |
| Cookstyle | Style and common mistakes in your Chef Infra code. It doesn't inspect `.erb` templates. |
| [ChefSpec](/workstation/latest/tools/chefspec/) | What a recipe would do on a given platform, including what a template renders, without running it on a system. |
| [Test Kitchen](/workstation/latest/tools/kitchen/) | Whether the cookbook converges on a real, throwaway machine, and whether `nginx -t` and the service accept the result. |
| [Chef InSpec](/inspec/latest/) | Whether the finished server meets requirements. |

ChefSpec is where a template gets checked, because Cookstyle doesn't read `.erb` files.
Create `cookbooks/web_tier/spec/unit/recipes/nginx_spec.rb`.
It stubs the `secret` helper, so the test never calls a cloud service:

```ruby
require 'chefspec'

describe 'web_tier::nginx' do
  platform 'ubuntu', '22.04'

  before { allow_any_instance_of(Chef::DSL::Secret).to receive(:secret).and_return('PEM-DATA') }

  let(:config) { chef_run.template('/etc/nginx/nginx.conf') }

  it 'checks the file with nginx -t before it replaces the live one' do
    commands = config.verifications.map { |v| v.instance_variable_get(:@command) }
    expect(commands).to eq(['nginx -t -c %{path}'])
  end

  it 'reloads nginx when the file changes, and never restarts it' do
    expect(config).to notify('service[nginx]').to(:reload).delayed
    expect(config).not_to notify('service[nginx]').to(:restart)
  end

  it 'hides the version, accepts only TLS 1.2 and later, and sends HSTS' do
    expect(chef_run).to render_file('/etc/nginx/nginx.conf')
      .with_content(/^\s*server_tokens off;$/)
      .with_content(/^\s*ssl_protocols TLSv1\.2 TLSv1\.3;$/)
      .with_content(/add_header Strict-Transport-Security "max-age=31536000" always;/)
  end

  it 'keeps the private key readable by root only and out of the logs' do
    key = chef_run.file('/etc/nginx/tls/server.key')
    expect(key.mode).to eq('0600')
    expect(key.sensitive).to be true
  end

  context 'when a policy overrides the TLS protocols' do
    override_attributes['web_tier'] = { 'tls_protocols' => 'TLSv1.3' }

    it 'renders the override' do
      expect(chef_run).to render_file('/etc/nginx/nginx.conf').with_content(/ssl_protocols TLSv1\.3;/)
    end
  end
end
```

Write `tomcat_spec.rb` in the same folder the same way.
It checks the `xmllint` verification, the shutdown port, the restart notification, and that the example applications are removed.

Run Cookstyle and the tests from the cookbook directory:

```shell
cd cookbooks/web_tier
cookstyle .
chef exec rspec spec
```

```text
8 files inspected, no offenses detected
```

```text
.........

9 examples, 0 failures
```

ChefSpec checks what the recipes would do, but it doesn't run `nginx -t` or start a service.
Use Test Kitchen to converge the cookbook on a Linux machine, and run the compliance profile in the same instance.
The compliance page shows the [`kitchen.yml` for that](/solutions/compliance/web_servers_middleware/#check-configuration-before-it-ships), and `recipe[web_tier::default]` is the cookbook it refers to.

## Use different settings for different servers

A public site and an internal one rarely want identical settings.
Keep the recipe the same, and put the differences in a Policyfile for each group.
A Policyfile locks the run-list and cookbook versions into one versioned revision, and it can carry attributes.

Create `policyfiles/web-internal.rb`.
It accepts only TLS 1.3 and uses a shorter HSTS period:

```ruby
name 'web-internal'
default_source :supermarket
run_list 'web_tier::default'
cookbook 'web_tier', path: '../cookbooks/web_tier'
default['web_tier']['server_name'] = 'intranet.example.com'
default['web_tier']['tls_protocols'] = 'TLSv1.3'
default['web_tier']['hsts_max_age'] = 15768000
```

Write `web-public.rb` the same way with only `server_name` set, and `app-tomcat.rb` with `run_list 'web_tier::tomcat'` and no attributes.
Then resolve each one from the `policyfiles` folder:

```shell
cd policyfiles
chef install web-public.rb
chef install web-internal.rb
chef install app-tomcat.rb
```

A policy's `default` attribute replaces the cookbook's own default for the same attribute, so the internal site gets TLS 1.3 only, and the public site keeps TLS 1.2 and 1.3.
Name a policy after what the server does, such as `web-public`, and use policy groups for environments, such as `staging` and `production`.
See [Policyfiles](/policyfile/) for the full syntax, including `include_policy` for sharing a base policy.

{{< warning >}}

A policy that sets a protocol list or a header affects every server in the group.
A server that accepts only TLS 1.3 refuses a client that supports only TLS 1.2, so check the clients that connect to that group first.

{{< /warning >}}

## Enroll servers and keep them current

Bootstrapping installs Chef Infra Client on a server over SSH and registers it with the central service.
Add `--policy-name` and `--policy-group` to apply a policy on the first run, and push the policy to its group first:

```shell
knife bootstrap <ADDRESS> -U <USERNAME> --sudo --chef-license-key <LICENSE> --policy-name web-public --policy-group production
```

Replace the placeholders with the server's address, an account that can use `sudo`, and your Chef license ID.
A Windows server running IIS bootstraps over WinRM with `-o winrm`.

Enrollment methods, scheduling, and servers that can't reach the central service work the same way for a web tier as for any other fleet, so this page doesn't repeat them:

- **Enroll and schedule.** See [The Chef way of hybrid fleet config management](/solutions/infra_management/hybrid_fleet_config/) for enrollment methods, the `chef_client_systemd_timer` and `chef_client_scheduled_task` resources, and how `splay` spreads the load on the central service.
- **Servers in a DMZ or closed segment.** Use `chef export` to apply a policy locally with `chef-client -z`, and set the proxy that Chef Infra Client reads. See [`chef export`](/client/latest/policy/policyfile/#chef-export) and [proxies](/client/latest/install/proxies/).
- **Certificates in a closed segment.** The `secret` helper calls the secrets service, so the server needs a route to it, or another way to deliver the certificate.

The central service is Chef Declarative State Management (DSM) in Chef 360 Platform, the direct replacement for Chef Infra Server.
If you run Chef Infra Server today, see [Migrate from Chef Infra Server](/360/latest/migrate/on_prem_to_self_managed/).

For a web tier, pick the interval and splay with the reload in mind: a run can reload NGINX or restart Tomcat, so a long interval keeps a hand edit alive longer, and a short one lets a bad change reach more servers before you notice.

## Roll changes out without an outage

A check stops a syntax error from reaching a server, but a valid change can still be a bad one.
Roll it out in stages so a mistake affects a few servers and not all of them.

**Promote through policy groups.**
A policy group binds a set of servers to a specific policy revision.
Push a revision to a small group first, and promote the same revision to the next group when it's healthy:

```shell
chef push canary web-public.lock.json
chef push production web-public.lock.json
```

To pick up a change in the cookbook, run `chef update` before `chef install`.

**Keep servers in service.**
Reloading NGINX keeps it serving, and restarting Tomcat doesn't.
For Tomcat, take the instance out of the load balancer before the change and put it back after.
Chef doesn't manage your load balancer, so this is a step in your own tooling.
Use [Chef Courier](/360/latest/use/operators/job_execution/) to run a coordinated, ordered action such as restarting servers two at a time, and policy revisions for changes to the configuration itself.

**Watch the first runs.**
A failed `verify` fails the run, so a rejected change shows up as a failed run in Chef Automate.
Check the canary group's runs before you promote.

### Tomcat's shutdown port

The compliance page's `mw-01` control requires the shutdown port to be disabled.
The Tomcat documentation says that setting the `Server` port to `-1` disables it, with a condition: it works when Tomcat is started with Apache Commons Daemon, which means as a Windows service or with `jsvc` on Linux and Unix.
It can't be used when you run Tomcat with the standard shell scripts, because it prevents `shutdown.sh` and `catalina.sh` from stopping Tomcat gracefully.

That's why the cookbook makes it an attribute, `tomcat_shutdown_port`, which defaults to `-1`.
For an instance managed by scripts, set another value in that group's policy, and record the exception as a waiver in the compliance profile.

## Check the result

Convergence and compliance answer different questions.
Chef Infra Client makes the server match your code, and Chef InSpec checks that the result meets a requirement.
The cookbook on this page sets what the six controls in the [compliance page](/solutions/compliance/web_servers_middleware/) check:

| Control | What it checks | What the cookbook sets |
| --- | --- | --- |
| `web-01` | NGINX doesn't disclose its version | `server_tokens off;` |
| `web-02` | The listener refuses SSL 3.0, TLS 1.0, and TLS 1.1 | `ssl_protocols TLSv1.2 TLSv1.3;` |
| `web-03` | HSTS, `X-Content-Type-Options`, and `X-Frame-Options` | The three `add_header ... always;` lines |
| `web-04` | The certificate has at least 30 days left | Writes the certificate. It doesn't renew it. |
| `mw-01` | The Tomcat shutdown port is disabled | `port="-1"`, subject to the note above |
| `mw-02` | The Tomcat example applications aren't deployed | The `directory ... action :delete` resources |

The cookbook and the profile don't depend on each other, so a failing control is informative.
If `web-03` fails on a server this cookbook configured, either the file was changed after the run or a header is being overridden, and the profile checks what a client actually sees.

To run the profile on a schedule, turn on the [Compliance Phase](/client/latest/features/chef_compliance_phase/), which runs Chef InSpec profiles after each Chef Infra Client run.
Chef also publishes audit and remediation content for web servers and middleware as [Chef Premium Content](/premium_content/): see [Web Servers](/premium_content/web_servers/) and [Applications / Middleware](/premium_content/applications_middleware/) for the benchmarks covered.

## See the state of your servers

After each run, Chef Infra Client reports what it did, and Chef Automate collects the reports.
See [client runs](/automate/client_runs/) and [data collection](/automate/data_collection/) for setup.
The [node filters](/automate/client_runs/#node-filters) map to this design:

| Question | Filter |
| --- | --- |
| Which servers failed their last run? | The run status tabs |
| Which servers belong to the public site? | **Policy Name**, such as `web-public` |
| Which servers are in the canary group? | **Policy Group**, such as `canary` |
| Which servers run an older revision? | **Policy Revision** |

## What the documentation doesn't say

This page sticks to what the Chef documentation states and what the examples proved.
A few things that people often assume aren't covered, so confirm them before you rely on them:

- **A converge on a real server.** The cookbook passes ChefSpec and Cookstyle, and its policies build, but this page doesn't show a run on a Linux server. Use Test Kitchen on a throwaway machine first.
- **`nginx -t` on this template.** NGINX wasn't run for this page. The rendered template parses with the NGINX parser that Chef InSpec's `nginx_conf` resource uses, and the checking behavior was shown with `httpd -t` and `xmllint`. Run `nginx -t` on your server before you rely on the template.
- **A Tomcat configuration test.** The Tomcat documentation doesn't describe a command that tests `server.xml` without starting Tomcat, so the page checks only that the XML is well-formed.
- **The `service` resource's reload action.** The resource's documentation lists four actions and doesn't list `:reload` or `:restart`, though Chef accepts them and the documentation's notification examples use them.
- **Certificate issuance and renewal.** Chef Infra Client doesn't request a certificate from a certificate authority. It places the files you give it.
- **Load balancer and DNS changes.** Chef Infra Client doesn't manage them, so rolling out without an outage depends on your own steps.
- **Community cookbook versions.** The cookbook details come from Supermarket and the cookbooks' own READMEs in November 2026. They change, so check the version you use.

## Where to start

If you're new to Chef, work through the example on this page, and then read [the Chef Infra Client run](/client/latest/#the-chef-infra-client-run).
Before you scale up:

- Put the whole configuration file under Chef's control, and let nothing edit it by hand.
- Add `verify` with the server's own checker to every template that has one.
- Reload where the service allows it, and plan how you take a server out of service where it doesn't.
- Keep certificates and keys in a secrets service, and set `sensitive true` on the key.
- Keep differences between groups in attributes and policies, not in recipes.
- Promote through a canary policy group, and check the runs before you promote.
- Run the compliance profile against the result.

## Related documentation

- [Chef Infra Client](/client/latest/)
- [Chef Workstation](/workstation/latest/)
- [Chef 360 Platform](/360/latest/)
- [Policyfiles](/policyfile/)
- [Secrets management integrations](/client/latest/infra_language/secrets/)
- [The Chef way of configuring web servers and middleware](/solutions/compliance/web_servers_middleware/)
- [The Chef way of hybrid fleet config management](/solutions/infra_management/hybrid_fleet_config/)
- [Chef Automate client runs](/automate/client_runs/)
- [NGINX: Controlling nginx](https://nginx.org/en/docs/control.html)
- [Apache Tomcat configuration reference](https://tomcat.apache.org/tomcat-10.1-doc/config/index.html)
