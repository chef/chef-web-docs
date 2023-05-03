+++
title = "Section Headings"
draft = false
gh_repo = "chef-web-docs"

[menu]
  [menu.overview]
    title = "Headings"
    identifier = "overview/style/formatting/headings"
    parent = "overview/style/formatting"
+++

The following sections describe the section heading pattern that Chef is using for topic titles, H1s, H2s, H3s and H4s.

As a general rule, limit the number of heading levels to no more than two within a topic. There can be exceptions, especially if the document is large, but remember that HTML TOC structures usually have width limitations (on the display side) and the more structure within a TOC, the harder it can be for users to figure out what is in it.

Unless the topics are about installing things or about API endpoints, the headings should never wrap. Keep them to a single line.

The width of heading adornment must be at least equal to the length of the text in the heading and the same width for headings is used everywhere. Consistent width is preferred.

{{< note >}}

Don't use headings to define CLI commands, properties, parameters, or other terms. Use a [definition list]({{< relref "lists#definition-lists" >}}) to define terms.

{{< /note >}}

## H1

The H1 heading is reserved for the page title which is created by the Hugo page template. The Markdown file text should not have any H1 headings.

## H2

Use two hash characters (##) before the heading name to indicate H2 headings:

```text
## H2 Heading

This is the body.
```

## H3

Use three hash characters (###) before the heading name to indicate H3 headings:

```text
### H3 Heading

This is the body.
```

## H4

Use four hash characters (####) before the heading name to indicate H4 headings:

```text
#### H4 Heading

This is the paragraph.
```

## Other headings

If you need more than four heading levels, use bold emphasis and then white space to make the heading text stand out and separate the heading from the content:

```text
**heading name goes here**        # bold emphasis
                                  # blank line
content, as normally authored.
```
