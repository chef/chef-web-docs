+++
title = "Lists"
draft = false
gh_repo = "chef-web-docs"

[menu]
  [menu.overview]
    title = "Lists"
    identifier = "overview/style/formatting/lists"
    parent = "overview/style/formatting"
+++


The following sections describe conventions for lists in Chef documentation.

## Markdown formatting

### Unordered lists

Bulleted lists break up text blocks and draw attention to a group of items:

```text
- text goes here
- text goes here

    - subitem text
    - subitem text

- text goes here
- text goes here
```

Use the dash symbol (-) for bulleted lists, even though Hugo supports other symbols. Indent nested list items by **four** spaces.

### Ordered Lists

Numbered lists are created like this:

```text
1. text goes here
1. text goes here
1. text goes here

    1. sub-list text
    1. sub-list text

1. text goes here
```

Start each ordered list item with the number 1 (1.). Hugo will generate the correct sequence of numbers in an ordered list regardless of the numbers that you use. Only using "1." will save you from having to re-number items if you add or remove an item later.

### Description Lists

Use a definition list to define terms, including CLI commands, command flags, parameters, and properties.

You can include more than definition for a term and more than one paragraph for a definition. Each definition should have a `:` at the beginning of the line of text, a space, and then the definition text. Additional paragraphs just need to be indented by two spaces. See the example below:

{{< note >}}

You can add a linkable ID to a definition list term by wrapping the term in brackets and adding `(@)` after the term. For example, `[term](@)`. In the example below, [another term](#another-term) has an ID.

{{< /note >}}

```md
term
: Term definition.

[another term](@)
: Another term definition.

  You can include multiple paragraphs in a definition if you need to.

: You can include more than one definition for a term by starting another line with a colon.

: Adding square brackets and the `(@)` symbol around the term (`[another term](@)`) add a linkable ID to the term.
```

The example above produces the following output:

term
: Term definition.

[another term](@)
: Another term definition.

  You can include multiple paragraphs in a definition if you need to.

: You can include more than one definition for a term by starting another line with a colon.

: Adding square brackets and the `(@)` symbol around the term (`[another term](@)`) adds a linkable ID to the term.
