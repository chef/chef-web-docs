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

      .. tag chef

      Chef is a powerful automation platform that transforms infrastructure into code. Whether you’re operating in the cloud, on-premises, or in a hybrid environment, Chef automates how infrastructure is configured, deployed, and managed across your network, no matter its size.

      This diagram shows how you develop, test, and deploy your Chef code.

      .. image:: ../../images/start_chef.svg
         :width: 700px
         :align: center

      .. end_tag

      The following diagram shows the relationships between the various elements of an organization, 
      including the nodes, the server, and the workstations. These elements work together to provide 
      the chef-client the information and instruction that it needs so that it can do its job. As 
      you are reviewing the rest of this doc, use the icons in the tables to refer back to this image.

      .. image:: ../../images/overview_chef_draft.png

      .. tag chef_key_elements

      Chef has the following major components:

      .. list-table::
         :widths: 100 400
         :header-rows: 1

         * - Component
           - Description
         * - .. image:: ../../images/icon_workstation.svg
                :width: 100px
                :align: center

             .. image:: ../../images/icon_cookbook.svg
                :width: 100px
                :align: center

             .. image:: ../../images/icon_ruby.svg
                :width: 100px
                :align: center

           - One (or more) workstations are configured to allow users to author, test, and maintain cookbooks. Cookbooks are uploaded to the Chef server from the workstation. Some cookbooks are custom to the organization and others are based on community cookbooks available from the Chef Supermarket.

             Ruby is the programming language that is the authoring syntax for cookbooks. Most recipes are simple patterns (blocks that define properties and values that map to specific configuration items like packages, files, services, templates, and users). The full power of Ruby is available for when you need a programming language.

             Often, a workstation is configured to use the Chef development kit as the development toolkit. The Chef development kit is a package from Chef that provides an optional (but recommended) set of tooling, including Chef itself, the chef command line tool, Kitchen, ChefSpec, Berkshelf, and more.

         * - .. image:: ../../images/icon_node.svg
                :width: 100px
                :align: center

             .. image:: ../../images/icon_chef_client.svg
                :width: 100px
                :align: center

           - .. tag node

             A node is any machine---physical, virtual, cloud, network device, etc.---that is under management by Chef.

             .. end_tag

             A chef-client is installed on every node that is under management by Chef. The chef-client performs all of the configuration tasks that are specified by the run-list and will pull down any required configuration data from the Chef server as it is needed during the chef-client run.
         * - .. image:: ../../images/icon_chef_server.svg
                :width: 100px
                :align: center

           - The Chef server acts as a hub of information. Cookbooks and policy settings are uploaded to the Chef server by users from workstations. (Policy settings may also be maintained from the Chef server itself, via the Chef management console web user interface.)

             The chef-client accesses the Chef server from the node on which it's installed to get configuration data, perform searches of historical chef-client run data, and then pull down the necessary configuration data. After the chef-client run is finished, the chef-client uploads updated run data to the Chef server as the updated node object.

             Chef management console is the user interface for the Chef server. It is used to manage data bags, attributes, run-lists, roles, environments, and cookbooks, and also to configure role-based access for users and groups.
         * - .. image:: ../../images/icon_chef_supermarket.svg
                :width: 100px
                :align: center

           - Chef Supermarket is the location in which community cookbooks are authored and maintained. Cookbooks that are part of the Chef Supermarket may be used by any Chef user. How community cookbooks are used varies from organization to organization.

      .. end_tag

      The following sections discuss these elements (and their various components) in more detail.

      Nodes
      =====================================================
      .. tag node

      A node is any machine---physical, virtual, cloud, network device, etc.---that is under management by Chef.

      .. end_tag

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
        - .. tag ohai

          Ohai is a tool that is used to detect attributes on a node, and then provide these attributes to the chef-client at the start of every chef-client run. Ohai is required by the chef-client and must be present on a node. (Ohai is installed on a node as part of the chef-client install process.)

          The types of attributes Ohai collects include (but are not limited to):

          * Platform details
          * Network usage
          * Memory usage
          * CPU data
          * Kernel data
          * Host names
          * Fully qualified domain names
          * Other configuration details

          Attributes that are collected by Ohai are automatic attributes, in that these attributes are used by the chef-client to ensure that these attributes remain unchanged after the chef-client is done configuring the node.

          .. end_tag

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
        - .. tag style_guide_example

          Lorem ipsum dolor. This is just an example.

          .. end_tag

      * - No image, just text!
        - .. tag style_guide_example

          Lorem ipsum dolor. This is just an example.

          .. end_tag

      * - Chef
        - Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure.

and then what a list table looks like after it is built:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Header
     - Description
   * - .. image:: ../../images/image_style_guide_example.png
     - .. tag style_guide_example

       Lorem ipsum dolor. This is just an example.

       .. end_tag

   * - No image, just text!
     - .. tag style_guide_example

       Lorem ipsum dolor. This is just an example.

       .. end_tag

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

   .. tag chef

   Chef is a powerful automation platform that transforms infrastructure into code. Whether you’re operating in the cloud, on-premises, or in a hybrid environment, Chef automates how infrastructure is configured, deployed, and managed across your network, no matter its size.

   This diagram shows how you develop, test, and deploy your Chef code.

   .. image:: ../../images/start_chef.svg
      :width: 700px
      :align: center

   .. end_tag

What it looks like after it's built:

.. tag chef

Chef is a powerful automation platform that transforms infrastructure into code. Whether you’re operating in the cloud, on-premises, or in a hybrid environment, Chef automates how infrastructure is configured, deployed, and managed across your network, no matter its size.

This diagram shows how you develop, test, and deploy your Chef code.

.. image:: ../../images/start_chef.svg
   :width: 700px
   :align: center

