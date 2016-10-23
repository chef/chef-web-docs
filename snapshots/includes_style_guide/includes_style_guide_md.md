=====================================================
.md vs. .rst? Write in both!
=====================================================

This is the CHEF style guide for authoring using syntax that is common to both Markdown and reStructuredText. It may seem limiting, given that there are only a handful of options, but realistically, most writing is headers, paragraphs (with bold, italics, and monospaced text), code blocks, lists (ordered and unordered) and hyperlinks. This is true regardless of the sophistication of the authoring toolset.

This is the syntax you should stick to when creating topics (like Readmes) that you want included in chef-docs.

Common Syntax
=====================================================
This is the syntax that is common to both Markdown (.md) and reStructuredText (.rst) authoring. This syntax will render in the same way in both formats and is the required syntax for any Markdown-authored file that must be included in chef-docs and published to https://docs.chef.io. This syntax ensures that the Sphinx documentation parser is able to read the file and build it into the topic collection.

Topic Titles
-----------------------------------------------------
Each topic can have a single topic title. Use the equals symbol (=) above and below the header name. What it looks like as reST::

    =====================================================
    header name goes here
    =====================================================

This is the only section header that requires the structure above and below the header.

Section Headers
=====================================================
Section headers create structure in a document. When section headers are part of a topic that is included in other topics, those headers are treated as if they first appeared at that location (and are bumped down appropriately). For this, and for other cosmetic reasons, the headers in CHEF documents are limited to 4 levels beyond the topic title. If headers are required beyond that, they should only be done using standard emphasis and white space or through some other creative method (such as creating more topics with less TOC depth).

H1
-----------------------------------------------------
If a topic requires a sub-header, this is the first one to use. Use the equals symbol (=) below the header name. What it looks like:: 

    header name goes here
    =====================================================
    This is the paragraph.

H2
-----------------------------------------------------
If an H1 requires a sub-header, this is one to use. Sphinx will generate errors if this header is not a child of an H1. Use the dash symbol (-) below the header name. What it looks like:: 

    header name goes here
    -----------------------------------------------------
    This is the paragraph.

H3
-----------------------------------------------------
Only 2 levels of headers are supported (H1, H2). Conversely, when more than 2 levels of headers are required, re-think the header structure rather than go deeper. If, in the rare instance a lower-level header is needed, use a bold emphasis and then white space to provide the visual treatment and content separation. What it looks like:: 

    **header name goes here**         # in regular bold emphasis
                                      # this is a hard return
    content, as normally authored.

What an "H3 header" looks like after it's built:

**Header**

content, as normally authored.


H1 Example
=====================================================
This is an H1 paragraph!

H2 Example
-----------------------------------------------------
This is an H2 paragraph!

**H3 Example**

This is an H3 paragraph!

Lists
=====================================================
Lists are useful! The following sections describe the various list types that CHEF is using for its documentation. A list must have a blank row before and after the list items.

Bulleted Lists
-----------------------------------------------------
Bulleted lists are useful for breaking up text blocks and for drawing attention to a group of items. What it looks like:: 

    * text goes here
    * text goes here
    * text goes here
    * text goes here

For example:

* foo
* bar
* baz

Numbered Lists
-----------------------------------------------------
Numbered lists are good for when people need to understand a list of information in a specific order, such as for how-tos or for process details. What it looks like:: 

    1. text goes here
    2. text goes here
    3. text goes here
    4. text goes here

For example:

1. foo
2. bar
3. baz

Inline Markup
=====================================================
Adding emphasis within text strings can be done using **bold**, *italics*, and ``monospaced text``.

Bold
-----------------------------------------------------
Use two asterisks to mark a text string as **bold**. What it looks like:: 

    **bold**

Italics
-----------------------------------------------------
Use a single asterisk to mark a text string as *italics*. What it looks like:: 

    *text goes here*

Monospaced Text
-----------------------------------------------------
Use two backquotes to mark a string as monospaced text within a regular string of text. What it looks like:: 

    Sometimes if an API ``method`` or database ``table`` needs to be referred to in a paragraph, it's useful to apply a style to that ``item`` so that readers can tell that it's special.

What it looks like in a paragraph after it is built:

Sometimes if an API ``method`` or database ``table`` needs to be referred to in a paragraph, it's useful to apply a style to that ``item`` so that readers can tell that it's special.

Links
=====================================================
Links are ways to get users to other useful topics. A link must always be spelled out, like this::

    https://docs.chef.io/resource.html#file

For example, this is a link to one of the most popular pages on chef-docs: https://docs.chef.io/resource.html#file.

Code Blocks
=====================================================
Code blocks are used to show code samples, such as those for Ruby, JSON, and command-line strings. To ensure compatibility between Markdown and reStructuredText identify all code blocks as a literal code block using a double colon ``::``, and then use **FOUR** spaces to indent each line in the code block. For example::

    # This is a code block
    
    file "/tmp/something" do
      owner 'root'
      group 'root'
      mode '0755'
      action :create
    end


Things we can't do ...
=====================================================
Sadly, there are times where what you want to do in Markdown just doesn't work the same way in reStructuredText. Since the goal is to create Markdown files that are 100% compatible with reStructuredText (and Sphinx), these are the things we can't do:

* Use square brackets in regular text (Markdown uses these to identify a hyperlink). For example: []
* Use a single backslash. For example: \ ... (can you see the single backslash on the rendered page?)
* Use a table? Please use a list instead
* Comments
* Markdown extensions (they won't parse in Sphinx)
* Anything else that's not listed here
