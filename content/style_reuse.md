+++
title = "Shortcodes"
draft = false

gh_repo = "chef-web-docs"
product = []

[menu]
  [menu.docs]
    title = "Content Reuse and Shortcodes Guide"
    identifier = "overview/style/style_reuse.md "
    parent = "overview/style"
    weight = 130
+++

## Repeating Text Blocks

Chef docs uses [shortcodes](https://gohugo.io/content-management/shortcodes/) to maintain reusable content, which is text that appears in more than one location and must be consistent in every location.

### Writing a shortcode

All shortcode files are written in **Markdown** and stored in the `layouts/shortcodes` directory in the `chef-web-docs` repo.

### Adding a Shortcode to a Page

To include a shortcode in a Markdown file, wrap the name of the shortcode file, without the file type suffix, in double curly braces and percent characters. For example, if you wanted to add the `chef.md` shortcode to a page, add the following text to the Markdown page:

```
{{%/* chef */%}}
```
