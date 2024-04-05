+++
title = "Hugo shortcodes"
draft = false
gh_repo = "chef-web-docs"

[menu]
  [menu.overview]
    title = "Shortcodes"
    identifier = "overview/style/hugo/shortcodes"
    parent = "overview/style/hugo"
    weight = 30
+++

This page describes shortcodes that we use in Chef documentation.

[Shortcodes](https://gohugo.io/content-management/shortcodes/) add short snippets of Hugo code, Markdown, or HTML to a page.
For example, the `readfile` shortcode can add a text file to a page, the `note` shortcode puts text inside an HTML div, and the [automate_cli_commands shortcode](https://github.com/chef/automate/blob/main/components/docs-chef-io/layouts/shortcodes/automate/automate_cli_commands.html) reads through YAML files and outputs formatted text from those files.

## Notices

Note, warning, and danger notice boxes have a different color than the surrounding text so they can be spotted within a document.
If you must use a note or warning, bracket the text of the note or warning in a **note**, **warning**, or **danger** shortcode.

See the [notices guidelines]({{< relref "notices" >}}) for usage recommendations.

### Notes

Add a note using the note shortcode:

```md
{{</* note */>}}

This is the text of a note.

{{</* /note */>}}
```

### Warnings

Add a warning using the warning shortcode.

```md
{{</* warning */>}}

This is text in a warning.

{{</* /warning */>}}
```

### Danger

Add a danger notice using the danger shortcode.

```md
{{</* danger */>}}

This is text in a warning.

{{</* /danger */>}}
```

## `figure` shortcode

Use the figure shortcode to add images to a page.

Basic example:

```md
{{</* figure src="path/to/image" */>}}
```

`figure` accepts the following parameters:

`src`
: The path to the image file. Required.

`link`
: An HTML link. Optional

`target`
: The target attribute for a link. Optional.

`alt`
: Alt text for an image.

`title`
: Image title. Optional.

`caption`
: An image caption. Optional.

`class`
: A class to add to an image. Optional.

`height`
: The image height. Optional.

`width`
: The image width. Optional.

## `fontawesome` shortcode

{{< readfile file="content/style/reusable/md/fontawesome_shortcode.md" >}}

## Foundation tabs container

You can combine four shortcodes to create a tabbed container that allows users to click on a tab to reveal content in a matching panel.
For example, you may want to display matching Ruby and YAML code blocks.
You can create two tabs, one titled **Ruby** and the other **YAML**, and the user can click on one tab to show
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

Each tab is created with a `foundation_tab` shortcode.
Use as many `foundation_tab` shortcodes as you need to display the number of code blocks or text blocks that you want the user to be able to click on and reveal.

All `foundation_tab` shortcodes must be contained within opening and closing `foundation_tabs` shortcodes.

For example:

```md
{{</* foundation_tabs tabs-id="ruby-python-panel" */>}}
  {{</* foundation_tab active="true" panel-link="ruby-panel" tab-text="Ruby" */>}}
  {{</* foundation_tab panel-link="python-panel" tab-text="Python" */>}}
{{</* /foundation_tabs */>}}
```

#### Tab parameters

The **`foundation_tabs`** shortcode has one parameter:

`tabs-id`
: This value must be identical to the `tabs-id` value in the `foundation_tabs_panels`
  shortcode, but otherwise it must be a unique HTML ID on the page.

The **`foundation_tab`** shortcode has three parameters:

`active`

: Use `active="true"` to highlight the tab that the user will see when they first load the page.
  Only add this value to one tab. The matching `foundation_tabs_panel` should also have `active="true"` in its parameters.

`panel-link`
: This is the value of the panel ID that this tab will link to.
  This must be identical to the `panel-id` value in the matching `foundation_tabs_panel` shortcode.

`tab-text`
: The text in the tab that the user will click on.

### Panels

Each tab has a matching panel which is created with `foundation_tabs_panel` shortcodes.
The Markdown text that's displayed in each panel must be contained in opening and
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

#### Panel parameters

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
: The HTML ID attribute of the panel.
  This value must be identical to the `panel-link` value in the matching `foundation_tab` shortcode that will link to this panel.
  This value must be a unique HTML ID on the page.

### Example

Below is an example of a container that shows three code blocks in three languages.
You can copy and paste the code below into a page to get started. Note that the `tabs-id`
and `panel-id`/`panel-link` values must be unique HTML IDs on the page.

<!-- markdownlint-disable MD046 MD032 -->

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

<!-- markdownlint-enable MD046 MD032 -->

## `highlight` shortcode

You can add code examples using the `highlight` shortcode.

For example, this:

<!-- markdownlint-disable MD046 -->

    {{</* highlight ruby */>}}
    puts 'Hello, world!'
    {{</* /highlight */>}}

<!-- markdownlint-enable MD046 -->

produces:

{{< highlight ruby >}}
puts 'Hello, world!'
{{< / highlight >}}


## `readfile` shortcode

The `readfile` shortcode adds text from a file to a page. You can add a Markdown file, HTML file, or code file by specifying the path to the file from the project root directory.

By default, it accepts a Markdown file:

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

## `relref` shortcode

We recommend using Hugo's built-in [relref shortcode](https://gohugo.io/content-management/shortcodes/#ref-and-relref) for making relative links to other pages in Chef's documentation.
If a link is made to a page that doesn't exist, the site build will fail when Hugo generates a preview of the site.
This will help us prevent dead links in our own documentation if a page is moved or deleted.

To format link to pages:

- `[link text]({{</* relref "some_page" */>}})`
- `[link text]({{</* relref "section/some_page" */>}})`

To format links to headings:

- `[link text]({{</* relref "#heading_on_this_page" */>}})`
- `[link text]({{</* relref "some_page#heading_on_other_page" */>}})`
- `[link text]({{</* relref "section/some_page#heading_on_other_page" */>}})`

{{< note >}}

`relref` doesn't validate links to headings, only page links. Double-check your headings when adding or updating heading links.

{{< /note >}}

## `svg` shortcode

The svg shortcode will add an inline SVG icon to a string of text.

The svg shortcode takes one parameter, `file`, which is the file path to the SVG file.

For example:

```md
Click on the web asset icon ({{</* svg file="/static/images/web-asset.svg" */>}}).
```

produces:

Click on the web asset icon ({{< svg file="/static/images/web-asset.svg" >}}).

## Create a new shortcode

Shortcode files are written in Markdown or HTML and are stored in [`layouts/shortcodes`](https://github.com/chef/chef-web-docs/tree/main/layouts/shortcodes) or [`themes/docs-new/layouts/shortcodes`](https://github.com/chef/chef-web-docs/tree/main/themes/docs-new/layouts/shortcodes) in the `chef/chef-web-docs` repository.

In repositories other than chef-web-docs, store shortcodes in `layouts/shortcodes/REPOSITORY_NAME/`.

### Add a shortcode to a page

The two types of shortcodes are Markdown and HTML. The shortcode type determines how it's added to a page and how Hugo processes the text when it renders the page into HTML.

{{< note >}}
If you add a Markdown shortcode to a page using HTML shortcode delimiters, Hugo will assume that the text is already formatted in HTML and won't run the shortcode file through its Markdown processor, leaving the bare Markdown in the HTML page output.
{{< /note >}}

#### Markdown shortcodes

A Markdown shortcode must be processed into HTML when Hugo builds the site.

To include a Markdown shortcode in a page, wrap the name of the shortcode file, without the file type suffix, in between double curly braces and percent characters, `{{%/* SHORTCODE */%}}`. For example, if you wanted to add the [`chef.md`](https://github.com/chef/chef-web-docs/blob/main/layouts/shortcodes/chef.md) shortcode to a page, add the following text to the Markdown page:

```markdown
{{%/* chef */%}}
```

For shortcodes located in a repository other than chef-web-docs, use `{{%/* REPO_NAME/SHORTCODE */%}}`. For example:

```markdown
{{%/* chef-workstation/bento */%}}
```

#### HTML shortcodes

To include an HTML shortcode in a page, wrap the name of the shortcode file, without the file type suffix, in between double curly braces and angle brackets, `{{</* SHORTCODE */>}}`. For example, add the following text to a page if you want to add the [`chef_automate_mark.html`](https://github.com/chef/chef-web-docs/blob/main/themes/docs-new/layouts/shortcodes/chef_automate_mark.html) shortcode:

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

### Nested content

Some shortcodes nest around Markdown text. Those shortcodes are closed with a forward slash `/` before the name of the closing shortcode. For example:

```md
{{</* shortcode_name */>}}

Some Markdown text.

{{</* /shortcode_name */>}}
```

See the [Notes and Warnings](#notes-warnings-and-admonitions) and the [Foundation Tabs](#foundation-tabs-container) for examples of nested shortcodes.
