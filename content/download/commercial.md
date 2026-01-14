+++
title = "Commercial API"
gh_repo = "chef-web-docs"

[menu]
  [menu.overview]
    title = "Commercial API"
    identifier = "overview/packages_&_platforms/download/Commercial"
    parent = "overview/packages_&_platforms/download"
    weight = 20
+++

Commercial customers can use Chef's Commercial API to download Chef software packages and view software package metadata.

## Install script

You can use an install script from the API to download and install Chef packages. For more information, see the [Chef install script documentation](/chef_install_script/).

## License

To download packages and review metadata with this API, you need a license ID.

You can get your license ID from the [Chef Downloads portal](https://chef.io/downloads), or [contact Chef](https://www.chef.io/contact-us) if you don't have one.

For more information, see [Chef's licensing documentation]({{< relref "licensing" >}}).

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
- `/fileName`
- `/package-managers`

For details about query strings, see the [parameters section](#parameters).

### architectures

The `architectures` endpoint returns a list of valid architectures for Chef products. You can use any of these architectures as the `m` [query string](#parameters) value in the endpoints below.

```plain
https://chefdownload-commercial.chef.io/architectures
```

### platforms

The `platforms` endpoint returns a list of valid platform keys and friendly names. You can use any of these platform keys as the `p` [query string](#parameters) value in the endpoints below.

```plain
https://chefdownload-commercial.chef.io/platforms
```

### products

The `products` endpoint returns a list of valid product keys. In the endpoints below, replace `<PRODUCT>` with a product key from this response.

```plain
https://chefdownload-commercial.chef.io/products
```

To include EOL products, use `eol=true`:

```plain
https://chefdownload-commercial.chef.io/products?eol=true
```

### packages

Use the `packages` endpoint to get a full list of packages for a particular release channel and product.

By default, this endpoint returns packages for the latest version.

```plain
https://chefdownload-commercial.chef.io/<CHANNEL>/<PRODUCT>/packages?license_id=<LICENSE_ID>
```

To get packages for a specific product version, use the `v` query string:

```plain
https://chefdownload-commercial.chef.io/<CHANNEL>/<PRODUCT>/packages?v=<VERSION_NUMBER>&license_id=<LICENSE_ID>
```

### versions/all

Use `versions/all` to return a list of versions of a product from a particular release channel.

```plain
https://chefdownload-commercial.chef.io/<CHANNEL>/<PRODUCT>/versions/all?license_id=<LICENSE_ID>
```

### versions/latest

Use `versions/latest` to return the latest version of a product from a particular release channel.

```plain
https://chefdownload-commercial.chef.io/<CHANNEL>/<PRODUCT>/versions/latest?license_id=<LICENSE_ID>
```

### metadata

The `metadata` endpoint returns data about a particular package of a Chef product.

```plain
https://chefdownload-commercial.chef.io/<CHANNEL>/<PRODUCT>/metadata?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>&v=<PRODUCT_VERSION>&license_id=<LICENSE_ID>
```

For products such as Chef Infra Client Enterprise or Chef Infra Client Legacy Migration, the pm (package manager) query parameter must be explicitly provided in the request. This value determines the type of package to retrieve (for example: deb, rpm, msi, or tar) and is required because these products support multiple packaging formats.

```plain
https://chefdownload-commercial.chef.io/<CHANNEL>/<PRODUCT>/metadata?p=<PLATFORM>&pm=<PACKAGE_MANAGER>&m=<ARCHITECTURE>&v=<PRODUCT_VERSION>&license_id=<LICENSE_ID>
```

### download

The `download` endpoint downloads a particular package of a Chef product.

```plain
https://chefdownload-commercial.chef.io/<CHANNEL>/<PRODUCT>/download?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>&v=<PRODUCT_VERSION>&license_id=<LICENSE_ID>
```

For Chef Infra Client Enterprise or Chef Infra Client Legacy Migration, you must include the `pm` (package manager) query parameter in your request.
This parameter specifies the package format to download---for example, `deb`, `rpm`, `msi`, or `tar`.

```plain
https://chefdownload-commercial.chef.io/<CHANNEL>/<PRODUCT>/download?p=<PLATFORM>&pm=<PACKAGE_MANAGER>&m=<ARCHITECTURE>&v=<PRODUCT_VERSION>&license_id=<LICENSE_ID>
```

### fileName

The `fileName` endpoint returns the file name.

```plain
https://chefdownload-commercial.chef.io/<CHANNEL>/<PRODUCT>/fileName?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>&v=<PRODUCT_VERSION>&license_id=<LICENSE_ID>
```

For Chef Infra Client Enterprise or Chef Infra Client Legacy Migration, you must include the `pm` (package manager) query parameter in your request.
This parameter specifies the package format---for example, `deb`, `rpm`, `msi`, or `tar`.

```plain
https://chefdownload-commercial.chef.io/<CHANNEL>/<PRODUCT>/fileName?p=<PLATFORM>&pm=<PACKAGE_MANAGER>&m=<ARCHITECTURE>&v=<PRODUCT_VERSION>&license_id=<LICENSE_ID>
```

### package-managers

The `package-managers` endpoint lists the available package managers.

```plain
https://chefdownload-commercial.chef.io/package-managers
```

## Parameters

The API accepts the following parameters in a query string.

`<CHANNEL>`
: The release channel to install from. For the available channels, see [release channels](#release-channels).

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

  Versions typically take the form of `x.y.z` where x, y, and z are decimal numbers that represent major (x), minor (y), and patch (z) versions.
  One-part (`x`) and two-part (`x.y`) versions are allowed.

  Default value: `latest`.

`pm`
: The package manager.

  Use this parameter only for Chef Infra Client Enterprise and Chef Infra Client Legacy Migration products.

  Possible values:

  - `deb` for Debian-based systems, for example, Ubuntu
  - `rpm` for Red Hat-based systems, for example, CentOS or Fedora
  - `tar` for generic Unix-like systems
  - `msi` for Windows systems

## Chef product names

Use the following product keys to download packages or retrieve data for different Chef products.
You can also use the [products endpoint](#products)

| Product                            | Product key        |
| ---------------------------------- | ------------------ |
| Chef Automate                      | `automate`         |
| Chef Infra Client                  | `chef`             |
| Chef Backend                       | `chef-backend`     |
| Chef Infra Server                  | `chef-server`      |
| Chef Workstation                   | `chef-workstation` |
| Chef Habitat                       | `habitat`          |
| Chef InSpec                        | `inspec`           |
| Management Console                 | `manage`           |
| Supermarket                        | `supermarket`      |
| Chef Infra Client Enterprise       | `chef-ice`         |
| Chef Infra Client Legacy Migration | `migrate-ice`      |

See the [supported versions]({{< relref "versions" >}}) documentation for information about the support status of individual products.

### Release channels

{{< readfile file="content/reusable/md/release_channels.md" >}}

## Examples

### Get the latest build

To get the latest supported build of Chef Infra Client for Ubuntu 20.04, enter the following:

```sh
https://chefdownload-commercial.chef.io/stable/chef/metadata?p=ubuntu&pv=20.04&m=x86_64&license_id=<LICENSE_ID>
```

which returns something like:

```json
sha1	"8e8ae315d4695f9c95efc0a1437d2d453f7ab116"
sha256	"86f14ae08237b4e24201436ecb83c08c29b68aed1d6ede0953a1b4547a920e36"
url	"https://chefdownload-commercial.chef.io/stable/chef/download?license_id=<LICENSE_ID>&m=x86_64&p=ubuntu&pv=20.04"
version	"18.2.7"
```

To get the latest supported build of Chef Infra Client Enterprise for Linux 18.04, enter the following:

```sh
https://chefdownload-commercial.chef.io/stable/chef-ice/metadata?pv=18.04&m=x86_64&p=linux&pm=deb&license_id=<LICENSE_ID>
```

which returns something like:

```json
sha1	"dcf75b37bb80128af4657501bfd41eac52820191"
sha256	"2c501d02b16d67e9d5a28578b95f8d3155bed940ee4946229213f41a2e8b798e"
url	"https://chefdownload-commercial.chef.io/stable/chef-ice/download?license_id=<LICENSE_ID>&eol=false&m=x86_64&p=linux&pm=deb&v=19.1.8"
version	"19.1.8"
```

### Download directly

To use curl to download a package directly of Chef Products, enter the following:

```bash
curl -LOJ 'https://chefdownload-commercial.chef.io/<CHANNEL>/<PRODUCT>/download?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>&license_id=<LICENSE_ID>'
```

To use curl to download a package directly of Chef Infra Client Enterprise or Chef Infra Client Legacy Migration, enter the following:

```bash
curl -LOJ 'https://chefdownload-commercial.chef.io/<CHANNEL>/<PRODUCT>/download?p=<PLATFORM>&pm=<PACKAGE_MANAGER>&m=<ARCHITECTURE>&license_id=<LICENSE_ID>'
```

To use GNU Wget to download a package directly of Chef Products, enter the following:

```bash
wget --content-disposition https://chefdownload-commercial.chef.io/<CHANNEL>/<PRODUCT>/download?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>&license_id=<LICENSE_ID>
```

To use GNU Wget to download a package directly of Chef Infra Client Enterprise or Chef Infra Client Legacy Migration, enter the following:

```bash
wget --content-disposition https://chefdownload-commercial.chef.io/<CHANNEL>/<PRODUCT>/download?p=<PLATFORM>&pm=<PACKAGE_MANAGER>&m=<ARCHITECTURE>&license_id=<LICENSE_ID>
```
