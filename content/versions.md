+++
title = "Supported versions"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/versions.html"]
product = ["automate", "client", "server", "habitat", "inspec", "supermarket", "workstation"]

[menu]
  [menu.overview]
    title = "Supported versions"
    identifier = "overview/packages_&_platforms/versions.md Supported Versions"
    parent = "overview/packages_&_platforms"
    weight = 10
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

### Versions and Status

{{< important >}}

Chef Infra Client generally follows an N-1 support strategy. This means that if version 16 is the latest version, then both 15 and 16 are supported. As soon as version 17 is released, then 15 is placed in EOL status and no longer supported.

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
| Chef InSpec       | 6.x                      | GA               | n/a            |
| Chef Workstation  | 22.x (2022), 23.x (2023) | GA               | n/a            |

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
| Chef Backend      | 3.x     | Deprecated       | TBD               |
| Chef Infra Client | 17.x    | Deprecated       | November 30, 2024 |
| Chef Infra Server | 14.x    | Deprecated       | TBD               |
| Chef InSpec       | 5.x     | Deprecated       | TBD               |
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
| Chef InSpec              | 4.x                 | EOL              | November 14, 2023 |
| Chef Provisioning        | All                 | EOL              | August 31, 2019   |
| Chef Push Jobs           | All                 | EOL              | December 31, 2020 |
| Chef Replication/Sync    | All                 | EOL              | August 31, 2019   |
| Chef Server DRBD HA      | All                 | EOL              | March 31, 2019    |
| Chef Workflow (Delivery) | All                 | EOL              | December 31, 2020 |
| Chef Workstation         | 20.12.205 and under | EOL              | December 31, 2021 |
| Enterprise Chef          | All                 | EOL              | December 31, 2018 |
| Reporting                | All                 | EOL              | December 31, 2018 |
