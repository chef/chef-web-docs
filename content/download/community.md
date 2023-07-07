+++
title = "Community Download"
draft = false
gh_repo = "chef-web-docs"

[menu]
  [menu.overview]
    title = "Community"
    identifier = "overview/packages_&_platforms/download/Community"
    parent = "overview/packages_&_platforms/download"
    weight = 40
+++

Chef community members can use Chef's Community Downloads API to download Chef software packages.

## License

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
https://chefdownload-community.chef.io/architectures
```

### platforms

The `platforms` endpoint returns a list of valid platform keys along with full friendly names. Any of these platform keys can be used in the `p` [query string](#parameters) value in various endpoints below.

```plain
https://chefdownload-community.chef.io/platforms
```

### products

The `products` endpoint returns a list of valid product keys. In the following endpoints, you can replace the `<PRODUCT>` string with a product key in the response of this endpoint.

```plain
https://chefdownload-community.chef.io/products
```

Use `eol=true` to return EOL products.

```plain
https://chefdownload-community.chef.io/products?eol=true
```

### packages

Use `packages` to get a full list of all packages for a particular release channel and product.

By default, it returns packages for the latest version.

```plain
https://chefdownload-community.chef.io/stable/<PRODUCT>/packages
```

You can specify a version number with the `v` query string to get packages for a particular product version.

```plain
https://chefdownload-community.chef.io/stable/<PRODUCT>/packages?v=<VERSION_NUMBER>
```

### versions/all

Use `versions/all` to return a list of versions of a product from a particular release channel.

```plain
https://chefdownload-community.chef.io/stable/<PRODUCT>/versions/all
```

### versions/latest

Use `versions/latest` to return the latest version of a product from a particular release channel.

```plain
https://chefdownload-community.chef.io/stable/<PRODUCT>/versions/latest
```

### metadata

The `metadata` endpoint returns data about a particular package of a Chef product.

```plain
https://chefdownload-community.chef.io/stable/<PRODUCT>/metadata?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>&v=<PRODUCT_VERSION>
```

### download

The `download` endpoint downloads a particular package of a Chef product.

```plain
https://chefdownload-community.chef.io/stable/<PRODUCT>/download?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>&v=<PRODUCT_VERSION>
```

## Parameters

The API accepts the following parameters in a query string.

`<PRODUCT>`
: The Chef Software product to install.

  A list of valid product keys can be found in the [Chef product matrix](https://github.com/chef/mixlib-install/blob/main/PRODUCT_MATRIX.md) or by using the [`products`](#products) endpoint.

`eol`
: Whether to include EOL versions of a product or EOL products in the response.

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

  Possible values depend on the platform. For example, for
  Ubuntu or Debian: `i386` or `x86_64`, or for macOS: `x86_64`.

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
| Chef Infra Server | chef-server |
| Chef Workstation | chef-workstation |
| Chef InSpec | inspec |
| Supermarket | supermarket |

## Examples

### Get the latest build

To get the latest supported build of Chef Infra Client for Ubuntu 20.04, enter the following:

```plain
https://chefdownload-community.chef.io/stable/chef/metadata?p=ubuntu&pv=20.04&m=x86_64
```

which will return something like:

```json
sha1	"3c8a265a36c2ce7e5594ae894fafb248789464a2"
sha256	"512c1eff0a4103e4a5c73b196d14393eddbf2b766a75e94ac9a9cb97d1fdd19c"
url	"https://chefdownload-community.chef.io/stable/chef/download?eol=false&m=x86_64&p=ubuntu&pv=20.04&v=14.15.6"
version	"14.15.6"
```

### Download directly

To use cURL to download a package directly, enter the following:

```bash
curl -LOJ 'https://chefdownload-community.chef.io/stable/<PRODUCT>/download?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>'
```

To use GNU Wget to download a package directly, enter the following:

```bash
wget --content-disposition https://chefdownload-community.chef.io/stable/<PRODUCT>/download?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>
```
