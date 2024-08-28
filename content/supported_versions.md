+++
title = "Supported Versions(LTS/Innovation)"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/versions.html"]
product = ["automate", "client", "server", "habitat", "inspec", "supermarket", "workstation"]

[menu]
  [menu.overview]
    title = "Supported Versions(LTS/Innovation)"
    identifier = "overview/packages_&_platforms/supported_versions.md Supported Versions(LTS/Innovation)"
    parent = "overview/packages_&_platforms"
    weight = 35
+++

This section lists the free and commercial On-Premises Chef products and versions we support based on our new long-term support policy. This policy, which defines Chef Software's involvement in updating and maintaining each product, has significant implications for our customers and their products.

## Product releases

Chef runs different releases that can run in parallel, and our customers can adapt them based on their needs. Following are releases of Chef supports:

### Innovation (I) release

- Innovation releases are designed for customers seeking faster modernization and innovation. Progress recommends using continuous integration and continuous delivery to help benefit from the more rapid release cadence. Innovation releases also allow all customers to explore features appearing in future LTS releases.
- With the introduction of LTS in Chef, any other major release will be termed an Innovation release. This release will be flexible and allow Chef to release significant versions and new features without LTS.

### Long-term supported (LTS) release

- From time to time, Chef may elect to designate a new release as long-term supported (LTS). Customers who primarily look for stability and minimal change for their implementation over many years can adapt to the LTS release.
- The software will get support depending on the timeline decided with LTS.
- Upgrade planning is more manageable for customers since they know when the next LTS version will be out.

### Non-supported (NS) releases

Non-supported releases are ad hoc releases made according to the requirement. They can be technical, private preview, alpha, or beta release.

- Progress may offer technical/private previews containing technical preview features on a Progress hosted environment under the terms in the applicable End User License Agreement.
- Progress may preview features/products planned to be released as future LTS features/products so that customers can validate if new features/products meet their use case and provide early feedback to Progress ahead of a general release.
- This release does not include CVE fixes, which Progress may choose to do.
- Customers must move to GA release once GA is available for Chef products. We do not provide any support for any release candidates such as alpha, beta, or a private preview post the GA launch.

## Lifecycle definitions

- Each Innovation and LTS release has its lifecycle starting at GA, migrates, and ends as described below:

### Generally available (GA)

This stage indicates that the product or version is actively developing and maintaining.

- GA releases are fully supported (LTS or Innovation). If you face any problems, Progress will work with you to find an appropriate resolution if active maintenance and support services cover them.
- Chef continues to provide releases to the application or version in response to customer needs and security vulnerabilities.
- Chef welcomes customer feature requests for the product roadmap for the application.
- Progress will evaluate GA releases for certifications of new third-party products, including new operating system versions. If you are porting to a new operating system that has not previously been supported, the LTS versions will be considered.

### Migration phase (MP)

- An LTS/I release enters the Migration phase with the launch of the LTS+/I+ release. When the Sunset phase starts, in parallel, the Migration phase starts, which is the transition period provided to customers to move to LTS+/I+.
- LTS and Innovation releases in the Migration phase are fully supported. Progress will evaluate them for certifications on new operating environments but not for ports to new hardware systems.
- If you encounter any problems using product releases in the Migration phase, Progress will work with customers toward an appropriate resolution where possible if active maintenance and support services cover their licenses.

### Sunset phase (only for LTS releases)

- After fulfilling the following conditions, an LTS release enters the Sunset phase.
- When the launch of the release is for two or more years, and
- A new LTS version has been released.
- The Sunset phase does not apply to Innovation releases. Once a subsequent Innovation release becomes available, the prior Innovation release immediately moves to the EOL life cycle phase with a given period of migration phase.
- If you face any problem using product releases in the Sunset phase, Progress will work with customers towards an appropriate resolution where possible if active maintenance and support services cover their licenses. The resolution includes the possibility of an update provided by Progress. We are committed to continuous support even during the Sunset phase, ensuring your confidence in our products.
- Progress only provides standard support for the LTS release in the Sunset phase if the customer has opted for Extended Paid Support. Progress recommends that customers plan to upgrade from Sunset phase product releases using this document as a guideline.

