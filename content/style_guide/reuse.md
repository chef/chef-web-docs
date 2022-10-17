+++
title = "Content Reuse and Hugo Shortcodes"
draft = false
aliases = ["/style_reuse"]
gh_repo = "chef-web-docs"
product = []

[menu]
  [menu.overview]
    title = "Content Reuse and Shortcodes Guide"
    identifier = "overview/style/style_reuse"
    parent = "overview/style"
    weight = 130
+++
<!-- markdownlint-disable-file MD013 MD031 -->

## readfile Shortcode

The readfile shortcode adds text from a file to a page. You can add a Markdown file, HTML file, or code file by specifying the path to the file from the project root directory.

By default it accepts a Markdown file, for example:

```markdown
{{</* readfile file="layouts/shortcodes/example.md" */>}}
```

You can also add an HTML file:

```markdown
{{</* readfile file="layouts/shortcodes/example.html" html="true" */>}}
```

And you can pass in a sample code file:

```markdown
{{</* readfile file="path/to/file/example.rb" highlight="ruby" */>}}
```

or:

```markdown
{{</* readfile file="path/to/data/file.json" highlight="json" */>}}
```

## Notes, Warnings, and Admonitions

In general, notes, warnings, and admonitions are not the best way to present important information. Before using them, ask yourself how important the
information is. If you want the information to be returned in a search
result, then it is better for the information to have its own topic or
section heading. Notes and warnings have a different color than the surrounding text so they can be spotted within a document.
If you must use notes and warnings, bracket the text of the note or warning in **note**, **warning**, or **danger** shortcodes.

### Notes

```go
{{</* note */>}}

This is a note.

{{</* /note */>}}
```

What a note looks like after it is built:

{{< note >}}

This is a note.

{{< /note >}}

### Warnings

Use sparingly so that when the user sees a warning it registers appropriately:

```go
{{</* warning */>}}

This is a warning.

{{</* /warning */>}}
```

What a warning looks like after it is built:

{{< warning >}}

This is a warning.

{{< /warning >}}

### Danger

Danger should be used when there are serious consequences for the user:

```go
{{</* danger */>}}

This is a danger block.

{{</* /danger */>}}
```

This is what a danger block looks like after it is built:

{{< danger >}}

This is a danger block.

{{< /danger >}}

## Foundation Tabs Container

