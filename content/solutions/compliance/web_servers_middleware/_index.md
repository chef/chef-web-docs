+++
title = "The Chef way of configuring web servers and middleware"
description = "Assess web servers and middleware with Chef InSpec: check NGINX and Apache Tomcat configuration, the TLS protocols and HTTP headers clients see, and certificate expiry, then run the same checks before every release and across your fleet."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/compliance/web_servers_middleware"
  parent = "overview/solutions/compliance"
  title = "Configuring web servers and middleware"
  weight = 10
+++

Web servers and middleware are the part of your fleet that the internet talks to directly.
A version string left in a response header, a TLS 1.0 listener nobody turned off,
or a Tomcat example application that shipped with the package
is visible to anyone who sends a request.

Those settings drift for ordinary reasons.
A package upgrade restores a default configuration file,
a team adds a virtual host by copying an old one,
and a certificate renewal is missed because nobody owned it.
Checking them by hand after each change doesn't scale,
and it doesn't leave evidence you can show an assessor.

The steps below write a Chef InSpec profile for NGINX and Apache Tomcat,
run it against a server alongside a published benchmark,
run it again before a configuration change ships,
and then adapt it to the other web servers and middleware in your fleet.

If you haven't written a Chef InSpec profile before, start with
[The Chef way of SSH compliance](/solutions/compliance/ssh_baseline/).

## What web server and middleware compliance covers

A web tier is assessed at four layers.
Each layer answers a different question,
and a server can pass one layer while failing another,
so check all four.

| Layer | What you're asking | How Chef assesses it |
| --- | --- | --- |
| **Host operating system** | Is the server the web tier runs on configured to its benchmark? | CIS Benchmark and DISA STIG profiles for the operating system |
| **Server configuration** | Do the configuration files set what your standard requires? | Configuration resources such as `nginx_conf`, `apache_conf`, and `xml`, plus published benchmarks |
| **Behavior on the wire** | What does a client actually see --- which TLS protocols, which response headers? | Network resources such as `ssl` and `http` |
| **Certificates** | Is the certificate valid, strong enough, and far enough from expiry? | The `x509_certificate` resource |

The configuration and wire layers check the same requirement from two directions.
A configuration file can set `ssl_protocols TLSv1.2 TLSv1.3;`
while an included file, a load balancer, or a second listener still accepts TLS 1.0.
Checking the file tells you what was intended.
Checking the wire tells you what's true.

### Published benchmarks

Chef publishes audit and remediation content for these web servers and middleware:

| Technology | Benchmarks Chef covers |
| --- | --- |
| Apache HTTP Server | CIS Apache HTTP Server 2.2 and 2.4 |
| Microsoft IIS | CIS Microsoft IIS 10, STIG Microsoft IIS 10.0 |
| NGINX | CIS NGINX (remediation only) |
| Apache Tomcat | CIS Apache Tomcat 5.5, 8, 9, 10, 10.1, and 11 |
| IBM WebSphere Liberty | CIS IBM WebSphere Liberty |
| Microsoft SharePoint and Exchange | CIS Microsoft SharePoint 2016, CIS Microsoft Exchange Server 2016 |

Coverage differs by version.
Some benchmarks have audit content only, some have remediation content only, and some have both.
Check the [Web Servers](/premium_content/web_servers/) and
[Applications / Middleware](/premium_content/applications_middleware/)
coverage tables for the exact audit and remediation versions before you plan around one.

There's no published audit benchmark for NGINX,
which is one reason the profile on this page starts with NGINX.

## What you'll build

A Chef InSpec profile with six controls that assert:

- NGINX doesn't disclose its version.
- The HTTPS listener refuses SSL 3.0, TLS 1.0, and TLS 1.1.
- Responses send HTTP Strict Transport Security (HSTS) with a `max-age` of at least six months,
  and send `X-Content-Type-Options` and `X-Frame-Options`.
- The server certificate is valid for at least 30 more days and uses a key of at least 2048 bits.
- The Tomcat shutdown port is disabled.
- The Tomcat example, documentation, and management applications aren't deployed.

By the end you'll be able to run that profile against a web server,
run it in the same command as a published benchmark,
run it before a configuration change reaches production,
and extend it to Apache HTTP Server, IIS, and other middleware.

{{< note >}}

