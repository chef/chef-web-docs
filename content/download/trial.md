+++
title = "Trial Download"
draft = true
gh_repo = "chef-web-docs"

[menu]
  [menu.overview]
    title = "Trial"
    identifier = "overview/packages_&_platforms/download/Trial"
    parent = "overview/packages_&_platforms/download"
    weight = 30
+++

Trial users can use Chef's Trial Downloads API to download Chef software packages.

## License

You are not required to get a license to use the Trial API to download products.
However, you are limited to latest versions of Chef products if you don't have a license.
[Contact Chef](https://www.chef.io/contact-us) if you'd like to request a trial license.

See [Chef's licensing documentation]({{< relref "chef_license" >}}) for more information on the Chef license.

## Endpoints

The Chef Commercial Download API has the following endpoints:

- `/architectures`
- `/platforms`
- `/products`
- `/packages`
- `/versions/all`
- `/versions/latest`
- `/metadata`
- `/download`

See the [parameters section](#parameters) below to understand the query strings used in the following endpoint descriptions.

### architectures

The `architectures` endpoint returns a valid list of architecture that Chef products are built for.
Any of these architectures can be used in the `m` [query string](#parameters) value in various endpoints below.

```plain
https://chefdownload-trial.chef.io/architectures
```

### platforms

The `platforms` endpoint returns a list of valid platform keys along with full friendly names. Any of these platform keys can be used in the `p` [query string](#parameters) value in various endpoints below.

```plain
https://chefdownload-trial.chef.io/platforms
```

### products

The `products` endpoint returns a list of valid product keys. In the following endpoints, you can replace the `<PRODUCT>` string with a product key in the response of this endpoint.

```plain
https://chefdownload-trial.chef.io/products
```

Use `eol=true` to return EOL products.

```plain
https://chefdownload-trial.chef.io/products?eol=true
```

### packages

Use `packages` to get a full list of all packages for a particular release channel and product.

By default, it returns packages for the latest version.

```plain
https://chefdownload-trial.chef.io/stable/<PRODUCT>/packages
```

You can specify a version number with the `v` query string to get packages for a particular product version.

```plain
https://chefdownload-trial.chef.io/stable/<PRODUCT>/packages?v=<VERSION_NUMBER>
```

### versions/all

Use `versions/all` to return a list of versions of a product from a particular release channel.

```plain
https://chefdownload-trial.chef.io/stable/<PRODUCT>/versions/all
```

### versions/latest

Use `versions/latest` to return the latest version of a product from a particular release channel.

```plain
https://chefdownload-trial.chef.io/stable/<PRODUCT>/versions/latest
```

### metadata

The `metadata` endpoint returns data about a particular package of a Chef product. By default it returns the latest version.

```plain
https://chefdownload-trial.chef.io/stable/<PRODUCT>/metadata?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>
```

To get data about a version of a package other than the latest, you must use a license ID.

```plain
https://chefdownload-trial.chef.io/stable/<PRODUCT>/metadata?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>&v=<VERSION>&license_id=<LICENSE_ID>
```

### download

The `download` endpoint downloads a particular package of a Chef product. By default it downloads the latest version.

```plain
https://chefdownload-trial.chef.io/stable/<PRODUCT>/download?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>
```

To get download a version of a package other than the latest, you must use a license ID.

```plain
https://chefdownload-trial.chef.io/stable/<PRODUCT>/download?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>&v=<VERSION>&license_id=<LICENSE_ID>
```

## Parameters

The API accepts the following parameters in a query string.

`<PRODUCT>`
: The Chef Software product to install.

  A list of valid product keys can be found in the [Chef product matrix](https://github.com/chef/mixlib-install/blob/main/PRODUCT_MATRIX.md) or by using the [`products`](#products) endpoint.

`eol`
: Whether to include EOL products or EOL versions of a product in the response.

  Possible values: `true` or `false`.

  Default value: `false`.

`p`
: The platform.

  Possible values: `debian`, `el` (for RHEL derivatives), `freebsd`, `mac_os_x`, `solaris2`, `sles`, `suse`, `ubuntu` or `windows`.

`pv`
: The platform version.

  Possible values depend on the platform. For example, Ubuntu: `18.04`, or `20.04`, or for macOS: `10.15` or `11`.

`m`
: The machine architecture for the machine on which the product will be installed.

  Possible values depend on the platform. For example, for Ubuntu or Debian: `i386` or `x86_64`, or for macOS: `x86_64`.

`v`
: The version of the product to be installed.

  Versions typically take the form of `x.y.z` where x, y, and z are decimal numbers that are used to represent major (x), minor (y), and patch (z) versions.
  One-part (x) and two-part (x.y) versions are allowed.

  Default value: `latest`.

## Chef product names

See the [Supported Versions]({{< relref "versions" >}}) documentation for information about the support status of individual products.

This is a list of currently supported products that you can install with this API.

| Product | Product Key  |
| ------- | ------------ |
| Chef Infra Client | chef |
| Chef Backend | chef-backend |
| Chef Infra Server | chef-server |
| Chef Workstation | chef-workstation |
| Chef InSpec | inspec |
| Chef Manage | manage |
| Supermarket | supermarket |

## Examples

### Get the latest build

To get the latest supported build of Chef Infra Client for Ubuntu 20.04, enter the following:

```plain
https://chefdownload-trial.chef.io/stable/chef/metadata?p=ubuntu&pv=20.04&m=x86_64
```

which will return something like:

```json
sha1	"8e8ae315d4695f9c95efc0a1437d2d453f7ab116"
sha256	"86f14ae08237b4e24201436ecb83c08c29b68aed1d6ede0953a1b4547a920e36"
url	"https://chefdownload-trial.chef.io/stable/chef/download?license_id=&m=x86_64&p=ubuntu&pv=20.04"
version	"18.2.7"
```

### Get an earlier build

You must use a license ID to get metadata about a package for an earlier release.

```plain
https://chefdownload-trial.chef.io/stable/chef/metadata?p=ubuntu&pv=20.04&m=x86_64&v=18.1.0&license_id=<LICENSE_ID>
```

which will return something like:

```json
sha1	"f45a7ee73a346deba2a52fd7b03b4a0e80f24762"
sha256	"56856c196c5b38ed918bc7c489652896cf30fab9bbcc8def14b9576e59e681f4"
url	"https://chefdownload-trial.chef.io/stable/chef/download?license_id=<LICENSE_ID>&m=x86_64&p=ubuntu&pv=20.04&v=18.1.0"
version	"18.1.0"
```

### Download directly

To use cURL to download a package directly, enter the following:

```bash
curl -LOJ 'https://chefdownload-trial.chef.io/stable/<PRODUCT>/download?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>'
```

To use GNU Wget to download a package directly, enter the following:

```bash
wget --content-disposition https://chefdownload-trial.chef.io/stable/<PRODUCT>/download?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>
```