.. end_tag

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

   .. tag server_orgs_13

   =====================================================
   Organizations and Groups
   =====================================================

   .. tag server_rbac

   The Chef server uses role-based access control (RBAC) to restrict access to objects---nodes, environments, roles, data bags, cookbooks, and so on. This ensures that only authorized user and/or chef-client requests to the Chef server are allowed. Access to objects on the Chef server is fine-grained, allowing access to be defined by object type, object, group, user, and organization. The Chef server uses permissions to define how a user may interact with an object, after they have been authorized to do so.

   .. end_tag

   .. tag server_rbac_components

   The Chef server uses organizations, groups, and users to define role-based access control:

   .. list-table::
      :widths: 100 420
      :header-rows: 1

      * - Feature
        - Description
      * - .. image:: ../../images/icon_server_organization.svg
             :width: 100px
             :align: center

        - An organization is the top-level entity for role-based access control in the Chef server. Each organization contains the default groups (``admins``, ``clients``, and ``users``, plus ``billing_admins`` for the hosted Chef server), at least one user and at least one node (on which the chef-client is installed). The Chef server supports multiple organizations. The Chef server includes a single default organization that is defined during setup. Additional organizations can be created after the initial setup and configuration of the Chef server.
      * - .. image:: ../../images/icon_server_groups.svg
             :width: 100px
             :align: center

        - .. tag server_rbac_groups

          A group is used to define access to object types and objects in the Chef server and also to assign permissions that determine what types of tasks are available to members of that group who are authorized to perform them. Groups are configured per-organization.

          Individual users who are members of a group will inherit the permissions assigned to the group. The Chef server includes the following default groups: ``admins``, ``clients``, and ``users``. For users of the hosted Chef server, an additional default group is provided: ``billing_admins``.

          .. end_tag

      * - .. image:: ../../images/icon_server_users.svg
             :width: 100px
             :align: center

        - A user is any non-administrator human being who will manage data that is uploaded to the Chef server from a workstation or who will log on to the Chef management console web user interface. The Chef server includes a single default user that is defined during setup and is automatically assigned to the ``admins`` group. 
      * - .. image:: ../../images/icon_chef_client.svg
             :width: 100px
             :align: center

        - .. tag server_rbac_clients

          A client is an actor that has permission to access the Chef server. A client is most often a node (on which the chef-client runs), but is also a workstation (on which knife runs), or some other machine that is configured to use the Chef server API. Each request to the Chef server that is made by a client uses a private key for authentication that must be authorized by the public key on the Chef server.

          .. end_tag

   .. end_tag

   .. tag server_rbac_workflow

   When a user makes a request to the Chef server using the Chef server API, permission to perform that action is determined by the following process:

   #. Check if the user has permission to the object type
   #. If no, recursively check if the user is a member of a security group that has permission to that object 
   #. If yes, allow the user to perform the action

   Permissions are managed using the Chef management console add-on in the Chef server web user interface.

   .. end_tag

   Multiple Organizations
   =====================================================
   .. tag server_rbac_orgs_multi

   A single instance of the Chef server can support many organizations. Each organization has a unique set of groups and users. Each organization manages a unique set of nodes, on which a chef-client is installed and configured so that it may interact with a single organization on the Chef server.

   .. image:: ../../images/server_rbac_orgs_groups_and_users.png

   A user may belong to multiple organizations under the following conditions:

   * Role-based access control is configured per-organization
   * For a single user to interact with the Chef server using knife from the same chef-repo, that user may need to edit their knife.rb file prior to that interaction

   .. end_tag

   .. tag server_rbac_orgs_multi_use

   Using multiple organizations within the Chef server ensures that the same toolset, coding patterns and practices, physical hardware, and product support effort is being applied across the entire company, even when:

   * Multiple product groups must be supported---each product group can have its own security requirements, schedule, and goals
   * Updates occur on different schedules---the nodes in one organization are managed completely independently from the nodes in another
   * Individual teams have competing needs for object and object types---data bags, environments, roles, and cookbooks are unique to each organization, even if they share the same name

   .. end_tag

   Permissions
   =====================================================
   .. tag server_rbac_permissions

   Permissions are used in the Chef server to define how users and groups can interact with objects on the server. Permissions are configured per-organization.

   .. end_tag

   Object Permissions
   -----------------------------------------------------
   .. tag server_rbac_permissions_object

   The Chef server includes the following object permissions:

   .. list-table::
      :widths: 60 420
      :header-rows: 1

      * - Permission
        - Description
      * - **Delete**
        - Use the **Delete** permission to define which users and groups may delete an object. This permission is required for any user who uses the ``knife [object] delete [object_name]`` argument to interact with objects on the Chef server.
      * - **Grant**
        - Use the **Grant** permission to define which users and groups may configure permissions on an object. This permission is required for any user who configures permissions using the **Administration** tab in the Chef management console.
      * - **Read**
        - Use the **Read** permission to define which users and groups may view the details of an object. This permission is required for any user who uses the ``knife [object] show [object_name]`` argument to interact with objects on the Chef server.
      * - **Update**
        - Use the **Update** permission to define which users and groups may edit the details of an object. This permission is required for any user who uses the ``knife [object] edit [object_name]`` argument to interact with objects on the Chef server and for any chef-client to save node data to the Chef server at the conclusion of a chef-client run.

   .. end_tag

   Global Permissions
   -----------------------------------------------------
   .. tag server_rbac_permissions_global

   The Chef server includes the following global permissions:

   .. list-table::
      :widths: 60 420
      :header-rows: 1

      * - Permission
        - Description
      * - **Create**
        - Use the **Create** global permission to define which users and groups may create the following server object types: cookbooks, data bags, environments, nodes, roles, and tags. This permission is required for any user who uses the ``knife [object] create`` argument to interact with objects on the Chef server.
      * - **List**
        - Use the **List** global permission to define which users and groups may view the following server object types: cookbooks, data bags, environments, nodes, roles, and tags. This permission is required for any user who uses the ``knife [object] list`` argument to interact with objects on the Chef server.

   These permissions set the default permissions for the following Chef server object types: clients, cookbooks, data bags, environments, groups, nodes, roles, and sandboxes.

   .. end_tag

   Client Key Permissions
   -----------------------------------------------------
   .. note:: This is only necessary after migrating a client from one Chef server to another. Permissions must be reset for client keys after the migration.

   .. tag server_rbac_clients

   A client is an actor that has permission to access the Chef server. A client is most often a node (on which the chef-client runs), but is also a workstation (on which knife runs), or some other machine that is configured to use the Chef server API. Each request to the Chef server that is made by a client uses a private key for authentication that must be authorized by the public key on the Chef server.

   .. end_tag

   .. tag server_rbac_permissions_key

   Keys should have ``DELETE``, ``GRANT``, ``READ`` and ``UPDATE`` permissions.

   Use the following code to set the correct permissions:

   .. code-block:: ruby

      #!/usr/bin/env ruby
      require 'rubygems'
      require 'chef/knife'

      Chef::Config.from_file(File.join(Chef::Knife.chef_config_dir, 'knife.rb'))

      rest = Chef::REST.new(Chef::Config[:chef_server_url])

      Chef::Node.list.each do |node|
        %w{read update delete grant}.each do |perm|
          ace = rest.get("nodes/#{node[0]}/_acl")[perm]
          ace['actors'] << node[0] unless ace['actors'].include?(node[0])
          rest.put("nodes/#{node[0]}/_acl/#{perm}", perm => ace)
          puts "Client \"#{node[0]}\" granted \"#{perm}\" access on node \"#{node[0]}\""
        end
      end

   Save it as a Ruby script---``chef_server_permissions.rb``, for example---in the ``.chef/scripts`` directory located in the chef-repo, and then run a knife command similar to:

   .. code-block:: bash

      $ knife exec chef_server_permissions.rb

   .. end_tag

   Default Permissions
   -----------------------------------------------------
   .. tag server_rbac_groups

   A group is used to define access to object types and objects in the Chef server and also to assign permissions that determine what types of tasks are available to members of that group who are authorized to perform them. Groups are configured per-organization.

   Individual users who are members of a group will inherit the permissions assigned to the group. The Chef server includes the following default groups: ``admins``, ``clients``, and ``users``. For users of the hosted Chef server, an additional default group is provided: ``billing_admins``.

   .. end_tag

   Groups
   =====================================================
   .. tag server_rbac_groups

   A group is used to define access to object types and objects in the Chef server and also to assign permissions that determine what types of tasks are available to members of that group who are authorized to perform them. Groups are configured per-organization.

   Individual users who are members of a group will inherit the permissions assigned to the group. The Chef server includes the following default groups: ``admins``, ``clients``, and ``users``. For users of the hosted Chef server, an additional default group is provided: ``billing_admins``.

   .. end_tag

   Default Groups
   -----------------------------------------------------
   .. tag server_rbac_permissions_default

   The following sections show the default permissions assigned by the Chef server to the ``admins``, ``billing_admins``, ``clients``, and ``users`` groups.

   .. note:: The creator of an object on the Chef server is assigned ``create``, ``delete``, ``grant``, ``read``, and ``update`` permission to that object.

   .. end_tag

   admins
   +++++++++++++++++++++++++++++++++++++++++++++++++++++
   .. tag server_rbac_permissions_default_admins

   The ``admins`` group is assigned the following:

   .. list-table::
      :widths: 160 100 100 100 100 100
      :header-rows: 1

      * - Group
        - Create
        - Delete
        - Grant
        - Read
        - Update
      * - admins
        - yes
        - yes
        - yes
        - yes
        - yes
      * - clients
        - yes
        - yes
        - yes
        - yes
        - yes
      * - users
        - yes
        - yes
        - yes
        - yes
        - yes

   .. end_tag

   billing_admins
   +++++++++++++++++++++++++++++++++++++++++++++++++++++
   .. tag server_rbac_permissions_default_billing_admins

   The ``billing_admins`` group is assigned the following:

   .. list-table::
      :widths: 160 100 100 100 100
      :header-rows: 1

      * - Group
        - Create
        - Delete
        - Read
        - Update
      * - billing_admins
        - no
        - no
        - yes
        - yes

   .. end_tag

   clients
   +++++++++++++++++++++++++++++++++++++++++++++++++++++
   .. tag server_rbac_permissions_default_clients

   The ``clients`` group is assigned the following:

   .. list-table::
      :widths: 160 100 100 100 100
      :header-rows: 1

      * - Object
        - Create
        - Delete
        - Read
        - Update
      * - clients
        - no
        - no
        - no
        - no
      * - cookbooks
        - no
        - no
        - yes
        - no
      * - cookbook_artifacts
        - no
        - no
        - yes
        - no
      * - data
        - no
        - no
        - yes
        - no
      * - environments
        - no
        - no
        - yes
        - no
      * - nodes
        - yes
        - no
        - yes
        - no
      * - organization
        - no
        - no
        - yes
        - no
      * - policies
        - no
        - no
        - yes
        - no
      * - policy_groups
        - no
        - no
        - yes
        - no
      * - roles
        - no
        - no
        - yes
        - no
      * - sandboxes
        - no
        - no
        - no
        - no

   .. end_tag

   public_key_read_access
   +++++++++++++++++++++++++++++++++++++++++++++++++++++
   .. tag server_rbac_permissions_default_public_key_read_access

   The ``public_key_read_access`` group controls which users and clients have :doc:`read permissions to the following endpoints </api_chef_server>`:

   * GET /clients/CLIENT/keys
   * GET /clients/CLIENT/keys/KEY
   * GET /users/USER/keys 
   * GET /users/USER/keys/

   By default, the ``public_key_read_access`` assigns all members of the ``users`` and ``clients`` group permission to these endpoints:

   .. list-table::
      :widths: 160 100 100 100 100 100
      :header-rows: 1

      * - Group
        - Create
        - Delete
        - Grant
        - Read
        - Update
      * - admins
        - no
        - no
        - no
        - no
        - no
      * - clients
        - yes
        - yes
        - yes
        - yes
        - yes
      * - users
        - yes
        - yes
        - yes
        - yes
        - yes

   .. end_tag

   users
   +++++++++++++++++++++++++++++++++++++++++++++++++++++
   .. tag server_rbac_permissions_default_users

   The ``users`` group is assigned the following:

   .. list-table::
      :widths: 160 100 100 100 100
      :header-rows: 1

      * - Object
        - Create
        - Delete
        - Read
        - Update
      * - clients
        - no
        - yes
        - yes
        - no
      * - cookbooks
        - yes
        - yes
        - yes
        - yes
      * - cookbook_artifacts
        - yes
        - yes
        - yes
        - yes
      * - data
        - yes
        - yes
        - yes
        - yes
      * - environments
        - yes
        - yes
        - yes
        - yes
      * - nodes
        - yes
        - yes
        - yes
        - yes
      * - organization
        - no
        - no
        - yes
        - no
      * - policies
        - yes
        - yes
        - yes
        - yes
      * - policy_groups
        - yes
        - yes
        - yes
        - yes
      * - roles
        - yes
        - yes
        - yes
        - yes
      * - sandboxes
        - yes
        - no
        - no
        - no

   .. end_tag

   chef-validator
   +++++++++++++++++++++++++++++++++++++++++++++++++++++
   .. tag security_chef_validator

   Every request made by the chef-client to the Chef server must be an authenticated request using the Chef server API and a private key. When the chef-client makes a request to the Chef server, the chef-client authenticates each request using a private key located in ``/etc/chef/client.pem``.

   .. end_tag

   .. tag server_rbac_permissions_default_validator

   The chef-validator is allowed to do the following at the start of a chef-client run. After the chef-client is registered with Chef server, that chef-client is added to the ``clients`` group:

   .. list-table::
      :widths: 160 100 100 100 100
      :header-rows: 1

      * - Object
        - Create
        - Delete
        - Read
        - Update
      * - clients
        - yes
        - no
        - no
        - no

   .. end_tag

   Chef Push Jobs Groups
   -----------------------------------------------------
   .. tag push_jobs_1

   Chef push jobs is an extension of the Chef server that allows jobs to be run against nodes independently of a chef-client run. A job is an action or a command to be executed against a subset of nodes; the nodes against which a job is run are determined by the results of a search query made to the Chef server.

   Chef push jobs uses the Chef server API and a Ruby client to initiate all connections to the Chef server. Connections use the same authentication and authorization model as any other request made to the Chef server. A knife plugin is used to initiate job creation and job tracking.

   .. end_tag

   .. tag server_rbac_groups_push_jobs

   It is possible to initiate jobs from the chef-client, such as from within a recipe based on an action to be determined as the recipe runs. For a chef-client to be able to create, initiate, or read jobs, the chef-client on which Chef push jobs is configured must belong to one (or both) of the following groups:

   .. list-table::
      :widths: 60 420
      :header-rows: 1

      * - Group
        - Description
      * - ``pushy_job_readers``
        - Use to view the status of jobs.
      * - ``pushy_job_writers``
        - Use to create and initiate jobs.

   These groups do not exist by default, even after Chef push jobs has been installed to the Chef server. If these groups are not created, only members of the ``admin`` security group will be able to create, initiate, and view jobs.

   .. end_tag

   Reporting Groups
   -----------------------------------------------------
   .. tag reporting_summary

   Use Reporting to keep track of what happens during the execution of chef-client runs across all of the machines that are under management by Chef. Reports can be generated for the entire organization and they can be generated for specific nodes.

   Reporting data is collected during the chef-client run and the results are posted to the Chef server at the end of the chef-client run at the same time the node object is uploaded to the Chef server.

   .. end_tag

   .. tag server_rbac_groups_reporting

   A chef-client on which Reporting is configured always sends data to the Chef server. Users of the Chef management console web user interface must belong to the following group:

   .. list-table::
      :widths: 60 420
      :header-rows: 1

      * - Group
        - Description
      * - ``reporting_readers``
        - Use to view and configure reports.

   This group does not exist by default, even after Reporting has been installed to the Chef server. If this group is not created, all members of the organization will be unable to view reports.

   .. SAVE FOR LATER
   ..
   .. must belong to one (or both) of the following groups:
   ..
   ..   * - ``reporting_writers``
   ..     - (This group is not used by the current version of Reporting.)

   .. end_tag

   Server Admins
   =====================================================
   .. tag server_rbac_server_admins

   The ``server-admins`` group is a global group that grants its members permission to create, read, update, and delete user accounts, with the exception of superuser accounts. The ``server-admins`` group is useful for users who are responsible for day-to-day administration of the Chef server, especially user management via the ``knife user`` subcommand. Before members can be added to the ``server-admins`` group, they must already have a user account on the Chef server.

   .. end_tag

   Scenario
   -----------------------------------------------------
   .. tag server_rbac_server_admins_scenario

   The following user accounts exist on the Chef server: ``pivotal`` (a superuser account), ``alice``, ``bob``, ``carol``, and ``dan``. Run the following command to view a list of users on the Chef server:

   .. code-block:: bash

      $ chef-server-ctl user-list

   and it returns the same list of users:

   .. code-block:: bash

      pivotal
      alice
      bob
      carol
      dan

   Alice is a member of the IT team whose responsibilities include day-to-day administration of the Chef server, in particular managing the user accounts on the Chef server that are used by the rest of the organization. From a workstation, Alice runs the following command:

   .. code-block:: bash

      $ knife user list -c ~/.chef/alice.rb

   and it returns the following error:

   .. code-block:: bash

      ERROR: You authenticated successfully to <chef_server_url> as alice
             but you are not authorized for this action
      Response: Missing read permission

   Alice is not a superuser and does not have permissions on other users because user accounts are global to organizations in the Chef server. Let's add Alice to the ``server-admins`` group:

   .. code-block:: bash

      $ chef-server-ctl grant-server-admin-permissions alice

   and it returns the following response:

   .. code-block:: bash

      User alice was added to server-admins.

   Alice can now create, read, update, and delete user accounts on the Chef server, even for organizations to which Alice is not a member. From a workstation, Alice re-runs the following command:

   .. code-block:: bash

      $ knife user list -c ~/.chef/alice.rb

   which now returns:

   .. code-block:: bash

      pivotal
      alice
      bob
      carol
      dan

   Alice is now a server administrator and can use the following knife subcommands to manage users on the Chef server:

   * ``knife user-create``
   * ``knife user-delete``
   * ``knife user-edit``
   * ``knife user-list``
   * ``knife user-show``

   For example, Alice runs the following command:

   .. code-block:: bash

      $ knife user edit carol -c ~/.chef/alice.rb

   and the $EDITOR opens in which Alice makes changes, and then saves them.

   .. end_tag

   Superuser Accounts
   +++++++++++++++++++++++++++++++++++++++++++++++++++++
   .. tag server_rbac_server_admins_superusers

   Superuser accounts may not be managed by users who belong to the ``server-admins`` group. For example, Alice attempts to delete the ``pivotal`` superuser account:

   .. code-block:: bash

      $ knife user delete pivotal -c ~/.chef/alice.rb

   and the following error is returned:

   .. code-block:: bash

      ERROR: You authenticated successfully to <chef_server_url> as user1
             but you are not authorized for this action
      Response: Missing read permission

   Alice's action is unauthorized even with membership in the ``server-admins`` group.

   .. end_tag

   Manage server-admins Group
   -----------------------------------------------------
   .. tag ctl_chef_server_server_admin

   Membership of the ``server-admins`` group is managed with a set of ``chef-server-ctl`` subcommands:

   * ``chef-server-ctl grant-server-admin-permissions``
   * ``chef-server-ctl list-server-admins``
   * ``chef-server-ctl remove-server-admin-permissions``

   .. end_tag

   Add Members
   +++++++++++++++++++++++++++++++++++++++++++++++++++++
   .. tag ctl_chef_server_server_admin_grant_user

   The ``grant-server-admin-permissions`` subcommand is used to add a user to the ``server-admins`` group. Run the command once per user added.

   This subcommand has the following syntax:

   .. code-block:: bash

      $ chef-server-ctl grant-server-admin-permissions USER_NAME

   where ``USER_NAME`` is the user to add to the list of server administrators.

   For example:

   .. code-block:: bash

      $ chef-server-ctl grant-server-admin-permissions bob

   returns:

   .. code-block:: bash

      User bob was added to server-admins. This user can now list,
      read, and create users (even for orgs they are not members of)
      for this Chef Server.

   .. end_tag

   Remove Members
   +++++++++++++++++++++++++++++++++++++++++++++++++++++
   .. tag ctl_chef_server_server_admin_remove_user

   The ``remove-server-admin-permissions`` subcommand is used to remove a user from the ``server-admins`` group. Run the command once per user removed.

   This subcommand has the following syntax:

   .. code-block:: bash

      $ chef-server-ctl remove-server-admin-permissions USER_NAME

   where ``USER_NAME`` is the user to remove from the list of server administrators.

   For example:

   .. code-block:: bash

      $ chef-server-ctl remove-server-admin-permissions bob

   returns:

   .. code-block:: bash

      User bob was removed from server-admins. This user can no longer
      list, read, and create users for this Chef Server except for where
      they have default permissions (such as within an org).

   .. end_tag

   List Membership
   +++++++++++++++++++++++++++++++++++++++++++++++++++++
   .. tag ctl_chef_server_server_admin_list

   The ``list-server-admins`` subcommand is used to return a list of users who are members of the ``server-admins`` group.

   This subcommand has the following syntax:

   .. code-block:: bash

      $ chef-server-ctl list-server-admins

   and will return a list of users similar to:

   .. code-block:: bash

      pivotal
      alice
      bob
      carol
      dan

   .. end_tag

   Manage Organizations
   =====================================================
   .. tag ctl_chef_server_org

   Use the ``org-create``, ``org-delete``, ``org-list``, ``org-show``, ``org-user-add`` and ``org-user-remove`` commands to manage organizations.

   .. end_tag

   org-create
   -----------------------------------------------------
   .. tag ctl_chef_server_org_create

   The ``org-create`` subcommand is used to create an organization. (The validation key for the organization is returned to ``STDOUT`` when creating an organization with this command.)

   .. end_tag

   **Syntax**

   .. tag ctl_chef_server_org_create_syntax

   This subcommand has the following syntax:

   .. code-block:: bash

      $ chef-server-ctl org-create ORG_NAME "ORG_FULL_NAME" (options)

   where:

   * The name must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores, and must be between 1 and 255 characters. For example: ``chef``.
   * The full name must begin with a non-white space character and must be between 1 and 1023 characters. For example: ``"Chef Software, Inc."``.

   .. end_tag

   **Options**

   .. tag ctl_chef_server_org_create_options

   This subcommand has the following options:

   ``-a USER_NAME``, ``--association_user USER_NAME``
      Associate a user with an organization and add them to the ``admins`` and ``billing_admins`` security groups.

   ``-f FILE_NAME``, ``--filename FILE_NAME``
      Write the ORGANIZATION-validator.pem to ``FILE_NAME`` instead of printing it to ``STDOUT``.

   .. end_tag

   org-delete
   -----------------------------------------------------
   .. tag ctl_chef_server_org_delete

   The ``org-delete`` subcommand is used to delete an organization.

   .. end_tag

   **Syntax**

   .. tag ctl_chef_server_org_delete_syntax

   This subcommand has the following syntax:

   .. code-block:: bash

      $ chef-server-ctl org-delete ORG_NAME

   .. end_tag

   org-list
   -----------------------------------------------------
   .. tag ctl_chef_server_org_list

   The ``org-list`` subcommand is used to list all of the organizations currently present on the Chef server.

   .. end_tag

   **Syntax**

   .. tag ctl_chef_server_org_list_syntax

   This subcommand has the following syntax:

   .. code-block:: bash

      $ chef-server-ctl org-list (options)

   .. end_tag

   **Options**

   .. tag ctl_chef_server_org_list_options

   This subcommand has the following options:

   ``-a``, ``--all-orgs``
      Show all organizations.

   ``-w``, ``--with-uri``
      Show the corresponding URIs.

   .. end_tag

   org-show
   -----------------------------------------------------
   .. tag ctl_chef_server_org_show

   The ``org-show`` subcommand is used to show the details for an organization.

   .. end_tag

   **Syntax**

   .. tag ctl_chef_server_org_show_syntax

   This subcommand has the following syntax:

   .. code-block:: bash

      $ chef-server-ctl org-show ORG_NAME

   .. end_tag

   org-user-add
   -----------------------------------------------------
   .. tag ctl_chef_server_org_user_add

   The ``org-user-add`` subcommand is used to add a user to an organization.

   .. end_tag

   **Syntax**

   .. tag ctl_chef_server_org_user_add_syntax

   This subcommand has the following syntax:

   .. code-block:: bash

      $ chef-server-ctl org-user-add ORG_NAME USER_NAME (options)

   .. end_tag

   **Options**

   .. tag ctl_chef_server_org_user_add_options

   This subcommand has the following options:

   ``--admin``
      Add the user to the ``admins`` group.

   .. end_tag

   org-user-remove
   -----------------------------------------------------
   .. tag ctl_chef_server_org_user_remove

   The ``org-user-remove`` subcommand is used to remove a user from an organization.

   .. end_tag

   **Syntax**

   .. tag ctl_chef_server_org_user_remove_syntax

   This subcommand has the following syntax:

   .. code-block:: bash

      $ chef-server-ctl org-user-remove ORG_NAME USER_NAME (options)

   .. end_tag

   .. end_tag

