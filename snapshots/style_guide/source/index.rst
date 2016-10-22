=====================================================
Style Guide 
=====================================================

The Chef style guide is just a limited subset of the full capabilities of Sphinx, with regard to formatting and authoring options. Generally, if it's not listed here, we're not using it.

All of the documents built by Sphinx can be found at |url docs|.

Basic Doc Template
=====================================================
All documents must have a title and a body.

Topic Titles
-----------------------------------------------------
Each topic can have a single topic title. Use the equals symbol (=) above and below the header name. What it looks like as reST:: 

   =====================================================
   header name goes here
   =====================================================

This is the only section header that requires the structure above and below the header.

Body
-----------------------------------------------------
The body of the topic contains anything else needed for the topic. Often, a topic contains an include file (or three), and then some topics contain sub-headers. Most of the topics that are published to |url docs| contain a series of includes files. But some topics, like "An Overview of Chef", include original content alongside the includes files. It just depends on what the topic requires.

Example
-----------------------------------------------------
The following example is the first two sections from "An Overview of Chef"::

      =====================================================
      An Overview of Chef
      =====================================================
      
      .. include:: ../../includes_chef/includes_chef.rst
      
      The following diagram shows the relationships between the various elements of an organization, 
      including the nodes, the server, and the workstations. These elements work together to provide 
      the chef-client the information and instruction that it needs so that it can do its job. As 
      you are reviewing the rest of this doc, use the icons in the tables to refer back to this image.
      
      .. image:: ../../images/overview_chef_draft.png
      
      .. include:: ../../includes_chef/includes_chef_key_elements.rst
      
      The following sections discuss these elements (and their various components) in more detail.
      
      Nodes
      =====================================================
      .. include:: ../../includes_node/includes_node.rst

      There are two types of nodes that chef-client can manage:

   .. list-table::
      :widths: 60 420
      :header-rows: 1
      
      * - Feature
        - Description
      * - .. image:: ../../images/icon_node_cloud.png
        - .. include:: ../../includes_node/includes_node_cloud.rst
      * - .. image:: ../../images/icon_node_physical.png
        - .. include:: ../../includes_node/includes_node_physical.rst
      
   Some important components on nodes include:
      
   .. list-table::
      :widths: 60 420
      :header-rows: 1
      
      * - Feature
        - Description
      * - .. image:: ../../images/icon_chef_client.png
        - .. include:: ../../includes_chef/includes_chef_client.rst
      * - .. image:: ../../images/icon_ohai.png
        - .. include:: ../../includes_ohai/includes_ohai.rst
      
   The chef-client uses RSA public key-pairs to authenticate a chef-client with the Chef server every time a 
   chef-client needs access to data that is stored on the Chef server. This prevents any node from 
   accessing data that it shouldn't and ensures that only nodes that are properly registered with the 
   Chef server can be managed by the chef-client.

.. note:: Elements within this example, such as images, includes, inline replacements, list tables, and headers are discussed in more detail below.

Section Headers
=====================================================
Section headers create structure in a document. When section headers are part of a topic that is included in other topics, those headers are treated as if they first appeared at that location (and are bumped down appropriately). For this, and for other cosmetic reasons, the headers in Chef documents are limited to 4 levels beyond the topic title. If headers are required beyond that, they should only be done using standard emphasis and white space or through some other creative method (such as creating more topics with less TOC depth).

