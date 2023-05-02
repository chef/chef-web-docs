+++
title = "Markdown Guide"
draft = false
aliases = ["/style_markdown"]
gh_repo = "chef-web-docs"

[menu]
  [menu.overview]
    title = "Markdown"
    identifier = "overview/style/formatting/style_markdown"
    parent = "overview/style/formatting"
    weight = 120
+++
<!-- markdownlint-disable-file MD002 MD013 MD014 -->

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
