+++
title = "knife ssl check"
description = "DESCRIPTION"
draft = false

aliases = "/knife_ssl_check.html"

[menu]
  [menu.docs]
    title = "knife ssl_check"
    identifier = "knife ssl_check/knife_ssl_check.html"
    parent = "chefdk/knife"
    weight = 270
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/knife_ssl_check.rst)

{{% knife_ssl_check_summary %}}

Syntax
======

This subcommand has the following syntax:

``` bash
$ knife ssl check (options)
```

Options
=======

This subcommand has the following options:

`URL_or_URI`

:   The URL or URI for the location at which the SSL certificate is
    located. Default value: the URL for the Chef Infra Server, as
    defined in the config.rb file.

Examples
========

The following examples show how to use this knife subcommand:

**SSL certificate has valid X.509 properties**

{{% knife_ssl_check_verify_server_config %}}

**SSL certificate has invalid X.509 properties**

{{% knife_ssl_check_bad_ssl_certificate %}}

**Verify the SSL configuration for Chef Infra Client**

The SSL certificates that are used by Chef Infra Client may be verified
by specifying the path to the client.rb file. Use the `--config` option
(that is available to any knife command) to specify this path:

``` bash
$ knife ssl check --config /etc/chef/client.rb
```

**Verify an external server's SSL certificate**

``` bash
$ knife ssl check URL_or_URI
```

for example:

``` bash
$ knife ssl check https://www.chef.io
```
