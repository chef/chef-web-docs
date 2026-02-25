+++
title = "Chef Supermarket release notes"
draft = false
product = ["supermarket"]
linkTitle = "Chef Supermarket"
summary = "Chef Supermarket release notes"

[menu]
  [menu.release_notes]
    title = "Chef Supermarket"
    identifier = "release_notes/Chef Supermarket"
    parent = "release_notes"
    weight = 100
+++

<!-- markdownlint-disable-file -->
<!-- cSpell:disable  -->
<!-- vale off -->

## Chef Supermarket 5.3.0

Release date: November 11, 2025

### Packaging

- Upgraded Ruby on Rails to version 7.1.5.2 on Fieri engine and Supermarket to remove version skew.
- Updated constraints for Rails, Rack, Nokogiri, PostgreSQL, OpenSSL to ensure reproducible, secure builds.
- Updated Omnibus PostgreSQL definition from 13.18 to 13.22.
- Upgraded OpenSSL from 1.0.2zi to 3.2.4 with FIPS plugin 3.1.2 for FIPS compliance.
- Upgrade OpenResty from 1.21 to 1.27.1.2 (includes Nginx 1.21.4 to 1.27.1) with performance and security improvements.
- Update Ruby gems including Sprockets (4.0.3 to 4.2.2), Faraday (2.3.0 to 2.13.4), and testing frameworks.

### Security

- Upgrade PostgreSQL from 13.18 to 13.22

  - CVE-2025-1094

- Upgraded Ruby on Rails from 7.0.8.7 to 7.1.5.2

  - CVE-2025-24293

- Upgraded Rack from 2.2.8 to 2.2.20

  - CVE-2025-61919
  - CVE-2025-61770
  - CVE-2025-61772
  - CVE-2025-61771
  - CVE-2025-59830
  - CVE-2025-46727
  - CVE-2025-27610

- Upgraded Nokogiri from 1.18.8 to 1.18.9

  - CVE-2025-49796
  - CVE-2025-49795
  - CVE-2025-49794
  - CVE-2025-6170
  - CVE-2025-6021

- Upgraded OpenSSL from 1.0.2zi to 3.2.4

- Upgraded OpenSSL-FIPS from 2.0.16 to 3.1.2

- Upgraded OpenResty from 1.21 to 1.27.1.2. Includes Nginx upgrade from 1.21.4 to 1.27.1.

## Chef Supermarket 5.2.0

### Security

- Upgraded PostgreSQL from 13.4 to 13.18.
- Multiple CVEs fixed.

## Chef Supermarket 5.1.80

### Security

