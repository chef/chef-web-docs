+++
title = "Page Front Matter"
draft = false

gh_repo = "chef-web-docs"

[menu]
  [menu.overview]
    title = "Page Front Matter"
    identifier = "overview/style/hugo/Page Front Matter"
    parent = "overview/style/hugo"
    weight = 20
+++

This document describes how to format the front matter at the top of each page.

See [Hugo's documentation about front matter](https://gohugo.io/content-management/front-matter/) for additional information.

Each page starts with [TOML front matter](https://gohugo.io/content-management/front-matter/) which contains metadata about the page and places it properly in the left navigation menu. Below is the TOML front matter for this page which you can use as a reference. Contact the Docs Team if you have any questions about formatting TOML front matter.

## Front matter example

The following is a page front matter example. See the following sections for a description of each parameter.

```toml
+++
title = "Example Documentation Page"
draft = false
gh_repo = "chef-web-docs"
product = ["client", "server"]
aliases = "/style_guide.html"
robots = ""
st_robots = ""

[menu]
  [menu.infra]
    title = "Example Page"
    identifier = "infra/Example Documentation Page"
    parent = "infra"
    weight = 40
+++
```

## Front matter parameters

<!-- markdownlint-disable MD006 MD007 MD032-->

title
: The title of the page. This will appear at the top of the page.

draft (optional)
: Set draft to `true` if you do not want Hugo to build the page.

aliases (optional)
: Add an alias if you want Hugo to automatically redirect the user from another page to the page you are writing. Use this if you are renaming or deleting a page.

gh_repo
: The GitHub repository that the document originates from. This is used to generate "Edit on GitHub" links on each page. For example: `gh_repo = "chef-server"`.

product (optional)
: `product` is a list of Chef products that are relevant to a page.
  This list is used to facet search results by product in the documentation site search.

  This value is automatically added to every page in a section of documentation using [Hugo's Front Matter Cascade](https://gohugo.io/content-management/front-matter#front-matter-cascade) to specify the product in the index page of that section.

  Use the `product` parameter in a page to override the automatically generated value. You may want to add a product parameter to a page's front matter if that page references more than one Chef product. For example, if a page in the Chef InSpec documentation describes passing data to Chef Automate, you may want to add `product = ["inspec", "automate"]` to the page front matter.

: Relevant values:

   - `automate`
   - `desktop`
   - `client`
   - `server`
   - `habitat`
   - `inspec`
   - `supermarket`
   - `workstation`

robots (optional)
: Use robots to add a value to the `robots` meta tag in a page.

st_robots (optional)
: Add a `robots` meta tag specifically for the [Swiftype Site Search Crawler](https://swiftype.com/documentation/site-search/crawler-configuration/meta-tags).

### Menu parameters

menu
: The menu that a page belongs in. For example, `menu.server` adds a page to the Infra Server menu.
: Possible menus are:
  - `main` (for the top utility bar menu at the top of the docs site)
  - `overview`
  - `automate`
  - `desktop`
  - `server`
  - `infra`
  - `inspec`
  - `workstation`
  - `effortless`
  - `supermarket`
  - `release_notes`
  - `legacy`
  - `extra`

title
: The menu title of the page as it would appear in the left navigation menu.

identifier
: The menu identifier of the page that you are writing. Each identifier must be unique.
The convention we have adopted is to use the identifier of the page's parent, a forward slash, then the page file, a space, and then the page title.
For example, this page's parent identifier is `overview/style`, the menu title is `Page Front Matter`, so the full page identifier is `overview/style/Page Front Matter`.

parent
: The page's parent menu identifier.
  The convention we have adopted is to append the different menu levels together, separated by a forward slash, and starting with the highest level. For example, this page is nested under Overview and then style, so the page's parent identifier is `overview/style`.

weight
: The rank that the page will appear in the menu, incremented by 10. Higher numbers are lower in the menu.

<!-- markdownlint-enable MD006 MD007 MD032-->

## Menu titles

Keep menu titles short and succinct. These will often be shorter than the page title because readers can glean the context of a page from its location in a menu.