### End of Life (EOL) phase

The following describes the general impact of a product reaching EOL. For more details, refer to the official EOL communication, usually emailing. You can also find this information [here].

- This stage indicates that Progress has set a date after which the application or version will no longer be supported or recommended for customers' use.
- Products covered by active maintenance and support services at the time of an announced EOL will continue receiving technical support on the same terms as Sunset product releases for the duration of the purchased maintenance and support services.
- Progress does not allow renewal of maintenance and support services for EOL products.
- Once the existing maintenance and support services expire, Progress will not provide any further enhancements or fixes or entertain any new support cases. The existing product documentation, knowledge base articles, and online user community discussions will remain the only support.

To know more about the Chef's prem life cycle policy, see [Prem Life Cycle Policy].

### Versions and status

Chef has transitioned from N-1 and N-2 support policy to LTS++ and I++ support strategy. The support strategy works like follows:

- LTS for Chef will be for three years.
- LTS will follow the released version.
  - For Example, Chef Infra Server 19 LTS is a significant version. All minor releases are like 19. X and patches are like 19.2.x and will fall under LTS support.
- As the product EOL date is predetermined, a new release is not required to publish this message.
- There can be more than one Innovation release between the next LTS release. For example, Chef Infra Server 20 and 22 will be an Innovation release, and the next LTS release can be Chef 23 LTS.
- When LTS is released, it will have a declared sunset date of at most two years. The LTS will only be marked `Sunset` when the date (>=2 yr) has elapsed, and a new LTS version is released. `Sunset` in this context means the end of active support and the start of the EOL phase.
- Customers will then have a specified migration time (no less than six months) declared as part of the LTS+ release. At the end of the "migration window", LTS will be declared end of life. Customers may purchase extended migration support that will extend the time required to migrate to the new LTS version (up to a reasonable limit set by Progress).
- Upon releasing I+, the current Innovation release is EOL and subject to the migration window.

## Supported commercial distributions

Use of these and later versions of these distributions must be by the [Chef End User License Agreement](https://www.chef.io/end-user-license-agreement) or a commercial agreement with the Chef. Additional information is available in our blog post of [Introducing the New Chef](https://www.chef.io/blog/chef-software-announces-the-enterprise-automation-stack).

| Product           | Version | Release | Lifecycle status | Release date | EOL date                              |
|-------------------|---------|---------|------------------|--------------|---------------------------------------|
| Chef Courier      | 1.0     | I       | GA               |              | 6 months after the release of I+      |
| Chef 360 Platform | 1.0     | I       | GA               |              | 6 months after the release of I+      |
| Chef Infra Client | 19      | LTS     | GA               | TBD          | 3 years or more from the release date |
| Chef InSpec       | 7       | LTS     | GA               | TBD          | 3 years or more from the release date |

{{< note >}} Chef Backend does not directly require acceptance of the Chef EULA, but it does have functionality that requires its acceptance in other products. {{< /note >}}

## Supported free distributions < to be updated by Eng.>

Use of the following distributions is governed by the Apache License, version 2.0.

| Product     | Version | Lifecycle status | EOL date |
|-------------|---------|------------------|----------|
| Supermarket | 5.x     | GA               | TBD      |

## Deprecated products and versions

The following products are deprecated, so move to newer versions or products.

| Product           | Version | Lifecycle status | EOL date |
|-------------------|---------|------------------|----------|
| Chef Infra Client | 18.x    | TBD              | TBD      |
| Chef InSpec       | 6.x     | TBD              | TBD      |

## End of Life (EOL) products

The following list must be maintained in the future according to new policy.

| Product                  | Version             | Lifecycle Status | EOL Date          |
|--------------------------|---------------------|------------------|-------------------|
| Analytics                | All                 | EOL              | December 31, 2018 |
| Chef Automate            | 1.x                 | EOL              | December 31, 2019 |
| Chef Infra Client        | 16 and under        | EOL              | November 30, 2022 |
| Chef Compliance Server   | All                 | EOL              | December 31, 2018 |
| ChefDK                   | All                 | EOL              | December 31, 2020 |
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
