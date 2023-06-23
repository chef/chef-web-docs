+++
title = "Test Page"
draft = false
robots = "noindex"
product = []

+++

<!-- /* cSpell:disable */ -->
<!-- markdownlint-disable-file MD036 -->

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

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.

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

You can add a JSON file like this:

```md
{{</* readfile file="data/test/test.json" highlight="json" */>}}
```

which will produce this:

{{< readfile file="data/test/test.json" highlight="json" >}}

## Lists

Markdown doesn't have strict rules about how to process lists. These are things to keep in
mind:

- To end a list and start another, you need a HTML comment block on a new line
  between the lists, flush with the left-hand border. The first list won't end
  otherwise, no matter how many blank lines you put between it and the second.

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

This is some text that introduces an ordered list.

1. Testing multiple lines, nested ordered and unordered list items. Here's some code: `/etc/chef-backend/chef-backend-secrets.json` and more code `tmp/chef-backend-secrets.json`

1. Here's an ordered list item with a long code sample, a nested unordered list, and a nested ordered list.

    ```bash
    chef-backend-ctl join-cluster --accept-license --yes --quiet IP_OF_LEADER_NODE --publish_address IP_OF_FOLLOWER_NODE -s /tmp/chef-backend-secrets.json
    ```

    Replace:

    - `IP_OF_LEADER_NODE` with the IP address of the new leader node.
    - `IP_OF_FOLLOWER_NODE` with the IP address of the follower node.

    1. Another code example and it mentions a `chef-backend.rb` file.

        ```bash
        cp /etc/chef-backend/chef-backend.rb /tmp/chef-backend.rb
        chef-backend-ctl cleanse
        cp /tmp/chef-backend.rb /etc/chef-backend/chef-backend.rb
        ```

        Adding another list for testing:

        - item 1
        - item 2
        - code in item3 `chef-backend-ctl cleanse`

        1. another ordered list item
        1. Ea excepteur duis eiusmod duis laboris anim eiusmod. Est officia dolore veniam exercitation. Do cupidatat ea duis minim labore proident dolore sit dolore et. Elit Lorem aliqua incididunt sint.

    1. Retry joining the node to the cluster again using `chef-backend-ctl join-cluster` as described above.

1. Multiple paragraphs in a list item.

    ```bash
    chef-backend-ctl gen-server-config FQDN > /tmp/chef-server.rb
    ```

    Replace `FQDN` with the FQDN of your frontend node. For example, `chefserver.example.com`.

    Magna in ea nostrud aute ea incididunt eiusmod occaecat deserunt. Veniam in ipsum fugiat veniam adipisicing voluptate reprehenderit tempor pariatur dolore. Voluptate quis sunt commodo nisi aliquip minim eiusmod magna ea. Elit qui consectetur enim eu culpa do ex et culpa aliquip eiusmod. Officia irure cillum esse id aliquip cillum excepteur amet magna culpa culpa.

    1. Exercitation est non ipsum nostrud excepteur ullamco quis eu sit sint nulla ex. Velit excepteur sit deserunt occaecat duis ea laboris nisi occaecat quis dolor. Exercitation velit quis excepteur ut id ut duis enim sunt pariatur culpa occaecat sit magna.

    1. Est ut id proident eu exercitation ut ad irure consequat enim laboris amet. Reprehenderit velit laboris proident enim qui mollit velit aute adipisicing. Mollit est sit anim sunt nisi fugiat qui dolor est incididunt culpa dolore. Non sint culpa tempor excepteur officia non aliquip. Voluptate voluptate ea aliqua dolor cupidatat aute aute duis nisi irure.

       Ullamco proident ex nulla enim in anim. Enim laborum laboris laborum dolor aute officia sunt minim cillum. Irure consequat duis magna cupidatat eiusmod elit reprehenderit in laborum eiusmod minim cillum.

       - double nested item 1
       - double nested item 2
       - double nested item 3

    1. One more item. Culpa voluptate minim sunt velit officia mollit velit duis. Exercitation reprehenderit pariatur in aute id commodo id amet ea eiusmod. Ad quis aliquip enim irure ea magna ex. Eiusmod aliqua voluptate consequat consequat adipisicing consectetur veniam dolor.

    Introductory text:

    - nested item 1
    - nested item 2
    - nested item 3

    Velit incididunt sunt velit fugiat occaecat commodo do labore minim qui cupidatat anim non. Aliquip reprehenderit voluptate aute consectetur dolore dolor eu nisi dolore cupidatat exercitation. Ipsum ullamco quis enim enim ipsum.

### Unordered lists

**Plain list**

A plain unordered list:

- item 1
- item 2
- item 3

**Plain list with multiple paragraphs**

A plain unordered list with additional paragraphs in list items:

- item 1
- item 2

  A second paragraph in item 2
- item 3

  A second paragraph in item 3

  A long paragraph in item 3. Duis quis minim anim reprehenderit id in velit ut commodo deserunt Lorem qui aliqua. Sint duis dolore commodo et irure sunt. Labore ut reprehenderit excepteur eiusmod id ea dolore consectetur laborum sint magna. Qui aliqua consectetur tempor deserunt aliquip. Eiusmod deserunt dolore deserunt ea aliquip non fugiat. Duis tempor exercitation laborum aute ut sit do occaecat proident. Adipisicing qui ex do nulla pariatur ullamco pariatur magna proident.

- item 4

Note that the text of each list item is now enclosed in a paragraph tag while the items in the plain list just had a list item tag.

**Plain list with sublist**

Here's a regular list with a sublist:

- item 1
- item 2
  - subitem 1
  - subitem 2
  - subitem 3
- item 3
- item 4

**Plain list with paragraph introducing sublist**

Here's a regular list with a second paragraph introducing a sublist:

