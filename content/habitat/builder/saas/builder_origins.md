+++
title = "Create an origin on Builder"
description = "Create an origin on Builder"


[menu.habitat]
    title = "Origins"
    identifier = "habitat/builder/saas/origins"
    parent = "habitat/builder/saas"
    weight = 30
+++

An origin is a unique namespace in Chef Habitat Builder where you can store, share, and build packages.
Once created, an origin can't be renamed, but it can be deleted or transferred.
For example, the _core_ origin contains foundational packages managed and versioned by Chef Habitat maintainers.

You can join existing origins by invitation or create your own origins in an on-prem Habitat Builder deployment. For details about invitations, see [origin membership and RBAC](origin_rbac#origin-membership" >}}).

## Chef-owned origins

Progress Chef maintains the following origins:

- **core**: Hosts packages for common dependencies and compilers maintained by Progress Chef.
- **chef**: Hosts packages for Chef products like Chef Infra Client, Chef InSpec, and Chef Automate.
- **chef-platform**: Hosts packages for Chef 360 Platform skills.
- **habitat**: Hosts packages required for an on-prem Habitat Builder deployment.

## Where can I create an origin

You can create origins with [Habitat On-Prem Builder](https://docs.chef.io/habitat/on_prem_builder/).
You can't create origins in [Chef's public Habitat SaaS Builder](https://bldr.habitat.sh).
