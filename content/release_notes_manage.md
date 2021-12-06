+++
title = "Release Notes: Chef Manage 3.0"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/release_notes_manage.html"]
product = []

[menu]
  [menu.release_notes]
    title = "Chef Manage"
    identifier = "release_notes/release_notes_manage.md Chef Manage"
    parent = "release_notes"
    weight = 50
+++

Chef Manage provides a web-based user interface that manages Chef Infra nodes and other policy objects, such as data bags and roles, on the instance of Chef Infra Server that it is installed on.

Chef Manage is [deprecated](/versions/#deprecated) and users should plan to migrate to [Chef Automate](/automate/) as the replacement.

## Upgrading

Download the latest version of the chef-manage package for your platform from [downloads.chef.io](https://downloads.chef.io/manage) to your Chef Infra Server, then run:

```bash
# rpm -Uvh /path/to/chef-manage-*.rpm
or
# dpkg -i /path/to/chef-manage-*.deb

then
# chef-manage-ctl reconfigure
# chef-server-ctl reconfigure
```

## What's New in 3.0.16

### Bug Fixes

* Fixed issues adding cookbook constraints to an environment.
* Fixed errors when changing a node's environment.
* Fixed incorrect cookbook versions being displayed in environments.
* Fixed a blank page being shown when refreshing the databag item page.

### Ubuntu 20.04 Support

We added Ubuntu 20.04 packages and continue to support Ubuntu 16.04 and 18.04 packages.

### Dependency Updates

* Embedded Chef Infra Client is upgraded from 14 to 15
* Sidekiq is upgraded from 4.2.10 to 5.2.9

### Security Updates

#### Ruby 2.6

We updated Chef Manage's Ruby installation from 2.5.5 to 2.6.6. This upgrade improves the performance of the application and resolves the following CVEs:

* [CVE-2012-6708](https://nvd.nist.gov/vuln/detail/CVE-2012-6708)
* [CVE-2015-9251](https://nvd.nist.gov/vuln/detail/CVE-2015-9251)
* [CVE-2019-16255](https://nvd.nist.gov/vuln/detail/CVE-2019-16255)
* [CVE-2019-16254](https://nvd.nist.gov/vuln/detail/CVE-2019-16254)
* [CVE-2019-15845](https://nvd.nist.gov/vuln/detail/CVE-2019-15845)
* [CVE-2019-16201](https://nvd.nist.gov/vuln/detail/CVE-2019-16201)
* [CVE-2020-10663](https://nvd.nist.gov/vuln/detail/CVE-2020-10663)
* [CVE-2020-10933](https://nvd.nist.gov/vuln/detail/CVE-2020-10933)

#### OpenSSL

We updated OpenSSL from 1.0.2u to 1.0.2w to resolve [CVE-2020-1968](https://nvd.nist.gov/vuln/detail/CVE-2020-1968).

#### Rack

We updated the Rack gem used in Chef Manage from 2.0.9 to 2.2.3 to resolve [CVE-2020-8184](https://nvd.nist.gov/vuln/detail/CVE-2020-8184).

#### Rails

We updated the  Rails engine used in Chef Manage from 5.2.4.2 to 5.2.4.4 to resolve [CVE-2020-15169](https://nvd.nist.gov/vuln/detail/CVE-2020-15169).

## What's New in 3.0.11

This release includes important dependency updates and support for SSL connections to the Chef Infra Server.

### Dependency Updates

* Rails is upgraded to 5.2.4
* Chef Infra Client is upgraded from 11 to 14
* Sidekiq is upgraded from 2.5 to 4 to improve the background processing

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

* Generating a Knife Config now produces a `config.rb` instead of `knife.rb` file. These files have the same format and contents but `config.rb` has been preferred file name since Chef Infra Client 12.0.
* Minor UI bug fixes

### Supported Infra Server Versions

Chef Manage 3.0 is compatible with Chef Infra Server 12 and later. Users are always encouraged to stay up to date on Chef Infra Server releases to ensure they have the latest security updates.

#### Added Platform Support

* RHEL 7
* RHEL 8
* Ubuntu 16.04
* Ubuntu 18.04

#### Removed Platform Support

* Ubuntu 10.04
* Ubuntu 12.04
* Ubuntu 14.04

## What's New in 2.5.16

### Dependency Updates

* Embedded Chef Infra Client upgraded from 12.19.36 to 12.22.5

## What's New in 2.5.15

### Bug Fixes

* Replaced links to the legacy IRC channel with links to Chef Community Slack.
* Allow uppercase letters to be used in data bag names.
* Hide the reporting tab when Chef Reporting is not installed on the system.

### Security Updates

* Added Strict-Transport-Security headers to all pages.
* Sanitized HTML errors in JSON error output to prevent possible reflected XSS in the case of script tags being passed in as part of the URL of a JSON request.
