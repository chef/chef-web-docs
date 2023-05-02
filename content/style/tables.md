+++
title = "Tables"
draft = false
gh_repo = "chef-web-docs"


[menu]
  [menu.overview]
    title = "Tables"
    identifier = "overview/style/formatting/tables"
    parent = "overview/style/formatting"
    weight = 80
+++

Create tables in Markdown like this:

<!-- markdownlint-disable MD040 -->
```
| Chef Software | Description |
| --------|------ |
| Chef Infra Client | Awesome |
| Chef Infra Server | Fun |
| Chef Habitat | Super cool |
```
<!-- markdownlint-enable MD040 -->

Use three or more hyphens (---) to separate each column's header from the content of the table. Separate columns with a vertical bar or pipe (|).

## Table vs list

Use tables for displaying data. Don't use tables for defining CLI commands, properties, parameters, or other terms. Use a [definition list]({{< relref "lists#definition-lists" >}}) to define terms.
