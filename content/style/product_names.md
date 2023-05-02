+++
title = "Chef Product Names"
draft = false
gh_repo = "chef-web-docs"


[menu]
  [menu.overview]
    title = "Product names"
    identifier = "overview/style/Product names"
    parent = "overview/style"
    weight = 30
+++

This page provides guideance on using Chef product names.

## Chef product names

For Chef applications and components, use:

- Chef Automate
- Chef Backend
- Chef Habitat
- Chef Infra (formerly Chef)
- Chef Infra Client (Use Chef Client up to version 14.x)
- Chef Infra Server (Formerly Chef Server)
- Chef InSpec
- Chef Manage
- Supermarket

Always capitalize product names and never hyphenate a product name or refer to a product by its CLI command.

## Shorten product names

It is awkward to refer to the full product name all the time.
Use the full product name the first time it's used in a page or paragraph and then use the shortened product name afterward.

## Using "the" before product names

Don't use "the" before a product name unless you're referring to a component of that product.

{{< recommend >}}

The Chef Infra Client config file.

{{< /recommend >}}

{{< recommend not >}}

The Chef Infra Server manages nodes.

{{< /recommend >}}

## Possessives

Avoid using the possessive _'s_ with a product name.

{{< recommend >}}

The Chef Infra Client config file.

{{< /recommend >}}

{{< recommend not >}}

The Chef Infra Client's config file.

{{< /recommend >}}