- item 1
- item 2

  Adding a nested list:
  - subitem 1
  - subitem 2
  - subitem 3
- item 3
- item 4

**List with multiple paragraphs in sublist items**

Here's a regular list with additional paragraphs in list items and sublists:

- item 1
- item 2

  Adding a nested list:
  - subitem 1
  - subitem 2

    A second paragraph in the sublist item 2.

    Here's a long block of lorem. Pariatur ea deserunt adipisicing anim nulla consequat nostrud sunt incididunt do anim elit et Lorem. Proident fugiat excepteur esse cupidatat sunt ea culpa. Nisi proident ea sunt tempor et non proident in. Aliquip cupidatat dolore et commodo aliqua labore.
  - subitem 3
- item 3

  Additional pargraph for item 3. Consequat dolore nostrud quis ad consectetur pariatur. Mollit culpa sit adipisicing adipisicing sint officia. Commodo minim culpa mollit labore ad fugiat ut sit aute dolor esse.
- item 4

**List items with code blocks**

This is a list with code blocks included with each list item:

- Aute consectetur elit officia nostrud in nostrud irure elit deserunt:

  ```ruby
  print "Hello, World!\n"
  ```

- Consequat qui non commodo laborum:

  ```ruby
  def sum_eq_n?(arr, n)
    return true if arr.empty? && n == 0

    arr.product(arr).reject { |a,b| a == b }.any? { |a,b| a + b == n }
  end
  ```

  Another paragraph before a nested list item:

  - nested list item code example:

    ```ruby
    z = { 'mike' => 75, 'bill' => 18, 'alice' => 32 }
    z['joe'] = 44
    print z['bill'], " ", z['joe'], " ", z["smith"], "\n"
    print z.has_key?('mike'), " ", z.has_key?("jones"), "\n"
    ```

  - more text

    - ```ruby
      z = { 'mike' => 75, 'bill' => 18, 'alice' => 32 }
      z['joe'] = 44
      print z['bill'], " ", z['joe'], " ", z["smith"], "\n"
      print z.has_key?('mike'), " ", z.has_key?("jones"), "\n"
      ```

      Voluptate elit dolore consectetur id ex commodo.

    - ```sh
      ls -l
      ```

      Voluptate elit dolore consectetur id ex commodo.

- Ea dolor reprehenderit amet nostrud Lorem sunt officia duis.

### Description List

Use description lists to define commands, command flags, options, or other terms. For example:

term
second term with same definition
: Term definition.

plain text _(term in italics)_
: Ex quis duis deserunt commodo.

`code` _(`code` in italics **and bolded text in italics**)_ **and regular bolded text**
: Reprehenderit eu ex dolore sunt reprehenderit ut consequat amet Lorem pariatur Lorem anim.

[another term](@)
: Another term definition.

  You can include multiple paragraphs in a definition if you need to.

: You can include more than one definition for a term by starting another line with a colon.

: Adding square brackets and the `(@)` symbol around the term (`[another term](@)`) adds a [linkable ID to the term](#another-term).

### Checklists

Checklists are an unordered list with a checkbox.

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

Eiusmod cupidatat excepteur tempor elit officia ipsum aute nulla ea do minim eu eu.

```bash
ls -l
```

Incididunt officia consequat aliquip amet quis elit culpa eiusmod duis esse nisi incididunt.

```ruby
z = { 'mike' => 75, 'bill' => 18, 'alice' => 32 }
z['joe'] = 44
print z['bill'], " ", z['joe'], " ", z["smith"], "\n"
print z.has_key?('mike'), " ", z.has_key?("jones"), "\n"
```

Commodo adipisicing sunt nisi laborum laboris.

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
The reader should proceed with caution. Ignoring this could break their deployment.
{{< /danger >}}

## SVG Shortcode

The SVG shortcode will add an inline SVG icon to a string of text:

Click on the web asset icon ({{< svg file="themes/docs-new/static/images/web-asset.svg" >}}).

## Buttons

To create a link that looks like a button, just add add the `button` class to a link tag.

```html
<a href="#buttons" class="button">Link To Button Heading</a>
```

<!-- markdownlint-disable MD033 -->
<a href="#buttons" class="button">Link To Button Heading</a>

Disabled button:

<a href="#buttons" class="button" disabled>Link To Button Heading</a>
<!-- markdownlint-enable MD033 -->

## Recommend

Recommend shortcode blocks used in the style guide.

{{< recommend not >}}
You should back up the server.
{{< /recommend >}}

{{< recommend >}}
Back up the server.
{{< /recommend >}}

## Notices

### Notes

{{< note >}}

This is the text of a note.

{{< /note >}}

### Warnings

{{< warning >}}

This is text in a warning.

{{< /warning >}}

### Danger

{{< danger >}}

This is text in a danger notice.

{{< /danger >}}

### Beta

{{< beta >}}

This text tells the user that a feature or product is in beta.

{{< /beta >}}

{{< beta >}}

This text tells the user that a feature or product is in beta. Ad excepteur incididunt laboris labore nisi nulla tempor nisi sunt. Do in officia deserunt magna proident minim nisi amet aute minim deserunt minim ut. Do exercitation excepteur deserunt magna elit ullamco labore eu dolore non consequat dolor. Sint reprehenderit labore veniam veniam commodo aute cupidatat nisi dolor tempor id.

{{< /beta >}}

{{< beta >}}

The first line in multiple paragraphs gets bumped below the Beta div.

Id minim deserunt et ullamco quis minim consectetur esse esse reprehenderit. Commodo exercitation consequat laboris laborum aliquip cillum veniam. Et ad dolor quis deserunt duis excepteur voluptate exercitation officia dolore minim consectetur elit.

{{< /beta >}}
