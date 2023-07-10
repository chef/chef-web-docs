+++
title = "Commercial API"
draft = true
gh_repo = "chef-web-docs"

[menu]
  [menu.overview]
    title = "Commercial API"
    identifier = "overview/packages_&_platforms/download/Commercial"
    parent = "overview/packages_&_platforms/download"
    weight = 20
+++

Commercial customers can use Chef's Commercial API to download Chef software packages and view software package metadata.

## License

You must use a license to download packages and review metadata with this API.
If you don't already have one, [contact Chef](https://www.chef.io/contact-us) to get a license.

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
https://chefdownload-commerical.chef.io/architectures
```

### platforms

The `platforms` endpoint returns a list of valid platform keys along with full friendly names. Any of these platform keys can be used in the `p` [query string](#parameters) value in various endpoints below.

```plain
https://chefdownload-commerical.chef.io/platforms
```

### products

The `products` endpoint returns a list of valid product keys. In the following endpoints, you can replace the `<PRODUCT>` string with a product key in the response of this endpoint.

```plain
https://chefdownload-commerical.chef.io/products
```

Use `eol=true` to return EOL products.

```plain
https://chefdownload-commerical.chef.io/products?eol=true
```

### packages

Use `packages` to get a full list of all packages for a particular release channel and product.

By default, it returns packages for the latest version.

```plain
https://chefdownload-commerical.chef.io/<CHANNEL>/<PRODUCT>/packages?license_id=<LICENSE_ID>
```

You can specify a version number with the `v` query string to get packages for a particular product version.

```plain
https://chefdownload-commerical.chef.io/<CHANNEL>/<PRODUCT>/packages?v=<VERSION_NUMBER>&license_id=<LICENSE_ID>
```

### versions/all

Use `versions/all` to return a list of versions of a product from a particular release channel.

```plain
https://chefdownload-commerical.chef.io/<CHANNEL>/<PRODUCT>/versions/all?license_id=<LICENSE_ID>
```

### versions/latest

Use `versions/latest` to return the latest version of a product from a particular release channel.

```plain
https://chefdownload-commerical.chef.io/<CHANNEL>/<PRODUCT>/versions/latest?license_id=<LICENSE_ID>
```

### metadata

The `metadata` endpoint returns data about a particular package of a Chef product.

```plain
https://chefdownload-commerical.chef.io/<CHANNEL>/<PRODUCT>/metadata?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>&v=<PRODUCT_VERSION>&license_id=<LICENSE_ID>
```

### download

The `download` endpoint downloads a particular package of a Chef product.

```plain
https://chefdownload-commerical.chef.io/<CHANNEL>/<PRODUCT>/download?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>&v=<PRODUCT_VERSION>&license_id=<LICENSE_ID>
```

## Parameters

The API accepts the following parameters in a query string.

`<CHANNEL>`
: The release channel to install from. See [Chef Software Packages](/packages/) for full details on the available channels.

`<PRODUCT>`
: The Chef Software product to install.

  A list of valid product keys can be found in the [Chef product matrix](https://github.com/chef/mixlib-install/blob/main/PRODUCT_MATRIX.md) or by using the [`products`](#products) endpoint.

`license_id`
: Your license ID.

  A license is required to download packages and retrieve package metadata with this API.

`eol`
: Whether to include EOL versions of a product or EOL products in the response.

  Possible values: `true` or `false`.

  Default value: `false`.

`p`
: The platform.

  Possible values: `debian`, `el` (for RHEL derivatives), `freebsd`, `mac_os_x`, `solaris2`, `sles`, `suse`, `ubuntu` or
  `windows`.

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
  One-part (`x`) and two-part (`x.y`) versions are allowed.

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
| Management Console | manage |
| Supermarket | supermarket |

## Examples

### Get the latest build

To get the latest supported build of Chef Infra Client for Ubuntu 20.04, enter the following:

```plain
https://chefdownload-commerical.chef.io/stable/chef/metadata?p=ubuntu&pv=20.04&m=x86_64&license_id=<LICENSE_ID>
```

which will return something like:

```json
sha1	"8e8ae315d4695f9c95efc0a1437d2d453f7ab116"
sha256	"86f14ae08237b4e24201436ecb83c08c29b68aed1d6ede0953a1b4547a920e36"
url	"https://chefdownload-commerical.chef.io/stable/chef/download?license_id=<LICENSE_ID>&m=x86_64&p=ubuntu&pv=20.04"
version	"18.2.7"
```

### Download directly

To use cURL to download a package directly, enter the following:

```bash
curl -LOJ 'https://chefdownload-commerical.chef.io/<CHANNEL>/<PRODUCT>/download?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>&license_id=<LICENSE_ID>'
```

To use GNU Wget to download a package directly, enter the following:

```bash
wget --content-disposition https://chefdownload-commerical.chef.io/<CHANNEL>/<PRODUCT>/download?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>&license_id=<LICENSE_ID>
```