**What was run, and where.**
The generator output, `inspec check` output, and controls on this page
were produced and run on Chef InSpec 5.24.7 from Chef Workstation,
against an NGINX configuration file, a Tomcat `server.xml`, a certificate,
and a local HTTPS listener that each contain the findings shown,
to confirm that every resource, matcher, and `only_if` condition evaluates as described.
The results in [Read the results](#step-5-read-the-results) come from that run,
with host names and paths changed to match the examples.

{{< /note >}}

## Before you begin

You need:

- **Chef InSpec**, from [Chef Workstation](/workstation/latest/) or a
  [standalone install](/inspec/latest/install/).
  Run `inspec version` to confirm it's available.
- **A Linux server running NGINX, Apache Tomcat, or both**,
  that you can reach over SSH with an account that can escalate with `sudo`.
  The controls skip whichever one isn't installed.
  For Apache HTTP Server and IIS, see
  [Adapt the profile to other web servers and middleware](#adapt-the-profile-to-other-web-servers-and-middleware).
- **Network access to the HTTPS port** from the machine that runs Chef InSpec.
  The `ssl` resource opens TLS connections to the target's host name,
  so a firewall between you and the server affects the result.
- **The paths your installation uses**:
  the main NGINX configuration file, the certificate NGINX presents,
  and the Tomcat `CATALINA_BASE` directory.
  The defaults on this page are `/etc/nginx/nginx.conf`, `/etc/nginx/tls/server.crt`, and `/opt/tomcat`.

You don't need to install anything on the server.
Chef InSpec connects to it and reads what it needs.

## Step 1: Create a profile

Generate a profile:

```bash
inspec init profile web-tier-baseline
```

```text
─────────────────────────── InSpec Code Generator ───────────────────────────

Creating new profile at ./web-tier-baseline
 • Creating file README.md
 • Creating directory ./web-tier-baseline/controls
 • Creating file controls/example.rb
 • Creating file inspec.yml
```

Replace `web-tier-baseline/inspec.yml` with:

```yaml
name: web-tier-baseline
title: Web server and middleware baseline
maintainer: Example Organization, Inc.
copyright: Example Organization, Inc.
copyright_email: compliance@example.com
license: Apache-2.0
summary: Verify that NGINX and Apache Tomcat are configured to the organization's web tier standard
version: 0.1.0
supports:
  - platform-family: linux
inputs:
  - name: nginx_conf_path
    description: Path to the main NGINX configuration file
    type: String
    value: /etc/nginx/nginx.conf
  - name: tls_port
    description: Port the web server serves HTTPS on
    type: Numeric
    value: 443
  - name: site_url
    description: URL the security header checks request, from the target itself
    type: String
    value: https://localhost/
  - name: hsts_min_max_age
    description: Minimum HSTS max-age, in seconds
    type: Numeric
    value: 15768000
  - name: certificate_path
    description: Path to the certificate the web server presents
    type: String
    value: /etc/nginx/tls/server.crt
  - name: certificate_min_days
    description: Minimum number of days a certificate must remain valid
    type: Numeric
    value: 30
  - name: tomcat_home
    description: CATALINA_BASE of the Tomcat instance to check
    type: String
    value: /opt/tomcat
```

The `inputs` hold the values that differ between servers and organizations:
where the configuration and certificate live, which port serves HTTPS,
and how strict your HSTS and certificate expiry thresholds are.
Keeping them out of the controls means one profile covers servers
that are laid out differently.
Override them at run time with `--input`, or keep them in an input file for each server role.
See [Chef InSpec inputs](/inspec/latest/profiles/inputs/).

The `hsts_min_max_age` default of 15768000 seconds is six months,
the minimum the CIS NGINX Benchmark recommends.

`supports` limits the profile to Linux, as in
[Step 1 of SSH compliance](/solutions/compliance/ssh_baseline/#step-1-create-a-profile).

## Step 2: Write the controls

Delete `controls/example.rb` and create `controls/web_tier.rb`:

```ruby
control 'web-01' do
  impact 'medium'
  title "Don't disclose the NGINX version"
  desc 'NGINX must not include its version in the Server response header or on error pages.'
  desc 'rationale', 'A version string tells an attacker which published vulnerabilities to try first.'
  tag 'web', 'nginx'

  only_if("NGINX isn't installed on this target.") do
    file(input('nginx_conf_path')).exist?
  end

  server_tokens = nginx_conf(input('nginx_conf_path')).params.dig('http', 0, 'server_tokens').to_a.flatten

  describe 'server_tokens in the NGINX http block' do
    subject { server_tokens }
    it { should cmp ['off'] }
  end
end

control 'web-02' do
  impact 'high'
  title 'Accept only TLS 1.2 and later'
  desc 'The HTTPS listener must refuse SSL 3.0, TLS 1.0, and TLS 1.1 connections.'
  desc 'rationale', 'Older protocol versions have known weaknesses and are disallowed by PCI DSS and NIST SP 800-52.'
  tag 'web', 'tls'

  %w(ssl3 tls1.0 tls1.1).each do |protocol|
    describe ssl(port: input('tls_port')).protocols(protocol) do
      it { should_not be_enabled }
    end
  end
end

control 'web-03' do
  impact 'medium'
  title 'Send HTTP security headers'
  desc 'Responses must tell browsers to use HTTPS only and must not allow the site to be framed or content types to be sniffed.'
  tag 'web', 'headers'

  response = http(input('site_url'), ssl_verify: false)
  hsts_max_age = response.headers['Strict-Transport-Security'].to_s[/max-age=(\d+)/i, 1].to_i

  describe 'HSTS max-age in seconds' do
    subject { hsts_max_age }
    it { should be >= input('hsts_min_max_age') }
  end

  describe response do
    its('headers.X-Content-Type-Options') { should cmp 'nosniff' }
    its('headers.X-Frame-Options') { should match(/\A(DENY|SAMEORIGIN)\z/i) }
  end
end

control 'web-04' do
  impact 'high'
  title 'Renew certificates before they expire'
  desc 'The certificate the web server presents must remain valid for at least the configured number of days.'
  desc 'rationale', 'An expired certificate takes the service down for every client that validates it.'
  tag 'web', 'tls', 'certificate'

  describe x509_certificate(input('certificate_path')) do
    its('validity_in_days') { should be >= input('certificate_min_days') }
    its('key_length') { should be >= 2048 }
  end
end

control 'mw-01' do
  impact 'high'
  title 'Disable the Tomcat shutdown port'
  desc "The Tomcat Server element must set port to -1 so the instance can't be stopped over the network."
  desc 'rationale', 'Anyone who can reach the shutdown port and knows the shutdown string can stop Tomcat.'
  tag 'middleware', 'tomcat'

  only_if("Tomcat isn't installed at the configured tomcat_home.") do
    file("#{input('tomcat_home')}/conf/server.xml").exist?
  end

  describe xml("#{input('tomcat_home')}/conf/server.xml") do
    its('Server/@port') { should cmp ['-1'] }
  end
end

control 'mw-02' do
  impact 'medium'
  title 'Remove Tomcat default and example applications'
  desc 'Production Tomcat instances must not deploy the examples, docs, manager, or host-manager applications.'
  tag 'middleware', 'tomcat'

  only_if("Tomcat isn't installed at the configured tomcat_home.") do
    directory("#{input('tomcat_home')}/webapps").exist?
  end

  %w(examples docs manager host-manager).each do |app|
    describe directory("#{input('tomcat_home')}/webapps/#{app}") do
      it { should_not exist }
    end
  end
end
```

What's specific to web servers and middleware here:

`nginx_conf(...).params.dig('http', 0, 'server_tokens')`
: The [`nginx_conf` resource](/inspec/latest/resources/core/nginx_conf/)
  parses `nginx.conf` and every file it includes into nested `params`.
  `web-01` reads `server_tokens` from the first `http` block.
  If the directive isn't set at all, the value is empty and the control fails ---
  which is correct, because NGINX sends its version by default.
  The `nginx_conf` resource is marked experimental, so confirm it parses your configuration
  by running `web-01` against one server before you roll it out.

`ssl(port: ...).protocols(...)`
: The [`ssl` resource](/inspec/latest/resources/core/ssl/)
  attempts a handshake with each protocol and reports whether the server accepted it.
  `web-02` checks what the listener actually accepts,
  not what a configuration file says it should,
  so it catches a second listener or an included file that re-enables an old protocol.

`http(...)` and `headers`
: The [`http` resource](/inspec/latest/resources/core/http/)
  sends the request from the target itself when you assess a remote server,
  so `https://localhost/` reaches the local listener without opening it to your workstation.
  `ssl_verify: false` lets the request succeed against a certificate issued for the public name.
  `web-03` extracts the number from `max-age` and compares it,
  because a header that's present with `max-age=0` turns HSTS off.

`x509_certificate`
: The [`x509_certificate` resource](/inspec/latest/resources/core/x509_certificate/)
  reads the certificate file and reports `validity_in_days` as the time left until it expires.
  Set `certificate_min_days` longer than your renewal process takes,
  so a failure is a warning you can act on, not an outage.

`xml(...)` with `Server/@port`
: The [`xml` resource](/inspec/latest/resources/core/xml/)
  evaluates an XPath expression against `server.xml` and returns an array of matches.
  `@port` selects the attribute, and Tomcat's default of `8005` fails the control.

`only_if`
: Runs the control only when the condition is true, and reports it as skipped otherwise.
  The NGINX and Tomcat controls use it so the same profile runs on a server that has only one of them.

For the parts of a control that aren't specific to web servers ---
`impact`, `desc`, `tag`, and `cmp` ---
see [Step 2 of SSH compliance](/solutions/compliance/ssh_baseline/#step-2-write-the-controls).

## Step 3: Validate the profile

```bash
inspec check web-tier-baseline
```

```text
Location :   web-tier-baseline
Profile :    web-tier-baseline
Controls :   6
Timestamp :  2026-11-06T13:26:58+05:30
Valid :      true

No errors, warnings, or offenses
```

## Step 4: Run the assessment against a server

Run the profile against a server over SSH:

```bash
inspec exec web-tier-baseline \
  --target ssh://admin@web01.example.com \
  --key-files ~/.ssh/id_rsa \
  --sudo
```

`--sudo` is needed because private keys, Tomcat configuration, and some NGINX include files
are readable only by root or the service account.

If a server is laid out differently from the defaults, override the inputs for that run:

```bash
inspec exec web-tier-baseline \
  --target ssh://admin@web02.example.com \
  --key-files ~/.ssh/id_rsa \
  --sudo \
  --input certificate_path=/etc/ssl/certs/web02.pem tomcat_home=/srv/tomcat
```

### Run it with a published benchmark

The profile above checks your organization's standard.
The web server, the middleware, and the host operating system each still need their own benchmark.
`inspec exec` accepts more than one profile,
so pass them together and assess the server in a single run:

```bash
inspec exec web-tier-baseline path/to/tomcat-benchmark-profile path/to/os-benchmark-profile \
  --target ssh://admin@web01.example.com \
  --key-files ~/.ssh/id_rsa \
  --sudo \
  --reporter cli json:web01-results.json
```

Get the benchmark profiles from the [Chef Automate Profiles page](/automate/profiles/),
and confirm the version you need in the [Web Servers](/premium_content/web_servers/),
[Applications / Middleware](/premium_content/applications_middleware/), and
[Operating Systems](/premium_content/operating_systems/) coverage tables.
Each profile reports its own results, so a reviewer can tell a finding against your standard
from a benchmark finding.

## Step 5: Read the results

A run against a server running NGINX and Tomcat with package defaults,
a missing HSTS header, and a certificate that expires in 20 days:

```text
Profile:   Web server and middleware baseline (web-tier-baseline)
Version:   0.1.0
Target:    ssh://admin@web01.example.com:22

  ×  web-01: Don't disclose the NGINX version
     ×  server_tokens in the NGINX http block is expected to cmp == ["off"]

     expected: ["off"]
          got: ["on"]

     (compared using `cmp` matcher)

  ✔  web-02: Accept only TLS 1.2 and later
     ✔  SSL/TLS on web01.example.com:443 with protocol == "ssl3" is expected not to be enabled
     ✔  SSL/TLS on web01.example.com:443 with protocol == "tls1.0" is expected not to be enabled
     ✔  SSL/TLS on web01.example.com:443 with protocol == "tls1.1" is expected not to be enabled
  ×  web-03: Send HTTP security headers (1 failed)
     ×  HSTS max-age in seconds is expected to be >= 15768000
     expected: >= 15768000
          got:    0
     ✔  HTTP GET on https://localhost/ headers.X-Content-Type-Options is expected to cmp == "nosniff"
     ✔  HTTP GET on https://localhost/ headers.X-Frame-Options is expected to match /\A(DENY|SAMEORIGIN)\z/i
  ×  web-04: Renew certificates before they expire (1 failed)
     ×  x509_certificate /etc/nginx/tls/server.crt validity_in_days is expected to be >= 30
     expected: >= 30
          got:    19.986562904386574
     ✔  x509_certificate /etc/nginx/tls/server.crt key_length is expected to be >= 2048
  ×  mw-01: Disable the Tomcat shutdown port
     ×  XML /opt/tomcat/conf/server.xml Server/@port is expected to cmp == ["-1"]

     expected: ["-1"]
          got: ["8005"]

     (compared using `cmp` matcher)

  ×  mw-02: Remove Tomcat default and example applications (1 failed)
     ×  Directory /opt/tomcat/webapps/examples is expected not to exist
     expected Directory /opt/tomcat/webapps/examples not to exist
     ✔  Directory /opt/tomcat/webapps/docs is expected not to exist
     ✔  Directory /opt/tomcat/webapps/manager is expected not to exist
     ✔  Directory /opt/tomcat/webapps/host-manager is expected not to exist


Profile Summary: 1 successful control, 5 control failures, 0 controls skipped
Test Summary: 9 successful, 5 failures, 0 skipped
```

`web-04` is the finding to act on first.
It's the only one with a deadline: in 20 days the service stops working for every client,
regardless of how the rest is configured.

`web-01`, `mw-01`, and `mw-02` are package defaults.
Every server installed the same way has the same findings,
so fix them in the cookbook or image that builds the server, not on each server ---
see [Fix what fails](#fix-what-fails).

`web-03` shows `got: 0` because the response has no `Strict-Transport-Security` header.
A header with `max-age=0` reports the same value and fails the same way.

On a server without NGINX or Tomcat, the matching controls report as skipped with their `only_if` message,
not as a pass:

```text
  ↺  mw-01: Disable the Tomcat shutdown port
     ↺  Skipped control due to only_if condition: Tomcat isn't installed at the configured tomcat_home.
```

For exit codes, keeping results as evidence, and recording an accepted exception as a waiver,
the steps are the same as for any profile:

- [Check the exit code](/solutions/compliance/ssh_baseline/#check-the-exit-code)
- [Keep the results](/solutions/compliance/ssh_baseline/#keep-the-results)
- [Waive an exception you've accepted](/solutions/compliance/ssh_baseline/#step-7-waive-an-exception-youve-accepted)

## Step 6: Check configuration before it ships

Most web tier findings are introduced by a change:
a new virtual host, a cookbook update, or a package upgrade.
The cheapest place to catch them is before the change reaches production.

Use [Test Kitchen](/workstation/latest/tools/kitchen/) to build a server with the cookbook
that configures your web tier, run the profile against it, and destroy it.
Configure the InSpec verifier in `kitchen.yml` to run the same profiles you run in production:

```yaml
verifier:
  name: inspec

suites:
  - name: web
    run_list:
      - recipe[web_tier::default]
    verifier:
      inspec_tests:
        - path: ../web-tier-baseline
      inputs:
        site_url: https://localhost/
```

Then build, verify, and destroy the test instance:

```bash
kitchen test web
```

Two things to account for when you verify configuration this way:

- **Test with the certificate path, not the certificate.**
  A test instance usually has a self-signed certificate,
  so `web-04` measures the test certificate's expiry, not production's.
  Override `certificate_min_days` for the test suite, or waive `web-04` there,
  and rely on the scheduled production run for expiry.
- **Run the same profile version everywhere.**
  Pin the profile version that Test Kitchen and production use,
  so a change that passes in CI is assessed against the same controls in production.

## Adapt the profile to other web servers and middleware

The controls above follow one pattern:
read the configuration with a resource that understands its format,
then check behavior on the wire.
The same pattern applies to the rest of the web tier:

| Technology | Configuration resource | Example check |
| --- | --- | --- |
| Apache HTTP Server | [`apache_conf`](/inspec/latest/resources/core/apache_conf/) | `its('ServerTokens') { should cmp 'Prod' }` |
| Microsoft IIS | [`iis_site`](/inspec/latest/resources/core/iis_site/), [`iis_app`](/inspec/latest/resources/core/iis_app/) | `it { should have_binding('https :443:www.example.com sslFlags=Ssl') }` |
| Apache Tomcat, IBM WebSphere Liberty, and other Java middleware | [`xml`](/inspec/latest/resources/core/xml/) | An XPath expression against the server's XML configuration file |
| Applications configured with JSON, YAML, or INI files | [`json`](/inspec/latest/resources/core/json/), [`yaml`](/inspec/latest/resources/core/yaml/), [`ini`](/inspec/latest/resources/core/ini/) | Check a setting by its key path |
| Any listener | [`port`](/inspec/latest/resources/core/port/), [`ssl`](/inspec/latest/resources/core/ssl/), [`http`](/inspec/latest/resources/core/http/) | Check what's listening and what clients see |

Two things to account for:

- **`apache_conf` needs `ServerRoot`.**
  The resource follows `Include` directives only when `ServerRoot` is set in the configuration,
  so a configuration without it reports only the main file's settings.
- **IIS runs on Windows.**
  Put IIS controls in a separate profile that `supports` the `windows` platform family,
  and run it over WinRM, as described in the [Chef InSpec CLI reference](/inspec/latest/reference/cli/).
  The `ssl`, `http`, and `x509_certificate` checks work the same way on Windows targets.

For middleware without a dedicated resource, such as message brokers,
see [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
for resource packs and for writing your own resources.

## Assess web servers across your fleet

Running a profile by hand answers a question once.
Running it on a schedule catches a certificate that's about to expire,
or a setting that a package upgrade reset.

- **Servers managed by Chef Infra Client:**
  add the profile to the [Compliance Phase](/client/latest/features/chef_compliance_phase/),
  so every Chef Infra Client run assesses the server it configured.
- **Servers that aren't:**
  add them as nodes in Chef Automate and create a recurring [scan job](/automate/scan_jobs/),
  or enroll them in [Chef 360 Platform](/360/latest/use/operators/node_enrollment/)
  and run scans as [Chef Courier jobs](/360/latest/use/operators/job_execution/).

Web servers are often VMs or cloud instances, so the discovery and scheduling options
in [Assess VMs across your fleet](/solutions/compliance/vm_compliance/#assess-vms-across-your-fleet) apply here too.
Tag nodes by role, such as `web` or `tomcat`, so a scan job runs this profile only where it applies.

Run `web-04` at least daily on production servers.
A certificate expiry check that runs weekly can miss the renewal window entirely.

Report results into [compliance reporting](/automate/reports/),
where you can filter by profile and control to see every server that fails `web-04`.

## Fix what fails

For published benchmarks,
[compliance remediation](/solutions/compliance/#compliance-remediation)
content corrects the configuration behind failing controls
on servers managed by Chef Infra Client.
Check remediation coverage for your benchmark and version first ---
for example, CIS NGINX has remediation content but no audit content,
and some Tomcat versions have audit content but no remediation content.

For findings from your own profile, fix the source rather than each server:

- **A finding on every server built the same way** is a build finding.
  Fix the cookbook or image, reverify it with
  [Test Kitchen](#step-6-check-configuration-before-it-ships),
  then roll it out.
- **A finding on one server** is drift.
  Fix it with Chef Infra Client, so the fix is reapplied if it drifts again,
  and reassess to confirm the control passes.
- **A certificate finding** is a renewal process finding.
  Renew the certificate now, then find out why renewal didn't happen before the threshold.
- **A finding you've accepted**, such as a legacy application that requires TLS 1.1
  until a dated migration,
  is a waiver with a justification and an expiration date, not an ignored failure.

## Where to go next

**Turn it on for the fleet.**
Enable the [Compliance Phase](/client/latest/features/chef_compliance_phase/)
on managed servers, and create recurring [scan jobs](/automate/scan_jobs/)
for servers that Chef Infra Client doesn't manage.

**Add the published benchmark for each server.**
Use the [Web Servers](/premium_content/web_servers/) and
[Applications / Middleware](/premium_content/applications_middleware/) coverage tables
to match each web server and middleware version to its benchmark.

**Prepare for an assessment.**
See [Prepare for a compliance assessment](/solutions/compliance/#prepare-for-a-compliance-assessment)
for filtering, exporting, and accounting for every failing control.

## Related

- [Compliance solution overview](/solutions/compliance/)
- [The Chef way of SSH compliance](/solutions/compliance/ssh_baseline/)
- [The Chef way of virtual machine compliance](/solutions/compliance/vm_compliance/)
- [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Web server benchmark coverage](/premium_content/web_servers/)
- [Applications and middleware benchmark coverage](/premium_content/applications_middleware/)
- [Chef InSpec `nginx_conf` resource](/inspec/latest/resources/core/nginx_conf/)
- [Chef InSpec `ssl` resource](/inspec/latest/resources/core/ssl/)
- [Chef InSpec `http` resource](/inspec/latest/resources/core/http/)
- [Chef InSpec `x509_certificate` resource](/inspec/latest/resources/core/x509_certificate/)
- [Chef InSpec inputs](/inspec/latest/profiles/inputs/)
