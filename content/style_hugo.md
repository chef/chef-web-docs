+++
title = "Docs Hugo Guide"
draft = false

gh_repo = "chef-web-docs"

[menu]
  [menu.overview]
    title = "Docs Hugo Guide"
    identifier = "overview/community/contributing/style_hugo.md Chef "
    parent = "overview/community/contributing"
    weight = 43
+++

## Deleting Pages or Making New Pages


In addition, pages must be placed in the left navigation menu properly. This may involve moving other pages up or down in the left navigation menu by increasing or decreasing their menu weight which is specified in TOML front matter of each page or possibly in the `config.toml` file.

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

## Hugo

### Page Metadata

#### title

The title of the page. This will appear at the top of the page.

#### draft

Set draft to `true` if you don't want Hugo to build the page.

#### aliases

Add an alias if you want Hugo to automatically redirect the user from another page to the page you are writing.

#### gh_repo

The GitHub repository that the document originates from. This is used to generate "Edit on GitHub" links on each page.
For example, `chef-server`, `chef-workstation`, `chef-web-docs`, `automate`.
#### product

`product` is a list of Chef products that are relevant to a page. This list is used to facet search
results in our documentation search by the product. Each section of the documentation
has a default product parameter configured using [Front Matter Cascade](https://gohugo.io/content-management/front-matter#front-matter-cascade), however you may want to add a product if a page references
more than one Chef product. For example, if a page in the Chef InSpec documentation describes
passing data to Chef Automate, you may want to add `product = ["inspec", "automate"]` to the page frontmatter.

Relevant values:
- `automate`
- `desktop`
- `client`
- `server`
- `habitat`
- `inspec`
- `workstation`

#### menu title

The title of the page as it would appear in the left navigation menu.

#### menu identifier

The identifier of the page that you are writing. Each identifier must be unique.

The convention we've adopted is to use the identifier of the page's parent, a forward slash, then the page file, a space, and then the page title.

For example, this page's parent identifier is `overview/community`, the page file is `style_guide.md` and the page title is `Docs Style Guide`, so the full page identifier is `overview/community/style_guide.md Docs Style Guide`

#### menu parent

The menu identifier of the page's parent.

The convention we've adopted is to append the different menu levels together, separated by a forward slash, and starting with the highest level. For example, this page is nested under Overview and then Community, so the page's parent identifier is `overview/community`.

#### menu weight

The rank that the page will appear in the menu, incremented by 10. Higher numbers are lower in the menu.
