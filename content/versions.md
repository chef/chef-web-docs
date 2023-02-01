+++
title = "Supported Versions"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/versions.html"]
product = ["automate", "client", "server", "habitat", "inspec", "supermarket", "workstation"]

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

| Product           | Version                  | Lifecycle Status | EOL Date       |
|-------------------|--------------------------|------------------|----------------|
| Chef Automate     | Latest                   | GA               | n/a            |
| Chef Infra Client | 18.x                     | GA               | n/a            |
| Chef Infra Server | 15.x                     | GA               | n/a            |
| Chef Habitat      | 0.81+                    | GA               | n/a            |
| Chef InSpec       | 5.x                      | GA               | n/a            |
| Chef Workstation  | 21.x (2021), 22.x (2022) | GA               | n/a            |
| Chef Backend      | 3.x                      | Releasing 2021   | TBD            |

{{< note >}}

**Chef Backend** does not directly require acceptance of the Chef
EULA, but it does have functionality that requires its acceptance in other
products.

{{< /note >}}

## Supported Free Distributions

Use of the following distributions is governed by the Apache License,
version 2.0.

| Product     | Version | Lifecycle Status | EOL Date |
|-------------|---------|------------------|----------|
| Supermarket | 5.x     | GA               | TBD      |

## Deprecated Products and Versions

The following products are deprecated. Users are advised to move to
newer versions or products.

| Product           | Version | Lifecycle Status | EOL Date          |
|-------------------|---------|------------------|-------------------|
| Chef Backend      | 2.x     | Deprecated       | TBD               |
| Chef Infra Client | 17.x    | Deprecated       | TBD               |
| Chef Infra Server | 14.x    | Deprecated       | TBD               |
| Chef Manage       | 2.5.x+  | Deprecated       | TBD               |

## End of Life (EOL) Products

| Product                  | Version             | Lifecycle Status | EOL Date          |
|--------------------------|---------------------|------------------|-------------------|
| Analytics                | All                 | EOL              | December 31, 2018 |
| Chef Automate            | 1.x                 | EOL              | December 31, 2019 |
| Chef Infra Client        | 16 and under        | EOL              | November 30, 2022 |
| Chef Compliance Server   | All                 | EOL              | December 31, 2018 |
| ChefDK                   | ALL                 | EOL              | December 31, 2020 |
| Chef Infra Server        | 13.x                | EOL              | June 30, 2021     |
| Chef InSpec              | 2 and under         | EOL              | December 31, 2019 |
| Chef InSpec              | 3.x                 | EOL              | April 30, 2020    |
| Chef Provisioning        | All                 | EOL              | August 31, 2019   |
| Chef Push Jobs           | All                 | EOL              | December 31, 2020 |
| Chef Replication/Sync    | All                 | EOL              | August 31, 2019   |
| Chef Server DRBD HA      | All                 | EOL              | March 31, 2019    |
| Chef Workflow (Delivery) | All                 | EOL              | December 31, 2020 |
| Chef Workstation         | 20.12.205 and under | EOL              | December 31, 2021 |
| Enterprise Chef          | All                 | EOL              | December 31, 2018 |
| Reporting                | All                 | EOL              | December 31, 2018 |