Sphinx allows many different conventions for how headers can exist in documents and looks for consistency to determine which ones go where. The width of the header must be equal to (or longer) than the length of the text in the header and (ideally) the same width for headers are used everywhere. (Having everything the same width can help spot the headers during reviews or when trying to find bugs in topics. The following sections describe the section header pattern that Chef is using for topic titles, H1s, H2s, H3s, H4s, and the occasional H5.

.. note:: As a general rule, try to limit the number of header levels to no more than 2 within a topic. There can be exceptions, of course, and especially if the document is very large, but remember that HTML TOC structures usually have width limitations (on the display side) and the more structure within a TOC, the harder it can be for users to figure out what's in it.

.. warning:: Unless the topics are about installing things or about API endpoints, the headers should never wrap. Keep them to a single line.

H1
-----------------------------------------------------
If a topic requires a sub-header, this is the first one to use. Use the equals symbol (=) below the header name. What it looks like as reST:: 

   header name goes here
   =====================================================
   This is the paragraph.

H2
-----------------------------------------------------
If an H1 requires a sub-header, this is one to use. Sphinx will generate errors if this header is not a child of an H1. Use the dash symbol (-) below the header name. What it looks like as reST:: 

   header name goes here
   -----------------------------------------------------
   This is the paragraph.

H3
-----------------------------------------------------
If an H2 requires a sub-header, this is one to use. Sphinx will generate errors if this header is not a child of an H2. Use the plus symbol (+) below the header name. What it looks like as reST:: 

   header name goes here
   +++++++++++++++++++++++++++++++++++++++++++++++++++++
   This is the paragraph.

H4
-----------------------------------------------------
If a H3 requires a sub-header, this is the one to use. Sphinx will generate errors if this header is not a child of an H3. Use the caret symbol (^) below the header name. What it looks like as reST:: 

   header name goes here
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   This is the paragraph.

H5
-----------------------------------------------------
Only 4 levels of headers are supported (title, H2, H3, and H4). Conversely, when more than 4 levels of headers are required, re-think the header structure rather than go deeper. If, in the rare instance a lower-level header is needed, use a bold emphasis and then white space to provide the visual treatment and content separation. What it looks like as reST:: 

   **header name goes here**         # in regular bold emphasis
                                     # this is a hard return
   content, as normally authored.

What an "H5 header" link looks like after it's built:

**Header**

content, as normally authored.


Lists and Tables
=====================================================
Lists and tables can be useful. The following sections describe the various lists and tables that Chef is using for its documentation.

Bullet Lists
-----------------------------------------------------
Bulleted lists are useful for breaking up text blocks and for drawing attention to a group of items. What it looks like as reST:: 

   * text goes here
   * text goes here
   * text goes here
   * text goes here

Use the asterisk symbol (*) only for bulleted lists, even though Sphinx supports using other symbols. What bullets look like after they are built:

* text goes here
* text goes here
* text goes here
* text goes here

Numbered Lists
-----------------------------------------------------
Numbered lists are good for when people need to understand a list of information in a specific order, such as for how-tos or for process details. What it looks like as reST:: 

   #. text goes here
   #. text goes here
   #. text goes here
   #. text goes here

Use the number symbol (#) to let Sphinx handle the actual ordering. If the number list needs to change later, you don't have to worry about making sure the numbers are in the correct order. What an ordered list looks like after it is built:

#. text goes here
#. text goes here
#. text goes here
#. text goes here

Definition Lists
-----------------------------------------------------
These are used primarily to show the options available to a command line tool. These appear the same way in the HTML and print documentation as they appear in the man page output. What it looks like as reST:: 
   
   ``--name-only``
      Show only the names of modified files.
   
   ``--name-status``
      Show only the names of files with a status of ``Added``, ``Deleted``, ``Modified``, or ``Type Changed``.

What a definition list looks like after it's built:

``--name-only``
   Show only the names of modified files.

``--name-status``
   Show only the names of files with a status of ``Added``, ``Deleted``, ``Modified``, or ``Type Changed``.

List Tables
-----------------------------------------------------
The list table is the only table style that Chef is using in the docs. Sphinx supports other approaches to tables, but they are crude and inelegant and are a pain so why bother with them. What the list table looks like as reST:: 

   .. list-table::
      :widths: 250 250
      :header-rows: 1
      
      * - Header
        - Description
      * - text, image, swap, or include
        - text, image, swap, or include
      * - text, image, swap, or include
        - text, image, swap, or include

The table cells support images and includes, along with all of the other standard Sphinx that is being used here. The widths can be changed and the number of columns can be changed too. In general, Chef is trying to keep the number of columns below 4. When creating a list table, think about what it will look like in HTML, PDF, man-page, and other formats and keep in mind the width limitations inherent in print formats.

.. warning:: Tables (as opposed to list tables) should never be used. This is, in part, to help ensure that all topics can work in any published format, including HTML, PDF, and man-page, but also because list tables are much, much easier to work with.

What the list table might look like in the source file::

   .. list-table::
      :widths: 60 420
      :header-rows: 1
      
      * - Header
        - Description
      * - .. image:: ../../images/image_style_guide_example.png
        - .. include:: ../../includes_style_guide/includes_style_guide_example.rst
      * - No image, just text!
        - .. include:: ../../includes_style_guide/includes_style_guide_example.rst
      * - Chef
        - Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure.

and then what a list table looks like after it is built:

.. list-table::
   :widths: 60 420
   :header-rows: 1
   
   * - Header
     - Description
   * - .. image:: ../../images/image_style_guide_example.png
     - .. include:: ../../includes_style_guide/includes_style_guide_example.rst
   * - No image, just text!
     - .. include:: ../../includes_style_guide/includes_style_guide_example.rst
   * - Chef
     - Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure.

Inline Markup
=====================================================
Adding emphasis within text strings can be done using **bold**, *italics*, and ``code strings``.

Bold
-----------------------------------------------------
Use two asterisks (*) to mark a text string as **bold**. What it looks like as reST:: 

   **text goes here**

Italics
-----------------------------------------------------
Use a single asterisk (*) to mark a text string as *italics*. What it looks like as reST:: 

   *text goes here*

Code Strings
-----------------------------------------------------
Sometimes the name of a method or database field needs to be used inline in a paragraph. Use two backquotes to mark certain strings as code within a regular string of text. What it looks like as reST::

   ``code goes here``

What it looks like in a paragraph after it is built:

Sometimes if an API ``method`` or database ``table`` needs to be referred to in a paragraph, it's useful to apply a style to that ``item`` so that readers can tell that it's special.

Links
=====================================================
Links are ways to get users to other useful topics.

Internal
-----------------------------------------------------
An internal link is one that resolves to another topic that is built by Sphinx. What it looks like as reST:: 

   :doc:`essentials_nodes`

where ``:doc:`` tells Sphinx that what follows is a file name that Sphinx will encounter during the build process. If this isn't formatted correctly, Sphinx will let you know.

Internal w/short names
-----------------------------------------------------
An internal link is one that resolves to another topic that is built by Sphinx. Sometimes it's better to have the name of the link that displays be as short as possible (and different from the actual title of the topic). What it looks like as reST:: 

   :doc:`Actions </resource_common_actions>`

where ``:doc:`` tells Sphinx that what follows is a file name that Sphinx will encounter during the build process. ``Actions`` represents the short name that will display on the page in which this internal link is located, and then ``resource_common_actions`` is the filename and is contained within brackets (< >). If this isn't formatted correctly, Sphinx will let you know.

External
-----------------------------------------------------
An external link points to something that does not live on |url docs|. An external link requires an HTTP address. In general, it's better to spell out the HTTP address fully, in case the topic is printed out. What an external link looks like as reST:: 

   http://www.codecademy.com/tracks/ruby

and what an external link looks like after it's built:

"A great tool for learning Ruby is http://www.codecademy.com/tracks/ruby."


TOC Trees
=====================================================
A TOC tree defines all of the topics that are children of this topic. In Sphinx outputs, the Previous and Next patterns use this topic structure to determine these links. In addition, a visible TOC will use the structure defined by the ``toctree`` directive. In general, Chef is not using the visible TOC tree, but they still need to be present in the topics to keep Sphinx happy. What the hidden ``toctree`` looks like as reST:: 

   .. toctree::
      :hidden:
   
      chef_overview
      just_enough_ruby_for_chef
      ...

Code Blocks
=====================================================
Code blocks are used to show code samples, such as those for Ruby, JSON, and command-line strings. There are many options here, especially if Pygments is part of your Sphinx environment. The most common code block styles are shown below, but there are many lexers available.

.. note:: For more information about all of the code styles that Pygments supports, see: http://pygments.org/docs/lexers/.

Ruby
-----------------------------------------------------
Use this approach to show code blocks that use Ruby. What it looks like as reST:: 

   .. code-block:: ruby

      default["apache"]["dir"]          = "/etc/apache2"
      default["apache"]["listen_ports"] = [ "80","443" ]

and what it looks like after it's built:

.. code-block:: ruby

   default["apache"]["dir"]          = "/etc/apache2"
   default["apache"]["listen_ports"] = [ "80","443" ]

Bash
-----------------------------------------------------
Use this approach to show code blocks that use any type of shell command, such as for Knife or the chef-client or for any other command-line example that may be required. What it looks like as reST:: 

   .. code-block:: bash

      $ knife data bag create admins

and what it looks like after it's built:

.. code-block:: bash

   $ knife data bag create admins

Javascript (and JSON)
-----------------------------------------------------
Use this approach to show code blocks that use any type of JavaScript, including any JSON code sample. What it looks like as reST:: 

   .. code-block:: javascript
   
      {
         "id": "charlie",
         "uid": 1005,
         "gid":"ops",
         "shell":"/bin/zsh",
         "comment":"Crazy Charlie"
      }

and what it looks like after it's built:

.. code-block:: javascript

   {
      "id": "charlie",
      "uid": 1005,
      "gid":"ops",
      "shell":"/bin/zsh",
      "comment":"Crazy Charlie"
   }

Literal
-----------------------------------------------------
These should be used sparingly, but sometimes there is a need for a block of text that doesn't fit neatly into one of the options available for ``code-block``, such as showing a directory structure, basic syntax, or pseudocode. Use a double colon (::) at the end of the preceding paragraph, add a hard return, and then indent the literal text. What it looks like as reST::

   Use a double colon (::) at the end of the preceding paragraph. What it looks like as reST::

      a block of literal text indented three spaces
      with more
      text as required to
      complete the block of text.
      end.

and what it looks like after it's built::

   a block of literal text indented three spaces
   with more
   text as required to
   complete the block of text.
   end.


Includes   
-----------------------------------------------------
An includes file is a way to use a path to pull content into a topic at build time. This allows the contents of a topic to be sourced in one location, yet used within any deliverable that requires it. What it looks like as reST:: 

   .. include:: ../../includes_chef/includes_chef.rst

What it looks like after it's built:

.. include:: ../../includes_chef/includes_chef.rst

Inline Replacements
=====================================================
A swap file is a file that contains short strings of information that are replaced at build time. Mostly, these are definitions of command-line options, descriptions of settings in Ruby files, and other short descriptions that may live in more than one place across the doc set.

They are grouped by letter (for definition strings, a-z), grouped by names (for product name and other formal names), for notes, and for HTTP links. These should only be included when it's certain that, should the swap replacement need to change later, that that change is exactly what is wanted in that location later.

What it looks like as reST:: 

   Mac OS X

or::

   Homebrew

or::

   knife.rb

or::

   **deploy**

or::

   chef-client

and what it looks like in a document::

   I like to use Homebrew on my Mac OS X machine when managing my knife.rb file that I 
   use with my chef-client every time the **deploy** resource is run.

and what that would look like after it's built: "I like to use Homebrew on my Mac OS X machine when managing my knife.rb file that I use with my chef-client every time the **deploy** resource is run."

Notes and Warnings
=====================================================
In general, notes and warnings are not the best way to present important information. Before using them ask yourself how important the information is. If you want the information to be returned in a search result, then it is better for the information to have its own topic or section header. Notes and warnings do provide a visual (because they have a different color than the surrounding text) and can be easily spotted within a doc. If notes and warnings must be used, the approach for using them is as follows.

Notes
-----------------------------------------------------
Use sparingly, but much more often than a warning. A note works best when they are consistently used across a wide set of topics. Some people just read docs looking for notes and images and steps. Notes shouldn't be used in a way that discourages people from reading the docs. The most important topics have unique and meaningful titles. If something is really important, the best place for it is a location that gives it a spot in the TOC, with its own topic title, and so on.

What a note looks like as reST:: 

   .. note:: This is a note.

What a note looks like after it's built:

.. note:: This is a note.

Warnings
-----------------------------------------------------
Use sparingly, so that when the user sees a warning it registers appropriately. A warning really should be a "Hey, if you do this, you might break your environment." type of situation. What a warning looks like as reST:: 

   .. warning:: This is a warning.

What a warning looks like after it's built:

.. warning:: This is a warning.

Images
=====================================================
Images are useful and can be better at telling readers what is going on than actual text. What it looks like as reST::

   .. image:: ../../images/icon_chef_client.svg
      :width: 100px
      :align: center

What an image looks like after it's built:

.. image:: ../../images/icon_chef_client.svg

Images should be 96 dpi and no larger than 600 pixels wide. Ideally, no larger than 550 pixels wide. (This helps ensure that the image can be printed and/or built into other output formats more easily; in some cases, separate 300 dpi files should be maintained for images that require inclusion in formats designed for printing and/or presentations.)

Grammar
=====================================================
Chef does not follow a specific grammar convention. Be clear and consistent as often as possible. Follow the established patterns in the docs.

Tautologies
-----------------------------------------------------
A tautology, when used as a description for a component, setting, method, etc. should be avoided. If a string is a tautology, some effort should be made to make it not so. An example of a tautology is something like "Create a new user" (by its very nature, a user created **is** a new user) or (for a setting named ``cidr_block``) "The CIDR block for the VPC."

Doc Repositories
=====================================================
There are two document repositories for chef-docs, one that contains the docs and another that contains image files for quick references.

chef-docs
-----------------------------------------------------
All of the documentation for Chef can be found here:

https://github.com/chef/chef-docs

The chef-docs repo contains a lot of directories!

Build Directories
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The most important directory is ``chef_master`` and it contains all of the topics that can be found at the root of https://docs.chef.io. For example:

.. list-table::
   :widths: 250 250
   :header-rows: 1
   
   * - chef-docs
     - docs.chef.io
   * - resource_execute.rst
     - https://docs.chef.io/resource_execute.html
   * - kitchen.rst
     - https://docs.chef.io/kitchen.html
   * - ruby.rst
     - https://docs.chef.io/ruby.html

There is always a 1:1. The contents within each of these files show the path to the actual content that is pulled into the topic at build time. These paths are similar to::

   .. include:: ../../includes_some_folder/includes_some_file.rst

See the section "Includes Directories" below for more information about the included content.

.. note:: The ``conf.py`` file should never be modified. This file just tells Sphinx what to do when it's asked to build chef-docs.

There are other build directories: ``docs_all``, ``docs_analytics``, ``docs_client``, ``docs_devkit``, ``docs_server``. These are used to build sub-sites like https://docs.chef.io/server, which is focused only on the content for Chef server 12. For example. These pages are almost always cloned from the ``chef_master`` directory, like this::

   .. THIS PAGE IS IDENTICAL TO docs.chef.io/server_orgs.html BY DESIGN
   .. THIS PAGE IS LOCATED AT THE /server/ PATH.
   
   .. include:: ../../chef_master/source/server_orgs.rst

This just means that if a change is made to ``chef_master/source/server_orgs.rst`` it will also be made at build-time to ``docs_server/source/server_orgs.rst``. Manage the change in a single location.

Includes Directories
+++++++++++++++++++++++++++++++++++++++++++++++++++++
But wait! Why do most of the files in the ``chef_master`` directory have zero actual content? It's to separate what is published from what is authored. There is an ``includes_*`` folder for all of the objects, concepts, tools, etc. that exist in Chef. The goal of each ``includes_`` directory is to ensure that all of the content about a specific piece of Chef can be found in a single location.

Single-sourcing this content allows publishing of versioned content, generating output to man pages, HTML, slide decks, and PDFs, etc. in a way that reuses the same content as much as possible.

For example, the ``template`` resource::

   =====================================================
   template
   =====================================================
   
   .. include:: ../../includes_resources_common/includes_resources_common_generic.rst
   
   .. include:: ../../includes_resources/includes_resource_template.rst
   
   |note execute resource intepreter|
   
   
   Syntax
   =====================================================
   .. include:: ../../includes_resources/includes_resource_template_syntax.rst
   
   Actions
   =====================================================
   .. include:: ../../includes_resources/includes_resource_template_actions.rst
   
   Attributes
   =====================================================
   .. include:: ../../includes_resources/includes_resource_template_attributes.rst

The actual content lives in the ``include_resources`` directory, and for each section at the file named in the path. For example, the properties available to the ``template`` resource are in the ``includes_resource_template_attributes.rst`` file::

   |description resource_attributes_intro|
   
   .. list-table::
      :widths: 150 450
      :header-rows: 1
   
      * - Property
        - Description
      * - ``atomic_update``
        - Perform atomic file updates on a per-resource basis. Set to ``true`` for atomic file updates. Set to ``false`` for non-atomic file updates. This setting overrides ``file_atomic_update``, which is a global setting found in the client.rb file. Default value: ``true``.
      * - ``backup``
        - The number of backups to be kept in ``/var/chef/backup`` (for UNIX- and Linux-based platforms) or ``C:/chef/backup`` (for the Microsoft Windows platform). Set to ``false`` to prevent backups from being kept. Default value: ``5``.
      * - ``cookbook``
        - The cookbook in which a file is located (if it is not located in the current cookbook). The default value is the current cookbook.
      * - ``force_unlink``
        - How the chef-client handles certain situations when the target file turns out not to be a file. For example, when a target file is actually a symlink. Set to ``true`` for the chef-client delete the non-file target and replace it with the specified file. Set to ``false`` for the chef-client to raise an error. Default value: ``false``.
      * - ``group``
        - A string or ID that identifies the group owner by group name, including fully qualified group names such as ``domain\group`` or ``group@domain``. If this value is not specified, existing groups remain unchanged and new group assignments use the default ``POSIX`` group (if available).
      * - ``helper``
        - Define a helper method inline. For example: ``helper(:hello_world) { "hello world" }`` or ``helper(:app) { node["app"] }`` or ``helper(:app_conf) { |setting| node["app"][setting] }``. Default value: ``{}``.
   <snip> ...
      * - ``verify``
        - A block or a string that returns ``true`` or ``false``. A string, when ``true`` is executed as a system command.
   
           .. include:: ../../includes_resources_common/includes_resources_common_attribute_verify.rst


These properties are available in the docs for the current version of Chef and are the same properties available in previous versions, until there is a difference. The chef-client 12.1 release added the ``verify`` property. This is versioned in chef-docs using a file named ``includes_resource_12-0_template_attributes.rst``, which is then included backwards all the way to chef-client 11-4 docs, which is when the ``helper`` and ``helpers`` properties were added. Three files, a few subtle changes, hooked in the same way, but with the correct file name for the correct version. This is how chef-docs build outputs are versioned.

This pattern is the same everywhere. In some cases, it may well be that a topic is only included in a single build output, but this is rare. Most of the topics are included many times, across client, server, and devkit docs, and across versions (backwards in time). So keep this in mind when making changes.

.. note:: For the majority of changes, especially those made by the Chef community, focus on making changes to the ``chef_master`` directory and against the current version of Chef. If you believe the change should be reflected to a specific version, just state that in the PR or issue and the chef-docs team will help apply that in the chef-docs repo.

String Replacements
+++++++++++++++++++++++++++++++++++++++++++++++++++++
So what are these things that are contained in pipes? For example::

   A block or a string that returns ``true`` or ``false``. A string, when ``true`` is executed as a system command.

or::

   chef-client

These are string replacements. There are two types: descriptions and names.

Descriptions are used primarily in the resource reference documentation to help ensure that the same descriptions are applied anywhere and everywhere. These are hooked into release notes, resource topics (across all versions) and elsewhere. For example, some descriptions apply to the Chef server API as well as Knife reference docs and also resource docs.

Names are proper names. For example:

.. list-table::
   :widths: 250 250
   :header-rows: 1
   
   * - Name
     - Replacement
   * - Microsoft Azure
     - ``Microsoft Azure``
   * - Chef
     - ``Chef``
   * - chef-client
     - ``chef-client``

String replacements are found in the ``/swaps`` directory. When submitting PRs or issues to chef-docs, it is not necessary to get the strings correct. Rather, just write what you think should be in the doc directly, and chef-docs will apply the string replacements (and/or create new ones!) later during an edit.

New Topics, Sections
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This can be tricky, but as long as you are following the pattern for the include_* files, it's pretty easy. They can be moved around, renamed, deleted, added quite easily.

Files in the ``chef_master`` repo can be sticky, in that they become searchable on the internet and can be found for longer than intended. So we just want to be careful about creating new top-level topic names.

Recap!
+++++++++++++++++++++++++++++++++++++++++++++++++++++
When submitting a PR or issue to chef-docs for a docs change, remember:

* Focus on the ``chef_master`` repo to find the topic/files
* Find the appropriate ``includes_`` folder, and then find the actual topic
* For a straightfoward PR or issue, make it against that file
* Keep in mind potential versioning issues, make those clear in the PR or issue if you're not sure---chef-docs will help out
* Focus on the actual content---chef-docs will help with any string replacements, includes file management, and versioning

For example, if you wanted to add an property to a resource, the PR or issue could look like this::

   Please add the following property to the template resource:
   
   ``foo``
   Use to do foo. Default value: ``false``.
   
   This appears to have been added in chef-client 11.8.
   
   Thanks!

If you want to try to get the full PR done in a way that allows chef-docs to merge it straightaway? Always welcome, but not required.

You can always send email to docs@chef.io if you have questions about specific folders, files, and patterns.

quick-reference
-----------------------------------------------------
The quick-reference repository contains large PNG images that can be printed (front and back), plus smaller single-page images. It can be found here:

https://github.com/chef/quick-reference


Slide Decks
=====================================================
You can build an HTML slide deck using reveal.js. First, install this plugin for Sphinx:

https://github.com/tell-k/sphinxjp.themes.revealjs

Slide Format
-----------------------------------------------------
A slide deck is a single .rst topic that uses the ``revealjs::`` directive to define each slide in the deck, and also to define the heirarchy of the slides themselves.

Basic Writing Tips
+++++++++++++++++++++++++++++++++++++++++++++++++++++
You don't need a lot of formatting to make a good slide deck topic. When writing a slide deck topic, use this style guide, but stick to:

* Lists (bullet, numbered, or definition)
* Links
* Inline markup
* Code blocks
* Notes and warnings
* Images

Never use:

* Section headers (the headers in a slide deck are defined in the maps, not as headers, but as slide titles)

Use carefully:

* List tables (you may need to hand-code a table in a slide, if a table is truly required)
* Includes and inline replacements (make sure they fit, that they are what you want, and that they render what you want)
* TOC trees (you just need to make sure any non-index.rst topic is listed under the toctree directive)

.. warning:: There are lots of other directives in Sphinx. It's just that chef-docs isn't using most of them. Everything chef-docs is using is defined in this style guide. If it's not here, it may not be supported. There are also reveal.js-specific directives. See the release notes: https://github.com/tell-k/sphinxjp.themes.revealjs. We can try them as needed to see how they do. Most of those have yet to be tried out.

Single Column Maps
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Official slide decks should be a single column. This means that users of the slide deck will scroll through the slide deck vertically. This is defined using the following pattern::

   .. revealjs::
   
    .. revealjs:: Slide Title
   
       slide contents
   
    .. revealjs:: Slide Title
   
       slide contents
   
    .. and so on ...

Use as many slides as needed and ensure that each slide is indented under the top-level ``revealjs::`` directive using a single space, and then the content of each slide indented to the start of the directive. Topics should be included, as a general pattern, like this::

   .. revealjs::
   
    .. revealjs:: Recipes
   
       .. include:: ../../includes_slides/includes_slides_core_splash.rst
   
    .. revealjs:: Recipes
   
       .. include:: ../../includes_slides/includes_slides_recipes.rst
   
    .. revealjs:: Order Matters
   
       .. include:: ../../includes_slides/includes_slides_recipes_order.rst

where the included file is a standard .rst file from the chef-docs library that **DOES NOT** include any ``revealjs::`` directive information. It's just well-formed restructured text as defined by this style guide. (It's important to remember that included topics may be in other formats, like PDF, non-reveal.js HTML formats, and even man pages.)

You may mix-and-match inclusions and custom content as needed. For example::

   .. revealjs::
   
    .. revealjs:: Recipes
   
       .. include:: ../../includes_slides/includes_slides_core_splash.rst
   
    ... <snip> ...
   
    .. revealjs:: Order Matters - Service Runs Third
   
       .. include:: ../../includes_slides/includes_slides_recipes_order_service.rst
   
    .. revealjs:: Questions
   
       .. include:: ../../includes_slides/includes_slides_core_questions.rst
   
    .. revealjs:: More Info About Resources
   
       For more information, see:
   
       * https://docs.chef.io/recipes.html

where the final slide contains information that only exists in this slide deck. As a general rule, custom slide contents should follow the styles defined in this style guide and should truly be custom. (Try to reuse slides as often as possible and use custom slides where necessary for flow, transition, genuinely unique information.)

Many Columm Maps
+++++++++++++++++++++++++++++++++++++++++++++++++++++
A subtle pattern change will create a deck that has multiple columns, accessed via horizontal navigation, and then for each column the same vertical navigation. To create multiple columns, use the following structure::

   .. revealjs::
   
    .. revealjs:: Slide Title  
   
     slide contents
   
    .. revealjs:: Slide Title
   
     .. include:: ../../path/to/file.rst
   
   
   .. revealjs::
   
    .. revealjs:: Slide Title
   
     .. include:: ../../path/to/file.rst
   
    .. revealjs:: Slide Title
   
     .. include:: ../../path/to/file.rst

Custom Decks
+++++++++++++++++++++++++++++++++++++++++++++++++++++
If you're building a deck that leverages the chef-docs repo, but will never be published to either docs.chef.io or slides.chef.io, then you can use whatever formats and slides structures you prefer. As long as Sphinx can build it, then use it! These types of decks may be employees of Chef building a custom deck for a specific training course, a presentation at a conference, and so on. This may also be community members (perhaps you!) using a deck at a conference, for something internal to your company about Chef, or anything.

Speaker Notes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Speaker notes are not recommended for a publicly visible slide deck. (The slide deck should be able to communicate to the reader without notes.) For custom decks or decks that are used privately, use the ``.. rv_note::`` directive to add notes to slides. And then view the notes using the ``s`` key on the keyboard.

For example:

.. code-block:: python

   .. rv_note:: This is a speaker note.


Official Names
=====================================================
Official names are listed in the ``/swaps/swap_names.rst`` file, including both Chef and 3rd party names. For Chef applications and components, use:

* ``Chef`` for Chef
* ``Chef`` for Chef, the family of products built and maintained by Chef
* ``Chef server`` for the Chef server
* ``chef-client`` for the chef-client

For the full list of official names used in the documentation, see https://github.com/chef/chef-docs/blob/master/swaps/swap_names.txt.


Localization
=====================================================
Sphinx supports localization into many languages.

.pot files
-----------------------------------------------------
.pot files are used by localization teams as an intermediate step in-between the native English content and the localized content. Opscode needs to build the .pot files so that localization teams can feed them into their tools as part of their localization process.

.. warning:: .pot files should be recompiled, not modified.

.. warning:: .pot files are built only for the current release of documentation, which is the same as the ``chef_master`` source collection in git.

The .pot file is built using much the same process as a regular Sphinx content build. For example, a regular content build:

.. code-block:: bash

   sphinx-build -b html /path/to/source /path/to/build

and then for the .pot files:

.. code-block:: bash

   sphinx-build -b gettext /path/to/source /path/to/translate

with the very important difference of the ``/build`` vs. ``/translate`` folders for the output.

.pot files should be checked into the github repository like every other source file and even though they are output of the source files, should be treated as if they are source files.

.. note:: The /translate folder in the github source contains a regularly updated set of .pot files. That said, it is recommended that if you want to localize the Chef documentation, check with Chef (send email to docs@chef.io) and let us know that you want to participate in the localization process and we can sync up. Or just update the .pot files locally to make sure they are the most current versions of the .pot files.

conf.py Settings
=====================================================
Every Sphinx build has a configuration file.

rst_prolog
-----------------------------------------------------
Chef has added this configuration setting to every conf.py file to help streamline the inclusion of files at the beginning of the build process and to help support localization efforts. This setting is added to the general configuration settings and looks like this:

.. code-block:: python

   # A string of reStructuredText that will be included at the beginning of every source file that is read.
   rst_prolog = """
   .. include:: ../../swaps/swap_descriptions.txt
   .. include:: ../../swaps/swap_names.txt
   """




.. Hide the TOC from this file.

.. toctree::
   :hidden:

   test_doc
