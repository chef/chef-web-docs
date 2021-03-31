+++
title = "Chef House Style"
draft = false

gh_repo = "chef-web-docs"

[menu]
  [menu.overview]
    title = "Chef House Style"
    identifier = "overview/style/style_house"
    parent = "overview/style"
    weight = 90
+++

We recommend that you use the conventions described in this guide when contributing to the Chef reference documentation.

## Official Names

For Chef applications and components, use:

- Chef Automate
- Chef Habitat
- Chef Infra (formerly Chef)
- Chef Infra Client (Use Chef Client up to version 14.x)
- Chef Infra Server (Formerly Chef Server)
- Chef InSpec

## Grammar

Chef does not follow a specific grammar convention. Be clear and
consistent as often as possible. Follow the established patterns in the
docs.

### Tautologies

A tautology, when used as a description for a component, setting,
method, etc. should be avoided. If a string is a tautology, some effort
should be made to make it not so. An example of a tautology is something
like "Create a new user" (by its very nature, a user created **is** a
new user) or (for a setting named `cidr_block`) "The CIDR block for the
VPC."

## Examples

### Example Company

We use the fictional company "Fourth Cafe, Inc." as an example throughout the docs.

Fourth Cafe, Inc.
123579 4th Ave
Seattle, WA 98122

Examples in code:
`admin@4thcafe.com`
`4thcafe.pem`

### Example Domains

Use the `4thcafe.com` domain for generic domains and email addresses in the documentation. Use the `chef.io` or `progress.com` for examples that should refer directly back to the company.

### Example Names

Don't reveal personal information in examples, such as the names of real people, real email addresses, or phone numbers.

Don't use the names of bands, musicians, or characters from works that are under copyright.

When writing about security, follow the accepted convention and use "Alice" and "Bob". Following this convention helps readers see that they are reading a topic about security and integrate the Chef information with their existing knowledge.

Here is a list of some example names for you to use (the last names are translations of "Chef"):

- Ares Koch
- Tamira Bucatar
- Dan Gotvach
- Lena Chushi
- Haris Shefu
- Booker Yolisa
- Kala Baavarchee
- Samuel Tagaluto

### Example Email Addresses

- akoch@4thcafe.com
- tbucatar@4thcafe.com
- dgotvach@4thcafe.com
- lchushi@4thcafe.com
- hshefu@4thcafe.com
- byolisa@4thcafe.com
- kbaavarchee@4thcafe.com
- stagaluto@4thcafe.com

Use `docs@chef.io` for the Chef Technical Documentation team.

#### Example Phone Numbers

Never use a real phone number in an example. For a US phone number, use one from the range reserved for examples in fiction, which is (800) 555-0100 through (800) 555-0199.

### Example Addresses

Use fictional street addresses in examples.

Use these fictional addresses:

2943 Conifer Drive
Seattle, WA 98122

1214 Hollow Road
Boston, MA 02110

### Example IP Addresses

For IPv4 addresses, use one of the addresses provided in [RFC 5735](https://tools.ietf.org/html/rfc5737) for documentation.

IPv4 addresses:

- `192.0.2.0`
- `198.51.100.0`
- `203.0.113.0`

IPv4 address ranges:

- `192.0.2.0/24` (TEST-NET-1)
- `198.51.100.0/24` (TEST-NET-2)
- `203.0.113.0/24` (TEST-NET-3)

For IPv6 addresses, use one of the addresses provided in [RFC 3849](https://tools.ietf.org/html/rfc3849) range for documentation.

IPv6 address range:

- `2001:DB8::/32`
