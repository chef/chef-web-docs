+++
title = "Markdown Guide"
draft = false
aliases = ["/style_markdown"]
gh_repo = "chef-web-docs"

[menu]
  [menu.overview]
    title = "Markdown"
    identifier = "overview/style/style_markdown"
    parent = "overview/style"
    weight = 120
+++
<!-- markdownlint-disable-file MD002 MD013 MD014 -->

## Section Headings

The following sections describe the section heading pattern that Chef is using for topic titles, H1s, H2s, H3s and H4s.

As a general rule, limit the number of heading levels to no more than two within a topic. There can be exceptions, especially if the document is large, but remember that HTML TOC structures usually have width limitations (on the display side) and the more structure within a TOC, the harder it can be for users to figure out what is in it.

Unless the topics are about installing things or about API endpoints, the headings should never wrap. Keep them to a single line.

The width of heading adornment must be at least equal to the length of the text in the heading and the same width for headings is used everywhere. Consistent width is preferred.

### H1

The H1 heading is reserved for the page title which is created by the Hugo page template. The Markdown file text should not have any H1 headings.

### H2

Use two hash characters (##) before the heading name to indicate H2 headings:

```text
## H2 Heading

This is the body.
```

### H3

Use three hash characters (###) before the heading name to indicate H3 headings:

```text
### H3 Heading

This is the body.
```

### H4

Use four hash characters (####) before the heading name to indicate H4 headings:

```text
#### H4 Heading

This is the paragraph.
```

### Other Headings

If you need more than four heading levels, use bold emphasis and then white space to make the heading text stand out and separate the heading from the content:

```text
**heading name goes here**        # bold emphasis
                                  # blank line
content, as normally authored.
```

## Lists

The following sections describe conventions for lists in Chef docs.

### Bulleted Lists

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

### Numbered Lists

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

### Definition Lists

Use a definition list to define a term, including CLI commands, command flags, parameters, and properties.

You can include more than definition for a term and more than one paragraph for a definition. Each definition should have a `:` at the beginning of the line of text, a space, and then the definition text. Additional paragraphs just need to be indented by two spaces. See the example below:

<!-- markdownlint-disable MD040 -->
```
term
: Term definition.

another term
: Another term definition.

  You can include multiple paragraphs in a definition if you need to.

: And you can include more than one definition for a term by starting another line with a colon.

: In est sit exercitation pariatur commodo sunt tempor mollit cillum magna et. Irure tempor cillum cupidatat sint velit veniam reprehenderit non et reprehenderit duis. Dolor magna aute dolore in sint eu fugiat irure laborum ea quis ipsum esse duis.
```
<!-- markdownlint-enable MD040 -->

The example above produces the following output:

term
: Term definition.

another term
: Another term definition.

  You can include multiple paragraphs in a definition if you need to.

: And you can include more than one definition for a term by starting another line with a colon.

: In est sit exercitation pariatur commodo sunt tempor mollit cillum magna et. Irure tempor cillum cupidatat sint velit veniam reprehenderit non et reprehenderit duis. Dolor magna aute dolore in sint eu fugiat irure laborum ea quis ipsum esse duis.

## Tables

Create tables in Markdown like this:

<!-- markdownlint-disable MD040 -->
```
Chef Software | Description
--------|------
Chef Infra Client | Awesome
Chef Infra Server | Fun
Chef Habitat | Super cool
```
<!-- markdownlint-enable MD040 -->

Use three or more hyphens (---) to separate each column's header from the content of the table. Separate columns with a vertical bar or pipe (|).

{{< note >}}

Use tables for displaying data. Don't use tables for defining CLI commands, properties, parameters, or other terms. Use a [definition list](#definition-lists) to define terms.

{{< /note >}}

## Inline Markup

Adding emphasis within text strings can be done using **bold** and
`code strings`.

### Bold

Use two asterisks (\*) to mark a text string as **bold**:

```text
**text goes here**
```

### Code Strings

Sometimes the name of a method or database field needs to be used inline
in a paragraph. Use **one** back quote to mark certain strings as `code`
within a regular string of text:

`code goes here`

## Links

To make a link in Markdown put the page title in square brackets followed by the link in parentheses. For example this:

`[Ruby Programming Language](https://www.ruby-lang.org/)`

will produce this:

[Ruby Programming Language](https://www.ruby-lang.org/)

External links requires an HTTP address.

### relref Links

We recommend using Hugo's built-in [relref shortcode](https://gohugo.io/content-management/shortcodes/#ref-and-relref) for making relative links to other pages in the documentation. The site build will fail if a link is made to a page that does not exist. This ensures that we catch bad links if a page is deleted but a link to that page is not removed.

#### Examples

Link to pages:

- `[link text]({{</* relref "some_page" */>}})`
- `[link text]({{</* relref "section/some_page" */>}})`

Link to headings:

- `[link text]({{</* relref "#heading_on_this_page" */>}})`.
- `[link text]({{</* relref "some_page#heading_on_other_page" */>}})`.
- `[link text]({{</* relref "section/some_page#heading_on_other_page" */>}})`.

## Code Blocks

Code blocks are used to show code samples, such as those for Ruby, JSON,
and command-line strings.

### Ruby

Use this approach to show code blocks that use Ruby:

```ruby
default['apache']['dir']          = '/etc/apache2'
default['apache']['listen_ports'] = [ '80', '443' ]
```

### Bash

Use this approach to show code blocks that use any type of shell command, such as for Knife or the Chef Infra Client or for any other command-line example that may be required:

```bash
knife data bag create admins
```

### JavaScript (and JSON)

Use this approach to show code blocks that use any type of JavaScript, including any JSON code sample:

```javascript
{
  "id": "charlie",
  "uid": 1005,
  "gid":"ops",
  "shell":"/bin/zsh",
  "comment":"Crazy Charlie"
}
```

### Literal

Literals should be used sparingly, but sometimes there is a need for a block of text that does not work in a fenced code block, such as showing a directory structure, basic syntax, or pseudocode. To make a literal code block, indent the text by **four** spaces:

<!-- markdownlint-disable MD040 -->
```
    A block of literal text indented four spaces
    with more
    text as required to
    complete the block of text.

```
<!-- markdownlint-enable MD040 -->

## Images

You have two options for formatting images in Hugo:

- Markdown syntax
- the `figure` shortcode

### Markdown Syntax

To add an image in Markdown, use an exclamation point, square brackets around the alt text, parenthesis around the path to the image file starting in the `static` directory, and then optional hover text. For example:

```md
![Alt Text](/path/to/img.png "Optional Title")
```

### Figure Shortcode

The [figure shortcode](https://gohugo.io/content-management/shortcodes/#figure) allows you to specify the image size and include a title, a caption, and alternate text.

SVG images should be formatted using the `figure` shortcode.

```md
{{</* figure src="/images/chef-logo.svg" title="Chef Logo" height="100" width="150" */>}}
```

Which looks like this:

{{< figure src="/images/chef-logo.svg" title="Chef Logo" height="100" width="150">}}

Raster images should be 96 dpi and no larger than 600 pixels wide. This helps ensure that the image can be printed and/or built into other output formats; in some cases, separate 300 dpi files should be maintained for images that require inclusion in formats designed for printing and/or presentations.

## Markdownlint

We use [Markdownlint](https://github.com/DavidAnson/markdownlint) in a [GitHub action](https://github.com/DavidAnson/markdownlint-cli2-action) to lint the
Markdown in each pull request. See the [Markdownlint](https://github.com/DavidAnson/markdownlint) repository for information about the different Markdown
rules that the linter will check for.

If necessary, you can enable or disable Markdownlint for a line, section of a page, or an entire page. See the [Markdownlint documentation](https://github.com/DavidAnson/markdownlint#configuration) for additional information.
