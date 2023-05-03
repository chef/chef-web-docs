+++
title = "Content Reuse"
draft = false
aliases = ["/style_reuse"]
gh_repo = "chef-web-docs"

[menu]
  [menu.overview]
    title = "Content Reuse"
    identifier = "overview/style/hugo/style_reuse"
    parent = "overview/style/hugo"
    weight = 10
+++
<!-- markdownlint-disable-file MD013 MD031 -->

This page describes how to create reusable text files or code examples that can be added to multiple pages.

## Reusable text files

If there are sections of text or code examples that appear in more than one location in Chef's documentation, that text should be sourced from a single file.
Store these files in a [headless subdirectory named `reusable`](#reusable-directory) in the content directory and use the [readfile shortcode](#readfile-shortcode) to add the file text to a page.

## reusable directory

Store reusable files in a subdirectory called `reusable` in the `content` directory. For example, `content/server/reusable` or `content/workstation/reusable`.

Make the `reusable` directory a [headless bundle](https://gohugo.io/content-management/page-bundles/#headless-bundle) by adding an `index.md` file to the directory and add `headless = true` to the file's front matter. This directory must be a headless bundle because it prevents Hugo from publishing this directory and its contents on <https://docs.chef.io>.

See the [`content/reusable/index.md` file in chef-web-docs](https://raw.githubusercontent.com/chef/chef-web-docs/main/content/reusable/index.md) for an example of an `index.md` file that makes a headless bundle.

## Reusable file organization

Store reusable text files in subdirectories organized by file type.

For example:

- `content/server/reusable/md/FILENAME.md`
- `content/server/reusable/rb/RUBY_EXAMPLE.rb`
- `content/server/reusable/rb/GO_EXAMPLE.go`

## readfile shortcode

The readfile shortcode adds text from a file to a page. You can add a Markdown file, HTML file, or code file by specifying the path to the file from the project root directory.

By default it accepts a Markdown file:

```markdown
{{</* readfile file="content/workstation/reusable/md/example.md" */>}}
```

You can also add an HTML file:

```markdown
{{</* readfile file="content/workstation/reusable/html/example.html" html="true" */>}}
```

You can pass in a sample code file:

```markdown
{{</* readfile file="content/workstation/reusable/rb/example.rb" highlight="ruby" */>}}
```

or:

```markdown
{{</* readfile file="content/workstation/reusable/json/example.json" highlight="json" */>}}
```

See the [full list of highlighting languages and aliases](https://gohugo.io/content-management/syntax-highlighting/#list-of-chroma-highlighting-languages) that Hugo accepts.
