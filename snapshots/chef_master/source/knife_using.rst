=====================================================
Working with Knife
=====================================================

.. include:: ../../includes_knife/includes_knife_using.rst

JSON Data Format
=====================================================
.. include:: ../../includes_knife/includes_knife_using_json.rst

Set the Text Editor
-----------------------------------------------------
Some knife commands, such as ``knife data bag edit``, require that information be edited as JSON data using a text editor. For example, the following command:

.. code-block:: bash

   $ knife data bag edit admins admin_name

will open up the text editor with data similar to:

.. code-block:: javascript

   {
     "id": "admin_name"
   }

Changes to that file can then be made:

.. code-block:: javascript

   {
     "id": "Justin C."
     "description": "I am passing the time by letting time pass over me ..."
   }

The type of text editor that is used by knife can be configured by adding an entry to the knife.rb file or by setting an ``EDITOR`` environment variable. For example, to configure the text editor to always open with vim, add the following to the knife.rb file:

.. code-block:: ruby

   knife[:editor] = "/usr/bin/vim"

When a Microsoft Windows file path is enclosed in a double-quoted string (" "), the same backslash character (``\``) that is used to define the file path separator is also used in Ruby to define an escape character. The knife.rb file is a Ruby file; therefore, file path separators must be escaped. In addition, spaces in the file path must be replaced with ``~1`` so that the length of each section within the file path is not more than 8 characters. For example, if EditPad Pro is the text editor of choice and is located at the following path::

   C:\\Program Files (x86)\EditPad Pro\EditPad.exe

the setting in the knife.rb file would be similar to:

.. code-block:: ruby

   knife[:editor] = "C:\\Progra~1\\EditPa~1\\EditPad.exe"

One approach to working around the double- vs. single-quote issue is to put the single-quotes outside of the double-quotes. For example, for Notepad++:

.. code-block:: ruby

   knife[:editor] = '"C:\Program Files (x86)\Notepad++\notepad++.exe" -nosession -multiInst'

for Sublime Text:

.. code-block:: ruby

   knife[:editor] = '"C:\Program Files\Sublime Text 2\sublime_text.exe" --wait'

for TextPad:

.. code-block:: ruby

   knife[:editor] = '"C:\Program Files (x86)\TextPad 7\TextPad.exe"'

and for vim:

.. code-block:: ruby

   knife[:editor] = '"C:\Program Files (x86)\vim\vim74\gvim.exe"'







Using Quotes
=====================================================
.. include:: ../../includes_knife/includes_knife_using_quotes.rst

Subcommands
=====================================================
.. include:: ../../includes_knife/includes_knife_using_subcommands.rst

Verb Subcommands
=====================================================
knife includes a set of subcommands that are built around common verbs: ``delete``, ``deps``, ``diff``, ``download``, ``edit``, ``list``, ``show``, ``upload``, ``xargs``. These subcommands allow knife to issue commands that interact with any object stored in the chef-repo or stored on the Chef server. Some important principles behind this group of subcommands includes:

* A command that works with each object in the chef-repo. The subcommands specify the desired action (the "verb"), and then directory in which that object resides (``clients``, ``cookbooks/``, ``data_bags/``, ``environments/``, ``nodes``, ``roles/``, and ``users``). For example: ``download cookbooks/``
* A command that works with certain objects in the Chef server, including ``acls``, ``groups``, and ``containers``
* Uses the Chef server as if it were a file system, allowing the chef-repo on the Chef server to behave like a mirror of the chef-repo on the workstation. The Chef server will have the same objects as the local chef-repo. To make changes to the files on the Chef server, just download files from the Chef server or upload files from the chef-repo
* The context from which a command is run matters. For example, when working in the ``roles/`` directory, knife will know what is being worked with. Enter ``knife show base.json`` and knife will return the base role from the Chef server. From the chef-repo root, enter ``knife show roles/base.json`` to get the same result
* Parallel requests can be made to the Chef server and are configurable on a per-command basis

Wildcard Search
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_verbs_wildcard.rst

Plug-ins
=====================================================
.. include:: ../../includes_knife/includes_knife_using_plugins.rst

Syntax
=====================================================
.. include:: ../../includes_knife/includes_knife_using_syntax.rst

Many Users, Same Repo
=====================================================
.. include:: ../../includes_chef_repo/includes_chef_repo_many_users_same_repo.rst

Authenticated API Requests
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife.rst

.. include:: ../../includes_plugin_knife/includes_plugin_knife_using_authenticated_requests.rst

Configuring a Proxy Server
=====================================================
See the :doc:`proxies </proxies>` documentation for information on how to configure Knife to use a proxy server.
