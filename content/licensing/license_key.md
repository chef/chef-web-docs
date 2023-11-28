+++
title = "Add a Chef License Key"
draft = false
gh_repo = "chef-web-docs"

[menu]
  [menu.overview]
    title = "Add License Key"
    identifier = "overview/licensing/Add License"
    parent = "overview/licensing"
    weight = 30
+++

This page describes how to add a license key to a Chef product.

You can find your license key on the [customer support portal](https://community.progress.com/s/products-list).

## Products

The following products require a Chef License key to run:

- [Chef InSpec 6 or greater](/inspec/license/)

## Add license key

Chef products accept a license key with either an environment variable or as a command line argument.

License data is stored locally in a configuration file at `$HOME/.chef/licenses.yaml`.

### Command line option

Use the `--chef-license-key` command line option to add a license key.

```sh
<CHEF_PRODUCT_COMMAND> --chef-license-key <LICENSE_KEY>
```

### Environment variable

Use the `CHEF_LICENSE_KEY` environment variable to add a license.

```sh
export CHEF_LICENSE_KEY=<LICENSE_KEY>
<CHEF_PRODUCT_COMMAND>
```
