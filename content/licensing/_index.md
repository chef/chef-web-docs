+++
title = "About Chef Licenses"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/chef_license/", "/license/"]

[cascade]
  product = ["automate", "client", "server", "habitat", "inspec", "supermarket", "workstation"]

[menu]
  [menu.overview]
    title = "About Licensing"
    identifier = "overview/licensing/chef_license.md About Licensing"
    parent = "overview/licensing"
    weight = 10
+++

This document gives an overview of Chef product licenses and license tiers.

Before you can use distributions of Chef products, you must [accept the Chef End User License Agreement (Chef EULA)](accept) and you may be required to add a [Chef license key](#chef-license-key).

## Chef license key

For agent or client software downloaded directly from our Download Portal or via Hab distribution, licence is only enforced at the point of downloading software and not during runtime of the agent or client software. For software that downloads packages at runtime, license requirements depend on the source.

[Chef license key](license_key) is required to run:

-	To download the binaries from Progress Chef Download Portal or via Hab distribution: license key will be required.
-	Workflows which download packages at runtime (for example, knife bootstrap or kitchen converge): licence key will be required to proceed if you are downloading the binaries from Chef APIs.
-	Software obtained from any other sources not mentioned above, such as public Ruby gems or channels outside of our official Hab distribution and Download Portal: a valid licence will now be required to ensure accurate functioning.

Chef license key is not required to run:

- Knife bootstrap or kitchen converge workflows when using your own source to download binaries.
- License key is not required to execute any non-download commands using software obtained from an official source.

You can't manually enable or disable licensing. The licensing requirements are determined by the distribution.

### Chef license tiers

Progress Chef offers three license tiers that have different entitlements: Free, Trial, and Commercial.

| License | Duration | Environment | Support | Uses |
|---|---|---|---|---|
| Free | Unlimited | Non-production workloads | Community support in Slack | Personal and non-commercial use |
| Trial | 30 days | Non-production workloads | Community support in Slack and solution architect support | Product evaluation in a non-production environment |
| Commercial | Renewable | Production and non-production workloads | Support by contract | Enterprise workloads |

Licensing is available for non-profit, research, and academic organizations through a special, free, or highly discounted commercial license in [Progress Chef's Non-Profit Entitlement Program](https://www.chef.io/nonprofit-entitlement-program).

## Chef license agreements

All Chef products are governed by the [Chef End User License Agreement (Chef EULA)](#chef-eula) or the [Chef Master License and Services Agreement (Chef MLSA)](#chef-mlsa). The source code of open-source Chef projects is governed by the [Apache 2.0 license](#apache-20).

Third-party software included in our distributions may have individual licenses which are listed in the `/opt/<PRODUCT-NAME>/LICENSE` file. You can find individual copies of all referenced licenses in the `/opt/<PRODUCT-NAME>/LICENSES` directory.

### Chef EULA

The [Chef End User License Agreement (Chef EULA)](https://www.chef.io/end-user-license-agreement) or your commercial agreement with Progress Software Corporation
governs the commercial distributions of Progress Chef products---such as Chef Infra Client, Chef Habitat, or Chef InSpec. You must accept these terms when using the distributions for the first time. For additional information on how to accept the license, see [Accepting the Chef License](accept) documentation.

### Chef MLSA

The [Chef Master License and Services Agreement (Chef MLSA)](https://www.chef.io/online-master-agreement) governs distributions of older proprietary Chef products--such as Chef Automate 1.x and the Chef Management Console. You must accept this license as part of any install or upgrade process.

### Apache 2.0

The [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0.txt) governs the reuse of source code of open-source Progress Chef projects---including Chef Infra Client ("chef"), Chef InSpec, and Chef Habitat---unless specified otherwise in the project's repository.
Source code is released publicly through repositories in these organizations:

- [Progress Chef](https://github.com/chef)
- [Progress Chef InSpec](https://github.com/inspec)
- [Progress Chef Habitat](https://github.com/habitat-sh)

Progress Chef identifies third-party software included in our distributions in the `/opt/<PRODUCT-NAME>/LICENSE` file of our distribution. Full copies of all third-party referenced licenses are in the `/opt/<PRODUCT-NAME>/LICENSES` directory.

Intermediate products---such as binaries, modules, containers, and executables (including scripts or interpreted language files such as Ruby)---that Progress Chef releases on sites other than GitHub are governed by the [Chef EULA](#chef-eula). These products require a license and aren't considered open source.

For further questions, please contact [Chef Developer Relations](https://community.chef.io/).
