+++
title = "Hugo Guide"
draft = false

gh_repo = "chef-web-docs"

[menu]
  [menu.overview]
    title = "Hugo"
    identifier = "overview/style/style_hugo."
    parent = "overview/style"
    weight = 110
+++

## Building

To build the docs locally, from the root of the `chef-web-docs` directory, run the command:

```bash
make serve
```

## Add a New Page

Adding a new page has two steps:

1. Create the page
1. Add the page to the left navigation bar

From the root of the `chef-web-docs` directory, add a completely new page with the command:

```go
hugo new content/page_name.md
```

Navigate to your new page in the `chef-web-docs/content` directory and edit the frontmatter accordingly.

## Add or Remove pages from the Left Nav Bar

Adding, removing, and changing the placement of a page in the left nav involves three steps:

1. Defining the page weight in the document's  front matter or the `config.toml` file
1. Verifying that the page appears as you intend in the left nav
1. Adjusting the weighting in affected pages accordingly

Contact the documentation team if you have any questions about adding or removing pages.

## TOML Front Matter

Each page starts with [TOML front matter](https://gohugo.io/content-management/front-matter/) which contains metadata about the page and places it properly in the left navigation menu. Below is the TOML front matter for this page which you can use as a reference. Contact the Docs Team if you have any questions about properly formatting TOML front matter.

```toml
+++
title = "Example Documentation Page"
description = "DESCRIPTION"
draft = false
gh_repo = "chef-web-docs"
product = ["client", "server"]
aliases = "/style_guide.html"

[menu]
  [menu.infra]
    title = "Example Page"
    identifier = "infra/Example Documentation Page"
    parent = "infra"
    weight = 40
+++
```

title
: The title of the page. This will appear at the top of the page.

draft
: Set draft to `true` if you don't want Hugo to build the page.

aliases
: Add an alias if you want Hugo to automatically redirect the user from another page to the page you are writing.

gh_repo
: The GitHub repository that the document originates from. This is used to generate "Edit on GitHub" links on each page. For example:
`chef-server`, `chef-workstation`, `chef-web-docs`, `automate`.

product
: `product` is a list of Chef products that are relevant to a page. Relevant values:

- `automate`
- `desktop`
- `client`
- `server`
- `habitat`
- `inspec`
- `workstation`

This list is used to facet search results in our documentation search by the product. Each section of the documentation
has a default product parameter configured using [Front Matter Cascade](https://gohugo.io/content-management/front-matter#front-matter-cascade), however you may want to add a product if a page references more than one Chef product. For example, if a page in the Chef InSpec documentation describes passing data to Chef Automate, you may want to add `product = ["inspec", "automate"]` to the page frontmatter.

menu title
: The title of the page as it would appear in the left navigation menu.

menu identifier
: The identifier of the page that you are writing. Each identifier must be unique.
The convention we've adopted is to use the identifier of the page's parent, a forward slash, then the page file, a space, and then the page title.
For example, this page's parent identifier is `overview/style`, the page file is `style_guide.md` and the page title is `Docs Style Guide`, so the full page identifier is `overview/style/style_guide.md Docs Style Guide`

menu parent
: The menu identifier of the page's parent.
The convention we've adopted is to append the different menu levels together, separated by a forward slash, and starting with the highest level. For example, this page is nested under Overview and then style, so the page's parent identifier is `overview/style`.

menu weight
: The rank that the page will appear in the menu, incremented by 10. Higher numbers are lower in the menu.
