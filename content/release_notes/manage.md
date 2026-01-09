+++
title = "Chef Manage release notes"
draft = false
product = []
linkTitle = "Chef Manage"
summary = "Chef Manage release notes"

[menu]
  [menu.release_notes]
    title = "Chef Manage"
    identifier = "release_notes/release_notes_manage.md Chef Manage"
    parent = "release_notes"
    weight = 95
+++

<!-- markdownlint-disable-file -->
<!-- cSpell:disable  -->
<!-- vale off -->

Chef Manage provides a web-based user interface that manages Chef Infra nodes and other policy objects, such as data bags and roles, on the instance of Chef Infra Server that it's installed on.

{{< note >}}

Chef Manage is [deprecated](/versions/#deprecated) and users should plan to migrate to [Chef Automate](/automate/) as the replacement.

{{< /note >}}

## Upgrading

Download the latest version of the chef-manage package for your platform from [Chef Downloads](https://www.chef.io/downloads) to your Chef Infra Server, then run:

```bash
rpm -Uvh /path/to/chef-manage-*.rpm
```

or

```bash
dpkg -i /path/to/chef-manage-*.deb
```

then:

```bash
chef-manage-ctl reconfigure
chef-server-ctl reconfigure
```

## Chef Manage 3.3.97

### Updates

- Removed the 'My Account' menu item in the top-right user menu. This change applies only to Hosted Chef.

## Chef Manage 3.3.96

### Bug Fixes

We fixed an issue introduced in Chef Manage 3.3.93 where changes made to attributes using the web UI would not persist.

To fix this issue, we've removed the `redis-namespace` Gem since it's no longer supported by Sidekiq.

**Note**: If you use the Redis instance shipped with Chef Manage, please review your use case to ensure this change doesn't affect you.

## Chef Manage 3.3.95

### Security

#### Security Improvements

- Updated the Content Security Policy (CSP) to exclude the `unsafe-eval` policy, which is susceptible to common bypass techniques.

### Updates

- Removed support for Google Tag Manager.

## Chef Manage 3.3.93

### Improvements

- Added support for Google Tag Manager. Google Tag Manager ID can be set to manage Google Tags. ([#1714](https://github.com/chef/chef-manage/pull/1714) , [#1718](https://github.com/chef/chef-manage/pull/1718))
- Added support for OneTrust cookie consent which can be set to display a cookie consent banner. ([#1714](https://github.com/chef/chef-manage/pull/1714))
- Updated footer to include links to Privacy Policy & Cookie Policy. ([#1705](https://github.com/chef/chef-manage/pull/1705))
- Updated logo to reflect current Progress Chef brand. ([#1705](https://github.com/chef/chef-manage/pull/1705))

### Security

#### Security Improvements

- The user sign-up form now includes improved input validation. ([#1690](https://github.com/chef/chef-manage/pull/1690))
- Updated password reset message ([#1645](https://github.com/chef/chef-manage/pull/1645))
- Upgrade : globalid,rack,actionpack,rails ([#1624](https://github.com/chef/chef-manage/pull/1624))
- Bump sidekiq from 6.5.6 to 7.0.7 ([#1634](https://github.com/chef/chef-manage/pull/1634))
- Gem upgrade: rack, omnibus-software, newrelic_rpm, excon, kitchen-vagrant, spring, test-kitchen, rails-html-sanitizer, loofah, sinatra, haml, nokogiri, redis-store, timers ([#1622](https://github.com/chef/chef-manage/pull/1622))
- Gem upgrade: savon, timers, redis, sidekiq, asset_sync, omnibus-software ([#1490](https://github.com/chef/chef-manage/pull/1490))
- Gem upgrade: newrelic_rpm, omnibus ([#1477](https://github.com/chef/chef-manage/pull/1477))
- Gem upgrade for dotenv and excon ([#1459](https://github.com/chef/chef-manage/pull/1459))
- Upgrade omnibus-software and kitchen-vagrant ([#1455](https://github.com/chef/chef-manage/pull/1455))
- Bump actionpack from 7.0.3 to 7.0.3.1 in /src/chef-manage ([#1452](https://github.com/chef/chef-manage/pull/1452))
- Bundle Dependabot PRs ([#1475](https://github.com/chef/chef-manage/pull/1475), [#1444](https://github.com/chef/chef-manage/pull/1444), [#1450](https://github.com/chef/chef-manage/pull/1450))
- Bump sidekiq from 6.4.2 to 6.5.0 in /src/chef-manage ([#1421](https://github.com/chef/chef-manage/pull/1421))
- Upgrade octkit, kitchen-vagrant and test-kitchen ([#1430](https://github.com/chef/chef-manage/pull/1430))
- Fix release notes expeditor path ([#1426](https://github.com/chef/chef-manage/pull/1426))
- Removed all the debugging code and updated the project name ([#1425](https://github.com/chef/chef-manage/pull/1425))

### Bug Fixes

- Updated dependency 'mime-types-data' to address a logging related issue. ([#1717](https://github.com/chef/chef-manage/pull/1717))

## Chef Manage 3.3.66

#### Enhancements

- Upgraded Ruby version to 3.0.3 and Rails version to 7.0.3 [#1391](https://github.com/chef/chef-manage/pull/1391) ([antima-gupta](https://github.com/antima-gupta)) <!-- 3.3.51 -->

#### Security Updates

The following version upgrades are now live with this release of Chef Manage:

- `omnibus-software` from `9b0e605` to `924d9cf` in /omnibus [#1417](https://github.com/chef/chef-manage/pull/1417) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.63 -->
- `veil` from `51a81ad` to `da6a693` in /src/chef-manage [#1418](https://github.com/chef/chef-manage/pull/1418) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.62 -->
- Updated the expeditor config to fix the wiki page failure [#1414](https://github.com/chef/chef-manage/pull/1414) ([saghoshprogress](https://github.com/saghoshprogress)) <!-- 3.3.61 -->
- `newrelic_rpm` from 8.7.0 to 8.8.0 in /src/chef-manage [#1416](https://github.com/chef/chef-manage/pull/1416) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.60 -->
- `omnibus-software` from `a9b13a0` to `9b0e605` in /omnibus [#1415](https://github.com/chef/chef-manage/pull/1415) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.59 -->
- `asset_sync` from 2.15.1 to 2.15.2 in /src/chef-manage [#1413](https://github.com/chef/chef-manage/pull/1413) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.58 -->
- `veil` from `660dca8` to `51a81ad` in /src/chef-manage [#1412](https://github.com/chef/chef-manage/pull/1412) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.57 -->
- `berkshelf` from 8.0.1 to 8.0.2 in /omnibus [#1411](https://github.com/chef/chef-manage/pull/1411) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.56 -->
- `Update rack` from 2.2.3 to 2.2.3.1 [#1410](https://github.com/chef/chef-manage/pull/1410) ([dheerajd-msys](https://github.com/dheerajd-msys)) <!-- 3.3.55 -->
- `omnibus` from `8ecfecd` to `78ad41d` in /omnibus [#1400](https://github.com/chef/chef-manage/pull/1400) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.54 -->
- `omnibus-software` from `36f49ec` to `c9447a3` in /omnibus [#1399](https://github.com/chef/chef-manage/pull/1399) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.53 -->
- `omnibus` from `63be4f1` to `8ecfecd` in /omnibus [#1398](https://github.com/chef/chef-manage/pull/1398) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.52 -->
- `omnibus-software` from `fe68016` to `36f49ec` in /omnibus [#1397](https://github.com/chef/chef-manage/pull/1397) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.50 -->
- `berkshelf` from 8.0.0 to 8.0.1 in /omnibus [#1396](https://github.com/chef/chef-manage/pull/1396) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.49 -->
- `omnibus-software` from `99b8d53` to `fe68016` in /omnibus [#1393](https://github.com/chef/chef-manage/pull/1393) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.47 -->
- `omnibus-software` from `a079a77` to `99b8d53` in /omnibus [#1392](https://github.com/chef/chef-manage/pull/1392) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.46 -->
- `omnibus` from `27c37fc` to `63be4f1` in /omnibus [#1387](https://github.com/chef/chef-manage/pull/1387) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.45 -->
- `actionpack` and `actionview` to 6.1.5.1 [#1382](https://github.com/chef/chef-manage/pull/1382) ([dheerajd-msys](https://github.com/dheerajd-msys)) <!-- 3.3.44 -->
- `omnibus-software` from `ff4c902` to `a079a77` in /omnibus [#1384](https://github.com/chef/chef-manage/pull/1384) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.43 -->
- `omnibus-software` from `9499b1c` to `ff4c902` in /omnibus [#1383](https://github.com/chef/chef-manage/pull/1383) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.42 -->
- `omnibus-software` from `ebd14d3` to `9499b1c` in /omnibus [#1381](https://github.com/chef/chef-manage/pull/1381) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.41 -->
- `newrelic_rpm` from 8.6.0 to 8.7.0 in /src/chef-manage [#1379](https://github.com/chef/chef-manage/pull/1379) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.40 -->
- `brakeman` from 5.2.2 to 5.2.3 in /src/chef-manage [#1378](https://github.com/chef/chef-manage/pull/1378) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.39 -->
- `berkshelf` from 7.2.2 to 8.0.0 in /omnibus [#1376](https://github.com/chef/chef-manage/pull/1376) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.38 -->
- `omnibus-software` from `50d05bc` to `ebd14d3` in /omnibus [#1375](https://github.com/chef/chef-manage/pull/1375) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.37 -->
- `omnibus-software` from `8f141a6` to `50d05bc` in /omnibus [#1373](https://github.com/chef/chef-manage/pull/1373) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.36 -->
- combine dependabot prs/infsus-157 [#1369](https://github.com/chef/chef-manage/pull/1369) ([RajeshPaul38](https://github.com/RajeshPaul38)) <!-- 3.3.35 -->
- `excon` from 0.92.2 to 0.92.3 in /src/chef-manage [#1371](https://github.com/chef/chef-manage/pull/1371) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.34 -->
- `omnibus-software` from `7d5c535` to `50d05bc` in /omnibus [#1370](https://github.com/chef/chef-manage/pull/1370) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.33 -->
- `omnibus-software` from `4af4298` to `7d5c535` in /omnibus [#1362](https://github.com/chef/chef-manage/pull/1362) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.32 -->
- `omnibus-software` from `518f3f8` to `4af4298` in /omnibus [#1361](https://github.com/chef/chef-manage/pull/1361) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.31 -->
- `omnibus` from `124d596` to `27c37fc` in /omnibus [#1360](https://github.com/chef/chef-manage/pull/1360) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.30 -->
- `omnibus-software` from `960cb6e` to `518f3f8` in /omnibus [#1359](https://github.com/chef/chef-manage/pull/1359) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.29 -->
- `nokogiri` from 1.13.3 to 1.13.4 in /src/chef-manage [#1358](https://github.com/chef/chef-manage/pull/1358) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.28 -->
- `omnibus-software` from `553d1e0` to `960cb6e` in /omnibus [#1355](https://github.com/chef/chef-manage/pull/1355) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.27 -->
- `brakeman` from 5.2.1 to 5.2.2 in /src/chef-manage [#1357](https://github.com/chef/chef-manage/pull/1357) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.26 -->
- `newrelic_rpm` from 8.5.0 to 8.6.0 in /src/chef-manage [#1356](https://github.com/chef/chef-manage/pull/1356) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.25 -->
- `excon` from 0.92.1 to 0.92.2 in /src/chef-manage [#1352](https://github.com/chef/chef-manage/pull/1352) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.24 -->
- dependabot pr bundle/infsus 112 [#1344](https://github.com/chef/chef-manage/pull/1344) ([RajeshPaul38](https://github.com/RajeshPaul38)) <!-- 3.3.22 -->
- Combined dependabot PR&#39;s [#1338](https://github.com/chef/chef-manage/pull/1338) ([pratixha](https://github.com/pratixha)) <!-- 3.3.21 -->
- Update Rails to 6.1.4.6 [#1323](https://github.com/chef/chef-manage/pull/1323) ([tas50](https://github.com/tas50)) <!-- 3.3.19 -->
- `newrelic_rpm` from 8.4.0 to 8.5.0 in /src/chef-manage [#1325](https://github.com/chef/chef-manage/pull/1325) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.18 -->
- Corrected failing specs for knife_rb [#1327](https://github.com/chef/chef-manage/pull/1327) ([pratixha](https://github.com/pratixha)) <!-- 3.3.17 -->
- `omnibus-software` from `a4f4849` to `f64a223` in /omnibus [#1321](https://github.com/chef/chef-manage/pull/1321) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.16 -->
- `omnibus` from `55e74ac` to `124d596` in /omnibus [#1314](https://github.com/chef/chef-manage/pull/1314) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.15 -->
- `chef` from 17.9.46 to 17.9.52 in /src/chef-manage [#1317](https://github.com/chef/chef-manage/pull/1317) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.15 -->
- `chef` from 17.9.42 to 17.9.46 in /src/chef-manage [#1307](https://github.com/chef/chef-manage/pull/1307) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.14 -->
- `config` from 3.1.1 to 4.0.0 in /src/chef-manage [#1311](https://github.com/chef/chef-manage/pull/1311) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.13 -->
- `omnibus-software` from `91c1297` to `a4f4849` in /omnibus [#1312](https://github.com/chef/chef-manage/pull/1312) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.12 -->
- `redis` from 4.5.1 to 4.6.0 in /src/chef-manage [#1300](https://github.com/chef/chef-manage/pull/1300) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.11 -->
- `omnibus-software` from `c7a43ec` to `91c1297` in /omnibus [#1309](https://github.com/chef/chef-manage/pull/1309) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.10 -->
- `omnibus-software` from `0c87f0b` to `c7a43ec` in /omnibus [#1303](https://github.com/chef/chef-manage/pull/1303) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.9 -->
- Use lifecycle hook in omnibus kitchen config [#1013](https://github.com/chef/chef-manage/pull/1013) ([tas50](https://github.com/tas50)) <!-- 3.3.8 -->
- `sidekiq` from 6.4.0 to 6.4.1 in /src/chef-manage [#1305](https://github.com/chef/chef-manage/pull/1305) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.7 -->
- `excon` from 0.90.0 to 0.91.0 in /src/chef-manage [#1302](https://github.com/chef/chef-manage/pull/1302) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.5 -->
- font-awsome-rails 3 to 4.7 [#1284](https://github.com/chef/chef-manage/pull/1284) ([antima-gupta](https://github.com/antima-gupta)) <!-- 3.3.4 -->
- `omnibus-software` from `1c00b6d` to `0c87f0b` in /omnibus [#1299](https://github.com/chef/chef-manage/pull/1299) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.3 -->
- `chef` from 17.9.26 to 17.9.42 in /src/chef-manage [#1296](https://github.com/chef/chef-manage/pull/1296) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.2 -->
- `brakeman` from 5.2.0 to 5.2.1 in /src/chef-manage [#1297](https://github.com/chef/chef-manage/pull/1297) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.3.1 -->
- Updated sidekiq gem [#1298](https://github.com/chef/chef-manage/pull/1298) ([saghoshprogress](https://github.com/saghoshprogress)) <!-- 3.2.53 -->
- `newrelic_rpm` from 8.3.0 to 8.4.0 in /src/chef-manage [#1292](https://github.com/chef/chef-manage/pull/1292) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.2.52 -->
- `rspec-rails` from 5.0.2 to 5.1.0 in /src/chef-manage [#1290](https://github.com/chef/chef-manage/pull/1290) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.2.51 -->
- `omnibus` from `f077b40` to `55e74ac` in /omnibus [#1293](https://github.com/chef/chef-manage/pull/1293) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.2.50 -->
- `omnibus-software` from `b646bed` to `1c00b6d` in /omnibus [#1294](https://github.com/chef/chef-manage/pull/1294) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.2.49 -->
- `omnibus` from `2bf77bb` to `f077b40` in /omnibus [#1287](https://github.com/chef/chef-manage/pull/1287) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.2.47 -->
- `omnibus-software` from `dd555fa` to `b646bed` in /omnibus [#1288](https://github.com/chef/chef-manage/pull/1288) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.2.46 -->
- `omnibus-software` from `774125f` to `dd555fa` in /omnibus [#1280](https://github.com/chef/chef-manage/pull/1280) ([dependabot[bot]](https://github.com/dependabot[bot])) <!-- 3.2.45 -->

### Bug Fixes

- update specs for capybara upgrade [#1394](https://github.com/chef/chef-manage/pull/1394) ([msys-sgarg](https://github.com/msys-sgarg)) <!-- 3.3.48 -->
- CVE fix: Karma node module version upgrade [#1337](https://github.com/chef/chef-manage/pull/1337) ([RajeshPaul38](https://github.com/RajeshPaul38)) <!-- 3.3.23 -->
- Replace js-yaml with marked [#1318](https://github.com/chef/chef-manage/pull/1318) ([dheerajd-msys](https://github.com/dheerajd-msys)) <!-- 3.3.20 -->
- Update private_chef_addon to not break user setup [#1257](https://github.com/chef/chef-manage/pull/1257) ([tas50](https://github.com/tas50)) <!-- 3.3.6 -->
- Disable the feedback button in Hosted Chef [#1014](https://github.com/chef/chef-manage/pull/1014) ([tas50](https://github.com/tas50)) <!-- 3.3.0 -->
- Update the config comments with command information [#1271](https://github.com/chef/chef-manage/pull/1271) ([tas50](https://github.com/tas50)) <!-- 3.2.54 -->
- Fix variable names in expeditor scripts [#1295](https://github.com/chef/chef-manage/pull/1295) ([IanMadd](https://github.com/IanMadd)) <!-- 3.2.48 -->
- Add expeditor config for release notes [#1283](https://github.com/chef/chef-manage/pull/1283) ([IanMadd](https://github.com/IanMadd)) <!-- 3.2.44 -->

## Chef Manage 3.2.43

### Bug Fixes

This release resolves a regression in the previous 3.2.35 release, which resulted in icons not displaying in the Manage UI.

## Chef Manage 3.2.35

### Bug Fixes and Improvements

- Resolved deprecation warnings when running chef-manage-ctl reconfigure.

### Security Updates

#### Improved HTTP Headers

Added stricter HTTP headers for improved security.

#### Rails 6.1.4.3

Updated Rails to 6.1.4.3 to resolve CVE-2021-44528.

## Chef Manage 3.2.20

### Security

#### Ruby 2.7.5

Updated Ruby from 2.7.4 to 2.7.5 to resolve the following CVEs:

- CVE-2021-41817
- CVE-2021-41816
- CVE-2021-41819

## Chef Manage 3.2.13

### Bug Fixes and Improvements

- Fixed rendering of the changelog from the Manage UI.
- Refreshed many icons throughout the UI.

### Security Updates

#### Sidekiq 6.3.1

Upgraded the Sidekiq job queuing engine used in Chef Manage from 5.2.9 to 6.3.1 to resolve CVE-2021-30151.

#### Improved HTTP Headers

Chef Manage now includes `Referrer-Policy` and `Permissions-Policy` HTTP headers for improved security.

## Chef Manage 3.1.83

### Bug fixes

- Fixed 500 error while loading change log url introduced in 3.1.80

## Chef Manage 3.1.80

### Updates

The Chef Manage UI has received minor updates to branding, emails, and external URLs:

- Links lead to the latest pages
- Brand logos match Chef Infra Client / Chef Infra Server
- Community Slack replaces the link to the defunct IRC channel
- Chef Questions replaces the legacy mailing list

### Package Improvements

#### Smaller Package Size

The Chef Manage packaging is optimized, reducing both the package and the on-disk install size by half.

#### RHEL 6 Package Removal

Chef Manage packages are no longer produced for EOL RHEL 6.

#### RPM Package Digests

The file digest in Chef Infra RPM packages is updated from M5 to SHA256 to prevent installation failures on some FIPS-enabled systems.

### Security Enhancements

#### User Signup Enhancements

Users can no longer change their email during the signup process to avoid validation.

#### MTLS Support

Support MTLS in Chef Infra Server

#### E-mail Verification

User email verification is enforced for all user email address changes.

#### Ruby 2.7.4

Updated Ruby from 2.6.6 to 2.7.4 to resolve a large number of bugs as well as the following CVEs:

- CVE-2021-28966
- CVE-2021-28965
- CVE-2020-25613
- CVE-2021-31810
- CVE-2021-32066
- CVE-2021-31799

#### Rails 6.1.4.1

Updated the Rails framework used by Chef Manage from 5.2.4.4 to 6.1.4.1. This new release includes performance improvements, new capabilities, and resolves the following CVEs:

- CVE-2021-22902
- CVE-2021-22903
- CVE-2021-22885
- CVE-2021-22904

#### OpenSSL 1.0.2zb

Updated OpenSSL from 1.0.2w to 1.0.2zb to resolve issues with Let's Encrypt certificates and to resolve CVE-2021-3712.

#### cacerts

Updated the cacerts bundle to the 2021-09-30 release, which removes older expired root certificates and adds the following new root certificates:

- AC RAIZ FNMT-RCM SERVIDORES SEGUROS
- GlobalSign Root R46
- GlobalSign Root E46
- GLOBALTRUST 2020
- ANF Secure Server Root CA
- Certum EC-384 CA
- Certum Trusted Root CA

#### nokogiri 1.12.5

Update the nokogiri gem to 1.12.5 to resolve CVE-2021-41098.

#### libarchive 3.5.2

Update the libarchive library from 3.4.3 to 3.5.2 to resolve security vulnerabilities in libarchive's handling of symbolic links.

## Chef Manage 3.0.16

### Bug Fixes

- Fixed issues adding cookbook constraints to an environment.
- Fixed errors when changing a node's environment.
- Fixed incorrect cookbook versions being displayed in environments.
- Fixed a blank page being shown when refreshing the databag item page.

### Ubuntu 20.04 Support

We added Ubuntu 20.04 packages and continue to support Ubuntu 16.04 and 18.04 packages.

### Dependency Updates

- Embedded Chef Infra Client is upgraded from 14 to 15
- Sidekiq is upgraded from 4.2.10 to 5.2.9

### Security Updates

#### Ruby 2.6

We updated Chef Manage's Ruby installation from 2.5.5 to 2.6.6. This upgrade improves the performance of the application and resolves the following CVEs:

- [CVE-2012-6708](https://nvd.nist.gov/vuln/detail/CVE-2012-6708)
- [CVE-2015-9251](https://nvd.nist.gov/vuln/detail/CVE-2015-9251)
- [CVE-2019-16255](https://nvd.nist.gov/vuln/detail/CVE-2019-16255)
- [CVE-2019-16254](https://nvd.nist.gov/vuln/detail/CVE-2019-16254)
- [CVE-2019-15845](https://nvd.nist.gov/vuln/detail/CVE-2019-15845)
- [CVE-2019-16201](https://nvd.nist.gov/vuln/detail/CVE-2019-16201)
- [CVE-2020-10663](https://nvd.nist.gov/vuln/detail/CVE-2020-10663)
- [CVE-2020-10933](https://nvd.nist.gov/vuln/detail/CVE-2020-10933)

#### OpenSSL

We updated OpenSSL from 1.0.2u to 1.0.2w to resolve [CVE-2020-1968](https://nvd.nist.gov/vuln/detail/CVE-2020-1968).

#### Rack

We updated the Rack gem used in Chef Manage from 2.0.9 to 2.2.3 to resolve [CVE-2020-8184](https://nvd.nist.gov/vuln/detail/CVE-2020-8184).

#### Rails

We updated the  Rails engine used in Chef Manage from 5.2.4.2 to 5.2.4.4 to resolve [CVE-2020-15169](https://nvd.nist.gov/vuln/detail/CVE-2020-15169).

## Chef Manage 3.0.11

This release includes important dependency updates and support for SSL connections to the Chef Infra Server.

### Dependency Updates

- Rails is upgraded to 5.2.4
- Chef Infra Client is upgraded from 11 to 14
- Sidekiq is upgraded from 2.5 to 4 to improve the background processing

### SSL Support

Chef Manage 3.0 now supports SSL communication between Chef Manage and Chef Infra Server. For compatibility
with self-signed certificates which are commonly used on the Chef Infra Server, this feature defaults to off in this release.

#### Configuration

The SSL support is configured using these settings in the
`/etc/chef-manage/manager.rb` configuration file. After any changes you must run
`sudo chef-manage-ctl reconfigure` to apply the changes.

`ssl_verify_mode`: Configure SSL verification for the connection to the Chef Infra
Server. By default this is set to `:verify_none`. Setting this to `:verify_peer`
will require a Chef Manage to verify the SSL certificate of the Chef Infra Server.

`trusted_certs_dir`: Provide a path to a directory containing trusted SSL
certificates. This is empty by default, but `/etc/chef/trusted_certs` is the
most likely setting for reusing certificates installed by Chef Infra Client.

### Bug Fixes

- Generating a Knife Config now produces a `config.rb` instead of `knife.rb` file. These files have the same format and contents, but `config.rb` has been the preferred file name since Chef Infra Client 12.0.
- Minor UI bug fixes

### Supported Infra Server Versions

Chef Manage 3.0 is compatible with Chef Infra Server 12 and later. Users are always encouraged to stay up to date on Chef Infra Server releases to ensure they have the latest security updates.

#### Added Platform Support

- RHEL 7
- RHEL 8
- Ubuntu 16.04
- Ubuntu 18.04

#### Removed Platform Support

- Ubuntu 10.04
- Ubuntu 12.04
- Ubuntu 14.04

## Chef Manage 2.5.16

### Dependency Updates

- Embedded Chef Infra Client upgraded from 12.19.36 to 12.22.5

## Chef Manage 2.5.15

### Bug Fixes

- Replaced links to the legacy IRC channel with links to Chef Community Slack.
- Allow uppercase letters to be used in data bag names.
- Hide the reporting tab when Chef Reporting isn't installed on the system.

### Security Updates

- Added Strict-Transport-Security headers to all pages.
- Sanitized HTML errors in JSON error output to prevent possible reflected XSS in the case of script tags being passed in as part of the URL of a JSON request.
