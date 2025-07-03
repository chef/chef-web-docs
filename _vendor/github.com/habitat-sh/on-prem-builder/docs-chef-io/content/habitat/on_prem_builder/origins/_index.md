+++
title = "Chef Habitat origins"

[menu]
  [menu.habitat]
    title = "Overview"
    identifier = "habitat/on-prem-builder/origins/overview"
    parent = "habitat/on-prem-builder/origins"
    weight = 10
+++

An origin is a unique namespace in Chef Habitat Builder where you can store, share, and build packages.
Once created, you can'tt rename an origin, but you can delete or transfer it.
For example, the _core_ origin contains foundational packages managed and versioned by the core Chef Habitat maintainers.

You can create origins in an Habitat On-Prem Builder deployment.
[Chef's public Habitat Builder](https://bldr.habitat.sh) doesn't support creating new origins.

You can join existing origins by invitation or create your own origins in an Habitat On-Prem Builder deployment.

## Chef-owned origins

Progress Chef maintains the following origins:

- **core**: Hosts packages for common dependencies and compilers maintained by Progress Chef.
- **chef**: Hosts packages for Chef products like Chef Infra Client, Chef InSpec, and Chef Automate.
- **chef-platform**: Hosts packages for Chef 360 Platform skills.
- **habitat**: Hosts packages required for an Habitat On-Prem Builder deployment.

## Origin user guides

See the following user guides for managing Chef Habitat origins:

- [Create an origin](create_an_origin)
- [Origin keys](origin_keys)
- [Origin settings](origin_settings)
- [Origin role-based access control](rbac)

## More information

- [Manage packages in Habitat On-Prem Builder](../packages/)
- [Habitat packages](../packages/)
