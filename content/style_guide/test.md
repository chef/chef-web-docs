+++
title = "Test Page"
draft = false
robots = "noindex"

+++

This page is a "smoke test" document that we can use to test HTML, CSS, and template
changes that affect the overall documentation.

## H2

The above heading is an H2. The page title renders as an H1. The following
sections show H3-H6.

### H3

This is in an H3 section.

#### H4

This is in an H4 section.

##### H5

This is in an H5 section.

Note that H5 and H6 sections aren't included in the table of contents.

###### H6

This is in an H6 section.

<!-- markdownlint-disable MD036 -->

**Bold**

<!-- markdownlint-enable MD036 -->

This is in an bolded section.

## Inline Elements

Inline elements show up within the text of paragraph, list item, admonition, or
other block-level element.

<!-- /* cSpell:disable */ -->

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.

<!-- /* cSpell:enable */ -->

### Inline Text Styles

<!-- markdownlint-disable MD033 -->

- **bold**
- _italic_
- _**bold italic**_
- ~~strikethrough~~
- <u>underline</u>
- _<u>underline italic</u>_
- **<u>underline bold</u>**
- _**<u>underline bold italic</u>**_
- `monospace text`
- **`monospace bold`**

<!-- markdownlint-enable MD033 -->

## readfile Shortcode

Use the `readfile` shortcode to add files to a page. This could be Markdown text or a code sample.

{{< readfile file="data/test/test.json" highlight="json" >}}

## Lists

Markdown doesn't have strict rules about how to process lists. These are things to keep in
mind:

- To end a list and start another, you need a HTML comment block on a new line
  between the lists, flush with the left-hand border. The first list won't end
  otherwise, no matter how many blank lines you put between it and the second.

### Bullet Lists

Indent unordered sub-list items **2 spaces**.

- This is a list item
- This is another list item in the same list
  - To make a sub-item, indent two spaces.
    - This is a sub-sub-item. Indent two more spaces.
  - Another sub-item.

<!-- separate lists -->

- This is a new list. With Hugo, you need to use a HTML comment to separate two
  consecutive lists. **The HTML comment needs to be at the left margin.**
- Bullet lists can have paragraphs or block elements within them.

  Indent the content to be the same as the first line of the bullet point.
  **This paragraph and the code block line up with the first `B` in `Bullet`
  above.**

  ```bash
  ls -l
  ```

  - And a sub-list after some block-level content

### Ordered Lists

Indent ordered sub-list items **3 spaces**.

1. This is a list item
2. This is another list item in the same list. The number you use in Markdown
   does not necessarily correlate to the number in the final output. By
   convention, we keep them in sync.
3. {{< note >}}
   For single-digit numbered lists, using two spaces after the period makes
   interior block-level content line up better along tab-stops.
   {{< /note >}}

<!-- separate lists -->

1. This is a new list. With Hugo, you need to use a HTML comment to separate
   two consecutive lists. **The HTML comment needs to be at the left margin.**
2. Numbered lists can have paragraphs or block elements within them.

   Indent the content to be the same as the first line of the bullet
   point. **This paragraph and the code block line up with the `N` in
   `Numbered` above.**

   ```bash
   ls -l
   ```

   - And a sub-list after some block-level content. This is at the same
     "level" as the paragraph and code block above, despite being indented
     more.

### Description List

Use description lists to define things like commands, command flags, options, or other terms. For example:

<!-- /* cSpell:disable */ -->

plain text _(term in italics)_
: Ex quis duis deserunt commodo.

`code` _(`code` in italics **and bolded text in italics**)_ **and regular bolded text**
: Reprehenderit eu ex dolore sunt reprehenderit ut consequat amet Lorem pariatur Lorem anim.

term
: Term definition.

[another term](@)
: Another term definition.

  You can include multiple paragraphs in a definition if you need to.

: You can include more than one definition for a term by starting another line with a colon.

: Adding square brackets and the `(@)` symbol around the term (`[another term](@)`) adds a linkable ID to the term.

<!-- /* cSpell:enable */ -->

### Checklists

Checklists are technically bullet lists, but the bullets are suppressed by CSS.

- [ ] This is a checklist item
- [x] This is a selected checklist item

### Tab Panels

<!-- markdownlint-disable MD031 -->

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

<!-- markdownlint-enable MD031 -->

## Code Blocks

You can create code blocks two different ways by surrounding the code block with
three back-tick characters on lines before and after the code block. **Only use
back-ticks (code fences) for code blocks.** This allows you to specify the
language of the enclosed code, which enables syntax highlighting. It is also more
predictable than using indentation.

```bash
ls -l
```

## Links

