+++
title = "Chef Documentation style guide"
draft = false
gh_repo = "chef-web-docs"

[cascade]
  product = []

[menu]
  [menu.overview]
    title = "Overview"
    identifier = "overview/community/style/Docs Style"
    parent = "overview/community/style"
    weight = 10
+++

<!-- markdownlint-disable-file MD013 -->

This style guide provides a set of standards for writing clear and consistent developer documentation for all of Progress Chef's products.

Chef's documentation is open source and we follow a [docs as code](https://www.docslikecode.com/) methodology.
Any community member can make or suggest a documentation change through a pull request or issue in a documentation repository.

For additional guidance not covered in this style guide, refer to [Google's style guide](https://developers.google.com/style) and [Microsoft's style guide](https://learn.microsoft.com/en-us/style-guide/welcome/).

## Documentation repositories

Our main repository for [docs.chef.io](https://docs.chef.io) is [chef-web-docs](https://github.com/chef/chef-web-docs). This repo contains the files for Chef Infra Client and the Hugo files for our front-end theme, templates, and shortcodes. The Chef documentation is located in: `https://github.com/chef/chef-web-docs`

- The `chef-web-docs` repo contains a `content` directory which holds most the Markdown files in the doc set.
- The `static/images` directory stores the image files used in the docs.
- The `config.toml` tells Hugo how to build the navigation menus and contains other Hugo settings. Don't modify this file.