This just means that if a change is made to ``chef_master/source/server_orgs.rst`` it will also be made at build-time to ``docs_server/source/server_orgs.rst``. Manage the change in a single location.

Includes Directories
+++++++++++++++++++++++++++++++++++++++++++++++++++++
But wait! Why do most of the files in the ``chef_master`` directory have zero actual content? It's to separate what is published from what is authored. There is an ``includes_*`` folder for all of the objects, concepts, tools, etc. that exist in Chef. The goal of each ``includes_`` directory is to ensure that all of the content about a specific piece of Chef can be found in a single location.

Single-sourcing this content allows publishing of versioned content, generating output to man pages, HTML, slide decks, and PDFs, etc. in a way that reuses the same content as much as possible.

For example, the ``template`` resource::

   =====================================================
   template
   =====================================================

   .. tag resources_common_generic

   A :doc:`resource <resource>` defines the desired state for a single configuration item present on a node that is under management by Chef. A resource collection---one (or more) individual resources---defines the desired state for the entire node. During a :ref:`chef-client run <chef_client-the-chef-client-run>`, the current state of each resource is tested, after which the chef-client will take any steps that are necessary to repair the node and bring it back into the desired state.

   .. end_tag

   .. tag resource_template_24

   Use the **template** resource to manage the contents of a file using an Embedded Ruby (ERB) template by transferring files from a sub-directory of ``COOKBOOK_NAME/templates/`` to a specified path located on a host that is running the chef-client. This resource includes actions and properties from the **file** resource. Template files managed by the **template** resource follow the same file specificity rules as the **remote_file** and **file** resources.

   .. end_tag

   |note execute resource intepreter|

   Syntax
   =====================================================
   .. tag resource_template_syntax

   A **template** resource block typically declares the location in which a file is to be created, the source template that will be used to create the file, and the permissions needed on that file. For example:

   .. code-block:: ruby

      template '/etc/motd' do
        source 'motd.erb'
        owner 'root'
        group 'root'
        mode '0755'
      end

   where

   * ``'/etc/motd'`` specifies the location in which the file is created
   * ``'motd.erb'`` specifies the name of a template that exists in in the ``/templates`` folder of a cookbook
   * ``owner``, ``group``, and ``mode`` define the permissions

   The full syntax for all of the properties that are available to the **template** resource is:

   .. code-block:: ruby

      template 'name' do
        atomic_update              TrueClass, FalseClass
        backup                     FalseClass, Integer
        cookbook                   String
        force_unlink               TrueClass, FalseClass
        group                      String, Integer
        helper(:method)            Method { String } # see Helpers below
        helpers(module)            Module # see Helpers below
        inherits                   TrueClass, FalseClass
        local                      TrueClass, FalseClass
        manage_symlink_source      TrueClass, FalseClass, NilClass
        mode                       String, Integer
        notifies                   # see description
        owner                      String, Integer
        path                       String # defaults to 'name' if not specified
        provider                   Chef::Provider::File::Template
        rights                     Hash
        sensitive                  TrueClass, FalseClass
        source                     String, Array
        subscribes                 # see description
        variables                  Hash
        verify                     String, Block
        action                     Symbol # defaults to :create if not specified
      end

   where

   * ``template`` is the resource
   * ``name`` is the name of the resource block, typically the path to the location in which a file is created *and also* the name of the file to be managed. For example: ``/var/www/html/index.html``, where ``/var/www/html/`` is the fully qualified path to the location and ``index.html`` is the name of the file
   * ``source`` is the template file that will be used to create the file on the node, for example: ``index.html.erb``; the template file is located in the ``/templates`` directory of a cookbook
   * ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
   * ``atomic_update``, ``backup``, ``cookbook``, ``force_unlink``, ``group``, ``helper``, ``helpers``, ``inherits``, ``local``, ``manage_symlink_source``, ``mode``, ``owner``, ``path``, ``provider``, ``rights``, ``sensitive``, ``source``, ``variables``, and ``verify`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

   .. end_tag

   Actions
   =====================================================
   .. tag resource_template_actions

   This resource has the following actions:

   ``:create``
      Default. Create a file. If a file already exists (but does not match), update that file to match.

   ``:create_if_missing``
      Create a file only if the file does not exist. When the file exists, nothing happens.

   ``:delete``
      Delete a file.

   ``:nothing``
      .. tag resources_common_actions_nothing

      Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the chef-client run.

      .. end_tag

   ``:touch``
      Touch a file. This updates the access (atime) and file modification (mtime) times for a file. (This action may be used with this resource, but is typically only used with the **file** resource.)

   .. end_tag

   Attributes
   =====================================================
   .. tag resource_template_attributes

   This resource has the following properties:

   ``atomic_update``
      **Ruby Types:** TrueClass, FalseClass

      Perform atomic file updates on a per-resource basis. Set to ``true`` for atomic file updates. Set to ``false`` for non-atomic file updates. This setting overrides ``file_atomic_update``, which is a global setting found in the client.rb file. Default value: ``true``.

   ``backup``
      **Ruby Types:** FalseClass, Integer

      The number of backups to be kept in ``/var/chef/backup`` (for UNIX- and Linux-based platforms) or ``C:/chef/backup`` (for the Microsoft Windows platform). Set to ``false`` to prevent backups from being kept. Default value: ``5``.

   ``cookbook``
      **Ruby Type:** String

      The cookbook in which a file is located (if it is not located in the current cookbook). The default value is the current cookbook.

   ``force_unlink``
      **Ruby Types:** TrueClass, FalseClass

      How the chef-client handles certain situations when the target file turns out not to be a file. For example, when a target file is actually a symlink. Set to ``true`` for the chef-client delete the non-file target and replace it with the specified file. Set to ``false`` for the chef-client to raise an error. Default value: ``false``.

   ``group``
      **Ruby Types:** Integer, String

      A string or ID that identifies the group owner by group name, including fully qualified group names such as ``domain\group`` or ``group@domain``. If this value is not specified, existing groups remain unchanged and new group assignments use the default ``POSIX`` group (if available).

   ``helper``
      **Ruby Type:** Method

      Define a helper method inline. For example: ``helper(:hello_world) { "hello world" }`` or ``helper(:app) { node["app"] }`` or ``helper(:app_conf) { |setting| node["app"][setting] }``. Default value: ``{}``.

   ``helpers``
      **Ruby Type:** Module

      Define a helper module inline or in a library. For example, an inline module: ``helpers do``, which is then followed by a block of Ruby code. And for a library module: ``helpers(MyHelperModule)``. Default value: ``[]``.

   ``ignore_failure``
      **Ruby Types:** TrueClass, FalseClass

      Continue running a recipe if a resource fails for any reason. Default value: ``false``.

   ``inherits``
      **Ruby Types:** TrueClass, FalseClass

      Microsoft Windows only. Whether a file inherits rights from its parent directory. Default value: ``true``.

   ``local``
      **Ruby Types:** TrueClass, FalseClass

      Load a template from a local path. By default, the chef-client loads templates from a cookbook's ``/templates`` directory. When this property is set to ``true``, use the ``source`` property to specify the path to a template on the local node. Default value: ``false``.

   ``manage_symlink_source``
      **Ruby Types:** TrueClass, FalseClass, NilClass

      Cause the chef-client to detect and manage the source file for a symlink. Possible values: ``nil``, ``true``, or ``false``. When this value is set to ``nil``, the chef-client will manage a symlink's source file and emit a warning. When this value is set to ``true``, the chef-client will manage a symlink's source file and not emit a warning. Default value: ``nil``. The default value will be changed to ``false`` in a future version.

   ``mode``
      **Ruby Types:** Integer, String

      A quoted 3-5 character string that defines the octal mode. For example: ``'755'``, ``'0755'``, or ``00755``. If ``mode`` is not specified and if the file already exists, the existing mode on the file is used. If ``mode`` is not specified, the file does not exist, and the ``:create`` action is specified, the chef-client assumes a mask value of ``'0777'`` and then applies the umask for the system on which the file is to be created to the ``mask`` value. For example, if the umask on a system is ``'022'``, the chef-client uses the default value of ``'0755'``.

      The behavior is different depending on the platform.

      UNIX- and Linux-based systems: A quoted 3-5 character string that defines the octal mode that is passed to chmod. For example: ``'755'``, ``'0755'``, or ``00755``. If the value is specified as a quoted string, it works exactly as if the ``chmod`` command was passed. If the value is specified as an integer, prepend a zero (``0``) to the value to ensure that it is interpreted as an octal number. For example, to assign read, write, and execute rights for all users, use ``'0777'`` or ``'777'``; for the same rights, plus the sticky bit, use ``01777`` or ``'1777'``.

      Microsoft Windows: A quoted 3-5 character string that defines the octal mode that is translated into rights for Microsoft Windows security. For example: ``'755'``, ``'0755'``, or ``00755``. Values up to ``'0777'`` are allowed (no sticky bits) and mean the same in Microsoft Windows as they do in UNIX, where ``4`` equals ``GENERIC_READ``, ``2`` equals ``GENERIC_WRITE``, and ``1`` equals ``GENERIC_EXECUTE``. This property cannot be used to set ``:full_control``. This property has no effect if not specified, but when it and ``rights`` are both specified, the effects are cumulative.

   ``notifies``
      **Ruby Type:** Symbol, 'Chef::Resource[String]'

      .. tag resources_common_notification_notifies

      A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notifiy more than one resource; use a ``notifies`` statement for each resource to be notified.

      .. end_tag

      .. tag resources_common_notification_timers

      A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

      ``:before``
         Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

      ``:delayed``
         Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

      ``:immediate``, ``:immediately``
         Specifies that a notification should be run immediately, per resource notified.

      .. end_tag

      .. tag resources_common_notification_notifies_syntax

      The syntax for ``notifies`` is:

      .. code-block:: ruby

         notifies :action, 'resource[name]', :timer

      .. end_tag

   ``owner``
      **Ruby Types:** Integer, String

      A string or ID that identifies the group owner by user name, including fully qualified user names such as ``domain\user`` or ``user@domain``. If this value is not specified, existing owners remain unchanged and new owner assignments use the current user (when necessary).

   ``path``
      **Ruby Type:** String

      The full path to the file, including the file name and its extension.

      Microsoft Windows: A path that begins with a forward slash (``/``) will point to the root of the current working directory of the chef-client process. This path can vary from system to system. Therefore, using a path that begins with a forward slash (``/``) is not recommended.

   ``provider``
      **Ruby Type:** Chef Class

      Optional. Explicitly specifies a provider.

   ``retries``
      **Ruby Type:** Integer

      The number of times to catch exceptions and retry the resource. Default value: ``0``.

   ``retry_delay``
      **Ruby Type:** Integer

      The retry delay (in seconds). Default value: ``2``.

   ``rights``
      **Ruby Types:** Integer, String

      Microsoft Windows only. The permissions for users and groups in a Microsoft Windows environment. For example: ``rights <permissions>, <principal>, <options>`` where ``<permissions>`` specifies the rights granted to the principal, ``<principal>`` is the group or user name, and ``<options>`` is a Hash with one (or more) advanced rights options.

   ``sensitive``
      **Ruby Types:** TrueClass, FalseClass

      Ensure that sensitive resource data is not logged by the chef-client. Default value: ``false``.

   ``source``
      **Ruby Types:** String, Array

      The location of a template file. By default, the chef-client looks for a template file in the ``/templates`` directory of a cookbook. When the ``local`` property is set to ``true``, use to specify the path to a template on the local node. This property may also be used to distribute specific files to specific platforms. See "File Specificity" below for more information. Default value: the ``name`` of the resource block See "Syntax" section above for more information.

   ``subscribes``
      **Ruby Type:** Symbol, 'Chef::Resource[String]'

      .. tag resources_common_notification_subscribes

      A resource may listen to another resource, and then take action if the state of the resource being listened to changes. Specify a ``'resource[name]'``, the ``:action`` to be taken, and then the ``:timer`` for that action.

      .. end_tag

      .. tag resources_common_notification_timers

      A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

      ``:before``
         Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

      ``:delayed``
         Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

      ``:immediate``, ``:immediately``
         Specifies that a notification should be run immediately, per resource notified.

      .. end_tag

      .. tag resources_common_notification_subscribes_syntax

      The syntax for ``subscribes`` is:

      .. code-block:: ruby

         subscribes :action, 'resource[name]', :timer

      .. end_tag

   ``variables``
      **Ruby Type:** Hash

      A Hash of variables that are passed into a Ruby template file.

      .. tag template_partials_variables_attribute

      The ``variables`` property of the **template** resource can be used to reference a partial template file by using a Hash. For example:

      .. code-block:: ruby

         template '/file/name.txt' do
           variables :partials => {
             'partial_name_1.txt.erb' => 'message',
             'partial_name_2.txt.erb' => 'message',
             'partial_name_3.txt.erb' => 'message'
           }
         end

      where each of the partial template files can then be combined using normal Ruby template patterns within a template file, such as:

      .. code-block:: ruby

         <% @partials.each do |partial, message| %>
           Here is <%= partial %>
           <%= render partial, :variables => {:message => message} %>
         <% end %>

      .. end_tag

   ``verify``
      **Ruby Types:** String, Block

      A block or a string that returns ``true`` or ``false``. A string, when ``true`` is executed as a system command.

      .. tag resource_template_attributes_verify

      A block is arbitrary Ruby defined within the resource block by using the ``verify`` property. When a block is ``true``, the chef-client will continue to update the file as appropriate.

      For example, this should return ``true``:

      .. code-block:: ruby

         template '/tmp/baz' do
           verify { 1 == 1 }
         end

      This should return ``true``:

      .. code-block:: ruby

         template '/etc/nginx.conf' do
           verify 'nginx -t -c %{path}'
         end

      .. warning:: For releases of the chef-client prior to 12.5 (chef-client 12.4 and earlier) the correct syntax is:

         .. code-block:: ruby

            template '/etc/nginx.conf' do
              verify 'nginx -t -c %{file}'
            end

         See GitHub issues https://github.com/chef/chef/issues/3232 and https://github.com/chef/chef/pull/3693 for more information about these differences.

      This should return ``true``:

      .. code-block:: ruby

         template '/tmp/bar' do
           verify { 1 == 1}
         end

      And this should return ``true``:

      .. code-block:: ruby

         template '/tmp/foo' do
           verify do |path|
             true
           end
         end

      Whereas, this should return ``false``:

      .. code-block:: ruby

         template '/tmp/turtle' do
           verify '/usr/bin/false'
         end

      If a string or a block return ``false``, the chef-client run will stop and an error is returned.

      .. end_tag

   .. end_tag

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

       .. tag slides_core_splash

       .. Use this slide as the very first slide in every slide deck. The title of this slide (as included in the slide map file) is what identifies the training.

       .. image:: ../../images/slides_splash.png

       .. end_tag

    .. revealjs:: Recipes

       .. tag slides_recipes

       * A resource is a piece of the system and its desired state
       * A recipe is a collection of resources

       .. end_tag

    .. revealjs:: Order Matters

       .. tag slides_recipes_order

       .. code-block:: ruby

          package 'haproxy' do
           action :install
          end

          template '/etc/haproxy/haproxy.cfg' do
            source 'haproxy.cfg.erb'
            owner 'root'
            group 'root'
            mode '0644'
            notifies :restart, 'service[haproxy]'
          end

          service 'haproxy' do
            supports :restart => :true
            action [:start, :enable]
          end

       .. end_tag

where the included file is a standard .rst file from the chef-docs library that **DOES NOT** include any ``revealjs::`` directive information. It's just well-formed restructured text as defined by this style guide. (It's important to remember that included topics may be in other formats, like PDF, non-reveal.js HTML formats, and even man pages.)

You may mix-and-match inclusions and custom content as needed. For example::

   .. revealjs::

    .. revealjs:: Recipes

       .. tag slides_core_splash

       .. Use this slide as the very first slide in every slide deck. The title of this slide (as included in the slide map file) is what identifies the training.

       .. image:: ../../images/slides_splash.png

       .. end_tag

    ... <snip> ...

    .. revealjs:: Order Matters - Service Runs Third

       .. tag slides_recipes_order_service

       .. code-block:: ruby

          package 'haproxy' do
            action :install
          end

          template '/etc/haproxy/haproxy.cfg' do
            source 'haproxy.cfg.erb'
            owner 'root'
            group 'root'
            mode '0644'
            notifies :restart, 'service[haproxy]'
          end

       .. code-block:: ruby

          service 'haproxy' do
            supports :restart => :true
            action [:start, :enable]
          end

       .. end_tag

    .. revealjs:: Questions

       .. tag slides_core_questions

       .. Use this slide every time the slide deck stops for Q/A sessions with attendees.

       .. image:: ../../images/slides_questions.png

       .. end_tag

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
