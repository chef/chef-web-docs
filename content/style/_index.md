+++
title = "Chef Documentation Style Guide"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/style_guide.html", "/style_index/", "/style_guide/"]

[cascade]
  product = []

[menu]
  [menu.overview]
    title = "Docs Style"
    identifier = "overview/style/Docs Style"
    parent = "overview/style"
    weight = 10
+++

<!-- markdownlint-disable-file MD013 -->

This style guide provides a set of standards for writing clear and consistent developer documentation for all of Progress Chef's products.

Chef's documentation is open source and we follow a [docs as code](https://www.docslikecode.com/) methodology.
Any community member can make or suggest a documentation change through a pull request or issue in a documentation repository.

For additional guidance not covered in this style guide, refer to [Google's style guide](https://developers.google.com/style) and [Microsoft's style guide](https://learn.microsoft.com/en-us/style-guide/welcome/).

## Documentation repositories

Our main repository for [docs.chef.io](https://docs.chef.io) is called [chef-web-docs](https://github.com/chef/chef-web-docs). This repo contains the files for Chef Infra Client and the Hugo files for our front-end theme, templates, and shortcodes. The Chef documentation is located in: `https://github.com/chef/chef-web-docs`

- The `chef-web-docs` repo contains a `content` directory which holds most the Markdown files in the doc set.
- The `static/images` directory stores the image files used in the docs.
- The `config.toml` tells Hugo how to build the navigation menus and contains other Hugo settings. don't modify this file.

### Repository locations

We try to keep our documentation source as close to the code as possible, which means that our documentation files are distributed across several product repositories.

<!-- markdownlint-disable -->
| Product | GitHub Docs Directory |
|---------|-----------------------|
| Chef Automate |https://github.com/chef/automate/tree/main/components/docs-chef-io|
| Chef Desktop |https://github.com/chef/desktop-config/blob/main/docs-chef-io/|
| Chef Habitat |https://github.com/habitat-sh/habitat/tree/main/components/docs-chef-io|
| Chef Infra Client |https://github.com/chef/chef-web-docs|
| Chef Infra Server |https://github.com/chef/chef-server/tree/main/docs-chef-io|
| Chef Inspec| https://github.com/inspec/inspec/tree/main/docs-chef-io|
| Chef Inspec AliCloud Resource Pack | https://github.com/inspec/inspec-alicloud/tree/main/docs-chef-io|
| Chef InSpec AWS Resource Pack| https://github.com/inspec/inspec-aws/tree/main/docs-chef-io|
| Chef Inspec Azure Resource Pack| https://github.com/inspec/inspec-azure/tree/main/docs-chef-io|
| Chef InSpec Habitat Resource Pack | https://github.com/inspec/inspec-habitat/tree/main/docs-chef-io|
| Chef Supermarket | https://github.com/chef/supermarket/tree/main/docs-chef-io |
| Chef Workstation| https://github.com/chef/chef-workstation/tree/main/docs-chef-io|
| Effortless Pattern |https://github.com/chef/effortless/tree/main/docs-chef-io|
<!-- markdownlint-enable -->
