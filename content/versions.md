+++
title = "Supported versions"
draft = false
gh_repo = "chef-web-docs"

swiftype_search_products = ["automate", "client", "server", "habitat", "inspec", "supermarket", "workstation"]

[menu]
  [menu.overview]
    title = "Supported versions"
    identifier = "overview/packages_&_platforms/versions.md Supported Versions"
    parent = "overview/packages_&_platforms"
    weight = 10
+++

This section lists the free and commercial Chef products and versions we currently support.
The lifecycle stage defines the involvement by Chef Software in updating and maintaining each product.

## Lifecycle definitions

### Generally Available (GA)

This stage indicates that the product or version is in active development and/or maintenance.

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

This stage indicates that Chef has set a date after which the application or version will no longer be supported or recommended for use by customers.

### Versions and status

{{< important >}}

Chef follows a Long-Term Support (LTS) model.
Designated LTS releases receive extended support, while non-LTS releases and older versions reach End of Life (EOL) on fixed dates.
Chef Infra Client version 19.x is the current LTS baseline.
Non-LTS versions below this baseline are EOL.

{{< /important >}}

## Supported commercial distributions

Use of these and later versions of these distributions must be in accordance with the [Chef End User License Agreement](https://www.chef.io/end-user-license-agreement) or a commercial agreement with Chef.
Additional information is available in [this announcement](https://www.chef.io/blog/chef-software-announces-the-enterprise-automation-stack).

| Product           | Version                  | Lifecycle Status | EOL Date       |
|-------------------|--------------------------|------------------|----------------|
| Chef 360 Platform | Latest                   | GA               | n/a            |
| Chef Automate     | Latest                   | GA               | n/a            |
| Chef Infra Client | 19.x                     | GA               | n/a            |
| Chef Habitat      | 0.81+                    | GA               | n/a            |
| Chef InSpec       | 5+                       | GA               | n/a            |
| Chef Workstation  | 25.x, 26.x               | GA               | n/a            |

{{< note >}}

**Chef Backend** doesn't directly require acceptance of the Chef EULA,
but it does have functionality that requires its acceptance in other products.

{{< /note >}}

## Supported free distributions

Use of the following distributions is governed by the Apache License,
version 2.0.

| Product     | Version | Lifecycle Status | EOL Date |
|-------------|---------|------------------|----------|
| Supermarket | 5.x     | GA               | TBD      |

## Deprecated products and versions

Progress Chef has deprecated the following products.
If you're using one of these products, migrate to a supported version or product.

| Product           | Version | Lifecycle Status | EOL Date       | Replacement product or version |
|-------------------|---------|------------------|----------------|--------------------------------|
| Chef Backend      | 3.x     | Deprecated       | TBD            | Chef 360 Platform              |
| Chef Infra Client | 18.x    | Deprecated       | TBD            | Chef Infra Client 19.x         |
| Chef Infra Server | 15.x    | Deprecated       | November 2026  | Chef 360 Platform              |
| Chef InSpec       | 4.x     | Deprecated       | TBD            | Chef InSpec 5.x                |
| Chef Workstation  | 24.x    | Deprecated       | April 2026     | Chef Workstation 25 or above   |

## End of Life (EOL) products

| Product                  | Version              | Lifecycle Status | EOL Date          | Replacement product or version |
|--------------------------|----------------------|------------------|-------------------|--------------------------------|
| Analytics                | All                  | EOL              | December 31, 2018 | None                           |
| Chef Automate            | 2.x and under        | EOL              | May 13, 2022      | Latest version                 |
| Chef Infra Client        | 17 and under         | EOL              | February 5, 2026  | Latest version                 |
| Chef Compliance Server   | All                  | EOL              | December 31, 2018 | Chef Automate Latest           |
| ChefDK                   | All                  | EOL              | December 31, 2020 | Chef Workstation Latest        |
| Chef Infra Server        | 14.x                 | EOL              | December 31, 2025 | Chef 360 Platform              |
| Chef InSpec              | 2 and under          | EOL              | December 31, 2019 | Chef InSpec Latest             |
| Chef InSpec              | 3.x                  | EOL              | April 30, 2020    | Chef InSpec Latest             |
| Chef Manage              | 2.5.x+               | EOL              | February 2026     | Chef 360 Platform              |
| Chef Provisioning        | All                  | EOL              | August 31, 2019   | No planned replacement; use your organization's preferred provisioning tools |
| Chef Push Jobs           | All                  | EOL              | December 31, 2020 | Chef 360 Platform              |
| Chef Replication/Sync    | All                  | EOL              | August 31, 2019   | None                           |
| Chef Server DRBD HA      | All                  | EOL              | March 31, 2019    | Chef 360 Platform              |
| Chef Workflow (Delivery) | All                  | EOL              | December 31, 2020 | No planned replacement                                                       |
| Chef Workstation         | 23.12.1055 and under | EOL              | December 31, 2024 | Chef Workstation Latest        |
| Enterprise Chef          | All                  | EOL              | December 31, 2018 | Chef 360 Platform              |
| Reporting                | All                  | EOL              | December 31, 2018 | Chef Automate Latest           |
