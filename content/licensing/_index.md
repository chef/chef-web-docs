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

Either the [Chef End User License Agreement (Chef EULA)](#chef-eula) or your commercial agreement with Progress Software Corporation governs commercial distributions of Chef products. The [Apache License, Version 2.0](#apache-20) governs the reuse of source code of open-source Progress Chef projects.

Chef licenses come in [three different license tiers](#license-tiers) depending on your use case.

Before you can use distributions of Chef products, you must [accept the Chef license](accept). You must also [add a license key](add_license) if you use the following products:

- Chef InSpec 6 or greater

Licensing is available for non-profit, research, and academic organizations through a special, free, or highly discounted commercial license in [Progress Chef's Non-Profit Entitlement Program](https://www.chef.io/nonprofit-entitlement-program).

## Licenses

### Chef EULA

The [Chef End User License Agreement (Chef EULA)](https://www.chef.io/end-user-license-agreement) or your commercial agreement with Progress Software Corporation
goverens the commercial distributions of Progress Chef products--such as Chef Infra Client, Chef Habitat, or Chef InSpec. You must accept these terms when using the distributions for the first time. For additional information on how to accept the license, see [Accepting the Chef License](accept) documentation.

### Chef MLSA

The [Chef Master License and Services Agreement (Chef MLSA)](https://www.chef.io/online-master-agreement) governs distributions of older proprietary Chef products--such as Chef Automate 1.x and the Chef Management Console. You must accept this license as part of any install or upgrade process.

### Apache 2.0

The [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0.txt) governs the reuse of source code of open-source Progress Chef projects--including Chef Infra Client ("chef"), Chef InSpec, and Chef Habitat--unless specified otherwise in the project's repository.
Source code is released publicly through repositories in these organizations:

- [Progress Chef](https://github.com/chef)
- [Progress Chef InSpec](https://github.com/inspec)
- [Progress Chef Habitat](https://github.com/habitat-sh)

Progress Chef identifies third-party software included in our distributions in the `/opt/<PRODUCT-NAME>/LICENSE` file of our distribution. Full copies of all third-party referenced licenses are in the `/opt/<PRODUCT-NAME>/LICENSES` directory.

Intermediate products--such as binaries, modules, containers, and executables (including scripts or interpreted language files such as Ruby)--that Progress Chef releases on sites other than GitHub are governed by the [Chef EULA](#chef-eula). These products require a license and aren't considered open source.

For further questions, please contact [Chef Developer Relations](https://community.chef.io/).

## License tiers

Progress Chef offers three license tiers that have different entitlements: free, trial, and commercial.

| License    | Duration                           | Features                       | Intended environment                    | Support Model                                             | Intended uses                                      |
|------------|------------------------------------|--------------------------------|-----------------------------------------|-----------------------------------------------------------|----------------------------------------------------|
| Free       | Perpetual requiring annual renewal | Basic                          | Non-production workloads                | Community support in Slack                                | Personal and non-commercial use                    |
| Trial      | 30-days, renewable up to 90 days   | Advanced functionality enabled | Non-production workloads                | Community support in Slack and solution architect support | Evaluate products in a non-production environment. |
| Commercial | Renewable and upgradable           | Advanced functionality enabled | Production and Non-production workloads | Support by contract                                      | Enterprise workloads                               |

## Usage data

The Progress Chef EULA requires that basic license information be transmitted to Chef for all products.
The basic license information collected includes which Chef applications are in use, their versions, and the license(s) that govern those products.

Licensed customers may opt to send additional telemetry and usage data to Progress Chef.
This telemetry is used to tailor recommendations to customers, develop new features, and optimize the customer experience.

<!--
Can the customer see this data? Can they opt-in / out regularly? Link to another article on what this is, maybe the telemetry service?
-->