There are four shortcodes that can be combined together to create a container that will allow
the user to click on a tab to reveal content in a matching panel. For example, you
may want to display matching Ruby and YAML code blocks. You can create two tabs,
one titled **Ruby** and the other **YAML**, and the user could click on one tab to show
the Ruby code block and another tab to show the YAML code block. See the [example](#example)
below.

The four shortcodes are:

- `foundation_tabs`
- `foundation_tab`
- `foundation_tabs_panels`
- `foundation_tabs_panel`

These shortcodes use the [Zurb Foundation Tabs](https://get.foundation/sites/docs/tabs.html) component.

The container consists of two parts, the tabs and the panels.

### Tabs

Each tab is created with a `foundation_tab` shortcode. Use as many `foundation_tab`
shortcodes as you need to display the number of code blocks or text blocks that
you want the user to be able click on and reveal.

All `foundation_tab` shortcodes must be contained within opening and closing `foundation_tabs` shortcodes.

For example:

```go
{{</* foundation_tabs tabs-id="ruby-python-panel" */>}}
  {{</* foundation_tab active="true" panel-link="ruby-panel" tab-text="Ruby" */>}}
  {{</* foundation_tab panel-link="python-panel" tab-text="Python" */>}}
{{</* /foundation_tabs */>}}
```

#### Tab Parameters

The **`foundation_tabs`** shortcode has one parameter:

`tabs-id`
: This value must be identical to the `tabs-id` value in the `foundation_tabs_panels`
  shortcode, but otherwise it must be a unique HTML ID on the page.

The **`foundation_tab`** shortcode has three parameters:

`active`

: Use `active="true"` to highlight the tab that user will see when they first load
the page. Only add this value to one tab. The matching `foundation_tabs_panel`
should also have `active="true"` in its parameters.

`panel-link`
: This is the value of the panel ID that this tab will link to. This must be identical to
  the `panel-id` value in the matching `foundation_tabs_panel` shortcode.

`tab-text`
: The text in the tab that the user will click on.

### Panels

Each tab has a matching panel which is created with `foundation_tabs_panel` shortcodes.
The Markdown text that is displayed in each panel must be contained in opening and
closing `foundation_tabs_panel` shortcodes.

All `foundation_tab_panel` shortcodes must contained within opening and closing
`foundation_tabs_panels` shortcodes.

For example:

<!-- markdownlint-disable MD046 -->
    {{</* foundation_tabs_panels tabs-id="ruby-python-panel" */>}}
      {{</* foundation_tabs_panel active="true" panel-id="ruby-panel" */>}}
      ```ruby
      puts 'Hello, world!'
      ```
      {{</* /foundation_tabs_panel */>}}

      {{</* foundation_tabs_panel panel-id="python-panel" */>}}
      ```python
      print('Hello, world!')
      ```
      {{</* /foundation_tabs_panel */>}}
    {{</* /foundation_tabs_panels */>}}
<!-- markdownlint-enable MD046 -->

#### Panel Parameters

The **`foundation_tabs_panels`** shortcode has one parameter:

`tabs-id`
: This value must be identical to the `tabs-id` value in the `foundation_tabs`
  shortcode, but otherwise it must be a unique HTML ID on the page.

The **`foundation_tabs_panel`** shortcode has two parameters:

`active`
: Use `active="true"` to indicate which panel the user will see when they first
  load the page. This value should also be added to the panels matching tab. Only
  add this value to one panel.

`panel-id`
: The HTML ID attribute of the panel. This value must be identical to the `panel-link` value
  in the matching `foundation_tab` shortcode that will link to this panel. This
  value must be unique HTML ID on the page.

### Example

Below is an example of a container that shows three code blocks in three languages.
You can copy and paste the code below into a page to get started. Note that the `tabs-id`
and `panel-id`/`panel-link` values must be unique HTML IDs on the page.

<!-- markdownlint-disable MD046 -->

{{< foundation_tabs tabs-id="ruby-python-go-panel" >}}
  {{< foundation_tab active="true" panel-link="ruby-panel" tab-text="Ruby">}}
  {{< foundation_tab panel-link="python-panel" tab-text="Python" >}}
  {{< foundation_tab panel-link="golang-panel" tab-text="Go" >}}
{{< /foundation_tabs >}}

{{< foundation_tabs_panels tabs-id="ruby-python-go-panel" >}}
  {{< foundation_tabs_panel active="true" panel-id="ruby-panel" >}}
  ```ruby
  puts 'Hello, world!'
  ```
  {{< /foundation_tabs_panel >}}

  {{< foundation_tabs_panel panel-id="python-panel" >}}
  ```python
  print('Hello, world!')
  ```
  {{< /foundation_tabs_panel >}}
  {{< foundation_tabs_panel panel-id="golang-panel" >}}
  ```go
  package main

  import "fmt"

  func main() {
      fmt.Println("Hello, world!")
  }
  ```
  {{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}

    {{</* foundation_tabs tabs-id="ruby-python-go-panel" */>}}
      {{</* foundation_tab active="true" panel-link="ruby-panel" tab-text="Ruby"*/>}}
      {{</* foundation_tab panel-link="python-panel" tab-text="Python" */>}}
      {{</* foundation_tab panel-link="golang-panel" tab-text="Go" */>}}
    {{</* /foundation_tabs */>}}

    {{</* foundation_tabs_panels tabs-id="ruby-python-go-panel" */>}}
      {{</* foundation_tabs_panel active="true" panel-id="ruby-panel" */>}}
      ```ruby
      puts 'Hello, world!'
      ```
      {{</* /foundation_tabs_panel */>}}

      {{</* foundation_tabs_panel panel-id="python-panel" */>}}
      ```python
      print('Hello, world!')
      ```
      {{</* /foundation_tabs_panel */>}}
      {{</* foundation_tabs_panel panel-id="golang-panel" */>}}
      ```go
      package main

      import "fmt"

      func main() {
          fmt.Println("Hello, world!")
      }
      ```
      {{</* /foundation_tabs_panel */>}}
    {{</* /foundation_tabs_panels */>}}

<!-- markdownlint-enable MD046 -->

## Fontawesome Shortcode

The Fontawesome shortcode will display any free [Font Awesome icon](https://fontawesome.com/icons) in a page.

It accepts the following parameters:

- `background-color`
- `border`
- `border-radius`
- `class`
- `color`
- `font-size`
- `margin`
- `padding`

The only required parameter is `class`, which is the same as the class name of the icon.

The following shortcode examples will display these icons: {{< fontawesome class="fas fa-ellipsis-h">}} {{< fontawesome class="fas fa-anchor" font-size="3rem" border="2px dashed" padding="1px" border-radius="5px">}} {{< fontawesome class="fas fa-archive" color="#cc814b" margin="0 0 0 12px">}} {{< fontawesome class="far fa-address-book" background-color="DarkBlue" color="rgb(168, 218, 220)">}}

```markdown
{{</* fontawesome class="fas fa-ellipsis-h" */>}}
{{</* fontawesome class="fas fa-anchor" font-size="3rem" border="2px dashed" padding="1px" border-radius="5px" */>}}
{{</* fontawesome class="fas fa-archive" color="#cc814b" margin="0 0 0 12px"*/>}}
{{</* fontawesome class="far fa-address-book" background-color="DarkBlue" color="rgb(168, 218, 220)" */>}}
```

## Shortcodes

[Shortcodes](https://gohugo.io/content-management/shortcodes/) add short snippets of code or HTML to a page. For example, the readfile shortcode can add a text file to a page or the notes shortcode can add HTML to a page that places text in an HTML div.

### Writing a Shortcode

Shortcode files are written in **Markdown** or **HTML** and are stored in [`layouts/shortcodes`](https://github.com/chef/chef-web-docs/tree/main/layouts/shortcodes) or [`themes/docs-new/layouts/shortcodes`](https://github.com/chef/chef-web-docs/tree/main/themes/docs-new/layouts/shortcodes) in the `chef/chef-web-docs` repository.

In repositories other than chef-web-docs, store shortcodes in `layouts/shortcodes/REPOSITORY_NAME/`.

### Adding a Shortcode to a Page

There are two types of shortcodes, **Markdown** and **HTML**. The type of shortcode determines how it is added to a page and how Hugo processes the text when it renders the page into HTML.

{{< note >}}
If you add a **Markdown** shortcode to a page using **HTML** shortcode delimiters, Hugo will assume that the text is already formatted in HTML and will not run the shortcode file through its Markdown processor, leaving the bare Markdown in the HTML page output.
{{< /note >}}

#### Markdown Shortcodes

A Markdown shortcode must be processed into HTML by Hugo when the site is built.

To include a Markdown shortcode in a page, wrap the name of the shortcode file, without the file type suffix, in between double curly braces and percent characters, `{{%/* SHORTCODE */%}}`. For example, if you wanted to add the [`chef.md`](https://github.com/chef/chef-web-docs/blob/main/layouts/shortcodes/chef.md) shortcode to a page, add the following text to the Markdown page:

```markdown
{{%/* chef */%}}
```

For shortcodes located in a repository other than chef-web-docs, use `{{%/* REPO_NAME/SHORTCODE */%}}`. For example:

```markdown
{{%/* chef-workstation/bento */%}}
```

#### HTML Shortcodes

To include an HTML shortcode in a page, wrap the name of the shortcode file, without the file type suffix, in between double curly braces and angle brackets, `{{</* SHORTCODE */>}}`. For example, add the following text to a page if you wanted to add the [`chef_automate_mark.html`](https://github.com/chef/chef-web-docs/blob/main/themes/docs-new/layouts/shortcodes/chef_automate_mark.html) shortcode:

```markdown
{{</* chef_automate_mark */>}}
```

For shortcodes located in a repository other than chef-web-docs, use `{{</* REPO_NAME/SHORTCODE */>}}`. For example:

```markdown
{{</* automate/automate_cli_commands */>}}
```

### Parameters

Some shortcodes accept positioned or named parameters. For example, the `example_fqdn` shortcode requires a hostname, which is added like this: `{{</* example_fqdn "HOSTNAME" */>}}`, and produces the following output: `{{< example_fqdn "HOSTNAME" >}}`.

The [Fontawesome Shortcode](#fontawesome-shortcode) accepts named parameters. For example, it accepts a class value which is added like this: `{{</* fontawesome class="fas fa-ellipsis-h" */>}}`

See the [Fontawesome Shortcode](#fontawesome-shortcode) section for more examples.

### Nested Content

We have some shortcodes that nest around Markdown content that is included in the text of a page. Those shortcodes are all written in HTML. Note the slash `/` before the name of the closing shortcode.

```md
{{</* shortcode_name */>}}

Some Markdown text.

{{</* /shortcode_name */>}}
```

See the [Notes and Warnings](#notes-warnings-and-admonitions) and the [Foundation Tabs](#foundation-tabs-container) for examples of nested shortcodes.
