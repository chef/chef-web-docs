+++
title = "Supported Versions"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/versions.html"]
product = ["automate", "client", "server", "habitat", "inspec", "workstation"]

[menu]
  [menu.overview]
    title = "Supported Versions"
    identifier = "overview/packages_&_platforms/versions.md Supported Versions"
    parent = "overview/packages_&_platforms"
    weight = 30
+++

This section lists the free and commercial Chef products and versions we
currently support. The lifecycle stage defines the involvement by Chef
Software in updating and maintaining each product.

## Lifecycle Definitions

### Generally Available (GA)

This stage indicates that the product or version is in active
development and/or maintenance.

- Chef continues to provide releases to the application or version in response to customer needs and security vulnerabilities
- Chef welcomes customer feature requests for the product roadmap for the application

### Deprecated

This stage indicates that an application or version is no longer in
active development and will eventually move to end of life status. Chef
continues to provide support [according to our
SLAs](https://www.chef.io/service-level-agreement/).

- Chef no longer provides scheduled releases
- Customers should use the GA alternative to these products; contact us for help with product selection and deployment
- Chef may provide a release for a critical defect or security vulnerability

### End of Life (EOL)

This stage indicates that Chef has set a date after which the
application or version will no longer be supported or recommended for
use by customers.

- As of the end of life date, the application will no longer be supported by Chef and will no longer be available for download
- Documentation for the application will be moved to <https://docs-archive.chef.io>

### Versions and Status

{{< important >}}

Unless otherwise stated, versions older than those listed below are EOL.

{{< /important >}}

## Supported Commercial Distributions

Use of these and later versions of these distributions must be in
accordance with the [Chef End User License
Agreement](https://www.chef.io/end-user-license-agreement) or a
commercial agreement with Chef. Additional information is available in
[this announcement](https://www.chef.io/blog/chef-software-announces-the-enterprise-automation-stack).

<table>
<colgroup>
<col style="width: 18%" />
<col style="width: 31%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr class="header">
<th>Product</th>
<th>Version</th>
<th>Lifecycle Status</th>
<th>EOL Date</th>
</tr>
</thead>
<tbody>
<tr>
<td>Chef Automate</td>
<td>Latest</td>
<td>GA</td>
<td>n/a</td>
</tr>
<tr>
<td>Chef Infra Client</td>
<td>17.x</td>
<td>GA</td>
<td>April 30, 2023</td>
</tr>
<tr>
<td>Chef Infra Server</td>
<td>14.x</td>
<td>GA</td>
<td>n/a</td>
</tr>
<tr>
<td>Chef Habitat</td>
<td>0.81+</td>
<td>GA</td>
<td>n/a</td>
</tr>
<tr>
<td>Chef InSpec</td>
<td>4.x</td>
<td>GA</td>
<td>n/a</td>
</tr>
<tr>
<td>Chef Workstation</td>
<td>21.x (2021), 22.x (2022)</td>
<td>GA</td>
<td>n/a</td>
</tr>
<tr>
<td>Chef Backend</td>
<td>3.x</td>
<td>Releasing 2021</td>
<td>2022</td>
</tr>
</tbody>
</table>

{{< note >}}

**Chef Backend** does not directly require acceptance of the Chef
EULA, but it does have functionality that requires its acceptance in other
products.

{{< /note >}}

## Supported Free Distributions

Use of the following distributions is governed by the Apache License,
version 2.0.

<table>
<colgroup>
<col style="width: 18%" />
<col style="width: 31%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr class="header">
<th>Product</th>
<th>Version</th>
<th>Lifecycle Status</th>
<th>EOL Date</th>
</tr>
</thead>
<tbody>
<tr>
<td>Supermarket</td>
<td>5.x</td>
<td>GA</td>
<td>TBD</td>
</tr>
</tbody>
</table>

## Deprecated Products and Versions

The following products are deprecated. Users are advised to move to
newer versions or products.

<table>
<colgroup>
<col style="width: 18%" />
<col style="width: 31%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr class="header">
<th>Product</th>
<th>Version</th>
<th>Lifecycle Status</th>
<th>EOL Date</th>
</tr>
</thead>
<tbody>
<tr>
<td>Chef Backend</td>
<td>2.x</td>
<td>Deprecated</td>
<td>December 31, 2022</td>
</tr>
<tr>
<td>Chef Infra Client</td>
<td>16.x</td>
<td>Deprecated</td>
<td>November 30, 2022</td>
</tr>
<tr>
<td>Chef Manage</td>
<td>2.5.x+</td>
<td>Deprecated</td>
<td>December 31, 2022</td>
</tr>
</tbody>
</table>

## End of Life (EOL) Products

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr class="header">
<th>Product</th>
<th>Version</th>
<th>Lifecycle Status</th>
<th>EOL Date</th>
</tr>
</thead>
<tbody>
<tr>
<td>Analytics</td>
<td>All</td>
<td>EOL</td>
<td>December 31, 2018</td>
</tr>
<tr>
<td>Chef Automate</td>
<td>1.x</td>
<td>EOL</td>
<td>December 31, 2019</td>
</tr>
<tr>
<td>Chef Infra Client</td>
<td>15 and under</td>
<td>EOL</td>
<td>April 30, 2021</td>
</tr>
<tr>
<td>Chef Compliance Server</td>
<td>All</td>
<td>EOL</td>
<td>December 31, 2018</td>
</tr>
<tr>
<td>ChefDK</td>
<td>ALL</td>
<td>EOL</td>
<td>December 31, 2020</td>
</tr>
<tr>
<td>Chef Infra Server</td>
<td>13.x</td>
<td>EOL</td>
<td>June 30, 2021</td>
</tr>
<tr>
<td>Chef InSpec</td>
<td>2 and under</td>
<td>EOL</td>
<td>December 31, 2019</td>
</tr>
<tr>
<td>Chef InSpec</td>
<td>3.x</td>
<td>EOL</td>
<td>April 30, 2020</td>
</tr>
<tr>
<td>Chef Provisioning</td>
<td>All</td>
<td>EOL</td>
<td>August 31, 2019</td>
</tr>
<tr>
<td>Chef Push Jobs</td>
<td>All</td>
<td>EOL</td>
<td>December 31, 2020</td>
</tr>
<tr>
<td>Chef Replication/Sync</td>
<td>All</td>
<td>EOL</td>
<td>August 31, 2019</td>
</tr>
<tr>
<td>Chef Server DRBD HA</td>
<td>All</td>
<td>EOL</td>
<td>March 31, 2019</td>
</tr>
<tr>
<td>Chef Workflow (Delivery)</td>
<td>All</td>
<td>EOL</td>
<td>December 31, 2020</td>
</tr>
<tr>
<td>Chef Workstation</td>
<td>20.12.205 and under</td>
<td>EOL</td>
<td>December 31, 2021</td>
</tr>
<tr>
<td>Enterprise Chef</td>
<td>All</td>
<td>EOL</td>
<td>December 31, 2018</td>
</tr>
<tr>
<td>Reporting</td>
<td>All</td>
<td>EOL</td>
<td>December 31, 2018</td>
</tr>
</tbody>
</table>
