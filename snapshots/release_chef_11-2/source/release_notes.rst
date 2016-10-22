=====================================================
Release Notes: chef-client 11.2
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

.. note:: The chef-client 11.2 release is updated for Ruby 1.9.3-p484, which resolves a security vulnerability that existed when using prior versions of Ruby.

What's New
=====================================================
The following items are new for chef-client 11.2 and/or are changes from previous versions. The short version:

* **knife user** A new subcommand for creating users in Open Source Chef

knife user
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_user.rst

create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_user_create.rst

**Syntax**

.. include:: ../../includes_knife/includes_knife_user_create_syntax.rst

**Options**

.. include:: ../../includes_knife/includes_knife_user_create_options.rst

delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_user_delete.rst

**Syntax**

.. include:: ../../includes_knife/includes_knife_user_delete_syntax.rst

edit
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_user_edit.rst

**Syntax**

.. include:: ../../includes_knife/includes_knife_user_edit_syntax.rst

list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_user_list.rst

**Syntax**

.. include:: ../../includes_knife/includes_knife_user_list_syntax.rst

**Options**

.. include:: ../../includes_knife/includes_knife_user_list_options.rst

reregister
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_user_reregister.rst

**Syntax**

.. include:: ../../includes_knife/includes_knife_user_reregister_syntax.rst

**Options**

.. include:: ../../includes_knife/includes_knife_user_reregister_options.rst

show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_user_show.rst

**Syntax**

.. include:: ../../includes_knife/includes_knife_user_show_syntax.rst

**Options**

.. include:: ../../includes_knife/includes_knife_user_show_options.rst

What's Fixed
=====================================================
The following bugs were fixed:

* `CHEF-2960 <http://tickets.opscode.com/browse/CHEF-2960>`_  --- Upgrade JSON dependency to 1.7+
* `CHEF-3706 <http://tickets.opscode.com/browse/CHEF-3706>`_  --- Knife should provide commands for the user endpoint
* `CHEF-3707 <http://tickets.opscode.com/browse/CHEF-3707>`_  --- knife configure -i should create a user and not a client
* `CHEF-3809 <http://tickets.opscode.com/browse/CHEF-3809>`_  --- Getting error NoMethodError: undefined method 'CloseHandle' for Chef::ReservedNames::Win32::Handle:Class on Windows servers
* `CHEF-3836 <http://tickets.opscode.com/browse/CHEF-3836>`_  --- Run Lock tests randomly fail on slower Ci machines


What's Improved
=====================================================
The following improvements were made:

* `CHEF-3156 <http://tickets.opscode.com/browse/CHEF-3156>`_  --- Net::SSH dependency prevents using HMAC SHA2 family



