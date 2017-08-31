=====================================================
Setting up Knife
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/knife_using.rst>`__

The knife command line tool must be configured to communicate with the Chef Server as well as any other infrastructure within your organization. This is done initially during the workstation setup, but subsequent modifications can be made using the knife.rb configuration file.

Knife.rb Configuration File
=====================================================

Knife is configured using a knife.rb configuration, which contains configuration for both the knife command line tool as well as any installed knife plugins. See :doc:`knife.rb </config_rb_knife>` for a complete list of configuration options in the knife.rb file.

Load Path Priority
-----------------------------------------------------

The knife.rb file is loaded every time the knife command is invoked using the following load order:

* From a specified location given the ``--config`` flag
* From a ``knife.rb`` file within a ``.chef`` directory in the current working directory ex: ``./.chef/knife.rb``
* From a ``knife.rb`` file within a ``.chef`` directory located one directory above the current working directory: ex: ``../.chef/knife.rb``
* From ``~/.chef/knife.rb`` (macOS and Linux platforms) or ``c:\Users\<username>\.chef`` (Microsoft Windows platform)

.. note:: When running Microsoft Windows, the knife.rb file is located at ``%HOMEDRIVE%:%HOMEPATH%\.chef`` (e.g. ``c:\Users\<username>\.chef``). If this path needs to be scripted, use ``%USERPROFILE%\chef-repo\.chef``.

Knife.rb Configuration Within a Chef Repository
-----------------------------------------------------
.. tag chef_repo_many_users_same_knife

The knife.rb configuration can include arbitrary Ruby code to extend configuration beyond static values. This can be used to load environmental variables from the workstation. This makes it possible to write a single knife.rb file that can be used by all users within your organization. This single file can also be checked into your chef-repo, allowing users to load different knife.rb files based on which chef-repo they execute the commands from. This can be especially useful when each chef-repo points to a different chef server or organization.

Example knife.rb:

.. code-block:: none

   current_dir = File.dirname(__FILE__)
     user = ENV['OPSCODE_USER'] || ENV['USER']
     node_name                user
     client_key               "#{ENV['HOME']}/chef-repo/.chef/#{user}.pem"
     validation_client_name   "#{ENV['ORGNAME']}-validator"
     validation_key           "#{ENV['HOME']}/chef-repo/.chef/#{ENV['ORGNAME']}-validator.pem"
     chef_server_url          "https://api.opscode.com/organizations/#{ENV['ORGNAME']}"
     syntax_check_cache_path  "#{ENV['HOME']}/chef-repo/.chef/syntax_check_cache"
     cookbook_path            ["#{current_dir}/../cookbooks"]
     cookbook_copyright       "Your Company, Inc."
     cookbook_license         "apachev2"
     cookbook_email           "cookbooks@yourcompany.com"

     # Amazon AWS
     knife[:aws_access_key_id] = ENV['AWS_ACCESS_KEY_ID']
     knife[:aws_secret_access_key] = ENV['AWS_SECRET_ACCESS_KEY']
.. end_tag


Generating a Knife.rb File
=====================================================

The knife command `knife configure` can be used to generate your initial knife.rb configuration file in your home directory. See :doc:`knife_configure` for details

Setting Your Text Editor
=====================================================

.. tag knife_common_set_editor

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

The type of text editor that is used by knife can be configured by adding an entry to your knife.rb file, or by setting an ``EDITOR`` environment variable. For example, to configure knife to open the ``vim`` text editor, add the following to your knife.rb file:

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

.. end_tag

Using Quotes
-----------------------------------------------------
The text editor command cannot include spaces that are not properly wrapped in quotes. The command can be entered with double quotes (" ") or single quotes (' '), but this should be done consistently as shown in the examples above.
