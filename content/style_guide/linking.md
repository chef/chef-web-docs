+++
title = "Linking"
draft = false
gh_repo = "chef-web-docs"

[menu]
  [menu.overview]
    title = "Linking"
    identifier = "overview/style/linking"
    parent = "overview/style"
    weight = 115
+++

Use descriptive link text that tell the user where a link will take them without needing to read the surrounding text.

## Writing Link Text

People who use screen reading software can jump from one link to the next in a document without reading the text in between.
Many users scan through documents looking for links.
Descriptive link text helps these users scan documents quickly.

Use the following guidelines in link text:

- Don't use phrases like "click here", "read more", "this document", "this article", or a URL in the text of a link.
- Keep link text short where possible.
- Link text should be unique. Don't use the same link text to link to different pages.
- Place important words at the beginning of link text.
- If a link downloads a file, write text to indicate this action as well as the file type.

{{< recommend not="true" >}}
Click [here](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html) for more information about AWS Lambda.
{{< /recommend >}}

{{< recommend not="true" >}}
[Click here](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html) for more information.
{{< /recommend >}}

{{< recommend not="true" >}}
See Chef's documentation: [https://docs.chef.io](https://docs.chef.io).
{{< /recommend >}}

Write descriptive links that make sense without the surrounding text.

{{< recommend >}}
For more information, see [Amazon's documentation on AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html).
{{< /recommend >}}

{{< recommend >}}
For more information about writing Lambda functions, see [Amazon's documentation on AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html).
{{< /recommend >}}

You may need to rewrite a sentence so that the link makes sense in the sentence.

## Linking to Headings

If you're adding a link to a heading in Chef's documentation, use the full heading text:

{{< recommend >}}
For more information, see [Chef Infra Components](https://docs.chef.io/chef_overview/#chef-infra-components).
{{< /recommend >}}

## Formatting Links

To make a link in Markdown, put the link text in square brackets followed by the link URL in parentheses:

`[Ruby Programming Language](https://www.ruby-lang.org/)`

### relref Shortcode

We recommend using Hugo's built-in [relref shortcode](https://gohugo.io/content-management/shortcodes/#ref-and-relref) for making relative links to other pages in Chef's documentation.
If a link is made to a page that does not exist, the site build will fail when Hugo generates a preview of the site.
This will help us catch dead links in our own documentation before they happen.

To format link to pages:

- `[link text]({{</* relref "some_page" */>}})`
- `[link text]({{</* relref "section/some_page" */>}})`

To format links to headings:

- `[link text]({{</* relref "#heading_on_this_page" */>}})`
- `[link text]({{</* relref "some_page#heading_on_other_page" */>}})`
- `[link text]({{</* relref "section/some_page#heading_on_other_page" */>}})`

{{< note >}}

relref doesn't validate heading links, only page links.

{{< /note >}}
