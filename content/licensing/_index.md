+++
title = "About Chef Licenses"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/chef_license.html", "/chef_license/", "/license/"]

[cascade]
  product = ["automate", "client", "server", "habitat", "inspec", "supermarket", "workstation"]

[menu]
  [menu.overview]
    title = "About Licensing"
    identifier = "overview/licensing/chef_license.md About Licensing"
    parent = "overview/licensing"
    weight = 10
+++

With the release of Chef InSpec 6, we are introducing a new licensing model which will expand to cover to all Chef products at a future date. The new licensing model is more flexible and lets customers and end-users choose a license which adapts to their specific DevOps scenarios.

For all products, including Chef InSpec 6 and higher, the existing [Progress Chef End-User License Agreement](https://www.chef.io/end-user-license-agreement) (EULA) still applies and is unchanged. The Progress Chef EULA covers the usage of the product distribution. Licensing and reuse of open source code is described in the section below [LINK].

Source code reuse is unchanged and follows the Apache 2.0 model as described below for open source products and repositories from Progress Chef.

## Chef End-User License Agreement

The commercial distributions of our products--such as Chef Infra Client, Chef Habitat, or Chef InSpec--are governed by either the Chef End User License Agreement (Chef EULA) or your commercial agreement with Progress Software Corporation. You are required to accept these terms when using the distributions for the first time. For additional information on how to accept the license, see [Accepting the Chef License](/license/accept/) documentation.

If you have a license from before April 2019 (referred to as the Chef Master License and Services Agreement, or MLSA), please consult the [Chef versions documentation](https://docs.chef.io/versions/) to understand which license applies.

## Overview of license types

For Chef InSpec 6 and higher, there are three new end-user licenses which govern usage and come with different entitlements: a free license, a trial license, and a commercial license. Upon installation of the Chef InSpec product distribution, the end-user accepts the basic Progress Chef [EULA][EULA] and then must activate the product with one of these new additional licenses. Chef InSpec 6 will not run without at least one of these licenses being applied. Each license type has different entitlements and permission grants based on the customer's intended usage.

| License | Duration | Cost | Features | Intended environment | Support Model | Restrictions | Typical Persona | Intended uses |
| ----------- | ----------- | ----------- | ----------- |  ----------- |  ----------- | ----------- | ----------- | --------- |
| Free | Perpetual requiring annual renewal | Free | Basic | Non-production workloads | Community support in Slack | Some features and scale may be restricted | Issued to individual (seat license) | Personal and non-commercial use |
| Trial | Initial 30-day license renewable up to 90 days | Free | Advanced functionality enabled | Non-production workloads | Community support in Slack and solution architect support | Some features and scale may be restricted | Individual within an organization | Evaluate products in a non-production environment organization or company |
| Commercial | Duration of contract, renewable and upgradable | Paid | Advanced functionality enabled | Production and Non-production workloads | Support per contract | Full product(s) and content per contract | Professional DevOps Engineer within an organization | Enterprise workloads |

Licensing is available for non-profit, research, and academic organizations through a special, free, or highly discounted commercial license in [Progress Chef's Non-Profit Entitlement Program](https://www.chef.io/nonprofit-entitlement-program).

Official downstream distributions made from original Chef distributions (for example, CINC) are not affected by this license change.

## Required and optional usage data

The Progress Chef EULA requires basic license information to be transmitted to Chef for all products, including Chef InSpec 6. The basic license information collected includes which applications are in use, Chef product versions, and the license(s) that govern those products. How often? Link to another article?

The licensed customer may opt in to additional telemetry and usage data being sent back to Chef. This telemetry is used to tailor recommendations to customers, develop new features, and optimize the customer experience. Can the customer see this data? Can they opt-in / out regularly? Link to another article on what this is, maybe the telemetry service?

## Open source licensing

The [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0.txt) governs the reuse of source code of Progress Chef projects--including Chef Infra Client ("chef"), Chef InSpec, and Chef Habitat--unless specified otherwise in the project's repository. Source code is released publicly through repositories in these organizations:

- [Progress Chef](https://github.com/chef)
- [Progress Chef InSpec](https://github.com/inspec)
- [Progress Chef Habitat](https://github.com/habitat-sh)

Progress Chef identifies third-party software included in our distributions in the `/opt/<PRODUCT-NAME>/LICENSE` file of our distribution. Full copies of all third-party referenced licenses are in the `/opt/<PRODUCT-NAME>/LICENSES` directory.

Progress Chef releases other intermediate products on other public sites for use by the community. Binaries, modules, containers and executables (including scripts or interpreted language files such as Ruby) which are released on sites other than GitHub, are governed by the EULA above, require a license and are not considered open source. The reuse of source code and these intermediate products is described [here LINK](). For further questions, please contact Chef Developer Relations.