To format a link, put the link text inside square brackets, followed by the
link target in parentheses. [Link to chef.io](https://chef.io/) or
[Relative link to docs.chef.io](/)

<!-- markdownlint-disable MD033-->

You can also use HTML, but it is not preferred.
<a href="https://chef.io/">Link to chef.io</a>

## Images

To format an image, use similar syntax to [links](#links), but add a leading `!`
character. The square brackets contain the image's alt text. Try to always use
alt text so that people using screen readers can get some benefit from the
image. For example, `![Classic Chef logo](/images/chef-icon.png)` will produce this:

![Classic Chef logo](/images/chef-icon.png)

To specify extended attributes, such as width, title, caption, etc, use the
<a href="https://gohugo.io/content-management/shortcodes/#figure">figure shortcode</a>,
which is preferred to using a HTML `<img>` tag. Also, if you need the image to
also be a hyperlink, use the `link` attribute, rather than wrapping the whole
figure in Markdown link syntax as shown below.

For example, this will add the Chef icon with title, caption, and a width of 200 pixels:

``` md
{{</* figure src="/images/chef-icon.png" title="Classic Chef icon" caption="Image used to illustrate the figure shortcode" width="150px" */>}}
```

{{< figure src="/images/chef-icon.png" title="Classic Chef icon" caption="Image used to illustrate the figure shortcode" width="150px" >}}

Add the `figure-no-shadow` class to remove the drop shadow from around an image:

``` md
{{</* figure src="/images/chef-icon.png" class="figure-no-shadow" title="Classic Chef icon" width="150px" */>}}
```

{{< figure src="/images/chef-icon.png" class="figure-no-shadow" title="Classic Chef icon" width="150px" >}}

You can also use HTML for images, but we don't recommend it.

<img src="/images/chef-icon.png" alt="Classic Chef logo" />

<!-- markdownlint-enable MD033-->

## Tables

Simple tables have one row per line, and columns are separated by `|`
characters. The header is separated from the body by cells containing nothing
but at least three `-` characters. For ease of maintenance, try to keep all the
cell separators even, even if you heed to use extra space.

| Heading cell 1 | Heading cell 2          |
|----------------|-------------------------|
| Body cell 1    | Body cell 2 with `code` |

The header is optional. Any text separated by `|` will render as a table.

Markdown tables have a hard time with block-level elements within cells, such as
list items, code blocks, or multiple paragraphs. For complex or very wide
tables, use HTML instead.

<!-- markdownlint-disable MD033 -->

<table>
<thead>
  <tr>
    <th>Heading cell 1</th>
    <th>Heading cell 2</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Body cell 1</td>
    <td>Body cell with a note in it:
      {{< note spaces=6 >}}
        Some text in a note.
      {{< /note >}}
    </td>
  </tr>
  <tr class="even">
    <td><p><code>500</code></p></td>
    <td><p>Some text followed by a code sample:</p>
    <div class="sourceCode" id="cb1"><pre class="sourceCode javascript"><code class="sourceCode javascript"><span id="cb1-1"><a href="#cb1-1"></a><span class="op">{</span></span>
    <span id="cb1-2"><a href="#cb1-2"></a>  <span class="st">&quot;status&quot;</span><span class="op">:</span><span class="st">&quot;fail&quot;</span><span class="op">,</span></span>
    <span id="cb1-3"><a href="#cb1-3"></a>  <span class="st">&quot;upstreams&quot;</span><span class="op">:</span></span>
    <span id="cb1-4"><a href="#cb1-4"></a>    <span class="op">{</span></span>
    <span id="cb1-5"><a href="#cb1-5"></a>      <span class="st">&quot;service_name&quot;</span><span class="op">:</span> <span class="st">&quot;fail&quot;</span><span class="op">,</span></span>
    <span id="cb1-6"><a href="#cb1-6"></a>      <span class="st">&quot;service_name&quot;</span><span class="op">:</span> <span class="st">&quot;pong&quot;</span><span class="op">,</span></span>
    <span id="cb1-7"><a href="#cb1-7"></a>      ...</span>
    <span id="cb1-8"><a href="#cb1-8"></a>    <span class="op">}</span></span>
    <span id="cb1-9"><a href="#cb1-9"></a><span class="op">}</span></span></code></pre></div></td>
    </tr>
    <tr class="even">
    <td><p><code>client_rb</code></p></td>
    <td><p>More text, another code sample:</p>
    <div class="sourceCode" id="cb1"><pre class="sourceCode yaml"><code class="sourceCode yaml"><span id="cb1-1"><a href="#cb1-1"></a><span class="fu">client_rb</span><span class="kw">:</span></span>
    <span id="cb1-2"><a href="#cb1-2"></a><span class="at">  </span><span class="fu">log_level</span><span class="kw">:</span><span class="at"> :warn</span></span></code></pre></div></td>
  </tr>
</tbody>
</table>

<!-- markdownlint-enable MD033 -->

## Blockquotes and Admonitions

Sidebars and admonitions provide ways to add visual importance to text. Use
them sparingly.

### Blockquote

A blockquote offsets text visually, but without the visual prominence of
[admonitions](#admonitions).

> This is a blockquote.
>
> Use a blockquote to quote extended blocks of text.
>
> You can even have code blocks.
>
> ```bash
> sudo dmesg
> ```
>

### Admonitions

Admonitions (notes, warnings, etc) use Hugo shortcodes.

{{< note >}}
Notes catch the reader's attention without a sense of urgency.

You can have multiple paragraphs and block-level elements inside an admonition.

| Or | a | table |
|----|----|----|
|Like| this | one |

{{< /note >}}

{{< warning >}}
Warnings point out something that could cause harm if ignored.
{{< /warning >}}

{{< danger >}}
The reader should proceed with caution.
{{< /danger >}}

## SVG Shortcode

The SVG shortcode will add an inline SVG icon to a string of text:

Click on the web asset icon ({{< svg file="themes/docs-new/static/images/web-asset.svg" >}}).