Upgraded OpenSSL to 1.0.2zi. ([#3248](https://github.com/chef/supermarket/pull/3248))

## Chef Supermarket 5.1.79

### Packaging

We now produce packages for Red Hat Enterprise Linux 9. [(#3112)](https://github.com/chef/supermarket/pull/3212)

## Chef Supermarket 5.1.77

### Enhancements

- Added support for setting a OneTrust ID in Supermarket. ([#3210](https://github.com/chef/supermarket/pull/3210))

## Chef Supermarket 5.1.76

### Improvements

- Added support for OneTrust cookie consent so you can display a cookie consent notification on Supermarket. ([#3187](https://github.com/chef/supermarket/pull/3187))
- Updated logo and favicon to use Progress Chef branding. ([#3186](https://github.com/chef/supermarket/pull/3186))
- Updated footer to include links to the Privacy Policy and Cookie Policy. ([#3186](https://github.com/chef/supermarket/pull/3186))

## Chef Supermarket 5.1.63

### Enhancements

Add almalinux and rocky Linux logos <https://github.com/chef/supermarket/pull/3071>

### Security

Removed insecure links <https://github.com/chef/supermarket/pull/3078>

### Enhancements

Package Upgrades <https://github.com/chef/supermarket/pull/3057>

Package Upgrades <https://github.com/chef/supermarket/pull/3050>

## Chef Supermarket 5.1.62

### Enhancements

Add almalinux and rocky Linux logos <https://github.com/chef/supermarket/pull/3071>

### Security

Removed insecure links <https://github.com/chef/supermarket/pull/3078>

### Enhancements

Package Upgrades <https://github.com/chef/supermarket/pull/3057>

Package Upgrades <https://github.com/chef/supermarket/pull/3050>

## Chef Supermarket 5.1.58

### Bug Fixes

- Replaced insecure http url with correct https url in dashboard as well as welcome page [#2897](https://github.com/chef/supermarket/pull/2897)

### Security

- Upgrade : omnibus-software,nokogiri,faker,omnibus,ua-parser-js,rack,test-kitchen,tzinfo-data [#3032](https://github.com/chef/supermarket/pull/3032)
- Upgraded dependencies: globalid,rails-html-sanitizer,kitchen-vagrant,engine.io & socket.io [#3028](https://github.com/chef/supermarket/pull/3028)
- Update ruby with nokogiri [#3009](https://github.com/chef/supermarket/pull/3009)
- Upgraded dependency: lodash [#2905](https://github.com/chef/supermarket/pull/2905)
- Upgraded dependencies: omnibus-software, tzinfo-data, sqlite3, rspec-rails, net-smtp, shoulda-matchers, rails, lodash, omnibus, sidekiq, webmock [#2915](https://github.com/chef/supermarket/pull/2915)
- Upgraded dependencies: omnibus, omnibus-software, sitemap_generator, pg, webmock, brakeman, webmock, sidekiq, test-kitchen, nokogiri [#2871](https://github.com/chef/supermarket/pull/2871)
- Upgraded dependencies: webmock, omnibus-software, faker, dotenv, dotenv-rails, pg, sidekiq-cron, kitchen-vagrant [#2849](https://github.com/chef/supermarket/pull/2849)
- Upgraded dependencies: activerecord, omnibus-software, nokogiri, rails [#2832](https://github.com/chef/supermarket/pull/2832)
- Upgraded dependencies: SidekiqCron, Rails HTML sanitizer, rubocop Rails, Omnibus Software [#2824](https://github.com/chef/supermarket/pull/2824)
- Upgraded dependencies: octokit, test-kitchen, omnibus-software [#2817](https://github.com/chef/supermarket/pull/2817)
- Upgraded dependency: omnibus-software from 2bda5ed to a8ffc89 in /omnibus [#2810](https://github.com/chef/supermarket/pull/2810)
- Upgraded dependency: sidekiq from 6.5.0 to 6.5.1 [#2797](https://github.com/chef/supermarket/pull/2797)
- Upgraded dependencies: omnibus-software, pg, rubocop-rails [2808](https://github.com/chef/supermarket/pull/2808)

## Chef Supermarket 5.1.53

### Bug Fixes

### Enhancements

### Packaging

### Security

## Chef Supermarket 5.1.44

### Upgrades

- Upgraded Ruby on Rails from 6.1.6 to 7.0.2. Upgraded Ruby from 2.7 to 3.0.3. [#2602](https://github.com/chef/supermarket/pull/2602) ([RajeshPaul38](https://github.com/RajeshPaul38))

### Enhancements

- Add provision to allow multiple hostnames to the list of allowed hosts[#2733](https://github.com/chef/supermarket/pull/2733) ([pratixha](https://github.com/pratixha))
- Make cookstyle a runtime dep for Fieri [#2585](https://github.com/chef/supermarket/pull/2585) ([tas50](https://github.com/tas50))
- Bump pg from 1.3.5 to 1.4.0 in /src/supermarket #2800 (dependabot[bot])

### Security

The following version upgrades are now live with this release of Supermarket:

- `omnibus-software` from 9b0e605 to ccc7269, `sidekiq-cron` from 1.4.0 to 1.5.0, `sidekiq` from 6.4.2 to 6.5.0, `octokit` from 4.23.0 to 4.23.0 and `ddtrace` from 1.0.0 to 1.1.0 [#2782](https://github.com/chef/supermarket/pull/2782) ([RajeshPaul38](https://github.com/RajeshPaul38))
- `yard` from 0.9.27 to 0.9.28, `honeycomb-beeline` from 2.10.0 to 2.11.0 and `berkshelf` from 8.0.1 to 8.0.2 [#2772](https://github.com/chef/supermarket/pull/2772) ([RajeshPaul38](https://github.com/RajeshPaul38))
- `rack` from 2.2.3 to 2.2.3.1, `yajl-ruby` from 1.4.2 to 1.4.3  [#2767](https://github.com/chef/supermarket/pull/2767) ([dheerajd-msys](https://github.com/dheerajd-msys))
- Fixed security vulnerabilities reported in <https://snyk.io/vuln/npm:sprockets-chain@0.0.16> [#2691](https://github.com/chef/supermarket/pull/2691) ([pratixha](https://github.com/pratixha))

## Chef Supermarket 5.1.32

### Bug Fixes

- Updated content security policies for unblocking google analytics scripts [#2746](https://github.com/chef/supermarket/pull/2746) ([@RajeshPaul38](https://github.com/RajeshPaul38))

### Security

The following version upgrades are now live with this release of Supermarket:

- `validate_url` from 1.0.13 to 1.0.15. [#2734](https://github.com/chef/supermarket/pull/2734)
- `omnibus-software` from a079a77 to fe68016 [#2741](https://github.com/chef/supermarket/pull/2741)
- `faker` from 2.20.0 to 2.21.0 [#2738](https://github.com/chef/supermarket/pull/2738)

## Chef Supermarket 5.1.30

### Packaging

- Chef Supermarket's omnibus package now includes `runit`. This will help our users in running on Ruby 3.x installations [#2735](https://github.com/chef/supermarket/pull/2735) [@saghoshprogress](https://github.com/saghoshprogress)

### Security

The following version upgrades are now live with this release of Supermarket:

- `capybara` from 3.36.0 to 3.37.1. [#2729](https://github.com/chef/supermarket/pull/2729)
- `omnibus` from 27c37fc to 63be4f1 [#2728](https://github.com/chef/supermarket/pull/2728)
- `rails` from 6.1.5.1 to 6.1.6. [#2727](https://github.com/chef/supermarket/pull/2727)
- `nokogiri` from 1.13.5 to 1.13.6. [#2722](https://github.com/chef/supermarket/pull/2722)
- `aws-sdk-s3` from 1.113.2 to 1.114.0 [#2717](https://github.com/chef/supermarket/pull/2717)
- `sidekiq` from 6.4.1 to 6.4.2. [#2697](https://github.com/chef/supermarket/pull/2697)
- `omniauth` from 2.0.4 to 2.1.0. [#2693](https://github.com/chef/supermarket/pull/2693)
- `rspec-rails` from 5.1.1 to 5.1.2 [#2702](https://github.com/chef/supermarket/pull/2702)

## Chef Supermarket 5.1.18

### Bug Fixes

- Updated content security policy to allow script and style from google analytics [#2649](https://github.com/chef/supermarket/pull/2649) ([RajeshPaul38](https://github.com/RajeshPaul38))

### Enhancements

- Supermarket now ships with a toggle for enabling/disabling protection from host header attacks [#2684](https://github.com/chef/supermarket/pull/2684) ([RajeshPaul38](https://github.com/RajeshPaul38)).
- Cookstyle settings now have Chef/Security and InSpec/Deprecation cops enabled for checks [#2575](https://github.com/chef/supermarket/pull/2575) ([tas50](https://github.com/tas50))

### Packaging

- We now have a habitat package for the rails supermarket app, the sidekiq worker as well as wrapped versions of (core/) nginx, redis and postgresql with templating/defaults for supermarket [#2453](https://github.com/chef/supermarket/pull/2453) ([saghoshprogress](https://github.com/saghoshprogress))
- Docs update for upgrading to version 5.0 [#2626](https://github.com/chef/supermarket/pull/2626) ([RajeshPaul38](https://github.com/RajeshPaul38))
- Remove unused git dependency [#2429](https://github.com/chef/supermarket/pull/2429) ([dheerajd-msys](https://github.com/dheerajd-msys))
- Removed unused supported platforms metric [#2576](https://github.com/chef/supermarket/pull/2576) ([pratixha](https://github.com/pratixha))

### Security

- The following version upgrades are now live with this release of Supermarket
  - honeycomb-beeline from 2.8.2 to 2.10.0 in /src/supermarket [#2685](https://github.com/chef/supermarket/pull/2685)
  - karma devDependencies updated [#2663](https://github.com/chef/supermarket/pull/2663) ([pratixha](https://github.com/pratixha))
  - puma from 5.6.2 to 5.6.4 in /src/supermarket [#2665](https://github.com/chef/supermarket/pull/2665)
  - mixlib-shellout from 3.2.5 to 3.2.6 in /src/supermarket/engines/fieri [#2666](https://github.com/chef/supermarket/pull/2666)
  - pg from 1.3.4 to 1.3.5 in /src/supermarket [#2667](https://github.com/chef/supermarket/pull/2667) ([dependabot[bot]]
  - rails from 6.1.4.6 to 6.1.5 in /src/supermarket/engines/fieri [#2641](https://github.com/chef/supermarket/pull/2641)
  - honeycomb-beeline from 2.8.2 to 2.9.0 in /src/supermarket [#2661](https://github.com/chef/supermarket/pull/2661)
  - aws-sdk-s3 from 1.112.0 to 1.113.0 in /src/supermarket [#2624](https://github.com/chef/supermarket/pull/2624)

## Chef Supermarket 5.0.41

### Upgrade Requiremements

#### Database Upgrade

Supermarket 5 includes a large upgrade of the underlying PostgreSQL database. An automated upgrade will need to be run post package install. See <https://docs.chef.io/supermarket/supermarket_upgrade/> for details.

#### Allowed Host Attribute

In order to prevent potential host header attacks, users will need to specify the FQDN of the Supermarket with the `node['supermarket']['allowed_host']` attribute. For example, the public supermarket at `https://supermarket.chef.io` would set this value to `supermarket.chef.io`.

### Bug Fixes

- Updated links to the Chef Blog to use the latest URL.
- Updated links to the Chef Documentation to use the latest URL.
- Removed unused attributes for New Relic monitoring.

### Enhancements

#### PostgreSQL 13.4

The embedded PostgreSQL 9.3 installation used by Supermarket to store cookbook information has been upgraded to 13.4. This new release of PostgreSQL improves performance, includes new functionality that will be utilized in future Supermarket releases, and resolves multiple security vulnerabilities. See <https://docs.chef.io/supermarket/supermarket_upgrade/> for more information on completing this upgrade.

#### Cookstyle Cookbook Quality Metrics

The Cookbook Quality Metrics evaluation in Supermarket now uses our Cookstyle engine to evaluate cookbook quality. This greatly improves the breadth of evaluation we provide with ~250 Cookstyle cops being used for each cookbook. This also aligns the quality metrics with the same tools used in local development and CI processes. Stay tuned for exciting new improvements to the Cookbook Quality Metrics using these new capabilities.

#### Log Directory Permissions

Users can now set the permissions of the Supermarket log directory with a new `default['supermarket']['log_mode']` configuration option. This configuration option defaults to the previous directory default of `0700`.

#### Versioned Universe API Endpoint

The `universe` API endpoint is now available under the v1 API endpoint. There are no current plans to introduce breaking changes to the existing `universe` API endpoint, but we highly recommend using the new versioned API endpoint for future compatibility.

### Security

#### HTTP Headers

Supermarket now includes a more secure `Permissions-Policy` HTTP header by default.

#### Puma 5.6.2

Puma upgraded from 5.6.1 to 5.6.2 to resolve CVE-2022-23633

#### Sidekiq 6.4.1

The Sidekiq job processing system used by Supermarket has been updated from 6.3.1 to 6.4.1 to resolve CVE-2021-30151.

#### Ruby on Rails 6.1.4.6

The Ruby on Rails framework used by Supermarket has been updated from 6.1.4.4 to 6.1.4.6 to resolve CVE-2021-22904.

## Chef Supermarket 4.2.89

### Bug Fixes

Fixed icons in the UI not displaying correctly.

### Enhancements

#### Improved Search Results

Deprecated cookbooks are now filtered from search results by default. To include deprecated cookbooks in search you can enable deprecated cookbooks in the advanced search options.

## Chef Supermarket 4.2.82

### Bug Fixes

- Fixed the `/search` API endpoint to properly return the `total` number of cookbooks when the result has been paginated.
- Resolved failures when processing cookbook quality metrics.

### Enhancements

#### GitHub Enterprise Support

You can now set up Supermarket to use a corporate GitHub Enterprise installation in user profiles and to perform cookbook quality metrics scans instead of github.com. See the [Supermarket configuration documentation](https://docs.chef.io/config_rb_supermarket/) for more information on using this new functionality.

#### Maintenance Message Banner Support

You can now set a test string in Supermarket that will be displayed on login for all users. This is a great way to announce regulatory security requirements or to communicate planned maintenance windows. The content of the text can be set with the `default['supermarket']['announcement_text']` attribute.

#### SPDX Licenses

Supermarket cookbook pages now include links to the `spdx.dev` site describing the terms of each software license, so you can more easily evaluate cookbook licenses with your organizational requirements. See the [supermarket-ctl documentation](https://docs.chef.io/supermarket/ctl_supermarket/) for more information on new commands to process SPDX data for existing cookbooks.

#### Cookbook Deprecation Reasons

Users can now set the reason a cookbook is deprecated instead of setting a replacement cookbook when setting a cookbook to deprecated.

### Security

#### Ruby 2.7.5

Updated Ruby from 2.7.4 to 2.7.5 to resolve the following CVEs:

- CVE-2021-41817
- CVE-2021-41816
- CVE-2021-41819

#### Sidekiq 6.3.1

Updated the Sidekiq job queuing engine used to run cookbook quality evaluation jobs from 4.2.10 to 6.3.1 to resolve CVE-2021-30151.

#### Redis 6.2.6

Updated the Redis database used for queuing quality metrics jobs from 6.2.5 to 6.2.6 to resolve the following CVEs:

- CVE-2021-41099
- CVE-2021-32762
- CVE-2021-32687
- CVE-2021-32675
- CVE-2021-32672
- CVE-2021-32628
- CVE-2021-32627
- CVE-2021-32626

#### actionpack 6.1.4.4

Updated the `actionpack` gem used by Supermarket's Ruby on Rails engine to 6.1.4.4 to resolve CVE-2021-44528.

#### CA Certificates 10-26-2021

Updated the bundled CA Certificates file to the 10-26-2021 release, which includes three new CA certs.

#### Supermarket User

The `supermarket` user account that runs Supermarket is now created as a system account without a working shell for added security.

#### Improved HTTP Headers

Set the `Permissions-Policy` HTTP header to disable a user's webcam and payment systems when browsing Supermarket.

### Packaging

#### New Relic Removal

Supermarket no longer ships with New Relic integration for administrators.

#### RHEL 8 Build ID

Chef Infra Server packages no longer install a build ID file that would prevent installing other Chef packages such as Infra Client.

## Chef Supermarket 4.1.28

### Bug Fixes

- A regression introduced in 4.0, which caused the cookbook version pulldown to fail to load has been resolved.

### Enhancements

- User profiles now display a Slack icon next to their Slack username.
- Adopting or updating the maintainers for a cookbook now triggers a reevaluation of the quality score.
- Minor branding updates have been made.
- Embedded Chef Infra Client for `supermarket-ctl reconfigure` has been upgraded from 16.13 to 17.6.

### Packaging

#### Smaller Size

Supermarket packages are now up to 15% smaller, with similar space savings for the Supermarket installation as well.

### Security

#### OpenSSL 1.0.2zb

OpenSSL has been updated from 1.0.2za to 1.0.2zb to resolve issues with Let's Encrypt certificates.
cacerts

#### cacerts

The cacerts bundle has been updated to the 2021-09-30 release which removes older expired root certificates and adds the following new root certificates:

- AC RAIZ FNMT-RCM SERVIDORES SEGUROS
- GlobalSign Root R46
- GlobalSign Root E46
- GLOBALTRUST 2020
- ANF Secure Server Root CA
- Certum EC-384 CA
- Certum Trusted Root CA

#### nokogiri

The nokogiri gem has been updated to 1.12.5 to resolve CVE-2021-41098.

#### puma

The puma gem has been updated from 5.5.0 to 5.5.2 to resolve CVE-2021-41136.

## Chef Supermarket 4.0.21

### Breaking Changes

- Removed links to EOL Chef Provisioning drivers from the Tools tab. If you have existing Chef Provisioning Tools uploaded to Supermarket, they're no longer visible.
- Removed CCLA and ICLA management through Supermarket. The `supermarket-ctl upgrade` command will drop any existing CLA-related PostgreSQL tables.
- Removed `Publish Metric` from the Cookbook quality metric. Cookbooks no longer get a baseline quality score just for being published.

### Bug Fixes

- Updated the Octokit gem for interacting with GitHub to avoid deprecation e-mails from GitHub and failures running cookbook quality metrics after September 8th, 2021.
- Fixed the dead links in Supermarket.
- Removed links to the long-EOL'd `botbotirc` service.
- Fixed incorrect user profile rendering with large numbers of cookbooks.
- Fix search rendering on mobile browsers.

### Enhancements

- Updated the product names in Supermarket to match current product names.
- Adjusted the search algorithm so deprecated cookbooks are at the bottom of search results.
- Improved error messages, with more work coming to add messages for all required S3 environmental variables.
- Curated the list of platforms in the search filter to show common platforms.
- Added a prompt that requires users to confirm the action before removing themselves as collaborators from cookbooks.
- Removed references to EOL ChefDK and Chef Provisioning products.
- Set headers in the Automated release notification e-mails from Supermarket to avoid "Out of Office" replies from cookbook authors.

### Packaging

#### Ubuntu 16.04 Removal

We no longer make Supermarket packages for Ubuntu 16.04, which went EOL April 2021.

#### RPM Package Digests

The file digest in Chef Infra Server RPM packages has been updated from MD5 to SHA256 to prevent installation failures on some FIPS-enabled systems.

#### Ubuntu FIPS Support

Ubuntu packages are now FIPS compliant for all your FedRAMP needs.

#### RHEL 8 Packages

RHEL 8 packages now have additional RHEL 8 optimizations and EL8 in the filename.

#### SLES Packages

We now produce Supermarket packages for SLES 12 and 15.

### Security

#### TLS 1.0 and 1.1 Disabled By Default

TLS 1.2 is now the sole default for the `node['supermarket']['ssl']['protocols']` configuration attribute. The previous default was 1.0, 1.1, and 1.2. This change provides a more secure setup out of the box. It may cause failures on very old operating systems or ChefDK releases.

#### Content Security Policy

We added Content Security Policy HTTP response headers to improve Supermarket security and reduce the chance of cross-site scripting attacks.

#### Server Header Removal

We removed the HTTP 'Server' header from responses to prevent identification of the underlying web server.

#### Redirection Improvements

We improved validation within URL redirects to avoid potential spoofing.

#### Rails 6.1.4

The Rails engine that powers Supermarket has been updated from 5.2.4.4 to 6.1.4. This new release adds significant new capabilities to Rails that will enable future development work. It also resolves the following CVEs:

- CVE-2021-22903
- CVE-2021-22902
- CVE-2021-22904
- CVE-2021-22885
- CVE-2021-22881
- CVE-2021-22880
- CVE-2020-8166

#### Ruby 2.7.4

Ruby has been updated from 2.6.6 to 2.7.4 to improve performance and resolve the following CVEs:

- CVE-2020-25613
- CVE-2021-28965
- CVE-2021-31810
- CVE-2021-32066
- CVE-2021-31799

#### PostgreSQL 9.3.25

PostgreSQL has been updated from 9.3.18 to 9.3.25 to resolve a large number of bugs, as well as the following CVEs:

- CVE-2018-10915
- CVE-2018-1058
- CVE-2018-1053
- CVE-2017-15098
- CVE-2017-12172

#### OpenResty 1.19.9.1

Supermarket's Nginx 1.18 web server has been replaced with OpenResty 1.19.9.1. OpenResty is an Nginx-based web server that offers additional modules and is used by the Chef Infra Server. This new release includes significant performance improvements, bug fixes, and a fix for CVE-2021-23017.

#### Curl 7.79

Curl has been updated from 7.75 to 7.79 to resolve the following CVEs:

- CVE-2021-22897
- CVE-2021-22898
- CVE-2021-22901
- CVE-2021-22922
- CVE-2021-22923
- CVE-2021-22924
- CVE-2021-22925
- CVE-2021-22926
- CVE-2021-22945
- CVE-2021-22946
- CVE-2021-22947

#### Omniauth 2.0.4

The omniauth gem used by Supermarket has been updated from 1.9.1 to 2.0.4 to resolve CVE-2015-9284.

#### Redis 6.2.5

Redis has been updated from 3.0.7 to 6.2.5. This new release includes significant new capabilities and resolves the following CVEs:

- CVE-2021-32761
- CVE-2021-3470
- CVE-2020-14147
- CVE-2019-10193
- CVE-2019-10192
- CVE-2018-12453
- CVE-2018-12326
- CVE-2018-11219
- CVE-2018-11218
- CVE-2016-10517

#### OpenSSL 1.0.2za

OpenSSL has been updated from 1.0.2y to 1.0.2za to resolve CVE-2021-3712.

#### NodeJS Runtime Removal

Supermarket has switched from a full installation of EOL NodeJS 0.10.35 to an embedded release bundled within Ruby. This resolves a large number of CVEs and improves security by reducing the overall attack surface.

#### Python Runtime Removal

Removing NodeJS runtime from Supermarket made bundling Python 2.7 as part of Supermarket unnecessary. Removing Python 2.7 also resolves multiple CVEs and improves security by reducing the overall attack surface.

## Chef Supermarket 3.4.8

### Enhancements

Supermarket has been updated to support using external PostgreSQL releases version 9.6 and later allowing you to use up-to-date external PostgreSQL services such as Amazon RDS.

### Security Updates

#### Activerecord

The activerecord gem has been updated from 5.2.4.4 to 5.2.4.5 to resolve [CVE-2021-22880.](https://github.com/advisories/GHSA-8hc4-xxm3-5ppp)

#### Redcarpet

The redcarpet gem has been updated from 3.4.0 to 3.5.1 to resolve [GHSA-q3wr-qw3g-3p4h](https://github.com/advisories/GHSA-q3wr-qw3g-3p4h)

#### Nokogiri

The nokogiri gem has been updated from 1.10.10 to 1.11.1 to resolve [CVE-2020-26247](https://github.com/advisories/GHSA-vr8q-g5c7-m54m)

#### OpenSSL

The bundled OpenSSL library has been updated from 1.0.2u to 1.0.2y to resolve the following CVEs:

- [CVE-2021-23841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23841)
- [CVE-2021-23839](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23839)
- [CVE-2021-23840](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-23840)
- [CVE-2020-1971](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-1971)
- [CVE-2020-1968](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2020-1968)

#### curl

The embedded curl CLI has been updated from 7.71.1 to 7.75.0 to resolve the following CVEs:

- [CVE-2020-82841](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-82841)
- [CVE-2020-82851](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-82851)
- [CVE-2020-82861](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-82861)
- [CVE-2021-228761](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-228761)
- [CVE-2021-228901](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-228901)

## Chef Supermarket 3.4.1

### Bug Fixes

- disambiguate columns used in query ordering [#1893](https://github.com/chef/supermarket/pull/1893) ([robbkidd](https://github.com/robbkidd))
- Fix exceptions thrown by displaying an error [#1894](https://github.com/chef/supermarket/pull/1894) ([robbkidd](https://github.com/robbkidd))
- [omnibus] use YAML.dump to serialize simple hashes to disk [#1896](https://github.com/chef/supermarket/pull/1896) ([robbkidd](https://github.com/robbkidd))

### Security Fixes

- add HTTP strict transport security header when force SSL is enabled [#1855](https://github.com/chef/supermarket/pull/1855) ([robbkidd](https://github.com/robbkidd))

### Maintenance Updates

- Drop support for RHEL 6 builds [#1898](https://github.com/chef/supermarket/pull/1898) ([robbkidd](https://github.com/robbkidd))

## Chef Supermarket 3.3.35

### Security Fixes

These updates resolve CVE scanner audits. No vulnerabilities were found in Supermarket's use of these components.

- update deps: includes nginx 1.18.0 [#1874](https://github.com/chef/supermarket/pull/1874) ([tas50](https://github.com/tas50))
- update Ruby to 2.6.6 to resolve 2 CVEs [#1877](https://github.com/chef/supermarket/pull/1877) ([tas50](https://github.com/tas50))
- update actionview from 5.2.4.3 to 5.2.4.4 [#1887](https://github.com/chef/supermarket/pull/1887) ([dependabot-preview[bot]](https://github.com/dependabot-preview[bot]))

### Enhancements

- add support for enabling Server Side Encryption when storing cookbooks in AWS S3 [#1888](https://github.com/chef/supermarket/pull/1888) ([bdwyertech](https://github.com/bdwyertech))
- add packages for Amazon Linux 2 to the pipeline [#1875](https://github.com/chef/supermarket/pull/1875) ([tas50](https://github.com/tas50))

### Maintenance Updates

- update Foodcritic from 14.3 to 16.3 [#1881](https://github.com/chef/supermarket/pull/1881) ([tas50](https://github.com/tas50))
- update Cookstyle / Chefstyle to the latest [#1882](https://github.com/chef/supermarket/pull/1882) ([tas50](https://github.com/tas50))
- require Chef 14+ in omnibus now [#1883](https://github.com/chef/supermarket/pull/1883) ([tas50](https://github.com/tas50))

## Chef Supermarket 3.3.26

### Security Fixes

- Rails 5.0 -&gt; 5.1 -&gt; 5.2 upgrade; adoption of ChefStyle [#1867](https://github.com/chef/supermarket/pull/1867) ([robbkidd](https://github.com/robbkidd))
- Bump rack from 2.0.8 to 2.2.2 in quality metrics engine [#1858](https://github.com/chef/supermarket/pull/1858) ([dependabot-preview[bot]](https://github.com/dependabot-preview[bot]))
- Bump kaminari from 1.0.1 to 1.2.1  [#1862](https://github.com/chef/supermarket/pull/1862) ([dependabot-preview[bot]](https://github.com/dependabot-preview[bot]))
- Bump rack from 2.2.2 to 2.2.3  [#1868](https://github.com/chef/supermarket/pull/1868) ([dependabot[bot]](https://github.com/dependabot[bot]))

### Merged Pull Requests

- Remove bundler-audit from tests; we&#39;re auditing with GitHub [#1861](https://github.com/chef/supermarket/pull/1861) ([tas50](https://github.com/tas50))
- Resolve upcoming OpenSSL Ruby library deprecation of algorithm constants [#1860](https://github.com/chef/supermarket/pull/1860) ([tas50](https://github.com/tas50))

## Chef Supermarket 3.3.20

### Security Fixes

- update rubyzip to address CVE-2019-16892 [#1825](https://github.com/chef/supermarket/pull/1825) ([robbkidd](https://github.com/robbkidd))
- Bump loofah from 2.2.3 to 2.3.1 [#1830](https://github.com/chef/supermarket/pull/1830) ([dependabot[bot]](https://github.com/dependabot[bot]))
- update for CVE-2019-13117 &amp; CVE-2019-16782 [#1833](https://github.com/chef/supermarket/pull/1833) ([robbkidd](https://github.com/robbkidd))
- Bump rack from 2.0.7 to 2.0.8 in /omnibus [#1834](https://github.com/chef/supermarket/pull/1834) ([dependabot[bot]](https://github.com/dependabot[bot]))
- include secrets found in secrets.json in runtime omnibus config [#1832](https://github.com/chef/supermarket/pull/1832) ([robbkidd](https://github.com/robbkidd))
- Bump nokogiri from 1.10.7 to 1.10.9 [#1848](https://github.com/chef/supermarket/pull/1848) ([dependabot-preview[bot]](https://github.com/dependabot-preview[bot]))
- Bump rake from 12.3.2 to 13.0.1 [#1844](https://github.com/chef/supermarket/pull/1844) ([dependabot-preview[bot]](https://github.com/dependabot-preview[bot]))
- Bump omniauth from 1.9.0 to 1.9.1 [#1851](https://github.com/chef/supermarket/pull/1851) ([dependabot-preview[bot]](https://github.com/dependabot-preview[bot]))
- generate secrets.json with warning messages [#1849](https://github.com/chef/supermarket/pull/1849) ([robbkidd](https://github.com/robbkidd))
- Prevent unsafe links to cross-origin destinations [#1846](https://github.com/chef/supermarket/pull/1846) ([cattywampus](https://github.com/cattywampus))

### Merged Pull Requests

- add a version command to supermarket-ctl [#1811](https://github.com/chef/supermarket/pull/1811) ([robbkidd](https://github.com/robbkidd))
- avoid Double Bundler by pinning rubygems version [#1835](https://github.com/chef/supermarket/pull/1835) ([robbkidd](https://github.com/robbkidd))
- upgrade Ruby to 2.6.5 [#1852](https://github.com/chef/supermarket/pull/1852) ([robbkidd](https://github.com/robbkidd))

## Chef Supermarket 3.3.7

### Security Fixes

- update packaged OpenSSL to 1.0.2s [#1813](https://github.com/chef/supermarket/pull/1813) ([robbkidd](https://github.com/robbkidd))
- update to use curl 7.65.0 [#1814](https://github.com/chef/supermarket/pull/1814) ([robbkidd](https://github.com/robbkidd))
- require POSTs during sign-in (CVE-2015-9284) [#1815](https://github.com/chef/supermarket/pull/1815) ([robbkidd](https://github.com/robbkidd))

### Merged Pull Requests

- No more Ubuntu 14 builds. Canonical ended support for trusty in April 2019. [#1818](https://github.com/chef/supermarket/pull/1818) ([christopher-snapp](https://github.com/christopher-snapp))
- omnibus build fixes [#1821](https://github.com/chef/supermarket/pull/1821) ([robbkidd](https://github.com/robbkidd))

## Chef Supermarket 3.3.3

### Security Fixes

- upgrade nokogiri (CVE-2019-11068) [#1808](https://github.com/chef/supermarket/pull/1808) ([robbkidd](https://github.com/robbkidd))

### Bug Fixes

- fix `'tarball' is corrupt: "\x80\x00\x00\x00\x0E:\xBFD" isn't an octal string` upload error when cookbook tarball uid/gid is very large [#1810](https://github.com/chef/supermarket/pull/1810) ([robbkidd](https://github.com/robbkidd))

## Chef Supermarket 3.3.1

A big thanks goes out to [Pavel Kazhavets](https://github.com/pavel-kazhavets) for contributing the fix for enabling AWS IAM roles for S3 bucket cookbook storage. IAM user keys are no longer required!

### Enhancements

- add support for S3 storage using IAM roles [#1747](https://github.com/chef/supermarket/pull/1747) ([pavel-kazhavets](https://github.com/pavel-kazhavets))

## Chef Supermarket 3.2.2

### Security Fixes

- upgrade omnibus-embedded nginx [#1790](https://github.com/chef/supermarket/pull/1790) ([robbkidd](https://github.com/robbkidd))
- upgrade OpenSSL, RubyGems, and Rails to address multiple CVEs [#1798](https://github.com/chef/supermarket/pull/1798) ([robbkidd](https://github.com/robbkidd))

## Chef Supermarket 3.1.96

### Security Fixes

- update Rails to 5.0.7.1 [#1784](https://github.com/chef/supermarket/pull/1784) ([robbkidd](https://github.com/robbkidd))
- update rack (&amp; other gems) in the omnibus build environment [#1785](https://github.com/chef/supermarket/pull/1785) ([robbkidd](https://github.com/robbkidd))
- update rack for CVE-2018-16471 [#1782](https://github.com/chef/supermarket/pull/1782) ([robbkidd](https://github.com/robbkidd))
- RFC072 Artifact Yanking: disallow cookbook removal by owner (not enabled by default onprem ... yet) [#1789](https://github.com/chef/supermarket/pull/1789) ([robbkidd](https://github.com/robbkidd))

### Merged Pull Requests

- update omnibus to use latest enterprise cookbook [#1788](https://github.com/chef/supermarket/pull/1788) ([robbkidd](https://github.com/robbkidd))

## Chef Supermarket 3.1.91

### Bug Fixes

- Fix search engines knowing the correct cookbook create/update datetimes [#1779](https://github.com/chef/supermarket/pull/1779) ([rmoriz](https://github.com/rmoriz)) - Thanks to [rmoriz](https://github.com/rmoriz) for a fix to cookbook display dates that should help discovery in search engine ranking!

### Security Updates

- update nokogiri to quiet CVE audit [#1771](https://github.com/chef/supermarket/pull/1771) ([robbkidd](https://github.com/robbkidd))
- Update Ruby to 2.5.3 [#1769](https://github.com/chef/supermarket/pull/1769) ([tas50](https://github.com/tas50))

### Merged Pull Requests

- upgrade rails to 5.0.7 [#1777](https://github.com/chef/supermarket/pull/1777) ([robbkidd](https://github.com/robbkidd))
- update omnibus ctl test command for Inspec 3.0 [#1772](https://github.com/chef/supermarket/pull/1772) ([robbkidd](https://github.com/robbkidd))
- reduce package size with compression for omnibus DEB &amp; RPM configs [#1770](https://github.com/chef/supermarket/pull/1770) ([tas50](https://github.com/tas50))
- Update Foodcritic to 14.3 [#1773](https://github.com/chef/supermarket/pull/1773) ([tas50](https://github.com/tas50))
- update to latest omnibus and omnibus-software definitions [#1774](https://github.com/chef/supermarket/pull/1774) ([scotthain](https://github.com/scotthain))
- bring omnibus-internal cookbook up to Chef 14 standards [#1748](https://github.com/chef/supermarket/pull/1748) ([tas50](https://github.com/tas50))
- upgrade loofah to 2.2.3 [#1778](https://github.com/chef/supermarket/pull/1778) ([robbkidd](https://github.com/robbkidd))

## Chef Supermarket 3.1.81

### Security Fixes

- update rubyzip [#1766](https://github.com/chef/supermarket/pull/1766) ([rhass](https://github.com/rhass))
- omit web server version from response headers [#1765](https://github.com/chef/supermarket/pull/1765) ([Nimesh-Msys](https://github.com/Nimesh-Msys))
- set session cookie to secure when sent over an HTTPS connection [#1750](https://github.com/chef/supermarket/pull/1750) ([Vasu1105](https://github.com/Vasu1105))
- upgrade to OpenSSL 1.0.2p [#1752](https://github.com/chef/supermarket/pull/1752) ([robbkidd](https://github.com/robbkidd))
- update ffi gem to reduce CVE audit noise [#1763](https://github.com/chef/supermarket/pull/1763) ([robbkidd](https://github.com/robbkidd))

### Bug Fixes

- replace periodic job scheduler with one that's maintained [#1756](https://github.com/chef/supermarket/pull/1756) ([robbkidd](https://github.com/robbkidd))

### Merged Pull Requests

- reorganize the fieri subcomponent to make supermarket more container friendly [#1704](https://github.com/chef/supermarket/pull/1704) ([robbkidd](https://github.com/robbkidd))
- habitat skeleton to get started [#1761](https://github.com/chef/supermarket/pull/1761) ([jtimberman](https://github.com/jtimberman))
- change "knife cookbook site" references to "knife supermarket" [#1762](https://github.com/chef/supermarket/pull/1762) ([tas50](https://github.com/tas50))

## Chef Supermarket 3.1.72

### Security Fixes

- fix markdown rendering links and images with unsafe protocols [#1746](https://github.com/chef/supermarket/pull/1746) ([robbkidd](https://github.com/robbkidd))

### Merged Pull Requests

- update nokogiri to quiet gem audit finding [#1745](https://github.com/chef/supermarket/pull/1745) ([robbkidd](https://github.com/robbkidd))
