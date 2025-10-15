+++
title = "Add a Chef license key"
draft = false
gh_repo = "chef-web-docs"

[menu]
  [menu.overview]
    title = "Add license key"
    identifier = "overview/licensing/Add License"
    parent = "overview/licensing"
    weight = 30
+++

To use Chef products that require a license, you need to add your license key.
You can find your license key in the [customer support portal](https://community.progress.com/s/products-list).

## Products that require a Chef license key

You need a Chef license key to run the following products:

- Chef InSpec 6

You might need a Chef license key for the following products, depending on the distribution:

- Chef InSpec 7

For these products, you need a license depending on how you install it:

- Official distributions, such as the Chef Habitat package for InSpec 7, don't require a license key.
- Undistributed packages, such as the `inspec` gem, require a license key.

## Add a license key

Chef products accept a license key through an environment variable or a command line argument.
Chef stores license data locally in a configuration file at `$HOME/.chef/licenses.yaml`.

### Use a command line option

To add a license key, use the `--chef-license-key` command line option:

```sh
<CHEF_PRODUCT_COMMAND> --chef-license-key <LICENSE_KEY>
```

### Use an environment variable

To add a license key, set the `CHEF_LICENSE_KEY` environment variable:

```sh
export CHEF_LICENSE_KEY=<LICENSE_KEY>
<CHEF_PRODUCT_COMMAND>
```
