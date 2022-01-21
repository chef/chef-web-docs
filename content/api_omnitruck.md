+++
title = "Omnitruck API"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/api_omnitruck.html"]
product = ["automate", "client", "server", "habitat", "inspec", "workstation"]

[menu]
  [menu.overview]
    title = "Omnitruck API"
    identifier = "overview/packages_&_platforms/api_omnitruck.md Omnitruck API"
    parent = "overview/packages_&_platforms"
    weight = 50
+++

Chef's Omnitruck API powers the Chef Software install script as well as
[Chef's download](https://www.chef.io/downloads) site. It can be used to query available versions of
Chef Software products and to provide direct download URLs.

## Syntax

The URL from which these downloads can be obtained has the following syntax:

```none
https://omnitruck.chef.io/<CHANNEL>/<PRODUCT>/download?p=$PLATFORM&pv=$PLATFORM_VERSION&m=$MACHINE_ARCH&v=latest&prerelease=false&nightlies=false
```

or:

```none
https://omnitruck.chef.io/<CHANNEL>/<PRODUCT>/metadata?p=$PLATFORM&pv=$PLATFORM_VERSION&m=$MACHINE_ARCH&v=latest&prerelease=false&nightlies=false
```

where the difference between these URLs is the `metadata` and `download`
options. Use the `metadata` option to verify the build before
downloading it. Use the `download` option to download the package in a
single step.

## Downloads

The `/metadata` and/or `/download` endpoints can be used to download packages for all products:

```none
https://omnitruck.chef.io/<CHANNEL>/<PRODUCT>/download?p=$PLATFORM&pv=$PLATFORM_VERSION&m=$MACHINE_ARCH&v=latest
```

or:

```none
https://omnitruck.chef.io/<CHANNEL>/<PRODUCT>/metadata?p=$PLATFORM&pv=$PLATFORM_VERSION&m=$MACHINE_ARCH&v=latest
```

where:

- `<CHANNEL>` is the release channel to install from. See [Chef Software Packages](/packages/) for full details on the available channels.
- `<PRODUCT>` is the Chef Software product to install. A list of valid product keys can be found at <https://github.com/chef/mixlib-install/blob/main/PRODUCT_MATRIX.md>
- `p` is the platform. Possible values: `debian`, `el` (for RHEL derivatives), `freebsd`, `mac_os_x`, `solaris2`, `sles`, `suse`, `ubuntu` or `windows`.
- `pv` is the platform version. Possible values depend on the platform. For example, Ubuntu: `18.04`, or `20.04` or for macOS: `10.15` or `11`.
- `m` is the machine architecture for the machine on which the product will be installed. Possible values depend on the platform. For example, for Ubuntu or Debian: `i386` or `x86_64` or for macOS: `x86_64`.
- `v` is the version of the product to be installed. A version always takes the form x.y.z, where x, y, and z are decimal numbers that are used to represent major (x), minor (y), and patch (z) versions. One-part (x) and two-part (x.y) versions are allowed. For more information about application versioning, see <https://semver.org/>. Default value: `latest`.

### Platforms

Omnitruck accepts the following platforms:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 12%" />
<col style="width: 23%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr class="header">
<th>Platform</th>
<th>p</th>
<th>m</th>
<th>pv</th>
</tr>
</thead>
<tbody>
<tr>
<td>AIX</td>
<td><code>aix</code></td>
<td><code>powerpc</code></td>
<td><code>6.1</code>, <code>7.1</code>, <code>7.2</code></td>
</tr>
<tr>
<td>Amazon Linux</td>
<td><code>amazon</code></td>
<td><code>x86_64</code>,<code>aarch64</code></td>
<td><code>201X, 2</code></td>
</tr>
<tr>
<td>Debian</td>
<td><code>debian</code></td>
<td><code>i386</code>, <code>x86_64</code>, <code>aarch64</code></td>
<td><code>6</code>, <code>7</code>, <code>8</code>, <code>9</code>, <code>10</code>, <code>11</code></td>
</tr>
<tr>
<td>FreeBSD</td>
<td><code>freebsd</code></td>
<td><code>x86_64</code></td>
<td><code>9</code>, <code>10</code>, <code>11</code>, <code>12</code></td>
</tr>
<tr>
<td>macOS</td>
<td><code>mac_os_x</code></td>
<td><code>x86_64</code>, <code>aarch64</code></td>
<td><code>10.6</code>, <code>10.7</code>, <code>10.8</code>, <code>10.9</code>, <code>10.10</code>, <code>10.11</code>, <code>10.12</code>, <code>10.13</code>, <code>10.14</code>, <code>10.15</code>, <code>11</code>, <code>12</code></td>
</tr>
<tr>
<td>Solaris</td>
<td><code>solaris2</code></td>
<td><code>i386</code>, <code>sparc</code></td>
<td><code>5.10</code>, <code>5.11</code></td>
</tr>
<tr>
<td>SUSE Linux Enterprise Server</td>
<td><code>sles</code></td>
<td><code>x86_64</code>, <code>s390x</code>, <code>aarch64</code></td>
<td><code>11</code>, <code>12</code>, <code>15</code></td>
</tr>
<tr>
<td>Red Hat Enterprise Linux / CentOS / Oracle Linux</td>
<td><code>el</code></td>
<td><code>i386</code>, <code>x86_64</code>, <code>ppc64</code>, <code>ppc64le</code>, <code>aarch64</code>, <code>s390x</code>,</td>
<td><code>5</code>, <code>6</code>, <code>7</code>, <code>8</code></td>
</tr>
<tr>
<td>Ubuntu</td>
<td><code>ubuntu</code></td>
<td><code>i386</code>, <code>x86_64</code>, <code>aarch64</code>, <code>ppc64le</code></td>
<td><code>10.04</code>, <code>10.10</code>, <code>11.04</code>, <code>11.10</code>, <code>12.04</code>, <code>12.10</code>, <code>13.04</code>, <code>13.10</code>, <code>14.04</code>, <code>14.10</code>, <code>16.04</code>, <code>16.10</code>, <code>17.04</code>, <code>17.10</code>, <code>18.04</code>, <code>18.10</code>, <code>19.04</code>, <code>20.04</code>, <code>20.10</code>, <code>21.04</code>, <code>21.10</code></td>
</tr>
<tr>
<td>Microsoft Windows</td>
<td><code>windows</code></td>
<td><code>x86_64</code>, <code>i386</code></td>
<td><code>7</code>, <code>8</code>, <code>10</code>, <span class="title-ref">2008r2</span>, <code>2012</code>, <code>2012r2</code>, <code>2016</code>, <code>2019</code>, <code>11</code>, <code>2022</code></td>
</tr>
</tbody>
</table>

### Examples

#### Get the Latest Build

To get the latest supported build for Ubuntu 20.04, enter the following:

```none
https://omnitruck.chef.io/stable/chef/metadata?p=ubuntu&pv=20.04&m=x86_64
```

to return something like:

```none
sha1 3fe8e8a2f443675f9b82e876cdac8200104451f2 
sha256 9f1c1a2c0b1f4e8494664386437bf32f0cb5cbfbd4cb9d23e327767fc65581dc 
url https://packages.chef.io/files/stable/chef/17.7.29/ubuntu/20.04/chef_17.7.29-1_amd64.deb 
version 17.7.29
```

#### Download Directly

To use cURL to download a package directly, enter the following:

```bash
curl -LOJ 'https://omnitruck.chef.io/<CHANNEL>/<PRODUCT>/download?p=debian&pv=10&m=x86_64'
```

To use GNU Wget to download a package directly, enter the following:

```bash
wget --content-disposition https://omnitruck.chef.io/<CHANNEL>/<PRODUCT>/download?p=debian&pv=10&m=x86_64
```
