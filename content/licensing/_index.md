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

With the release of Chef InSpec 6, Chef is introducing a new licensing model which will expand to cover to all Chef products at a future date. The new licensing model is more flexible and lets customers and end-users choose a license that adapts to their specific DevOps scenarios.

<!--- What are these options? Is this just the license tiers? --->

For all products, including Chef InSpec 6 and higher, the existing [Chef End User License Agreement (Chef EULA)](#chef-eula) still applies and is unchanged.

Source code reuse is unchanged and follows the [Apache 2.0](#apache-20) model for open source products and repositories from Progress Chef.

## Licenses

### Chef EULA

The commercial distributions of our products--such as Chef Infra Client, Chef Habitat, or Chef InSpec--are governed by either the [Chef End User License Agreement (Chef EULA)](https://www.chef.io/end-user-license-agreement) or your commercial agreement with Progress Software Corporation. You must accept these terms when using the distributions for the first time. For additional information on how to accept the license, see [Accepting the Chef License](accept) documentation.

If you have a license from before April 2019 (referred to as the Chef Master License and Services Agreement, or MLSA), please consult the [Chef versions documentation](/versions/) to understand which license applies.

## Apache 2.0

The [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0.txt) governs the reuse of source code of open-source Progress Chef projects--including Chef Infra Client ("chef"), Chef InSpec, and Chef Habitat--unless specified otherwise in the project's repository.
Source code is released publicly through repositories in these organizations:

- [Progress Chef](https://github.com/chef)
- [Progress Chef InSpec](https://github.com/inspec)
- [Progress Chef Habitat](https://github.com/habitat-sh)

Progress Chef identifies third-party software included in our distributions in the `/opt/<PRODUCT-NAME>/LICENSE` file of our distribution. Full copies of all third-party referenced licenses are in the `/opt/<PRODUCT-NAME>/LICENSES` directory.

Intermediate products--such as binaries, modules, containers, and executables (including scripts or interpreted language files such as Ruby)--that Progress Chef releases on sites other than GitHub are governed by the [Chef EULA](#chef-eula). These products require a license and aren't considered open source.

For further questions, please contact [Chef Developer Relations](https://community.chef.io/).

## License tiers

Starting with Chef InSpec 6, there are three license tiers that have different entitlements: free, trial, and commercial.
Upon installation of Chef InSpec, you must accept the basic [Progress Chef EULA](https://www.chef.io/end-user-license-agreement) and then activate the product with a license key ID. Chef InSpec 6 doesn't run without a license. You can find your existing license key on the [customer support portal](https://community.progress.com/s/products-list).

| License    | Duration                           | Features                       | Intended environment                    | Support Model                                             | Intended uses                                      |
|------------|------------------------------------|--------------------------------|-----------------------------------------|-----------------------------------------------------------|----------------------------------------------------|
| Free       | Perpetual requiring annual renewal | Basic                          | Non-production workloads                | Community support in Slack                                | Personal and non-commercial use                    |
| Trial      | 30-days, renewable up to 90 days   | Advanced functionality enabled | Non-production workloads                | Community support in Slack and solution architect support | Evaluate products in a non-production environment. |
| Commercial | Renewable and upgradable           | Advanced functionality enabled | Production and Non-production workloads | Support by contract                                      | Enterprise workloads                               |

Licensing is available for non-profit, research, and academic organizations through a special, free, or highly discounted commercial license in [Progress Chef's Non-Profit Entitlement Program](https://www.chef.io/nonprofit-entitlement-program).

Official downstream distributions made from original Chef distributions (for example, CINC) aren't affected by this license change.

## Usage Data

The Progress Chef EULA requires basic license information to be transmitted to Chef for all products, including Chef InSpec 6.
The basic license information collected includes which applications are in use, Chef product versions, and the license(s) that govern those products.

Licensed customer may opt to send additional telemetry and usage data to Progress Chef.
This telemetry is used to tailor recommendations to customers, develop new features, and optimize the customer experience.

<!--
Can the customer see this data? Can they opt-in / out regularly? Link to another article on what this is, maybe the telemetry service?
-->